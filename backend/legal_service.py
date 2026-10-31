# ================================================================# LEX LEGAL SERVICE# Safe Legal Retrieval & Fact-Aware Case Matching# Indian Law | Database-Backed# ================================================================
"""

This module is intentionally conservative.



Core rule:



    Never turn a keyword match into a legal conclusion.



Lex follows this pipeline:



    User question

        -> normalize input

        -> detect explicit topic request

        -> retrieve candidate cases from database

        -> score candidates

        -> evaluate confidence + ambiguity

        -> evaluate whether enough facts are present

        -> answer OR ask clarification OR decline



Important:

    The legal database is the application's knowledge source.

    This module does not silently invent missing facts.



Response statuses:



    answered

    needs_clarification

    ambiguous

    unsupported

    out_of_scope

    knowledge_unavailable

"""



import re
import uuid

from datetime import date

from typing import Any, Dict, List, Optional, Tuple



from database import get_connection
from fact_memory import (
    get_or_create_memory,
    extract_and_merge_facts,
    evaluate_situation_definition,
    personalize_legal_response,
    get_violation_for_case
)
# ================================================================# CONFIGURATION# ================================================================
MIN_QUERY_LENGTH = 3
# A candidate must have meaningful evidence before it can be considered.
MIN_CANDIDATE_SCORE = 20.0
# If two candidates are very close AND both are weak, flag ambiguous.
# A strong top candidate (>= STRONG_MATCH_SCORE) can coexist with a close
# second — we still answer it rather than ask the user to disambiguate.
AMBIGUITY_MARGIN = 10.0
STRONG_MATCH_SCORE = 45.0   # top candidate is clearly the right one
# Very weak matches should never be presented as answers.
# Lowered from 55 -> 30 to reflect real query scoring distribution.
# Typical real queries score 25-40; "ideal" DB-phrase queries score 60-120.
ANSWER_SCORE = 30.0
# Queries with extremely little factual information should generally# produce clarification rather than a legal conclusion.
MIN_FACTUAL_TOKENS_FOR_DIRECT_ANSWER = 3
# ================================================================# STOP WORDS# ================================================================
STOPWORDS = {

    "i", "me", "my", "myself", "we", "our", "ours", "ourselves",

    "you", "your", "yours", "yourself", "he", "him", "his",

    "she", "her", "hers", "it", "its", "they", "them", "their",

    "the", "a", "an", "this", "that", "these", "those",



    "am", "is", "are", "was", "were", "be", "been", "being",

    "have", "has", "had", "having", "do", "does", "did", "doing",



    "and", "but", "if", "or", "because", "as", "until", "while",

    "of", "at", "by", "for", "with", "about", "against", "between",

    "into", "through", "during", "before", "after", "above", "below",

    "to", "from", "up", "down", "in", "out", "on", "off", "over",

    "under", "again", "then", "once", "here", "there", "when",

    "where", "why", "how", "all", "any", "both", "each", "few",

    "more", "most", "other", "some", "such", "no", "nor", "not",

    "only", "own", "same", "so", "than", "too", "very",



    "can", "will", "would", "could", "should", "may", "might",

    "just", "now", "want", "need", "please", "help", "tell",

    "know", "give", "get", "got", "advise", "advice", "guidance",

    "regarding", "matter", "case", "issue", "problem", "legal",

    "law", "laws", "india", "indian"

}
# ================================================================# DOMAIN SYNONYMS# ================================================================# These are retrieval aids only.# They MUST NOT be treated as proof that a particular legal case applies.
SYNONYMS = {

    "employment": {

        "job", "work", "employer", "employee", "boss", "company",

        "office", "workplace", "salary", "wage", "wages", "pay",

        "stipend", "payroll", "arrears", "dues", "remuneration",

        "terminated", "termination", "fired", "dismissed",

        "resignation", "notice", "overtime", "harassment",

        "posh", "pf", "gratuity"

    },



    "rent": {

        "rent", "rental", "landlord", "tenant", "deposit", "lease",

        "evict", "eviction", "flat", "apartment", "house", "room",

        "tenancy", "vacate", "security"

    },



    "consumer": {

        "product", "item", "purchase", "bought", "seller", "refund",

        "return", "defective", "warranty", "shopping", "goods",

        "ecommerce", "damaged", "broken", "service"

    },



    "cyber": {

        "cyber", "online", "scam", "fraud", "hacked", "hacker",

        "phishing", "blackmail", "threat", "threatening",

        "impersonation", "leak", "harassment", "upi", "qr",

        "otp", "banking", "account", "password"

    },



    "family": {

        "divorce", "marriage", "wife", "husband", "spouse", "child",

        "custody", "maintenance", "alimony", "domestic", "violence",

        "matrimonial", "inlaws", "dowry", "cruelty"

    },



    "property": {

        "property", "land", "plot", "flat", "ownership", "possession",

        "dispute", "boundary", "neighbor", "sale", "registry",

        "title", "builder", "rera", "ancestral", "partition"

    },



    "insurance": {

        "insurance", "claim", "policy", "mediclaim", "coverage",

        "rejected", "delayed", "payout", "reimbursement", "denied",

        "tpa"

    },



    "contract": {

        "contract", "agreement", "breach", "deal", "terms", "invoice",

        "vendor", "client", "deadline", "nonpayment", "non-payment"

    },



    "traffic": {

        "accident", "car", "vehicle", "bike", "motor", "driver",

        "hit", "crash", "collision", "challan", "rto", "mact",

        "compensation"

    },



    "intellectual": {

        "copyright", "trademark", "patent", "copied", "plagiarism",

        "logo", "brand", "infringement", "piracy"

    },



    "criminal": {

        "police", "fir", "bail", "arrest", "crime", "criminal",

        "assault", "beat", "hit", "punched", "attack", "gun",

        "bullet", "shot", "murder", "threat", "theft", "stolen",

        "robbery", "cheated"

    },



    "banking": {

        "cheque", "check", "bounce", "dishonour", "dishonored",

        "bank", "loan", "recovery", "agent", "harassment", "emi",

        "cibil", "credit"

    }

}
# ================================================================# PHRASE RETRIEVAL AIDS# ================================================================# These phrases are only used to improve retrieval.# They do not establish that the associated legal theory applies.
PHRASE_GROUPS = {

    "unpaid_salary": {

        "unpaid salary",

        "salary not paid",

        "salary delayed",

        "salary withheld",

        "withheld salary",

        "withheld my salary",

        "withheld wages",

        "withholding salary",

        "withholding wages",

        "not paid salary",

        "salary arrears",

        "unpaid wages",

        "stipend not paid",

        "company not paying salary",

        "boss not paying salary",

        "not paid my salary",

        "has not paid my salary",

        "havent paid my salary",

        "haven't paid salary",

        "not paid wages",

        "employer not paying",

        "salary pending",

        "months salary not given",

        "months salary not paid",

        "salary due",

        "boss not paid",

        "not paying my salary",

        "refusing to pay salary",

        "denying salary"

    },



    "security_deposit": {

        "security deposit",

        "deposit not returned",

        "deposit refund",

        "landlord withheld deposit",

        "rental deposit",

        "landlord not returning deposit"

    },



    "online_fraud": {

        "payment fraud",

        "upi scam",

        "online fraud",

        "bank fraud",

        "online scam",

        "unauthorized transaction",

        "phishing scam",

        "qr code fraud"

    },



    "defective_product": {

        "defective product",

        "broken item",

        "faulty product",

        "damaged goods",

        "product received damaged",

        "broken phone",

        "broken product",

        "damaged product",

        "received broken",

        "delivered broken",

        "sent broken",

        "defective item",

        "seller not refunding",

        "seller refusing refund",

        "seller refused refund",

        "seller sent broken",

        "seller sent wrong",

        "not refunding",

        "ignoring refund",

        "no refund given",

        "asking for refund",

        "asked for refund",

        "refund not given",

        "refund rejected",

        "refund denied",

        "wrong product delivered",

        "wrong item delivered",

        "product not working",

        "seller is ignoring",

        "seller ignoring",

        "they are ignoring",

        "not responding to refund",

        "bought online broken",

        "bought phone broken"

    },



    "physical_assault": {

        "beat me",

        "beaten me",

        "punched me",

        "hit me",

        "physically assaulted",

        "physical attack",

        "beaten up",

        "physical violence",

        "assaulted me",

        "attacked me",

        "physically attacked",

        "assault and battery",

        "bodily harm",

        "hit and beat",

        "slapped me",

        "kicked me"

    },



    "death_threat": {

        "threatened to kill me",

        "death threat",

        "threat to kill",

        "threatening my life",

        "threatened to murder"

    },



    "cheque_bounce": {

        "cheque bounce",

        "bounced cheque",

        "cheque dishonoured",

        "check bounced",

        "section 138"

    },



    "wrongful_termination": {

        "wrongful termination",

        "illegal termination",

        "unlawful termination",

        "fired illegally",

        "forced resignation",

        "illegal firing"

    }

}
# ================================================================# TEXT HELPERS# ================================================================
def normalize_text(value: Any) -> str:

    """Normalize user/database text for comparison."""

    if value is None:

        return ""



    text = str(value).lower()

    text = text.replace("&", " and ")

    text = re.sub(r"[^a-z0-9\s/-]", " ", text)

    text = re.sub(r"\s+", " ", text)

    return text.strip()





