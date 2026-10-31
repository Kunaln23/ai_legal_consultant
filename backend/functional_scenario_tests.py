"""Functional smoke tests for Lex legal retrieval and consultation rules.

Run from backend/: python functional_scenario_tests.py
These tests use the bundled SQLite knowledge database and do not write to it.
"""
import os
import sys
import unittest
import uuid

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import legal_service
from consultation_rules import (
    MAX_FOLLOWUP_QUESTIONS,
    filter_repeated_clarifications,
    select_next_clarification,
    is_same_domain_continuation,
)
from fact_memory import get_or_create_memory, extract_and_merge_facts


SCENARIOS = [
    ("employment termination", "My employer terminated me without notice after 4 years of service and has not paid my final salary.", "Termination without notice or notice pay"),
    ("unpaid salary", "My company has not paid my salary for the last three months despite repeated requests.", "Unpaid salary and withheld wages"),
    ("UPI fraud", "I was tricked into entering my UPI PIN and Rs 25000 was debited from my bank account yesterday.", "Online banking, UPI, and phishing fraud"),
    ("rental dispute", "My landlord is refusing to return my security deposit after I vacated the rented flat.", "Security deposit not returned by landlord"),
    ("cyber blackmail", "Someone is threatening to publish my private photos unless I transfer money.", "Cyber extortion, blackmail, and sextortion"),
    ("inheritance", "My father died without a will and my brother is refusing to share the ancestral property.", "Ancestral property inheritance dispute"),
    ("consumer complaint", "I purchased a defective mobile phone and the seller refuses repair or refund.", "Seller refuses refund or return"),
    ("physical assault", "My neighbour hit me and I suffered injuries; I have medical records.", "Physical assault, battery, and violent beating"),
    ("education dispute", "My college is withholding my original degree certificate over a disputed fee.", "Withholding of degree or transfer certificate"),
]


class FunctionalScenarioTests(unittest.TestCase):
    def test_nine_supported_legal_scenarios(self):
        for label, query, expected_title in SCENARIOS:
            with self.subTest(scenario=label):
                result = legal_service.analyze_question(query, session_id="TEST-" + uuid.uuid4().hex)
                self.assertEqual(result.get("status"), "answered", result)
                self.assertEqual((result.get("case") or {}).get("case_title"), expected_title)

    def test_multiple_independent_issues_are_identified(self):
        result = legal_service.analyze_question(
            "My employer fired me and withheld salary, and my landlord is also refusing to return my deposit.",
            session_id="TEST-" + uuid.uuid4().hex,
        )
        self.assertEqual(result.get("status"), "ambiguous")
        self.assertTrue(result.get("multiple_issues_detected"))
        self.assertIn("Employment Law", result.get("identified_legal_issues", []))
        self.assertIn("Rental and Tenancy", result.get("identified_legal_issues", []))
        self.assertEqual(len(result.get("clarifying_questions", [])), 1)

    def test_incomplete_information_requests_clarification(self):
        result = legal_service.analyze_question(
            "My boss is troubling me.", session_id="TEST-" + uuid.uuid4().hex
        )
        self.assertEqual(result.get("status"), "needs_clarification")
        self.assertFalse(result.get("found"))

    def test_general_question_without_database_support_does_not_invent_answer(self):
        result = legal_service.analyze_question(
            "What is the minimum age for marriage in India?",
            session_id="TEST-" + uuid.uuid4().hex,
        )
        self.assertNotEqual(result.get("status"), "answered")
        self.assertFalse(result.get("found"))

    def test_repeated_role_time_and_amount_questions_are_filtered(self):
        context = (
            "I am the tenant. I vacated yesterday. The landlord owes my "
            "₹15,000 security deposit."
        )
        questions = [
            "Are you the tenant or the landlord?",
            "When did you vacate?",
            "What is the deposit amount?",
        ]
        self.assertEqual(filter_repeated_clarifications(questions, context), [])

    def test_only_one_followup_question_is_selected(self):
        questions = ["Who is involved?", "When did it happen?", "What amount is involved?"]
        selected = select_next_clarification(questions, "No details supplied", 0)
        self.assertEqual(len(selected), 1)

    def test_four_question_budget_is_enforced(self):
        questions = ["Who is involved?", "When did it happen?"]
        self.assertEqual(MAX_FOLLOWUP_QUESTIONS, 4)
        self.assertEqual(select_next_clarification(questions, "", 3), questions[:1])
        self.assertEqual(select_next_clarification(questions, "", 4), [])

    def test_employment_followup_keeps_same_consultation(self):
        first = "My company terminated me without notice or reason."
        second = "My employer has not paid my salary for the last three months."
        self.assertTrue(is_same_domain_continuation(second, first))

    def test_unrelated_rental_issue_is_not_same_domain_followup(self):
        first = "My company terminated me without notice."
        second = "My landlord is refusing to return my security deposit."
        self.assertFalse(is_same_domain_continuation(second, first))

    def test_fact_memory_accumulates_across_turns(self):
        memory = get_or_create_memory("TEST-" + uuid.uuid4().hex)
        extract_and_merge_facts(
            "My employer is ABC Ltd and my salary of Rs 30000 has not been paid for 2 months.",
            memory,
        )
        extract_and_merge_facts(
            "I was terminated yesterday and I have my appointment letter.",
            memory,
        )
        self.assertGreaterEqual(len(memory.all_statements), 2)
        self.assertTrue(memory.amounts)
        self.assertTrue(memory.timeframes)


if __name__ == "__main__":
    unittest.main(verbosity=2)
