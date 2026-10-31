# ==================================================
# LEX BACKEND
# AI LEGAL CONSULTANT & CASE DESK
# ==================================================

import json
import os
import time
import random
import uuid
import re

from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS

from database import get_connection
from chat_service import answer_question
from legal_service import get_all_topics
from fact_memory import SESSION_MEMORIES
from consultation_rules import select_next_clarification, MAX_FOLLOWUP_QUESTIONS, is_same_domain_continuation
from config import HOST, PORT, DEBUG


# ==================================================
# CREATE FLASK APP
# ==================================================

# Resolve frontend directory (one level up from backend/)
_BACKEND_DIR = os.path.dirname(os.path.abspath(__file__))
_FRONTEND_DIR = os.path.normpath(os.path.join(_BACKEND_DIR, "..", "frontend"))

app = Flask(__name__, static_folder=_FRONTEND_DIR, static_url_path="")

CORS(
    app,
    resources={
        r"/*": {
            "origins": "*"
        }
    }
)


# ==================================================
# FRONTEND STATIC FILE SERVING
# ==================================================

@app.route("/")
def serve_index():
    return send_from_directory(_FRONTEND_DIR, "index.html")

@app.route("/<path:filename>")
def serve_static(filename):
    # Try to serve any file from the frontend directory
    if os.path.exists(os.path.join(_FRONTEND_DIR, filename)):
        return send_from_directory(_FRONTEND_DIR, filename)
    # Fallback: serve index.html (SPA routing)
    return send_from_directory(_FRONTEND_DIR, "index.html")


# ==================================================
# HOME / STATUS  (API)
# ==================================================

@app.route("/api/status", methods=["GET"])
def home():
    return jsonify({
        "success": True,
        "name": "Lex AI Legal Consultant API",
        "status": "online",
        "jurisdiction": "India",
        "version": "3.1.0"
    })


# ==================================================
# USER LOGIN / REGISTER API
# ==================================================

@app.route("/api/login", methods=["POST"])
def login():
    try:
        data = request.get_json() or {}

        first_name = data.get("first_name", "").strip()
        last_name = data.get("last_name", "").strip()
        email = data.get("email", "").strip()
        password = data.get("password", "").strip()

        if not email or not password:
            return jsonify({
                "success": False,
                "error": "Email and password are required."
            }), 400

        full_name = f"{first_name} {last_name}".strip()

        if not full_name:
            full_name = email.split("@")[0].capitalize()

        old_session_id = data.get("session_id") or data.get("old_session_id")
        if old_session_id:
            ACTIVE_CONSULTATIONS.pop(old_session_id, None)
            SESSION_MEMORIES.pop(old_session_id, None)

        session_id = (
            f"LEX-SESS-{int(time.time())}-"
            f"{random.randint(100, 999)}"
        )

        return jsonify({
            "success": True,
            "message": "Login successful.",
            "session_id": session_id,
            "user": {
                "name": full_name,
                "first_name": first_name or full_name,
                "last_name": last_name,
                "email": email,
                "session_id": session_id,
                "created_at": time.strftime(
                    "%Y-%m-%d %H:%M:%S"
                )
            }
        })

    except Exception as error:
        print("Login error:", error)

        return jsonify({
            "success": False,
            "error": "Failed to process login."
        }), 500


# ==================================================
# NEW SESSION API
# ==================================================

@app.route("/api/session/new", methods=["POST"])
def new_session():
    try:
        data = request.get_json() or {}

        user_email = (
            data.get(
                "user_email",
                "guest@lex.local"
            )
            or "guest@lex.local"
        )

        old_session_id = data.get("session_id") or data.get("old_session_id")
        if old_session_id:
            ACTIVE_CONSULTATIONS.pop(old_session_id, None)
            SESSION_MEMORIES.pop(old_session_id, None)

        session_id = (
            f"LEX-SESS-{int(time.time())}-"
            f"{random.randint(100, 999)}"
        )

        return jsonify({
            "success": True,
            "session_id": session_id,
            "user_email": user_email,
            "created_at": time.strftime(
                "%Y-%m-%d %H:%M:%S"
            )
        })

    except Exception as error:
        print("New session error:", error)

        return jsonify({
            "success": False,
            "error": str(error)
        }), 500


