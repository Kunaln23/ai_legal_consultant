import sys
sys.path.insert(0, '.')
from legal_service import _phrase_match_score, _fetch_cases, normalize_text, tokenize, PHRASE_GROUPS

cases = _fetch_cases()
q = 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'

# Find relevant cases
for c in (cases or []):
    if c.get('case_id') in [2, 33, 6]:  # seller refund, data leak, defective
        title = c.get('case_title', '')
        score = _phrase_match_score(q, c)
        print(f"case_id={c['case_id']}  title={title[:50]}")
        print(f"  phrase_score={score:.1f}")
        
        # Debug: which phrases matched?
        text = normalize_text(q)
        searchable = normalize_text(f"{title} {c.get('situation', '')}")
        for group_name, phrases in PHRASE_GROUPS.items():
            for phrase in phrases:
                if phrase in text:
                    phrase_tokens = set(tokenize(phrase))
                    case_tokens = set(tokenize(searchable))
                    overlap = len(phrase_tokens & case_tokens)
                    if overlap >= 1:
                        print(f"    MATCH: phrase='{phrase}' group={group_name} overlap={overlap} tokens_in_case={phrase_tokens & case_tokens}")
        print()