def tokenize(text: str) -> List[str]:

    """Return meaningful normalized tokens."""

    words = re.findall(r"\b[a-z0-9][a-z0-9/-]*\b", normalize_text(text))



    return [

        word

        for word in words

        if len(word) >= 2 and word not in STOPWORDS

    ]





def simple_stem(word: str) -> str:

    """

    Small retrieval stemmer.



    This is deliberately conservative.

    It is not used to establish legal meaning.

    """

    word = normalize_text(word)



    if len(word) <= 4:

        return word



    suffixes = (

        "ingly",

        "ation",

        "tions",

        "ments",

        "ment",

        "ness",

        "ing",

        "ies",

        "ied",

        "ed",

        "es",

        "s"

    )



    for suffix in suffixes:

        if word.endswith(suffix):

            remaining = len(word) - len(suffix)

            if remaining >= 4:

                return word[:remaining]



    return word





def contains_phrase(text: str, phrase: str) -> bool:

    text = normalize_text(text)

    phrase = normalize_text(phrase)



    if not phrase:

        return False



    return phrase in text





def unique_list(values: List[Any]) -> List[Any]:

    """Preserve order while removing duplicates."""

    seen = set()

    output = []



    for value in values:

        key = str(value)



        if key not in seen:

            seen.add(key)

            output.append(value)



    return output
# ================================================================# QUESTION CLASSIFICATION# ================================================================
def detect_domain(question: str) -> Optional[str]:

    """

    Detect broad domain only.



    Domain detection is intentionally weaker than case matching.

    It must never be used by itself to select a legal case.

    """

    text = normalize_text(question)

    tokens = set(tokenize(text))



    scores = {}



    for domain, words in SYNONYMS.items():

        score = 0



        for word in words:

            normalized_word = normalize_text(word)



            if " " in normalized_word:

                if normalized_word in text:

                    score += 2

            elif normalized_word in tokens:

                score += 1



        if score:

            scores[domain] = score



    if not scores:

        return None



    return max(scores, key=scores.get)





def detect_query_intent(question: str) -> str:

    """

    Detect the user's broad intent.



    This is not legal classification.

    It is used to prevent Lex from answering the wrong kind of question.

    """

    text = normalize_text(question)



    if any(

        phrase in text

        for phrase in (

            "what law",

            "which law",

            "which section",

            "section applies",

            "what section",

            "is this legal",

            "is this illegal"

        )

    ):

        return "legal_rule"



    if any(

        phrase in text

        for phrase in (

            "what should i do",

            "what can i do",

            "what are my options",

            "how can i",

            "how do i",

            "where can i complain",

            "where should i complain",

            "how to complain"

        )

    ):

        return "procedure_or_remedy"



    if any(

        phrase in text

        for phrase in (

            "can i sue",

            "can i file",

            "can i claim",

            "can i complain",

            "can i recover"

        )

    ):

        return "remedy"



    if any(

        phrase in text

        for phrase in (

            "what does",

            "meaning of",

            "explain",

            "what is"

        )

    ):

        return "general_information"



    return "situation"





def looks_like_general_greeting(question: str) -> bool:

    text = normalize_text(question)



    greetings = {

        "hi",

        "hello",

        "hey",

        "good morning",

        "good afternoon",

        "good evening",

        "namaste"

    }



    return text in greetings
# ================================================================# FACT EXTRACTION# ================================================================
def extract_explicit_facts(question: str) -> Dict[str, Any]:

    """

    Extract only facts explicitly stated by the user.



    This function intentionally does NOT infer:

        - legal violation

        - liability

        - entitlement

        - jurisdiction

        - employment classification

        - criminal offence

        - limitation period

    """

    text = normalize_text(question)

    tokens = tokenize(text)



    facts: Dict[str, Any] = {

        "raw_text": question.strip(),

        "domain": detect_domain(question),

        "intent": detect_query_intent(question),

        "tokens": tokens,

        "time_periods": [],

        "amounts": [],

        "mentioned_parties": [],

        "mentioned_documents": [],

        "location_mentioned": False,

        "safety_risk_terms": [],

    }
# Time periods
    time_patterns = [

        r"\b(?:\d+|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)\s+(?:day|days|week|weeks|month|months|year|years)\b",

        r"\b(?:yesterday|today|tomorrow|last week|last month|last year)\b"

    ]



    for pattern in time_patterns:

        facts["time_periods"].extend(re.findall(pattern, text))
# Amounts
    amount_matches = re.findall(

        r"(?:₹|rs\.?|inr)\s*\d+(?:[,\d]*)(?:\.\d+)?",

        text

    )



    facts["amounts"] = amount_matches
# Common party references explicitly stated
    party_terms = [

        "employer",

        "boss",

        "company",

        "landlord",

        "tenant",

        "seller",

        "builder",

        "bank",

        "insurance company",

        "police",

        "friend",

        "husband",

        "wife",

        "spouse",

        "partner",

        "neighbor"

    ]



    facts["mentioned_parties"] = [

        term for term in party_terms if term in text

    ]
# Documents explicitly mentioned
    document_terms = [

        "agreement",

        "contract",

        "invoice",

        "receipt",

        "payslip",

        "salary slip",

        "bank statement",

        "fir",

        "complaint",

        "medical report",

        "mlc",

        "notice",

        "policy",

        "cheque",

        "proof",

        "cctv",

        "screenshot"

    ]



    facts["mentioned_documents"] = [

        term for term in document_terms if term in text

    ]
# Location indicator
    location_markers = [

        "in maharashtra",

        "in mumbai",

        "in pune",

        "in delhi",

        "in bengaluru",

        "in bangalore",

        "in india",

        "state",

        "district",

        "police station"

    ]



    facts["location_mentioned"] = any(

        marker in text for marker in location_markers

    )
# Immediate safety terms.# These indicate that safety clarification may be important.
    safety_terms = [

        "gun",

        "shoot",

        "shot",

        "weapon",

        "kill",

        "death threat",

        "life threat",

        "bleeding",

        "injured",

        "attack"

    ]



    facts["safety_risk_terms"] = [

        term for term in safety_terms if term in text

    ]



    return facts
