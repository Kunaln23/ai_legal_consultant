# ================================================================
# LEX CHAT SERVICE
# Status-aware response adapter for the legal service.
# ================================================================

from typing import Any, Dict, Optional

from legal_service import get_legal_information


DEFAULT_DISCLAIMER = (
    "Lex provides database-backed general legal information for Indian-law "
    "situations. It does not replace advice from a qualified lawyer. A "
    "database match does not by itself establish that a particular offence, "
    "violation, liability, remedy, deadline, or legal entitlement applies "
    "to your specific facts."
)


def _base_response(information: Dict[str, Any]) -> Dict[str, Any]:
    """Copy the stable response contract used by the frontend."""
    return {
        "success": True,
        "status": information.get("status", "unsupported"),
        "confidence": information.get("confidence", 0.0),
        "found": information.get("found", False),
        "requires_user_input": information.get("requires_user_input", False),
        "is_topic_selection": information.get("is_topic_selection", False),
        "title": information.get("title", "Lex"),
        "violation_name": information.get("violation_name", ""),
        "violation_statute": information.get("violation_statute", ""),
        "violation_type": information.get("violation_type", ""),
        "violation_category": information.get("violation_category", ""),
        "remembered_details": information.get("remembered_details", {}),
        "situation_assessment": information.get("situation_assessment", ""),
        "explanation": information.get("explanation", ""),
        "clarifying_questions": information.get("clarifying_questions", []),
        "preventions": information.get("preventions", []),
        "actions": information.get("actions", []),
        "documents": information.get("documents", []),
        "options": information.get("options", []),
        "candidate_cases": information.get("candidate_cases", []),
        "case": information.get("case"),
        "sources": information.get("sources", []),
        "jurisdiction": information.get("jurisdiction", "India"),
        "disclaimer": information.get("disclaimer", DEFAULT_DISCLAIMER),
    }


def _build_clarification_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "needs_clarification",
            "found": False,
            "requires_user_input": True,
            "case": None,
        }
    )
    return response


def _build_ambiguous_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "ambiguous",
            "found": False,
            "requires_user_input": True,
            "case": None,
        }
    )
    return response


def _build_unsupported_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "unsupported",
            "found": False,
            "requires_user_input": False,
            "case": None,
        }
    )
    return response


def _build_unavailable_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "knowledge_unavailable",
            "found": False,
            "requires_user_input": False,
            "case": None,
        }
    )
    return response


def _build_out_of_scope_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "out_of_scope",
            "found": False,
            "requires_user_input": False,
            "case": None,
        }
    )
    return response


def _build_topic_selection_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "topic_selection",
            "found": False,
            "requires_user_input": True,
            "is_topic_selection": True,
            "case": None,
        }
    )
    return response


def _build_answer_response(information: Dict[str, Any]) -> Dict[str, Any]:
    response = _base_response(information)
    response.update(
        {
            "status": "answered",
            "found": True,
            "requires_user_input": False,
            "is_topic_selection": False,
        }
    )
    return response


def answer_question(question: str, session_id: Optional[str] = None) -> Dict[str, Any]:
    """Return a frontend-safe response without changing legal reasoning."""
    try:
        information = get_legal_information(question, session_id=session_id)
    except Exception as exc:
        print("Chat service error:", exc)
        return {
            "success": False,
            "status": "knowledge_unavailable",
            "confidence": 0.0,
            "found": False,
            "requires_user_input": False,
            "is_topic_selection": False,
            "title": "Legal Knowledge Database Unavailable",
            "situation_assessment": "Lex could not safely process the legal knowledge request.",
            "explanation": "No unverified fallback legal answer will be generated.",
            "clarifying_questions": [],
            "preventions": [],
            "actions": [],
            "documents": [],
            "options": [],
            "candidate_cases": [],
            "case": None,
            "sources": [],
            "jurisdiction": "India",
            "disclaimer": DEFAULT_DISCLAIMER,
        }

    if not information:
        return _build_unsupported_response(
            {
                "status": "unsupported",
                "title": "No Reliable Match Found",
                "situation_assessment": "Lex could not identify a sufficiently reliable supported legal issue.",
                "explanation": "Lex will not invent a legal case or remedy from a weak match.",
            }
        )

    status = information.get("status", "unsupported")

    if information.get("is_topic_selection") or status == "topic_selection":
        return _build_topic_selection_response(information)

    if status == "answered":
        return _build_answer_response(information)

    if status == "needs_clarification":
        return _build_clarification_response(information)

    if status == "ambiguous":
        return _build_ambiguous_response(information)

    if status == "knowledge_unavailable":
        return _build_unavailable_response(information)

    if status == "out_of_scope":
        return _build_out_of_scope_response(information)

    return _build_unsupported_response(information)


def is_successful_answer(result: Optional[Dict[str, Any]]) -> bool:
    return bool(result and result.get("status") == "answered" and result.get("found"))


def requires_user_input(result: Optional[Dict[str, Any]]) -> bool:
    if not result:
        return False
    return bool(
        result.get("requires_user_input")
        or result.get("status") in {"needs_clarification", "ambiguous", "topic_selection"}
    )


def is_safe_non_answer(result: Optional[Dict[str, Any]]) -> bool:
    if not result:
        return True
    return result.get("status") in {
        "needs_clarification",
        "ambiguous",
        "unsupported",
        "out_of_scope",
        "knowledge_unavailable",
        "topic_selection",
    }
