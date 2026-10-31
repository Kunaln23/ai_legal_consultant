import sys
sys.path.insert(0, '.')
from legal_service import _phrase_match_score, _fetch_cases

cases = _fetch_cases()
q = 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'

for c in (cases or []):
    if c.get('case_id') in [1, 2]:
        s = _phrase_match_score(q, c)
        print(f"case_id={c['case_id']}  title={c.get('case_title','')}  phrase_score={s}")

