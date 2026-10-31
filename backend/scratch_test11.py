import sys
sys.path.insert(0, '.')
from legal_service import _fetch_cases, normalize_text, tokenize, PHRASE_GROUPS

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

cases = _fetch_cases()
q = 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'
text = normalize_text(q)

c2 = next(c for c in cases if c.get('case_id') == 2)
title = normalize_text(c2.get('case_title', ''))
situation = normalize_text(c2.get('situation', ''))
case_topic = normalize_text(c2.get('topic_name', ''))
keywords_text = normalize_text(c2.get('keywords', ''))
case_domain_text = f"{title} {situation} {case_topic} {keywords_text}"
searchable = f"{title} {situation} {keywords_text}"

print(f"case_topic='{case_topic}'  title='{title}'")
print(f"keywords={keywords_text[:80]}")
print()

for group_name, phrase_group in PHRASE_GROUPS.items():
    guards = PHRASE_GROUP_DOMAIN_GUARDS.get(group_name)
    
    for phrase in phrase_group:
        if phrase in text:
            domain_ok = True
            if guards:
                domain_ok = any(g in case_domain_text for g in guards)
            
            phrase_tokens = set(tokenize(phrase))
            case_tokens = set(tokenize(searchable))
            overlap = len(phrase_tokens & case_tokens)
            
            print(f"Phrase '{phrase}' group={group_name}")
            print(f"  domain_ok={domain_ok}  phrase_tokens={phrase_tokens}  case_tokens_subset={phrase_tokens & case_tokens}  overlap={overlap}")