# ==================================================
# CONSULTATION CONTEXT HELPERS
# ==================================================

PENDING_STATUSES = {
    "needs_clarification",
    "ambiguous"
}

# Active consultation context for the running Flask process.
# Keyed by session_id so follow-up messages stay in the same
# consultation without depending only on the latest DB row.
ACTIVE_CONSULTATIONS = {}


def safe_json_load(value):
    """
    Safely decode the stored Lex response.

    Returns None when case_json is missing or invalid.
    """

    if not value:
        return None

    try:
        parsed = json.loads(value)

        if isinstance(parsed, dict):
            return parsed

    except Exception:
        pass

    return None


def is_followup_query(text, last_case_data):
    """Detect whether user message is continuing a previous answered matter."""
    if not text or not last_case_data:
        return False
    t = text.lower()
    followup_signals = [
        "what if", "can he", "can she", "can they", "will he", "will she",
        "will they", "what about", "is he", "is she", "how can he", "should he",
        "should i", "can i", "could i", "how do i", "how can i", "how to",
        "how long", "what if he", "what if she", "if he", "if she", "if they",
        "he still", "she still", "they still", "interest", "court", "police",
        "jail", "notice", "lawyer", "advocate", "fees", "expenses", "compensation",
        "damage", "damages", "evidence", "witness", "settlement", "hearing",
        "deadline", "limitation", "appeal", "tribunal", "commissioner", "rent authority",
        "consumer forum", "labour", "fir", "complaint", "refuse", "still not", "delay"
    ]
    if any(sig in t for sig in followup_signals):
        return True

    # Messages that describe another part of the same broad legal matter
    # (for example, termination followed by unpaid salary) are continuations
    # even when the user does not phrase them as a question about the first turn.
    previous_context = " ".join(str(last_case_data.get(key) or "") for key in (
        "consultation_context", "user_query", "title", "topic", "violation_name"
    ))
    case_info = last_case_data.get("case") or {}
    if isinstance(case_info, dict):
        previous_context += " " + " ".join(str(case_info.get(key) or "") for key in (
            "case_title", "topic_name", "situation"
        ))
    if is_same_domain_continuation(text, previous_context):
        return True

    rem = last_case_data.get("remembered_details") or {}
    for p in rem.get("parties", []):
        p_name = p.get("name", "").lower()
        if p_name and p_name in t:
            return True
        p_role = p.get("role", "").lower()
        if p_role and p_role in t:
            return True
    for amt in rem.get("amounts", []):
        cleaned_amt = re.sub(r"[^\d]", "", amt)
        if cleaned_amt and cleaned_amt in t:
            return True
    return False


def detect_same_domain_issue_facets(text):
    """Identify distinct fact patterns within one broad legal domain.

    This labels issues for consultation continuity only; it does not decide
    liability or select statutory provisions.
    """
    value = re.sub(r"\s+", " ", str(text or "").lower())
    facets = []
    employment_patterns = [
        ("Termination without notice or stated reason", r"\b(terminat(?:ed|ion)|fired|dismissed|let go)\b"),
        ("Unpaid salary or withheld wages", r"\b(unpaid salary|salary (?:has )?not been paid|(?:has\s+)?not paid (?:my )?salary|withheld (?:my )?salary|wages? (?:not paid|unpaid)|pending salary|salary arrears)\b"),
        ("Unpaid overtime or statutory employment dues", r"\b(overtime|provident fund|\bpf\b|gratuity|leave encashment)\b"),
    ]
    for label, pattern in employment_patterns:
        if re.search(pattern, value):
            facets.append(label)
    return facets