# ================================================================# DATABASE RETRIEVAL# ================================================================
def _fetch_cases() -> Optional[List[Dict[str, Any]]]:

    """

    Retrieve legal cases and their keywords from MySQL.



    Returns:

        list of cases

        [] if database is available but empty

        None if database is unavailable

    """

    connection = get_connection()



    if connection is None:

        return None



    try:

        # Add everyday-language aliases so normal descriptions map to the right case.
        try:
            from keyword_enhancements import apply_keyword_aliases
            apply_keyword_aliases(connection)
        except Exception as enhancement_error:
            print("Keyword enhancement notice:", enhancement_error)

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                lc.case_id,

                lc.topic_id,

                lc.case_title,

                lc.situation,

                lc.explanation,

                lc.urgency,

                lc.jurisdiction,

                lt.topic_name,

                lt.description AS topic_description,

                COALESCE(

                    GROUP_CONCAT(lk.keyword SEPARATOR ' | '),

                    ''

                ) AS keywords

            FROM legal_cases lc

            INNER JOIN legal_topics lt

                ON lc.topic_id = lt.topic_id

            LEFT JOIN legal_keywords lk

                ON lc.case_id = lk.case_id

            GROUP BY

                lc.case_id,

                lc.topic_id,

                lc.case_title,

                lc.situation,

                lc.explanation,

                lc.urgency,

                lc.jurisdiction,

                lt.topic_name,

                lt.description

            ORDER BY lc.case_id ASC

            """

        )



        cases = cursor.fetchall()



        cursor.close()

        connection.close()



        return cases



    except Exception as exc:

        print("Error fetching legal cases:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return None





def _fetch_sources_for_case(case_id: int) -> List[Dict[str, Any]]:

    """

    Retrieve source metadata for a legal case.



    Source metadata does not prove that the text is legally correct.

    It only lets Lex show where the database content claims to originate.

    """

    connection = get_connection()



    if connection is None:

        return []



    try:

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                source_id,

                source_name,

                source_url,

                source_type,

                last_verified

            FROM legal_sources

            WHERE case_id = %s

            ORDER BY

                CASE

                    WHEN last_verified IS NULL THEN 2

                    ELSE 1

                END,

                last_verified DESC,

                source_id ASC

            """,

            (case_id,)

        )



        sources = cursor.fetchall()



        cursor.close()

        connection.close()



        return sources



    except Exception as exc:

        print(f"Error fetching sources for case {case_id}:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return []
# ================================================================# CASE MATCHING# ================================================================
def _case_keywords(case: Dict[str, Any]) -> List[str]:

    raw = case.get("keywords", "") or ""



    return [

        normalize_text(keyword.strip())

        for keyword in str(raw).split("|")

        if normalize_text(keyword.strip())

    ]





def _phrase_match_score(question: str, case: Dict[str, Any]) -> float:

    """

    Score exact retrieval phrases.



    This improves retrieval but never makes a case automatically correct.

    Phrases are domain-aware: a phrase from the 'defective_product' group
    only scores for consumer law cases, etc., preventing false boosts to
    unrelated cases that share a single incidental token.

    """

    text = normalize_text(question)

    score = 0.0



    title = normalize_text(case.get("case_title", ""))

    situation = normalize_text(case.get("situation", ""))

    case_topic = normalize_text(case.get("topic_name", ""))

    keywords_text = normalize_text(case.get("keywords", ""))

    searchable = f"{title} {situation} {keywords_text}"

    # Map phrase groups to required case-topic signals
    # If a phrase group has a domain guard, at least one guard token
    # must appear in the case topic/title/situation for the phrase to score.
    PHRASE_GROUP_DOMAIN_GUARDS: Dict[str, List[str]] = {
        "unpaid_salary":        ["salary", "wage", "employment", "payment of wages"],
        "security_deposit":     ["deposit", "tenant", "landlord", "rent"],
        "online_fraud":         ["cyber", "upi", "fraud", "scam", "bank"],
        "defective_product":    ["consumer", "product", "seller", "defect", "refund"],
        "physical_assault":     ["assault", "criminal", "battery", "violence"],
        "death_threat":         ["criminal", "threat", "murder"],
        "cheque_bounce":        ["cheque", "bounce", "section 138", "banking"],
        "wrongful_termination": ["termination", "employment", "fired", "resign"],
    }

    query_tokens = set(tokenize(text))
    case_tokens = set(tokenize(searchable))

    for group_name, phrase_group in PHRASE_GROUPS.items():

        # Domain guard: skip scoring if this case doesn't match the phrase group's domain
        guards = PHRASE_GROUP_DOMAIN_GUARDS.get(group_name)
        if guards:
            case_domain_text = f"{title} {situation} {case_topic} {keywords_text}"
            if not any(g in case_domain_text for g in guards):
                continue

        for phrase in phrase_group:
            phrase_tokens = set(tokenize(phrase))
            if not phrase_tokens:
                continue

            # Method 1: Exact phrase substring in user text
            if phrase in text:
                overlap = len(phrase_tokens & case_tokens)
                if overlap >= 2:
                    score += 18.0
                elif overlap == 1:
                    score += 8.0

            # Method 2: All phrase tokens present in query (order-independent)
            # Catches "I have been asking for a refund" matching phrase "asking for refund"
            elif len(phrase_tokens) >= 2 and phrase_tokens.issubset(query_tokens):
                overlap = len(phrase_tokens & case_tokens)
                if overlap >= 2:
                    score += 14.0
                elif overlap == 1:
                    score += 6.0

    return score





def _score_case(question: str, case: Dict[str, Any]) -> Tuple[float, Dict[str, Any]]:

    """

    Calculate a conservative retrieval score.



    The score answers:

        "How strongly does this case resemble the words supplied?"



    It does NOT answer:

        "Is this legally the user's case?"

    """

    text = normalize_text(question)



    query_tokens = tokenize(text)

    query_set = set(query_tokens)

    query_stems = {simple_stem(token) for token in query_tokens}



    title = normalize_text(case.get("case_title", ""))

    situation = normalize_text(case.get("situation", ""))

    explanation = normalize_text(case.get("explanation", ""))

    topic = normalize_text(case.get("topic_name", ""))



    title_tokens = set(tokenize(title))

    situation_tokens = set(tokenize(situation))

    topic_tokens = set(tokenize(topic))



    score = 0.0

    evidence = {

        "exact_phrases": [],

        "keyword_matches": [],

        "title_matches": [],

        "situation_matches": [],

        "domain_matches": [],

    }
# ------------------------------------------------------------# Exact title# ------------------------------------------------------------
    if title and title in text:

        score += 35.0

        evidence["title_matches"].append("exact title")
# ------------------------------------------------------------# Database keywords# ------------------------------------------------------------
    for keyword in _case_keywords(case):

        if not keyword:

            continue



        if keyword in text:

            word_count = len(tokenize(keyword))



            score += min(32.0, 12.0 + word_count * 6.0)

            evidence["keyword_matches"].append(keyword)

            continue



        keyword_tokens = set(tokenize(keyword))



        if not keyword_tokens:

            continue



        overlap = len(keyword_tokens & query_set)



        if overlap >= 2:

            score += min(16.0, overlap * 5.0)

            evidence["keyword_matches"].append(

                f"{keyword} ({overlap} words)"

            )



        elif overlap == 1 and len(keyword_tokens) == 1:

            score += 5.0

            evidence["keyword_matches"].append(keyword)
# ------------------------------------------------------------# Query tokens against title# ------------------------------------------------------------
    for token in query_tokens:

        if token in title_tokens:

            score += 8.0

            evidence["title_matches"].append(token)



        elif simple_stem(token) in {

            simple_stem(item) for item in title_tokens

        }:

            score += 4.0
# ------------------------------------------------------------# Query tokens against situation# ------------------------------------------------------------
    for token in query_tokens:

        if token in situation_tokens:

            score += 4.0

            evidence["situation_matches"].append(token)



        elif simple_stem(token) in {

            simple_stem(item) for item in situation_tokens

        }:

            score += 2.0
# ------------------------------------------------------------# Domain overlap# ------------------------------------------------------------
    for domain, words in SYNONYMS.items():

        overlap = len(query_set & words)



        if overlap:

            case_text = f"{title} {situation} {topic}"



            domain_overlap = sum(

                1

                for word in words

                if normalize_text(word) in case_text

                and (

                    normalize_text(word) in query_set

                    or simple_stem(normalize_text(word)) in query_stems

                )

            )



            if domain_overlap:

                score += min(12.0, domain_overlap * 2.0)



                evidence["domain_matches"].append({

                    "domain": domain,

                    "overlap": domain_overlap

                })
# ------------------------------------------------------------# Phrase retrieval# ------------------------------------------------------------
    phrase_score_before = score

    score += _phrase_match_score(question, case)



    if score > phrase_score_before:

        evidence["exact_phrases"].append("phrase overlap")
# ------------------------------------------------------------# Explanation overlap is deliberately weak.# It should never dominate retrieval.# ------------------------------------------------------------
    explanation_tokens = set(tokenize(explanation))

    explanation_overlap = len(query_set & explanation_tokens)



    score += min(5.0, explanation_overlap * 0.75)



    return score, evidence





def _rank_cases(question: str) -> Optional[List[Dict[str, Any]]]:

    cases = _fetch_cases()



    if cases is None:

        return None



    if not cases:

        return []



    ranked = []



    for case in cases:

        score, evidence = _score_case(question, case)



        if score >= MIN_CANDIDATE_SCORE:

            item = dict(case)

            item["_score"] = round(score, 2)

            item["_evidence"] = evidence

            ranked.append(item)



    ranked.sort(

        key=lambda item: item["_score"],

        reverse=True

    )



    return ranked





def find_legal_case(question: str) -> Optional[Dict[str, Any]]:

    """

    Backward-compatible helper.



    IMPORTANT:

    This function now returns a case only when the top candidate is

    sufficiently strong AND clearly separated from the second candidate.



    For richer status information, use analyze_question().

    """

    analysis = analyze_question(question)



    if analysis["status"] != "answered":

        return None



    return analysis.get("case")
# ================================================================# FACT SUFFICIENCY# ================================================================
def _case_requires_clarification(
    question: str,
    case: Dict[str, Any],
    memory: Optional[Any] = None
) -> Tuple[bool, List[str]]:
    """
    Determine whether the user supplied enough information to present
    the case as directly relevant.

    This is intentionally conservative but respects session memory.
    If memory already contains rich facts, questions already answered
    in earlier turns are not re-asked.
    """
    full_text = " ".join(memory.all_statements) if (memory and hasattr(memory, "all_statements") and memory.all_statements) else question
    text = normalize_text(full_text)
    facts = extract_explicit_facts(full_text)

    title = normalize_text(case.get("case_title", ""))
    situation = normalize_text(case.get("situation", ""))
    case_topic = normalize_text(case.get("topic_name", ""))
    combined = f"{title} {situation}"

    missing = []

    # If memory is already rich (amounts + time OR multiple turns), be lenient
    memory_has_amounts  = bool(memory and memory.amounts)
    memory_has_time     = bool(memory and memory.timeframes) or bool(facts["time_periods"])
    memory_has_party    = bool(memory and memory.primary_party)
    memory_multi_turn   = bool(memory and len(getattr(memory, "all_statements", [])) >= 2)

# ------------------------------------------------------------# Employment / salary# ------------------------------------------------------------
    employment_signals = {
        "salary", "wage", "wages", "stipend", "employer",
        "employee", "job", "work", "boss", "company",
        "termination", "terminated", "fired"
    }

    if (
        "salary" in combined
        or "wage" in combined
        or "employment" in case_topic
    ):
        has_emp = (set(tokenize(text)) & employment_signals) or memory_has_party
        if not has_emp:
            missing.append(
                "What payment or employment issue are you facing?"
            )

        # Only ask about duration if we have no time info AND memory is not multi-turn
        if not memory_has_time and not memory_multi_turn:
            missing.append(
                "How long has the payment or employment issue been continuing?"
            )

# ------------------------------------------------------------# Tenancy / deposit# ------------------------------------------------------------
    if (
        "deposit" in combined
        or "tenant" in combined
        or "landlord" in combined
        or "rent" in case_topic
    ):
        has_party = "landlord" in text or "tenant" in text or (memory and memory.primary_party and memory.primary_party.get("role") in ["landlord", "tenant"])
        if not has_party:
            missing.append(
                "Are you the tenant or the landlord?"
            )

        if "deposit" in combined and "deposit" not in text and (not memory or not any("deposit" in s.lower() for s in memory.all_statements)):
            missing.append(
                "Is the dispute specifically about a security deposit?"
            )
# ------------------------------------------------------------# Consumer# ------------------------------------------------------------
    if (
        "consumer" in case_topic
        or "product" in combined
        or ("refund" in combined and "rent" not in case_topic and "tenan" not in case_topic and "employ" not in case_topic)
    ):
        if not any(
            term in text
            for term in (
                "product",
                "seller",
                "purchase",
                "order",
                "refund",
                "service"
            )
        ):
            missing.append(
                "What product or service did you purchase, and what went wrong?"
            )
# ------------------------------------------------------------# Cyber / banking# ------------------------------------------------------------
    # Banking-specific clarification belongs only to banking/phishing cases.
    # Do not ask sextortion, account-hacking, or data-leak users about UPI.
    is_banking_case = (
        int(case.get("case_id") or 0) == 29
        or any(term in combined for term in ("upi", "bank", "phishing"))
    )
    if is_banking_case:

        if not any(

            term in text

            for term in (

                "upi",

                "bank",

                "transaction",

                "payment",

                "scam",

                "fraud",

                "hacked",

                "phishing"

            )

        ):

            missing.append(

                "What happened: an unauthorized transaction, scam, hacked account, or something else?"

            )
# A clear threat to publish private images for money already supplies the
    # core facts for a preliminary cyber-extortion match.
    if "cyber extortion" in title or "sextortion" in title or "blackmail" in title:
        has_image_threat = any(term in text for term in ("photo", "picture", "image", "video")) and any(term in text for term in ("share", "post", "leak", "publish"))
        has_money_demand = any(term in text for term in ("money", "pay", "payment", "rupees", "rs"))
        if has_image_threat and has_money_demand:
            return False, []

    # ------------------------------------------------------------# Criminal / assault / threat# ------------------------------------------------------------
    if (

        "criminal" in normalize_text(case.get("topic_name", ""))

        or any(

            term in combined

            for term in (

                "assault",

                "attack",

                "theft",

                "threat",

                "murder",

                "robbery"

            )

        )

    ):

        if not any(

            term in text

            for term in (

                "assault",

                "attack",

                "beat",

                "hit",

                "stole",

                "theft",

                "threat",

                "kill",

                "robbery",

                "police"

            )

        ):

            missing.append(

                "Please describe what happened and what the other person did."

            )
# ------------------------------------------------------------# Accident# ------------------------------------------------------------
    if (

        "accident" in combined

        or "motor" in combined

        or "traffic" in normalize_text(case.get("topic_name", ""))

    ):

        if not any(

            term in text

            for term in (

                "accident",

                "vehicle",

                "car",

                "bike",

                "motor",

                "crash",

                "collision"

            )

        ):

            missing.append(

                "Please describe the accident and the type of vehicle involved."

            )
# ------------------------------------------------------------# General factual threshold# ------------------------------------------------------------
    meaningful_tokens = len(set(facts["tokens"]))



    if meaningful_tokens < MIN_FACTUAL_TOKENS_FOR_DIRECT_ANSWER:

        missing.append(

            "Please provide a little more detail about what happened."

        )



    return bool(missing), unique_list(missing)
# ================================================================# CLARIFICATION GENERATION# ================================================================
def build_clarification_response(

    question: str,

    candidates: List[Dict[str, Any]]

) -> Dict[str, Any]:

    """

    Build a clarification response without asserting that a candidate

    legally applies.

    """

    top_candidates = candidates[:3]



    category_options = []



    for case in top_candidates:

        category_options.append({

            "case_id": case.get("case_id"),

            "title": case.get("case_title"),

            "situation": case.get("situation"),

            "topic": case.get("topic_name"),

        })



    top_case = top_candidates[0] if top_candidates else None



    missing = []



    if top_case:

        _, missing = _case_requires_clarification(

            question,

            top_case

        )



    if not missing:

        missing = [

            "Please describe exactly what happened.",

            "Who is involved?",

            "When did it happen?",

            "What outcome are you seeking?"

        ]



    return {

        "status": "needs_clarification",

        "confidence": (

            round(top_case["_score"] / 100.0, 2)

            if top_case

            else 0.0

        ),

        "found": False,

        "is_topic_selection": False,

        "title": "More Information Needed",

        "situation_assessment": (

            "I can see a possible legal area, but I do not have enough "

            "facts to safely treat a specific legal situation as your case."

        ),

        "explanation": (

            "I do not want to assume facts that you have not provided. "

            "Please answer the questions below so Lex can determine "

            "whether the available legal information actually applies."

        ),

        "clarifying_questions": unique_list(missing),

        "candidate_cases": category_options,

        "preventions": [],

        # The frontend displays the suggested-next-step section from
        # `actions`. Keep it synchronized with clarification questions.
        # A clarification response must never contain questions that are
        # present in the API but invisible in the UI.
        "actions": unique_list(missing),

        "documents": [],

        "options": [],

        "jurisdiction": "India",

        "case": None,

        "sources": [],

        "disclaimer": (

            "Lex has not reached a legal conclusion because the available "

            "facts are insufficient. The clarification request is not a "

            "finding that any particular law, offence, remedy, or procedure applies."

        )

    }





def build_ambiguous_response(

    question: str,

    candidates: List[Dict[str, Any]]

) -> Dict[str, Any]:

    """

    Return multiple plausible candidates instead of selecting one

    arbitrarily.

    """

    category_options = []



    for case in candidates[:4]:

        category_options.append({

            "case_id": case.get("case_id"),

            "title": case.get("case_title"),

            "situation": case.get("situation"),

            "topic": case.get("topic_name"),

        })



    return {

        "status": "ambiguous",

        "confidence": 0.0,

        "found": False,

        "is_topic_selection": False,

        "title": "Your Situation Could Match More Than One Legal Issue",

        "situation_assessment": (

            "I found more than one potentially relevant legal situation, "

            "but I cannot safely choose one from the information provided."

        ),

        "explanation": (

            "Please select the situation that best describes your problem, "

            "or add more facts. Lex will not choose a legal category "

            "arbitrarily."

        ),

        "clarifying_questions": [

            "What exactly happened?",

            "Who is involved?",

            "What are you trying to achieve?"

        ],

        "candidate_cases": category_options,

        "preventions": [],

        "actions": [],

        "documents": [],

        "options": [],

        "jurisdiction": "India",

        "case": None,

        "sources": [],

        "disclaimer": (

            "These are possible database matches only. They are not a "

            "legal finding about your situation."

        )

    }
# ================================================================# SOURCE SAFETY# ================================================================
def _source_is_present(sources: List[Dict[str, Any]]) -> bool:

    return bool(sources)





def _source_summary(sources: List[Dict[str, Any]]) -> List[Dict[str, Any]]:

    """

    Return source metadata in a frontend-safe format.

    """

    output = []



    for source in sources:

        last_verified = source.get("last_verified")



        if isinstance(last_verified, date):

            last_verified = last_verified.isoformat()



        output.append({

            "source_id": source.get("source_id"),

            "source_name": source.get("source_name"),

            "source_url": source.get("source_url"),

            "source_type": source.get("source_type"),

            "last_verified": last_verified,

        })



    return output
# ================================================================# SAFE PREVENTIONS# ================================================================
def get_preventions_and_precautions(

    case: Dict[str, Any]

) -> List[str]:

    """

    Return only neutral evidence-preservation precautions.



    Deliberately avoids hardcoded legal conclusions such as:

        - fixed limitation periods

        - mandatory FIR claims

        - automatic compensation

        - automatic interest

        - guaranteed recovery

        - universal tenancy rules

        - universal employment rules



    Such claims must come from verified legal content and appropriate

    facts rather than this generic generator.

    """

    precautions = [

        "Keep relevant messages, emails, receipts, agreements, notices, and payment records.",

        "Record important dates, amounts, names, and events accurately.",

        "Keep original files where possible and make secure copies of important evidence.",

        "Do not delete or alter potentially relevant evidence.",

        "Do not sign a settlement, resignation, admission, or other legal document without understanding its terms."

    ]



    topic = normalize_text(case.get("topic_name", ""))

    title = normalize_text(case.get("case_title", ""))



    if (

        "criminal" in topic

        or any(

            term in title

            for term in (

                "assault",

                "attack",

                "threat",

                "theft",

                "robbery"

            )

        )

    ):

        precautions.insert(

            0,

            "If there is an immediate risk to your safety, move to a safe location and contact appropriate emergency services."

        )



    if "cyber" in topic or "bank" in topic:

        precautions.insert(

            0,

            "If an unauthorized financial transaction has occurred, contact the relevant bank or payment provider promptly and preserve the transaction details."

        )



    return precautions
# ================================================================# DATABASE OPTIONS / ACTIONS / DOCUMENTS# ================================================================
def get_options(case_id: int) -> List[Dict[str, Any]]:

    connection = get_connection()



    if connection is None:

        return []



    try:

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                option_id,

                option_text,

                priority

            FROM legal_options

            WHERE case_id = %s

            ORDER BY priority ASC

            """,

            (case_id,)

        )



        options = cursor.fetchall()



        cursor.close()

        connection.close()



        return options



    except Exception as exc:

        print(f"Error fetching options for case {case_id}:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return []





def get_actions(case_id: int) -> List[Dict[str, Any]]:

    connection = get_connection()



    if connection is None:

        return []



    try:

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                action_id,

                action_text,

                step_number

            FROM legal_actions

            WHERE case_id = %s

            ORDER BY step_number ASC

            """,

            (case_id,)

        )



        actions = cursor.fetchall()



        cursor.close()

        connection.close()



        return actions



    except Exception as exc:

        print(f"Error fetching actions for case {case_id}:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return []





def get_documents(case_id: int) -> List[Dict[str, Any]]:

    connection = get_connection()



    if connection is None:

        return []



    try:

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                document_id,

                document_name,

                required_level,

                description

            FROM legal_documents

            WHERE case_id = %s

            ORDER BY

                CASE required_level

                    WHEN 'Essential' THEN 1

                    WHEN 'Recommended' THEN 2

                    ELSE 3

                END,

                document_id ASC

            """,

            (case_id,)

        )



        documents = cursor.fetchall()



        cursor.close()

        connection.close()



        return documents



    except Exception as exc:

        print(f"Error fetching documents for case {case_id}:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return []
# ================================================================# TOPICS# ================================================================
def get_all_topics() -> List[Dict[str, Any]]:

    connection = get_connection()



    if connection is None:

        return []



    try:

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                lt.topic_id,

                lt.topic_name,

                lt.description,

                COUNT(lc.case_id) AS total_cases

            FROM legal_topics lt

            LEFT JOIN legal_cases lc

                ON lt.topic_id = lc.topic_id

            GROUP BY

                lt.topic_id,

                lt.topic_name,

                lt.description

            ORDER BY lt.topic_id ASC

            """

        )



        topics = cursor.fetchall()



        cursor.close()

        connection.close()



        return topics



    except Exception as exc:

        print("Error fetching all topics:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return []





def check_topic_inquiry(question: str) -> Optional[Dict[str, Any]]:

    """

    Detect explicit topic-directory requests.



    Important:

        A user mentioning a word such as "salary" is NOT considered

        a request to browse the entire employment topic.

    """

    connection = get_connection()



    if connection is None:

        return None



    try:

        cursor = connection.cursor(dictionary=True)



        cursor.execute(

            """

            SELECT

                topic_id,

                topic_name,

                description

            FROM legal_topics

            ORDER BY topic_id ASC

            """

        )



        topics = cursor.fetchall()



        text = normalize_text(question)



        explicit_patterns = (

            "show legal topics",

            "show topics",

            "legal topics",

            "list legal topics",

            "list topics",

            "what legal topics do you cover",

            "what topics do you cover",

            "show me legal categories",

            "show categories",

            "list categories"

        )



        explicit_topic_request = any(

            pattern in text

            for pattern in explicit_patterns

        )



        if not explicit_topic_request:

            cursor.close()

            connection.close()

            return None



        topic_options = []



        for topic in topics:

            cursor.execute(

                """

                SELECT

                    case_id,

                    case_title,

                    situation,

                    urgency

                FROM legal_cases

                WHERE topic_id = %s

                ORDER BY case_id ASC

                """,

                (topic["topic_id"],)

            )



            cases = cursor.fetchall()



            topic_options.append({

                "topic_id": topic["topic_id"],

                "topic_name": topic["topic_name"],

                "description": topic["description"],

                "total_cases": len(cases),

                "cases": cases

            })



        cursor.close()

        connection.close()



        return {

            "status": "topic_selection",

            "confidence": 1.0,

            "found": True,

            "is_topic_selection": True,

            "title": "Legal Topics Directory",

            "situation_assessment": (

                "Lex can provide information from the legal topics currently "

                "available in its database. Select a topic to continue."

            ),

            "explanation": (

                "Selecting a topic does not mean that a particular legal "

                "rule applies to your situation. You will still need to "

                "describe the facts of your case."

            ),

            "topics": topic_options,

            "category_options": [],

            "preventions": [],

            "actions": [],

            "documents": [],

            "options": [],

            "jurisdiction": "India",

            "case": None,

            "sources": [],

            "disclaimer": (

                "Topic categories are provided for navigation only. "

                "They are not legal conclusions."

            )

        }



    except Exception as exc:

        print("Error checking topic inquiry:", exc)



        try:

            if connection and connection.is_connected():

                connection.close()

        except Exception:

            pass



        return None



def detect_broad_legal_domain(question: str) -> List[str]:
    """
    Detect only the broad legal domain.

    IMPORTANT:
    This function must never select a specific legal case.
    It is only used to decide whether Lex should ask for
    additional facts instead of immediately returning
    "unsupported".
    """

    tokens = set(tokenize(question))

    domain_terms = {
        "Employment Law": {
            "employer", "employee", "salary", "salaries", "wage", "wages",
            "pay", "paid", "payment", "job", "work", "workplace", "boss",
            "company", "office", "employment", "worker", "workers",
            "stipend", "arrears", "remuneration", "termination",
            "terminated", "fired", "dismissed", "resignation", "overtime",
            "harassment", "pf", "gratuity"
        },

        "Rental and Tenancy": {
            "landlord", "tenant", "rent", "rental", "deposit", "lease",
            "eviction", "room", "flat", "apartment",
            "tenancy", "vacate", "security"
        },

        "Consumer Law": {
            "seller", "product", "refund", "replacement", "warranty",
            "defective", "purchase", "purchased", "buyer", "customer",
            "shopping", "order", "goods", "damaged", "broken"
        },

        "Cyber Law": {
            "upi", "scam", "scammed", "fraud", "hacked", "hack", "cyber",
            "online", "otp", "bank", "transaction", "phishing", "qr",
            "password", "account"
        },

        "Traffic & Motor Accidents": {
            "accident", "vehicle", "car", "bike", "motorcycle", "motor",
            "collision", "crash", "injury", "injured", "road", "traffic",
            "driver", "challan", "rto", "mact"
        },

        "Criminal Law": {
            "assault", "attack", "attacked", "beaten", "beat", "threat",
            "threatened", "stolen", "steal", "theft", "murder", "police",
            "fir", "robbery", "criminal", "crime", "arrest", "bail",
            "weapon", "gun"
        },

        "Family Law": {
            "divorce", "marriage", "wife", "husband", "spouse", "child",
            "custody", "maintenance", "alimony", "domestic", "violence",
            "matrimonial", "dowry", "cruelty"
        },

        "Property Law": {
            "property", "land", "plot", "ownership", "possession",
            "boundary", "neighbor", "registry", "title", "builder",
            "rera", "ancestral", "partition"
        },

        "Insurance Law": {
            "insurance", "claim", "policy", "mediclaim", "coverage",
            "rejected", "delayed", "payout", "reimbursement", "denied",
            "tpa"
        },

        "Contract Law": {
            "contract", "agreement", "breach", "deal", "terms", "invoice",
            "vendor", "client", "deadline", "nonpayment", "non-payment"
        },

        "Intellectual Property": {
            "copyright", "trademark", "patent", "copied", "plagiarism",
            "logo", "brand", "infringement", "piracy"
        },

        "Banking & Finance": {
            "cheque", "check", "bounce", "dishonour", "dishonored",
            "banking", "loan", "recovery", "agent", "emi", "cibil", "credit"
        }
    }

    matched_domains = []

    for domain, terms in domain_terms.items():
        if tokens.intersection(terms):
            matched_domains.append(domain)

    # A rental deposit dispute is one coherent tenancy matter. Generic
    # words such as "paid", "payment", or "flat" must not create a second
    # Employment/Property issue. Keep multi-domain handling for genuinely
    # distinct facts (for example, an employer dispute plus a rental dispute).
    rental_deposit = (
        bool(tokens.intersection({"landlord", "tenant", "rental", "tenancy", "rent"}))
        and bool(tokens.intersection({"deposit", "security", "vacate", "returned", "returning"}))
    )
    explicit_employment = bool(tokens.intersection({
        "employer", "employee", "salary", "wages", "workplace", "employment",
        "termination", "terminated", "fired", "dismissed", "job", "boss"
    }))
    if rental_deposit and not explicit_employment:
        return ["Rental and Tenancy"]

    return matched_domains


# ================================================================
# PROGRESSIVE CONSULTATION
# ================================================================
CONSULTATION_ORIGINAL_MARKER = "Original legal situation:"
CONSULTATION_FACTS_MARKER = "Additional facts provided by the user:"


def _is_consultation_followup(question: str) -> bool:
    """Return True only when app.py explicitly supplies prior consultation context."""
    text = str(question or "").lower()
    return (
        CONSULTATION_ORIGINAL_MARKER.lower() in text
        and CONSULTATION_FACTS_MARKER.lower() in text
    )


def _extract_latest_consultation_facts(question: str) -> str:
    """
    Extract the user's newest facts from an explicit consultation
    continuation.

    Retrieval should not depend on the artificial wrapper text
    ("Original legal situation", etc.). The newest user message is
    usually the strongest retrieval signal for the next turn.
    """
    text = str(question or "").strip()

    marker = CONSULTATION_FACTS_MARKER
    marker_index = text.lower().find(marker.lower())

    if marker_index >= 0:
        latest = text[marker_index + len(marker):].strip()
        if latest:
            return latest

    return text


def _progressive_clarification_questions(
    question: str,
    case: Dict[str, Any],
    memory: Optional[Any] = None
) -> List[str]:
    """Ask only facts still missing in an explicit follow-up consultation."""
    full_text = " ".join(memory.all_statements) if (memory and hasattr(memory, "all_statements") and memory.all_statements) else question
    text = normalize_text(full_text)
    combined_case_text = normalize_text(
        f"{case.get('case_title', '')} {case.get('situation', '')} {case.get('topic_name', '')}"
    )
    missing: List[str] = []

    if (
        "salary" in combined_case_text
        or "wage" in combined_case_text
        or "employment" in combined_case_text
    ):
        # Check employment status from full conversation memory
        has_status = bool(re.search(
            r"\b(?:currently|still|working|employed|resigned|left|terminated|fired|dismissed|notice|"
            r"refuses|refusing|refused|won't pay|not paying|not paid|hasn't paid|have not paid|"
            r"haven't paid|denying|still not|after the notice|continuing|ongoing)\b",
            text
        ))
        # If memory has timeframes or amounts, we likely have enough context
        memory_has_facts = bool(
            memory and (
                (memory.amounts and memory.timeframes)
                or (memory.timeframes and len(getattr(memory, "all_statements", [])) >= 2)
            )
        )
        if not has_status and not memory_has_facts:
            missing.append(
                "Are you currently working for the employer, or has your employment already ended?"
            )

        has_asked = bool(re.search(
            r"\b(?:asked|told|demanded|emailed|refused|refuses|refusing|ignored|promised|said|"
            r"no response|no reply|not paid|haven'?t paid|didn'?t pay|did not pay|no reason|"
            r"still not|after notice|claim|complain)\b",
            text
        ))
        if not has_asked and not memory_has_facts:
            missing.append(
                "Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?"
            )

    return unique_list(missing)


# MAIN QUESTION ANALYSIS# ================================================================
def analyze_question(question: str, session_id: Optional[str] = None) -> Dict[str, Any]:

    """

    Main safe analysis function with entity and fact memory tracking.

    """

    if question is None:

        question = ""

    question = str(question).strip()

    session_id = session_id or f"LEX-EPHEMERAL-{uuid.uuid4().hex}"
    memory = get_or_create_memory(session_id)
    if question:
        extract_and_merge_facts(question, memory)
# ------------------------------------------------------------# Empty / greeting# ------------------------------------------------------------
    if not question:

        return {

            "status": "needs_clarification",

            "confidence": 0.0,

            "found": False,

            "is_topic_selection": False,

            "title": "Please Describe Your Legal Issue",

            "situation_assessment": (

                "I need some information about the legal problem before "

                "I can search the legal database."

            ),

            "explanation": (

                "Please describe what happened, who is involved, and what "

                "you want help with."

            ),

            "clarifying_questions": [

                "What happened?",

                "Who is involved?",

                "When did it happen?",

                "What outcome are you seeking?"

            ],

            "preventions": [],

            "actions": [],

            "documents": [],

            "options": [],

            "candidate_cases": [],

            "case": None,

            "sources": [],

            "jurisdiction": "India",

            "disclaimer": (

                "Lex cannot provide a legal assessment without facts."

            )

        }



    if looks_like_general_greeting(question):

        return {

            "status": "needs_clarification",

            "confidence": 0.0,

            "found": False,

            "is_topic_selection": False,

            "title": "How Can Lex Help?",

            "situation_assessment": (

                "Please describe the legal problem you want help with."

            ),

            "explanation": (

                "For example, you can describe a salary dispute, tenancy "

                "issue, consumer problem, cyber incident, family matter, "

                "contract dispute, accident, or another legal issue."

            ),

            "clarifying_questions": [

                "What happened?",

                "Who is involved?",

                "What are you trying to achieve?"

            ],

            "preventions": [],

            "actions": [],

            "documents": [],

            "options": [],

            "candidate_cases": [],

            "case": None,

            "sources": [],

            "jurisdiction": "India",

            "disclaimer": (

                "Lex provides database-backed legal information and does "

                "not replace advice from a qualified lawyer."

            )

        }
# ------------------------------------------------------------# Very short query# ------------------------------------------------------------
    if len(normalize_text(question)) < MIN_QUERY_LENGTH:

        return {

            "status": "needs_clarification",

            "confidence": 0.0,

            "found": False,

            "is_topic_selection": False,

            "title": "More Information Needed",

            "situation_assessment": (

                "The message is too short to identify a legal issue safely."

            ),

            "explanation": (

                "Please describe what happened in one or two sentences."

            ),

            "clarifying_questions": [

                "What happened?",

                "Who is involved?"

            ],

            "preventions": [],

            "actions": [],

            "documents": [],

            "options": [],

            "candidate_cases": [],

            "case": None,

            "sources": [],

            "jurisdiction": "India",

            "disclaimer": (

                "Lex will not guess the legal issue from insufficient information."

            )

        }
# ------------------------------------------------------------# Explicit topic directory# ------------------------------------------------------------
    topic_result = check_topic_inquiry(question)



    if topic_result:

        return topic_result

    # Detect clearly separate legal domains before ranking a single case.
    # A strong match in one part of a long message must not hide another dispute.
    detected_domains = detect_broad_legal_domain(question)
    if len(detected_domains) > 1:
        issue_labels = [str(domain) for domain in detected_domains]
        return {
            "status": "ambiguous",
            "confidence": 0.0,
            "found": False,
            "is_topic_selection": False,
            "title": "Multiple Legal Issues Identified",
            "topic": "Multiple legal issues",
            "situation_assessment": (
                "Your description appears to contain more than one distinct legal issue: "
                + ", ".join(issue_labels)
                + ". These should be assessed separately so facts, laws, remedies, "
                  "and authorities are not incorrectly mixed."
            ),
            "explanation": (
                "Lex has identified the possible legal areas but has not concluded that "
                "any specific offence, breach, liability, or remedy applies. Please tell "
                "Lex which issue you want to address first; the other issue can then be "
                "handled as a separate consultation."
            ),
            "clarifying_questions": [
                "Which of these issues would you like Lex to assess first: "
                + ", ".join(issue_labels) + "?"
            ],
            "actions": [],
            "preventions": [],
            "documents": [],
            "options": [],
            "candidate_cases": [],
            "case": None,
            "sources": [],
            "identified_legal_issues": issue_labels,
            "multiple_issues_detected": True,
            "explicit_facts": extract_explicit_facts(question),
            "jurisdiction": "India",
            "disclaimer": (
                "This is issue identification only, not a legal conclusion. "
                "Each matter requires fact-specific assessment."
            )
        }
# ------------------------------------------------------------# Retrieve candidates# ------------------------------------------------------------
    is_followup = _is_consultation_followup(question)

    # For a continuation, retrieve primarily from the user's newest
    # facts. The wrapper text used to preserve consultation context should
    # not weaken legal-case retrieval. If that fails, retry with the full
    # accumulated consultation text.
    if is_followup:
        latest_facts = _extract_latest_consultation_facts(question)

        # Case identification must use the complete consultation, not only
        # the user's latest short reply. A reply such as "yes", "UPI", or
        # "three months" can be misleading when ranked by itself. Use the
        # latest reply only as a fallback when the complete context yields
        # no database candidates at all.
        ranked = _rank_cases(question)
        if not ranked:
            ranked = _rank_cases(latest_facts)
    else:
        ranked = _rank_cases(question)
        if (not ranked or (ranked and ranked[0]["_score"] < ANSWER_SCORE)) and len(memory.all_statements) > 1:
            combined_query = " ".join(memory.all_statements)
            combined_ranked = _rank_cases(combined_query)
            if combined_ranked and (not ranked or combined_ranked[0]["_score"] > ranked[0]["_score"]):
                ranked = combined_ranked



    if ranked is None:

        return {

            "status": "knowledge_unavailable",

            "confidence": 0.0,

            "found": False,

            "is_topic_selection": False,

            "title": "Legal Knowledge Database Unavailable",

            "situation_assessment": (

                "Lex cannot safely retrieve its legal knowledge database "

                "right now."

            ),

            "explanation": (

                "I will not substitute unverified hardcoded legal information "

                "when the database is unavailable."

            ),

            "clarifying_questions": [],

            "preventions": [],

            "actions": [],

            "documents": [],

            "options": [],

            "candidate_cases": [],

            "case": None,

            "sources": [],

            "jurisdiction": "India",

            "disclaimer": (

                "No legal conclusion has been provided because the required "

                "legal knowledge source is unavailable."

            )

        }



    if not ranked:

        # ------------------------------------------------------------
        # Broad-domain fallback
        # ------------------------------------------------------------
        #
        # A query can clearly indicate a legal domain without
        # containing enough information to identify a specific case.
        #
        # Example:
        #     "employer not paying me"
        #
        # This must NOT be converted into a specific salary,
        # PF, gratuity, termination, or other employment case.
        #
        # Instead, Lex identifies only the broad domain and asks
        # targeted clarification questions.
        # ------------------------------------------------------------

        broad_domains = detect_broad_legal_domain(question)

        if is_followup and len(broad_domains) == 1:
            domain = broad_domains[0]

            if domain == "Employment Law":
                followup_questions = [
                    "Are you currently working for the employer, or has your employment already ended?",
                    "Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?"
                ]

                return {
                    "status": "needs_clarification",
                    "confidence": 0.0,
                    "found": False,
                    "is_topic_selection": False,
                    "title": "More Information Needed",
                    "topic": domain,
                    "situation_assessment": (
                        "Lex has the additional information you provided, "
                        "but needs a few remaining employment facts before "
                        "it can determine whether a specific legal case "
                        "is supported."
                    ),
                    "explanation": (
                        "Lex will not assume your employment status or the "
                        "employer's response to the unpaid-salary issue."
                    ),
                    "clarifying_questions": followup_questions,
                    "actions": followup_questions,
                    "preventions": [],
                    "documents": [],
                    "options": [],
                    "candidate_cases": [],
                    "case": None,
                    "sources": [],
                    "explicit_facts": extract_explicit_facts(question),
                    "jurisdiction": "India",
                    "disclaimer": (
                        "This is a clarification request, not a finding "
                        "that a particular legal provision, remedy, or "
                        "procedure applies."
                    )
                }

        if len(broad_domains) == 1:

            domain = broad_domains[0]

            clarification_questions = {
                "Employment Law": [
                    "What payment or employment issue is involved?",
                    "Is it unpaid salary/wages, PF, gratuity, termination, workplace harassment, or something else?",
                    "How long has the issue been continuing?"
                ],
                "Rental and Tenancy": [
                    "What is the tenancy dispute?",
                    "Is it about a security deposit, rent, eviction, repairs, or something else?",
                    "When did the relevant event happen?"
                ],
                "Consumer Law": [
                    "What product or service did you purchase?",
                    "What exactly went wrong?",
                    "What remedy have you already requested from the seller?"
                ],
                "Cyber Law": [
                    "What exactly happened?",
                    "Was money transferred or was an account/device compromised?",
                    "When did the incident occur?"
                ],
                "Traffic & Motor Accidents": [
                    "When and where did the accident occur?",
                    "Was anyone injured?",
                    "Was an FIR or police complaint already made?"
                ],
                "Criminal Law": [
                    "Please describe exactly what happened.",
                    "Was anyone injured, threatened, or otherwise harmed?",
                    "Has a police complaint or FIR already been filed?"
                ],
                "Family Law": [
                    "What family or matrimonial issue are you facing?",
                    "Who is involved?",
                    "What outcome are you seeking?"
                ],
                "Property Law": [
                    "What is the property dispute?",
                    "Who are the parties involved?",
                    "What documents or agreements relate to the property?"
                ],
                "Insurance Law": [
                    "What type of insurance policy is involved?",
                    "What happened to the claim?",
                    "Has the insurer rejected, delayed, or otherwise disputed the claim?"
                ],
                "Contract Law": [
                    "What type of contract or agreement is involved?",
                    "What obligation or payment is in dispute?",
                    "What has the other party done or failed to do?"
                ],
                "Intellectual Property": [
                    "What was copied, used, registered, or allegedly infringed?",
                    "Do you own or control the relevant work, brand, or invention?",
                    "What happened and when?"
                ],
                "Banking & Finance": [
                    "What banking or financial issue occurred?",
                    "What transaction, loan, cheque, or account is involved?",
                    "When did the issue occur?"
                ]
            }

            is_def, dynamic_questions, lead_assessment = evaluate_situation_definition(question, memory, domain)
            if dynamic_questions:
                if domain == "Employment Law":
                    if not any("payment" in q.lower() for q in dynamic_questions) or not any("employment" in q.lower() for q in dynamic_questions):
                        dynamic_questions.insert(0, "What payment or employment issue is involved?")
                questions = dynamic_questions
            else:
                questions = clarification_questions.get(
                    domain,
                    [
                        "Please describe what happened in more detail.",
                        "When did the issue occur?",
                        "What action, if any, has already been taken?"
                    ]
                )

            return {
                "status": "needs_clarification",
                "confidence": 0.0,
                "found": False,
                "is_topic_selection": False,
                "title": "More Information Needed",
                "topic": domain,
                "situation_assessment": lead_assessment or (
                    f"Your message appears to concern {domain}, "
                    "but it does not contain enough facts to identify "
                    "a specific legal issue reliably."
                ),
                "explanation": (
                    "Lex will not assume which specific legal case "
                    "applies. Please provide the relevant facts so "
                    "the legal issue can be identified safely."
                ),
                "clarifying_questions": questions,
                "actions": questions,
                "preventions": [],
                "documents": [],
                "options": [],
                "candidate_cases": [],
                "case": None,
                "sources": [],
                "remembered_details": memory.to_dict(),
                "explicit_facts": extract_explicit_facts(question),
                "jurisdiction": "India",
                "disclaimer": (
                    "This is a clarification request, not a "
                    "determination of which legal provision applies. "
                    "Lex will not infer facts that you have not provided."
                )
            }

        if len(broad_domains) > 1:
            return {
                "status": "ambiguous",
                "confidence": 0.0,
                "found": False,
                "is_topic_selection": False,
                "title": "Please Clarify the Legal Issue",
                "situation_assessment": (
                    "Your message appears to involve more than one "
                    "possible legal area, so Lex cannot safely identify "
                    "the specific issue yet."
                ),
                "explanation": (
                    "Please describe the main event or dispute and "
                    "tell Lex what outcome you want help with."
                ),
                "clarifying_questions": [
                    "What exactly happened?",
                    "Who is involved?",
                    "Which part of the situation is causing the legal problem?",
                    "What outcome are you seeking?"
                ],
                "actions": [
                    "Describe the main event in chronological order.",
                    "Identify the people, company, seller, landlord, or other party involved.",
                    "State what you want Lex to help you achieve."
                ],
                "preventions": [],
                "documents": [],
                "options": [],
                "candidate_cases": [],
                "case": None,
                "sources": [],
                "explicit_facts": extract_explicit_facts(question),
                "identified_legal_issues": broad_domains,
                "multiple_issues_detected": True,
                "jurisdiction": "India",
                "disclaimer": (
                    "Lex will not select a specific legal case when "
                    "the available facts point to multiple possible "
                    "legal areas."
                )
            }

        return {
            "status": "unsupported",
            "confidence": 0.0,
            "found": False,
            "is_topic_selection": False,
            "title": "No Reliable Match Found",
            "situation_assessment": (
                "I could not find a sufficiently reliable match for "
                "the legal issue you described in Lex's current "
                "legal database."
            ),
            "explanation": (
                "I do not want to invent a legal section, remedy, "
                "deadline, procedure, or case that is not supported "
                "by the available legal information."
            ),
            "clarifying_questions": [
                "Can you describe what happened in more detail?",
                "Who is involved?",
                "What specific legal outcome are you looking for?"
            ],
            "actions": [],
            "preventions": [],
            "documents": [],
            "options": [],
            "candidate_cases": [],
            "case": None,
            "sources": [],
            "explicit_facts": extract_explicit_facts(question),
            "jurisdiction": "India",
            "disclaimer": (
                "No reliable legal match was found. This is not a "
                "statement that no legal remedy exists; it only means "
                "Lex cannot currently support one from its available "
                "legal database."
            )
        }

    top = ranked[0]

    second = ranked[1] if len(ranked) > 1 else None

    # ------------------------------------------------------------
    # Memory-aware effective answer threshold
    # If the session already has rich context (amounts + timeframes
    # or a primary party), lower the threshold even further.
    # ------------------------------------------------------------
    memory_rich = bool(
        memory and (
            (memory.amounts and memory.timeframes)
            or (memory.primary_party and memory.amounts)
            or (memory.primary_party and memory.timeframes)
            or len(getattr(memory, "all_statements", [])) >= 2
        )
    )
    effective_answer_score = 22.0 if memory_rich else ANSWER_SCORE

    # ------------------------------------------------------------
    # Ambiguity check
    # Only flag ambiguous when the top score is genuinely weak.
    # A strong top candidate (>= STRONG_MATCH_SCORE) that is close
    # to the second place is still the best answer — do not force
    # the user into a disambiguation loop in that case.
    # ------------------------------------------------------------
    top_is_strong = top["_score"] >= STRONG_MATCH_SCORE
    gap_too_small = second is not None and (top["_score"] - second["_score"]) < AMBIGUITY_MARGIN

    if gap_too_small and not top_is_strong:
        # Both candidates are weak and close — genuinely ambiguous
        return build_ambiguous_response(question, ranked)

    # ------------------------------------------------------------
    # Explicit consultation follow-ups: ask only remaining facts
    # before the weak-match check, so the user is not dropped into
    # the generic "describe what happened" route unnecessarily.
    # ------------------------------------------------------------
    if is_followup:
        remaining_questions = _progressive_clarification_questions(
            question,
            top,
            memory=memory
        )
        if remaining_questions:
            response = build_clarification_response(question, ranked)
            response["clarifying_questions"] = remaining_questions
            response["actions"] = remaining_questions
            return response

    # ------------------------------------------------------------
    # Weak match check (memory-adjusted threshold)
    # ------------------------------------------------------------
    if top["_score"] < effective_answer_score:
        return build_clarification_response(question, ranked)

    # ------------------------------------------------------------
    # Fact sufficiency check
    # ------------------------------------------------------------
    requires_clarification, missing_facts = _case_requires_clarification(
        question, top, memory=memory
    )

    if requires_clarification:
        response = build_clarification_response(question, ranked)
        response["clarifying_questions"] = unique_list(missing_facts)
        response["actions"] = unique_list(missing_facts)
        return response

# ------------------------------------------------------------# Source check# ------------------------------------------------------------
    sources = _fetch_sources_for_case(

        int(top["case_id"])

    )



    # Source metadata is displayed when available, but its absence must not
    # disable an otherwise populated database case. The case content, actions,
    # and documents are still returned with an explicit verification caveat.
# ------------------------------------------------------------# Retrieve supporting material# ------------------------------------------------------------
    case_id = int(top["case_id"])



    actions = get_actions(case_id)

    documents = get_documents(case_id)

    options = get_options(case_id)



    preventions = get_preventions_and_precautions(top)
# ------------------------------------------------------------# Build fact-based assessment# ------------------------------------------------------------
    explicit_facts = extract_explicit_facts(question)



    situation_assessment = (

        "Based only on the information you provided, your question "

        "appears relevant to the legal situation described in Lex's "

        "database. This is a database match, not a determination that "

        "the law has been violated."

    )



    response = {

        "status": "answered",

        "confidence": round(

            min(0.99, top["_score"] / 100.0),

            2

        ),

        "found": True,

        "is_topic_selection": False,



        "title": top.get("case_title"),

        "situation_assessment": situation_assessment,



        "explanation": top.get("explanation", ""),



        "preventions": preventions,

        "options": options,

        "actions": actions,

        "documents": documents,



        "jurisdiction": top.get(

            "jurisdiction",

            "India"

        ),



        "case": top,



        "sources": _source_summary(sources),
        "source_metadata_available": bool(sources),



        "explicit_facts": {

            "domain": explicit_facts["domain"],

            "intent": explicit_facts["intent"],

            "time_periods": explicit_facts["time_periods"],

            "amounts": explicit_facts["amounts"],

            "mentioned_parties": explicit_facts["mentioned_parties"],

            "mentioned_documents": explicit_facts["mentioned_documents"],

        },



        "candidate_cases": [

            {

                "case_id": item.get("case_id"),

                "title": item.get("case_title"),

                "situation": item.get("situation"),

                "topic": item.get("topic_name"),

                "score": item.get("_score"),

            }

            for item in ranked[:3]

        ],



        "disclaimer": (

            ("Some database entries do not yet include source links. Verify the applicable law and current procedure with an official source or qualified Indian lawyer. " if not sources else "")
            + "Lex provides database-backed general legal information for "

            "Indian-law situations. The database match does not establish "

            "that a particular offence, violation, liability, remedy, "

            "deadline, or legal entitlement applies to your specific facts. "

            "For decisions involving significant rights, money, safety, "

            "criminal allegations, or court proceedings, consult a "

            "qualified legal professional."

        )

    }

    return personalize_legal_response(response, memory)
# ================================================================# PUBLIC API# ================================================================
def get_legal_information(question: str, session_id: Optional[str] = None) -> Optional[Dict[str, Any]]:

    """

    Public entry point used by chat_service.py.

    """

    return analyze_question(question, session_id=session_id)