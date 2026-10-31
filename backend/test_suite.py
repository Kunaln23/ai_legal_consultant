# ================================================================
# LEX TEST SUITE
# ================================================================
# Regression and safety tests for the Lex AI Legal Consultant.
#
# Run from the backend directory:
#     python test_suite.py
#
# The tests intentionally mock database retrieval so that the core
# safety/decision logic can be tested without modifying the database.
# ================================================================

import sys
import unittest
from unittest.mock import patch

import legal_service
import chat_service


# ----------------------------------------------------------------
# Test fixtures
# ----------------------------------------------------------------

def make_case(
    case_id=8,
    title="Unpaid Salary / Wages",
    situation="Employee has not received salary or wages from employer.",
    topic="Employment Law",
    score=80.0,
):
    return {
        "case_id": case_id,
        "topic_id": 1,
        "case_title": title,
        "situation": situation,
        "explanation": "Database explanation for the legal situation.",
        "urgency": "Medium",
        "jurisdiction": "India",
        "topic_name": topic,
        "topic_description": "Employment-related legal issues.",
        "keywords": "unpaid salary | salary not paid | unpaid wages",
        "_score": score,
        "_evidence": {},
    }


class LexTestCase(unittest.TestCase):

    # ============================================================
    # BASIC TEXT / DOMAIN TESTS
    # ============================================================

    def test_01_empty_question_requires_clarification(self):
        result = legal_service.analyze_question("")
        self.assertEqual(result["status"], "needs_clarification")
        self.assertFalse(result["found"])

    def test_02_greeting_requires_clarification(self):
        result = legal_service.analyze_question("hello")
        self.assertEqual(result["status"], "needs_clarification")
        self.assertFalse(result["found"])

    def test_03_broad_employment_domain_detected(self):
        domains = legal_service.detect_broad_legal_domain(
            "employer not paying me"
        )
        self.assertIn("Employment Law", domains)

    def test_04_broad_tenancy_domain_detected(self):
        domains = legal_service.detect_broad_legal_domain(
            "my landlord is causing a problem"
        )
        self.assertIn("Rental and Tenancy", domains)

    def test_05_unknown_non_legal_query_is_unsupported(self):
        with patch.object(legal_service, "_rank_cases", return_value=[]):
            result = legal_service.analyze_question(
                "write a python program to sort a list"
            )

        self.assertEqual(result["status"], "unsupported")
        self.assertFalse(result["found"])

    # ============================================================
    # IMPORTANT REGRESSION:
    # "EMPLOYER NOT PAYING ME" MUST NOT PICK PF / GRATUITY
    # ============================================================

    def test_06_employer_not_paying_me_requires_clarification(self):
        """
        This is the main regression test for the original bug.

        Lex must recognize the broad employment area but must NOT
        arbitrarily select a specific employment case.
        """

        with patch.object(legal_service, "_rank_cases", return_value=[]):
            result = legal_service.analyze_question(
                "employer not paying me"
            )

        self.assertEqual(result["status"], "needs_clarification")
        self.assertFalse(result["found"])
        self.assertEqual(result["topic"], "Employment Law")

        questions = result.get("clarifying_questions", [])
        self.assertTrue(len(questions) >= 2)

        joined = " ".join(questions).lower()

        self.assertIn("payment", joined)
        self.assertIn("employment", joined)

    def test_07_vague_employment_issue_does_not_select_specific_case(self):
        with patch.object(legal_service, "_rank_cases", return_value=[]):
            result = legal_service.analyze_question(
                "my boss has a problem with my payment"
            )

        self.assertEqual(result["status"], "needs_clarification")
        self.assertIsNone(result.get("case"))

    # ============================================================
    # AMBIGUITY TESTS
    # ============================================================

    def test_08_close_candidates_are_ambiguous(self):
        """When two WEAK candidates are close, flag ambiguous.
        Strong candidates (>= STRONG_MATCH_SCORE) answer directly
        even with a close runner-up to give faster answers."""
        case_a = make_case(
            case_id=8,
            title="Unpaid Salary / Wages",
            score=35.0,   # weak: below STRONG_MATCH_SCORE (45)
        )
        case_b = make_case(
            case_id=9,
            title="Employment Payment Dispute",
            score=30.0,   # close to case_a
        )

        with patch.object(
            legal_service,
            "_rank_cases",
            return_value=[case_a, case_b],
        ):
            result = legal_service.analyze_question(
                "employer did not pay salary for two months"
            )

        self.assertEqual(result["status"], "ambiguous")
        self.assertFalse(result["found"])
        self.assertIsNone(result.get("case"))

    def test_09_ambiguous_response_contains_multiple_candidates(self):
        candidates = [
            make_case(case_id=1, title="Case A", score=80),
            make_case(case_id=2, title="Case B", score=76),
            make_case(case_id=3, title="Case C", score=70),
        ]

        result = legal_service.build_ambiguous_response(
            "employment dispute",
            candidates,
        )

        self.assertEqual(result["status"], "ambiguous")
        self.assertEqual(len(result["candidate_cases"]), 3)
        self.assertIsNone(result["case"])

    # ============================================================
    # WEAK MATCH TESTS
    # ============================================================

    def test_10_weak_candidate_requires_clarification(self):
        """A truly weak match (below ANSWER_SCORE=30) still needs clarification."""
        weak_case = make_case(
            case_id=8,
            title="Unpaid Salary / Wages",
            score=25.0,   # below ANSWER_SCORE (30)
        )

        with patch.object(
            legal_service,
            "_rank_cases",
            return_value=[weak_case],
        ):
            result = legal_service.analyze_question(
                "salary problem"
            )

        self.assertEqual(result["status"], "needs_clarification")
        self.assertFalse(result["found"])
        self.assertIsNone(result.get("case"))

    # ============================================================
    # FACT SUFFICIENCY TESTS
    # ============================================================

    def test_11_missing_time_for_salary_case_requires_clarification(self):
        case = make_case(score=80)

        needs_clarification, missing = (
            legal_service._case_requires_clarification(
                "my employer did not pay my salary",
                case,
            )
        )

        self.assertTrue(needs_clarification)
        self.assertTrue(any("long" in item.lower() for item in missing))

    def test_12_salary_with_time_period_has_sufficient_basic_facts(self):
        case = make_case(score=80)

        needs_clarification, missing = (
            legal_service._case_requires_clarification(
                "my employer did not pay my salary for two months",
                case,
            )
        )

        self.assertFalse(needs_clarification)
        self.assertEqual(missing, [])

    # ============================================================
    # SOURCE SAFETY TESTS
    # ============================================================

    def test_13_matching_case_without_source_can_be_answered_with_caveat(self):
        case = make_case(score=80)

        with patch.object(
            legal_service,
            "_rank_cases",
            return_value=[case],
        ), patch.object(
            legal_service,
            "_fetch_sources_for_case",
            return_value=[],
        ):
            result = legal_service.analyze_question(
                "my employer did not pay my salary for two months",
                session_id="test-source-optional",
            )

        self.assertEqual(result["status"], "answered")
        self.assertTrue(result["found"])
        self.assertIsNotNone(result.get("case"))
        self.assertFalse(result.get("source_metadata_available"))
        self.assertIn("source links", result["disclaimer"].lower())

    def test_14_matching_case_with_source_can_be_answered(self):
        case = make_case(score=80)

        source = {
            "source_id": 1,
            "source_name": "Verified Legal Source",
            "source_url": "https://example.com/source",
            "source_type": "official",
            "last_verified": None,
        }

        with patch.object(
            legal_service,
            "_rank_cases",
            return_value=[case],
        ), patch.object(
            legal_service,
            "_fetch_sources_for_case",
            return_value=[source],
        ), patch.object(
            legal_service,
            "get_actions",
            return_value=[],
        ), patch.object(
            legal_service,
            "get_documents",
            return_value=[],
        ), patch.object(
            legal_service,
            "get_options",
            return_value=[],
        ):
            result = legal_service.analyze_question(
                "my employer did not pay my salary for two months"
            )

        self.assertEqual(result["status"], "answered")
        self.assertTrue(result["found"])
        self.assertIsNotNone(result["case"])
        self.assertEqual(result["case"]["case_id"], 8)
        self.assertEqual(len(result["sources"]), 1)

    # ============================================================
    # DATABASE AVAILABILITY TEST
    # ============================================================

    def test_15_database_unavailable_never_falls_back_to_hardcoded_case(self):
        with patch.object(
            legal_service,
            "_rank_cases",
            return_value=None,
        ):
            result = legal_service.analyze_question(
                "my employer did not pay my salary for two months"
            )

        self.assertEqual(result["status"], "knowledge_unavailable")
        self.assertFalse(result["found"])
        self.assertIsNone(result.get("case"))

    # ============================================================
    # NO RANDOM CASE FALLBACK
    # ============================================================

    def test_16_no_candidate_never_returns_a_case(self):
        with patch.object(legal_service, "_rank_cases", return_value=[]):
            result = legal_service.analyze_question(
                "employer not paying me"
            )

        self.assertIsNone(result.get("case"))

    def test_17_find_legal_case_returns_none_for_non_answer(self):
        with patch.object(legal_service, "_rank_cases", return_value=[]):
            result = legal_service.find_legal_case(
                "employer not paying me"
            )

        self.assertIsNone(result)

    # ============================================================
    # FACT EXTRACTION TESTS
    # ============================================================

    def test_18_explicit_facts_do_not_invent_legal_conclusion(self):
        facts = legal_service.extract_explicit_facts(
            "my employer did not pay me for two months and I have a payslip"
        )

        self.assertEqual(facts["domain"], "employment")
        self.assertIn("two months", facts["time_periods"])
        self.assertIn("employer", facts["mentioned_parties"])
        self.assertIn("payslip", facts["mentioned_documents"])

        # The extractor must not invent a legal violation or entitlement.
        self.assertNotIn("violation", facts)
        self.assertNotIn("liability", facts)
        self.assertNotIn("entitlement", facts)

    # ============================================================
    # CHAT SERVICE STATUS DISPATCH TESTS
    # ============================================================

    def test_19_chat_service_preserves_clarification_status(self):
        fake_information = {
            "status": "needs_clarification",
            "confidence": 0.0,
            "found": False,
            "is_topic_selection": False,
            "title": "More Information Needed",
            "situation_assessment": "More facts are required.",
            "explanation": "Please provide more details.",
            "clarifying_questions": [
                "What happened?",
                "How long has this been happening?",
            ],
            "actions": [],
            "preventions": [],
            "documents": [],
            "options": [],
            "candidate_cases": [],
            "case": None,
            "sources": [],
            "jurisdiction": "India",
            "disclaimer": "Clarification only.",
        }

        with patch.object(
            chat_service,
            "get_legal_information",
            return_value=fake_information,
        ):
            result = chat_service.answer_question(
                "employer not paying me"
            )

        self.assertEqual(result["status"], "needs_clarification")
        self.assertFalse(result["found"])
        self.assertTrue(result["requires_user_input"])

    def test_20_chat_service_preserves_unsupported_status(self):
        fake_information = {
            "status": "unsupported",
            "confidence": 0.0,
            "found": False,
            "is_topic_selection": False,
            "title": "No Reliable Match Found",
            "situation_assessment": "No reliable match.",
            "explanation": "Lex cannot support this from its database.",
            "clarifying_questions": [],
            "actions": [],
            "preventions": [],
            "documents": [],
            "options": [],
            "candidate_cases": [],
            "case": None,
            "sources": [],
            "jurisdiction": "India",
            "disclaimer": "Unsupported.",
        }

        with patch.object(
            chat_service,
            "get_legal_information",
            return_value=fake_information,
        ):
            result = chat_service.answer_question(
                "something unrelated"
            )

        self.assertEqual(result["status"], "unsupported")
        self.assertFalse(result["found"])

    # ============================================================
    # ENTITY, PRONOUN, MEMORY & VIOLATION TESTS
    # ============================================================

    def test_21_remember_person_name_and_pronouns(self):
        import fact_memory
        sess_id = "test-mem-entity"
        mem = fact_memory.get_or_create_memory(sess_id)
        fact_memory.extract_and_merge_facts(
            "My landlord Ramesh refused to pay my security deposit. He said he won't give it back.",
            mem
        )
        self.assertEqual(mem.primary_party["name"], "Ramesh")
        self.assertEqual(mem.primary_party["role"], "landlord")
        self.assertIn("he", mem.pronouns_used)
        self.assertEqual(mem.primary_party["gender"], "male")

    def test_22_remember_specific_details(self):
        import fact_memory
        sess_id = "test-mem-details"
        mem = fact_memory.get_or_create_memory(sess_id)
        fact_memory.extract_and_merge_facts(
            "My boss Mr. Sharma withheld my 2 months salary of Rs 60,000 for a long time.",
            mem
        )
        self.assertTrue(any("60000" in amt or "60,000" in amt for amt in mem.amounts))
        self.assertIn("2 months", mem.timeframes)
        self.assertIn("Mr. Sharma", mem.primary_party["name"])

    def test_23_vague_situation_asks_for_more_details(self):
        sess_id = "test-vague-clarify"
        result = legal_service.analyze_question("my landlord is causing problems with me", session_id=sess_id)
        self.assertEqual(result["status"], "needs_clarification")
        self.assertFalse(result["found"])
        self.assertTrue(len(result["clarifying_questions"]) >= 2)

    def test_24_progressive_clarification_until_understood(self):
        import fact_memory
        sess_id = "test-progressive-1"
        # Turn 1: Vague
        res1 = legal_service.analyze_question("I have an issue with my employer", session_id=sess_id)
        self.assertEqual(res1["status"], "needs_clarification")

        # Turn 2: User supplies name and conflict
        res2 = legal_service.analyze_question(
            "His name is Mr. Sharma and he withheld my salary of Rs 50,000 for 3 months without reason",
            session_id=sess_id
        )
        # Should now understand the situation and answer or give violation
        self.assertTrue(res2["found"] or len(res2.get("clarifying_questions", [])) <= 1)
        if res2["found"]:
            self.assertEqual(res2["status"], "answered")
            self.assertIn("Unlawful Withholding", res2.get("violation_name", ""))
            self.assertIn("Sharma", res2.get("situation_assessment", ""))

    def test_25_violation_name_steps_and_documents_present(self):
        sess_id = "test-violation-full"
        result = legal_service.analyze_question(
            "My landlord Ramesh has not returned my security deposit of Rs 50,000 after vacating the flat for 2 months. He refuses to answer.",
            session_id=sess_id
        )
        self.assertEqual(result["status"], "answered")
        self.assertTrue(result["found"])
        # Check name of violation
        self.assertTrue(bool(result.get("violation_name")))
        self.assertIn("Security Deposit", result["violation_name"])
        # Check steps to handle the situation
        self.assertTrue(len(result["actions"]) >= 1)
        # Check documents needed
        self.assertTrue(len(result["documents"]) >= 1)
        # Check personalized detail
        self.assertIn("Ramesh", result["situation_assessment"])

    def test_26_tenancy_progressive_clarification_with_pronouns_and_name(self):
        sess_id = "test-tenancy-multi"
        # Turn 1: Vague
        res1 = legal_service.analyze_question("My landlord is causing issues", session_id=sess_id)
        self.assertEqual(res1["status"], "needs_clarification")

        # Turn 2: User provides Mr. Gupta, amount, duration, and deposit conflict
        res2 = legal_service.analyze_question(
            "His name is Mr. Gupta. He took Rs 45,000 security deposit and is refusing to return it even though I vacated 1 month ago.",
            session_id=sess_id
        )
        self.assertEqual(res2["status"], "answered")
        self.assertTrue(res2["found"])
        self.assertIn("Security Deposit", res2.get("violation_name", ""))
        self.assertIn("Mr. Gupta", res2.get("situation_assessment", ""))
        self.assertIn("he", res2.get("remembered_details", {}).get("pronouns_used", []))
        self.assertTrue(len(res2.get("actions", [])) >= 2)
        self.assertTrue(len(res2.get("documents", [])) >= 2)

    def test_27_consultation_scoping_detects_unrelated_matter(self):
        import app
        client = app.app.test_client()
        sess_id = "test-scoping-sess"

        # Turn 1: Conclude a tenancy matter
        t1 = client.post("/api/chat", json={
            "message": "My landlord Ramesh has not returned my security deposit of Rs 50,000 after vacating the flat for 2 months. He refuses to answer.",
            "session_id": sess_id
        })
        self.assertEqual(t1.status_code, 200)
        d1 = t1.get_json()
        self.assertEqual(d1.get("status"), "answered")

        # Turn 2: In the same consultation, ask about an unrelated employment matter
        t2 = client.post("/api/chat", json={
            "message": "My employer has not paid my salary for two months and is withholding wages",
            "session_id": sess_id
        })
        self.assertEqual(t2.status_code, 200)
        d2 = t2.get_json()
        self.assertEqual(d2.get("status"), "new_consultation_required")
        self.assertTrue(d2.get("requires_user_input"))
        self.assertIn("New Consultation Required", d2.get("title", ""))

    def test_28_consultation_scoping_allows_same_case_followup(self):
        import app
        client = app.app.test_client()
        sess_id = "test-followup-sess"

        # Turn 1: Conclude a tenancy matter
        t1 = client.post("/api/chat", json={
            "message": "My landlord Ramesh has not returned my security deposit of Rs 50,000 after vacating the flat for 2 months. He refuses to answer.",
            "session_id": sess_id
        })
        self.assertEqual(t1.status_code, 200)
        d1 = t1.get_json()
        self.assertEqual(d1.get("status"), "answered")

        # Turn 2: Ask a follow-up about the active case
        t2 = client.post("/api/chat", json={
            "message": "What if Ramesh still refuses to pay after the notice? Can I claim interest on the 50,000?",
            "session_id": sess_id
        })
        self.assertEqual(t2.status_code, 200)
        d2 = t2.get_json()
        self.assertNotEqual(d2.get("status"), "new_consultation_required")
        self.assertEqual(d2.get("status"), "answered")

    # ============================================================
    # SUMMARY
    # ============================================================


def run_tests():
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(
        LexTestCase
    )

    runner = unittest.TextTestRunner(
        verbosity=1
    )

    result = runner.run(suite)

    total = result.testsRun
    failed = len(result.failures) + len(result.errors)
    passed = total - failed

    print()
    print("=" * 60)
    print("TEST SUMMARY")
    print("=" * 60)
    print(f"Passed:  {passed}")
    print(f"Failed:  {failed}")
    print(f"Total:   {total}")
    print("=" * 60)

    if failed == 0:
        print("RESULT: ALL TESTS PASSED")
    else:
        print("RESULT: SOME TESTS FAILED")

    return 0 if failed == 0 else 1


if __name__ == "__main__":
    sys.exit(run_tests())