def get_pending_consultation(
    session_id,
    user_email,
    consultation_id=None,
    current_question=""
):
    """
    Return only the MOST RECENT pending consultation.

    We intentionally do not load the complete history.

    A previous conversation is considered active only when
    its latest Lex response has one of these statuses:

        needs_clarification
        ambiguous

    This prevents an unrelated old consultation from being
    silently included in a new legal question.
    """

    if not session_id:
        return None

    # Prefer the live in-memory consultation context. This is the
    # most reliable path for consecutive messages in one browser session.
    live = ACTIVE_CONSULTATIONS.get(session_id)

    if live:
        same_user = (
            not user_email
            or live.get("user_email") in (None, "", user_email)
            or user_email == "guest@lex.local"
        )
        same_consultation = (
            not consultation_id
            or live.get("consultation_id") == consultation_id
        )

        if (
            same_user
            and same_consultation
            and (
                live.get("status") in PENDING_STATUSES
                or (
                    live.get("status") == "answered"
                    and is_followup_query(current_question, live.get("case_data"))
                )
            )
        ):
            return {
                "id": live.get("id"),
                "user_message": live.get("user_message", ""),
                "context_text": live.get("context_text", ""),
                "topic": live.get("topic", "General"),
                "case_data": live.get("case_data", {}),
                "followup_count": live.get("followup_count", 0),
                "questions_asked": live.get("questions_asked", 0)
            }

    connection = get_connection()

    if connection is None:
        return None

    cursor = None

    try:
        cursor = connection.cursor(
            dictionary=True
        )

        query = """
            SELECT
                id,
                user_message,
                lex_response,
                topic,
                session_id,
                user_email,
                case_json,
                created_at
            FROM conversations
            WHERE session_id = %s
        """

        params = [session_id]

        if (
            user_email
            and user_email != "guest@lex.local"
        ):
            query += """
                AND (
                    user_email = %s
                    OR user_email IS NULL
                )
            """

            params.append(user_email)

        query += """
            ORDER BY id DESC
            LIMIT 1
        """

        cursor.execute(
            query,
            tuple(params)
        )

        row = cursor.fetchone()

        if not row:
            return None

        case_data = safe_json_load(
            row.get("case_json")
        )

        if not case_data:
            return None

        status = case_data.get("status")

        if status not in PENDING_STATUSES and not (
            status == "answered" and is_followup_query(current_question, case_data)
        ):
            return None

        return {
            "id": row.get("id"),
            "user_message": (
                row.get("user_message")
                or ""
            ),
            "context_text": (
                case_data.get("consultation_context")
                or row.get("user_message")
                or ""
            ),
            "topic": (
                row.get("topic")
                or "General"
            ),
            "case_data": case_data,
            "followup_count": case_data.get("followup_count", 0),
            "questions_asked": case_data.get("questions_asked", 0)
        }

    except Exception as error:
        print(
            "Pending consultation lookup error:",
            error
        )
        return None

    finally:
        try:
            if cursor:
                cursor.close()
        except Exception:
            pass

        try:
            connection.close()
        except Exception:
            pass


def build_consultation_question(
    previous_question,
    current_question
):
    """
    Combine the immediately previous pending legal
    situation with the user's new information.

    Only the latest pending consultation reaches this
    function. Older unrelated conversations are excluded.
    """

    previous_question = (
        previous_question or ""
    ).strip()

    current_question = (
        current_question or ""
    ).strip()

    if not previous_question:
        return current_question

    if not current_question:
        return previous_question

    return (
        "Original legal situation:\n"
        f"{previous_question}\n\n"
        "Additional facts provided by the user:\n"
        f"{current_question}"
    )




# ==================================================
# CHAT API
# ==================================================

