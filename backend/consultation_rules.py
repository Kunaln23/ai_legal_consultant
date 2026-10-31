"""Pure consultation clarification rules shared by the Flask API and tests."""

import re


MAX_FOLLOWUP_QUESTIONS = 4


def filter_repeated_clarifications(questions, consultation_text):
    """Remove questions whose answers are already present in the consultation."""
    text = re.sub(r"\s+", " ", str(consultation_text or "").lower())
    patterns = {
        "who": r"\b(my|the)\s+(landlord|tenant|employer|employee|boss|seller|buyer|builder|bank|spouse|husband|wife|neighbor|neighbour|company|manager)\b|\b(landlord|tenant|employer|employee|seller|buyer|builder|bank|police|spouse)\b",
        "when": r"\b(today|yesterday|last week|last month|last year|\d+\s*(?:day|week|month|year)s?|\d{1,2}[/-]\d{1,2}[/-]\d{2,4}|since|for the past|ago|on monday|on tuesday|on wednesday|on thursday|on friday)\b",
        "amount": r"(?:₹|rs\.?|inr)\s*\d|\b\d[\d,]*(?:\.\d+)?\s*(?:rupees|rs)\b",
        "action": r"\b(refused|refuses|denied|rejected|ignored|threatened|terminated|fired|withheld|deducted|transferred|stole|hacked|attacked|hit|paid|not paid|failed|damaged|cancelled|canceled|evicted|demanded|complained|reported|filed|sent notice)\b",
        "employment_status": r"\b(currently working|still working|employed|resigned|left the job|terminated|fired|dismissed|employment ended|not working)\b",
        "product": r"\b(product|item|order|purchase|seller|service|refund|warranty|defective|damaged)\b",
        "role": r"\b(tenant|landlord|employee|employer|customer|buyer|seller|owner|victim|complainant|accused|spouse|husband|wife)\b",
        "event": r"\b(happened|took place|occurred|scam|fraud|accident|assault|threat|harassment|theft|non.?payment|not paid|refund|deposit|eviction|termination|hacked)\b",
        "goal": r"\b(want|seeking|need to|recover|refund|compensation|return|stop|protect|file a complaint|take action|legal action)\b",
    }
    kept = []
    seen = set()
    for question in questions or []:
        q = str(question or "").strip()
        if not q:
            continue
        ql = q.lower()
        category = None
        if any(x in ql for x in ("who is involved", "who are involved", "your role", "are you the")):
            category = "who"
        elif any(x in ql for x in ("when did", "how long", "when did it", "when was", "what date")):
            category = "when"
        elif any(x in ql for x in ("how much", "what amount", "amount involved", "value involved", "deposit amount", "amount of", "amount is")):
            category = "amount"
        elif any(x in ql for x in ("currently working", "employment already ended", "still employed")):
            category = "employment_status"
        elif any(x in ql for x in ("what product", "what service", "what did you purchase")):
            category = "product"
        elif any(x in ql for x in ("what did the other party do", "what happened", "what exactly happened", "describe the incident")):
            category = "event"
        elif any(x in ql for x in ("what outcome", "what do you want", "what are you seeking")):
            category = "goal"
        elif any(x in ql for x in ("who is the", "are you the", "who is your")):
            category = "role"
        elif any(x in ql for x in ("asked the employer", "what did the employer say", "what action has", "what has the other party done")):
            category = "action"
        if category and re.search(patterns[category], text):
            continue
        key = re.sub(r"[^a-z0-9]", "", ql)
        if key not in seen:
            seen.add(key)
            kept.append(q)
    return kept[:4]


def select_next_clarification(questions, consultation_text, questions_asked=0):
    """Return at most one unanswered question within the four-question budget."""
    remaining = max(0, MAX_FOLLOWUP_QUESTIONS - int(questions_asked or 0))
    if remaining == 0:
        return []
    return filter_repeated_clarifications(questions, consultation_text)[:1]


def is_same_domain_continuation(current_text, previous_text):
    """Recognize a new fact about the same broad legal domain.

    Broad-domain overlap is used only to preserve consultation context; it
    does not identify a specific legal case or imply legal liability.
    """
    try:
        from legal_service import detect_broad_legal_domain
        current_domains = set(detect_broad_legal_domain(str(current_text or "")))
        previous_domains = set(detect_broad_legal_domain(str(previous_text or "")))
        return bool(current_domains and current_domains.intersection(previous_domains))
    except Exception:
        return False
