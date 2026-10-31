import sys
sys.path.insert(0, '.')
from legal_service import _rank_cases, STRONG_MATCH_SCORE, AMBIGUITY_MARGIN

q = 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'
ranked = _rank_cases(q)
print("CONSUMER ranked:")
for c in (ranked or [])[:5]:
    print(f"  score={c['_score']:.1f}  title={c['case_title'][:65]}")
    print(f"    evidence={c.get('_evidence', {})}")

print()
if ranked and len(ranked) >= 2:
    top = ranked[0]
    second = ranked[1]
    gap = top['_score'] - second['_score']
    strong = top['_score'] >= STRONG_MATCH_SCORE
    print(f"top={top['_score']:.1f}  second={second['_score']:.1f}  gap={gap:.1f}")
    print(f"STRONG_MATCH_SCORE={STRONG_MATCH_SCORE}  top_is_strong={strong}  AMBIGUITY_MARGIN={AMBIGUITY_MARGIN}")
    print(f"gap_too_small={gap < AMBIGUITY_MARGIN}  ambiguous={gap < AMBIGUITY_MARGIN and not strong}")