@app.route("/api/chat", methods=["POST"])
def chat():
    try:
        data = request.get_json()

        if not data:
            return jsonify({
                "success": False,
                "error": "Request body is empty."
            }), 400

        question = (
            data.get("message", "")
            or ""
        ).strip()

        user_email = (
            data.get(
                "user_email",
                "guest@lex.local"
            )
            or "guest@lex.local"
        ).strip()

        session_id = (
            data.get("session_id")
            or f"LEX-SESS-{int(time.time())}"
        ).strip()

        consultation_id = (
            data.get("consultation_id")
            or None
        )

        if not question:
            return jsonify({
                "success": False,
                "error": (
                    "Please enter a legal question "
                    "or situation."
                )
            }), 400

        # --------------------------------------------------
        # Consultation Scoping Check:
        # A consultation is strictly applicable to that exact case.
        # To consult on a different case, the user should create
        # a new consultation.
        # --------------------------------------------------
        live = ACTIVE_CONSULTATIONS.get(session_id)
        if live and live.get("status") == "answered":
            is_same_matter = is_followup_query(question, live.get("case_data"))
            if not is_same_matter:
                from legal_service import detect_broad_legal_domain
                new_domains = detect_broad_legal_domain(question)
                active_case_data = live.get("case_data") or {}
                active_topic = active_case_data.get("topic") or live.get("topic") or "Active Case"
                active_title = active_case_data.get("title") or active_case_data.get("case_title") or "Ongoing Consultation"

                is_different_domain = False
                if new_domains and not any(
                    d.lower() in active_topic.lower() or active_topic.lower() in d.lower()
                    for d in new_domains
                ):
                    is_different_domain = True

                if is_different_domain:
                    new_domain_label = new_domains[0]
                    return jsonify({
                        "success": True,
                        "status": "new_consultation_required",
                        "found": False,
                        "requires_user_input": True,
                        "title": "New Consultation Required for Different Case",
                        "active_case_title": active_title,
                        "active_topic": active_topic,
                        "new_topic_detected": new_domain_label,
                        "pending_new_query": question,
                        "situation_assessment": (
                            f"This consultation is dedicated exclusively to your active case: '{active_title}' ({active_topic}). "
                            f"Your new message introduces a different legal matter ({new_domain_label}). "
                            "To keep your statutory provisions, document checklists, and official Case Briefs separated and accurate, "
                            "please start a new consultation for this issue."
                        ),
                        "explanation": (
                            "Under Indian law, unrelated causes of action must be evaluated separately. "
                            "Starting a separate consultation preserves your current case document while providing "
                            "tailored advice for your new situation."
                        ),
                        "clarifying_questions": [
                            f"Would you like to start a new consultation for: \"{question}\"?",
                            "Or continue asking follow-up questions regarding your current active case?"
                        ],
                        "actions": [
                            "Click '+ Open New Consultation' below to start a dedicated consultation for this case.",
                            "Your current case brief remains saved in your History panel."
                        ],
                        "disclaimer": "Consultation scoping ensures each case maintains its own clean legal brief and document checklist."
                    })

        # --------------------------------------------------
        # Find only an active pending consultation
        # --------------------------------------------------

        pending = get_pending_consultation(
            session_id,
            user_email,
            consultation_id,
            current_question=question
        )

        effective_question = question

        if pending:
            effective_question = (
                build_consultation_question(
                    pending.get(
                        "context_text",
                        pending.get("user_message", "")
                    ),
                    question
                )
            )

        # --------------------------------------------------
        # Generate Lex response
        # --------------------------------------------------

        result = answer_question(
            effective_question,
            session_id=session_id
        )

        if not isinstance(result, dict):
            result = {
                "success": False,
                "status": "unsupported",
                "found": False,
                "requires_user_input": False,
                "is_topic_selection": False,
                "title": (
                    "Unable to Provide a "
                    "Reliable Legal Response"
                ),
                "situation_assessment": (
                    "Lex could not produce a valid "
                    "structured legal response."
                ),
                "explanation": (
                    "No reliable legal analysis was "
                    "returned."
                ),
                "actions": [],
                "documents": [],
                "options": [],
                "preventions": [],
                "sources": [],
                "case": None,
                "candidate_cases": [],
                "case_ref": None,
                "disclaimer": (
                    "Lex provides automated legal "
                    "information for guidance and "
                    "does not replace advice from "
                    "a qualified lawyer."
                )
            }

        # Preserve distinct employment issues mentioned over multiple turns.
        # This is issue labelling only; case-specific statutory analysis remains
        # tied to the verified database record returned by legal_service.
        employment_facets = detect_same_domain_issue_facets(effective_question)
        if len(employment_facets) > 1:
            result["identified_legal_issues"] = employment_facets
            result["multiple_issues_detected"] = True
            result["topic"] = result.get("topic") or "Employment Law"
            result["title"] = "Employment dispute: termination and unpaid salary"
            existing_assessment = str(result.get("situation_assessment") or "").strip()
            issue_note = (
                "The facts provided raise more than one employment issue: "
                + "; ".join(employment_facets)
                + ". These issues are related but may require separate checks of the appointment terms, "
                  "applicable state law, establishment type, and wage records."
            )
            if issue_note.lower() not in existing_assessment.lower():
                result["situation_assessment"] = (issue_note + "\n\n" + existing_assessment).strip()

        # --------------------------------------------------
        # Consultation metadata
        # --------------------------------------------------

        if not consultation_id:
            if pending and pending.get("case_data"):
                consultation_id = (
                    pending["case_data"].get(
                        "consultation_id"
                    )
                )

        if not consultation_id:
            consultation_id = (
                f"LEX-CONS-{uuid.uuid4().hex[:16]}"
            )

        result["session_id"] = session_id
        result["consultation_id"] = (
            consultation_id
        )

        # Preserve exactly what the user typed.
        result["user_query"] = question

        result["continued_consultation"] = (
            pending is not None
        )

        # Preserve the accumulated consultation context so a later
        # follow-up does not lose facts from earlier turns.
        consultation_context = effective_question
        result["consultation_context"] = consultation_context
        result["consultation_messages"] = (
            list((pending.get("case_data") or {}).get("consultation_messages", []))
            if pending else []
        ) + [question]

        # Count user replies to Lex's clarification prompts. The initial
        # problem description is turn zero; no consultation may ask more
        # than four follow-up questions.
        followup_count = (pending.get("followup_count", 0) + 1) if pending else 0
        result["followup_count"] = followup_count

        # Never display a clarification question when the answer is already
        # present in the original description or any later user reply.
        questions_asked = pending.get("questions_asked", 0) if pending else 0
        question_budget = max(0, MAX_FOLLOWUP_QUESTIONS - questions_asked)
        filtered_questions = select_next_clarification(
            result.get("clarifying_questions", []),
            consultation_context,
            questions_asked
        )[:question_budget]
        questions_asked += len(filtered_questions)
        result["clarifying_questions"] = filtered_questions
        result["questions_asked"] = questions_asked
        if result.get("status") in PENDING_STATUSES:
            result["actions"] = list(filtered_questions)
        if result.get("status") in PENDING_STATUSES and not filtered_questions:
            # No useful unanswered question remains, or the four-question
            # budget has been used. Never send a blank/repeated question turn.
            result["status"] = "unsupported"
            result["found"] = False
            result["requires_user_input"] = False
            result["title"] = "Unable to Confirm a Specific Legal Case"
            result["situation_assessment"] = (
                "Lex has used the available clarification questions but still cannot confirm a specific legal case "
                "from the facts supplied. It will not guess or label an unsupported claim as established."
            )
            result["explanation"] = (
                "A qualified Indian lawyer can review the complete facts and supporting documents to determine "
                "the correct legal route."
            )
            result["actions"] = []

        # Keep active consultation in memory so follow-up inquiries stay contextual
        ACTIVE_CONSULTATIONS[session_id] = {
            "id": pending.get("id") if pending else None,
            "user_email": user_email,
            "consultation_id": consultation_id,
            "status": result.get("status"),
            "followup_count": followup_count,
            "questions_asked": questions_asked,
            "context_text": consultation_context,
            "user_message": question,
            "topic": result.get("topic", "General"),
            "case_data": result
        }

        # --------------------------------------------------
        # Save the conversation
        # --------------------------------------------------

        save_conversation(
            question=question,
            result=result,
            user_email=user_email,
            session_id=session_id
        )

        return jsonify(result)

    except Exception as error:
        print("Chat error:", error)

        return jsonify({
            "success": False,
            "error": (
                "Something went wrong while processing "
                "your legal consultation."
            )
        }), 500


