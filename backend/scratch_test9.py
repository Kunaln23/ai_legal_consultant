import sys
sys.path.insert(0, '.')
from legal_service import _fetch_cases, normalize_text, tokenize, PHRASE_GROUPS

cases = _fetch_cases()
q = 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'
text = normalize_text(q)

PHRASE_GROUP_DOMAIN_GUARDS = {
    "unpaid_salary":        ["salary", "wage", "employment", "payment of wages"],
    "security_deposit":     ["deposit", "tenant", "landlord", "rent"],
    "online_fraud":         ["cyber", "upi", "fraud", "scam", "bank"],
    "defective_product":    ["consumer", "product", "seller", "defect", "refund"],
    "physical_assault":     ["assault", "criminal", "battery", "violence"],
    "death_threat":         ["criminal", "threat", "murder"],
    "cheque_bounce":        ["cheque", "bounce", "section 138", "banking"],
    "wrongful_termination": ["termination", "employment", "fired", "resign"],
}

for c in (cases or []):
    if c.get('case_id') in [1, 2, 33]:
        title = normalize_text(c.get('case_title', ''))
        situation = normalize_text(c.get('situation', ''))
        case_topic = normalize_text(c.get('topic_name', ''))
        keywords_text = normalize_text(c.get('keywords', ''))
        case_domain_text = f"{title} {situation} {case_topic} {keywords_text}"
        
        print(f"case_id={c['case_id']}  title={c.get('case_title','')}")
        print(f"  topic={c.get('topic_name', '')}")
        
        for group_name, phrase_group in PHRASE_GROUPS.items():
            guards = PHRASE_GROUP_DOMAIN_GUARDS.get(group_name)
            domain_ok = True
            if guards:
                domain_ok = any(g in case_domain_text for g in guards)
            
            for phrase in phrase_group:
                if phrase in text:
                    phrase_tokens = set(tokenize(phrase))
                    case_tokens = set(tokenize(f"{title} {situation} {keywords_text}"))
                    overlap = len(phrase_tokens & case_tokens)
                    print(f"  PHRASE '{phrase}' in user text, domain_ok={domain_ok}, overlap={overlap}, score_add={18.0 if overlap>=2 else (8.0 if overlap==1 else 0)}")
        print()