# ==================================================
# SAVE CONVERSATION
# ==================================================

def save_conversation(
    question,
    result,
    user_email="guest@lex.local",
    session_id=None
):
    """
    Save the user's actual message and the complete
    structured Lex response.

    case_json contains the response status, allowing the
    next request to determine whether a consultation is
    still awaiting clarification.
    """

    connection = get_connection()

    if connection is None:
        print(
            "Conversation was not saved: "
            "database unavailable."
        )
        return

    cursor = None

    try:
        cursor = connection.cursor()

        response_text = (
            f"{result.get('title', '')}\n\n"
            f"{result.get('situation_assessment', '')}\n\n"
            f"{result.get('explanation', '')}"
        )

        case_json_str = json.dumps(
            result,
            ensure_ascii=False,
            default=str
        )

        cursor.execute("""
            CREATE TABLE IF NOT EXISTS conversations (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_message TEXT NOT NULL,
                lex_response TEXT NOT NULL,
                topic VARCHAR(255)
                    DEFAULT 'General',
                session_id VARCHAR(100)
                    DEFAULT NULL,
                user_email VARCHAR(255)
                    DEFAULT NULL,
                case_json LONGTEXT
                    DEFAULT NULL,
                created_at TIMESTAMP
                    DEFAULT CURRENT_TIMESTAMP
            )
            ENGINE=InnoDB
            DEFAULT CHARSET=utf8mb4;
        """)

        query = """
            INSERT INTO conversations (
                user_message,
                lex_response,
                topic,
                session_id,
                user_email,
                case_json
            )
            VALUES (
                %s,
                %s,
                %s,
                %s,
                %s,
                %s
            )
        """

        cursor.execute(
            query,
            (
                question,
                response_text,
                result.get(
                    "topic",
                    "General"
                ),
                session_id,
                user_email,
                case_json_str
            )
        )

        connection.commit()

    except Exception as error:
        print(
            "Error saving conversation:",
            error
        )

    finally:
        try:
            if cursor:
                cursor.close()
        except Exception:
            pass

        try:
            connection.close()
        except Exception:
            pass


# ==================================================
# GET TOPICS API
# ==================================================

@app.route("/api/topics", methods=["GET"])
def topics():
    try:
        topic_list = get_all_topics()

        return jsonify({
            "success": True,
            "topics": topic_list
        })

    except Exception as error:
        print(
            "Topics error:",
            error
        )

        return jsonify({
            "success": False,
            "error": "Failed to fetch topics."
        }), 500


# ==================================================
# GET HISTORY API
# ==================================================

@app.route("/api/history", methods=["GET"])
def history():
    connection = get_connection()

    if connection is None:
        return jsonify({
            "success": False,
            "history": []
        })

    cursor = None

    try:
        user_email = request.args.get(
            "user_email"
        )

        session_id = request.args.get(
            "session_id"
        )

        cursor = connection.cursor(
            dictionary=True
        )

        query = """
            SELECT
                id,
                user_message,
                topic,
                session_id,
                user_email,
                case_json,
                created_at
            FROM conversations
        """

        params = []

        if (
            user_email
            and user_email != "guest@lex.local"
        ):
            query += """
                WHERE user_email = %s
            """
            params.append(user_email)

        elif session_id:
            query += """
                WHERE session_id = %s
            """
            params.append(session_id)

        query += """
            ORDER BY id DESC
            LIMIT 25
        """

        cursor.execute(
            query,
            tuple(params)
        )

        rows = cursor.fetchall()

        formatted_history = []

        for row in rows:

            case_data = safe_json_load(
                row.get("case_json")
            )

            formatted_history.append({
                "id": row["id"],
                "user_message": row[
                    "user_message"
                ],
                "topic": row.get(
                    "topic",
                    "General"
                ),
                "session_id": row.get(
                    "session_id",
                    ""
                ),
                "created_at": str(
                    row.get(
                        "created_at",
                        ""
                    )
                ),
                "case_data": case_data
            })

        return jsonify({
            "success": True,
            "history": formatted_history
        })

    except Exception as error:
        print(
            "History error:",
            error
        )

        return jsonify({
            "success": False,
            "history": []
        })

    finally:
        try:
            if cursor:
                cursor.close()
        except Exception:
            pass

        try:
            connection.close()
        except Exception:
            pass


# ==================================================
# CLEAR HISTORY API
# ==================================================

@app.route("/api/history/clear", methods=["POST"])
def clear_history_api():
    connection = get_connection()

    if connection is None:
        return jsonify({
            "success": False,
            "error": "Database not reachable"
        }), 500

    cursor = None

    try:
        data = request.get_json() or {}

        user_email = data.get(
            "user_email"
        )

        session_id = data.get(
            "session_id"
        )

        cursor = connection.cursor()

        if (
            user_email
            and user_email != "guest@lex.local"
        ):

            cursor.execute(
                """
                DELETE FROM conversations
                WHERE user_email = %s
                """,
                (user_email,)
            )

        elif session_id:

            cursor.execute(
                """
                DELETE FROM conversations
                WHERE session_id = %s
                """,
                (session_id,)
            )

        else:

            cursor.execute(
                """
                DELETE FROM conversations
                WHERE user_email =
                    'guest@lex.local'
                   OR user_email IS NULL
                """
            )

        connection.commit()

        return jsonify({
            "success": True,
            "message": "History cleared."
        })

    except Exception as error:
        print(
            "Clear history error:",
            error
        )

        return jsonify({
            "success": False,
            "error": str(error)
        }), 500

    finally:
        try:
            if cursor:
                cursor.close()
        except Exception:
            pass

        try:
            connection.close()
        except Exception:
            pass


# ==================================================
# DATABASE TEST API
# ==================================================

@app.route("/api/database-test", methods=["GET"])
def database_test():
    connection = get_connection()

    if connection is None:
        return jsonify({
            "success": False,
            "message": (
                "Database connection failed."
            )
        }), 500

    cursor = None

    try:
        cursor = connection.cursor()

        cursor.execute(
            "SELECT COUNT(*) FROM legal_cases"
        )

        cases_count = cursor.fetchone()[0]

        cursor.execute(
            "SELECT COUNT(*) FROM legal_topics"
        )

        topics_count = cursor.fetchone()[0]

        return jsonify({
            "success": True,
            "message": (
                "Database connection successful."
            ),
            "legal_cases": cases_count,
            "legal_topics": topics_count
        })

    except Exception as error:

        return jsonify({
            "success": False,
            "message": (
                "Database query error: "
                f"{str(error)}"
            )
        }), 500

    finally:
        try:
            if cursor:
                cursor.close()
        except Exception:
            pass

        try:
            connection.close()
        except Exception:
            pass


# ==================================================
# RUN SERVER
# ==================================================

if __name__ == "__main__":
    url = f"http://{HOST if HOST != '0.0.0.0' else 'localhost'}:{PORT}"
    print("\n" + "=" * 56)
    print("  ⚖  LEX  —  AI Legal Consultant  (India)")
    print("=" * 56)
    print(f"  ➜  Open in browser:  {url}")
    print(f"  ➜  API status:       {url}/api/status")
    print("=" * 56 + "\n")
    app.run(host=HOST, port=PORT, debug=DEBUG)
