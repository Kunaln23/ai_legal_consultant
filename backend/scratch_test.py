import sys
sys.path.insert(0, '.')
from legal_service import analyze_question

cases = [
    ('salary_case', 'My boss has not paid my salary for 3 months. I work at a private company in Mumbai.'),
    ('deposit_case', 'My landlord is refusing to return my security deposit of 50000 rupees even though I vacated the flat 2 months ago.'),
    ('consumer_case', 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'),
    ('assault_case', 'My neighbor is threatening me and has physically assaulted me twice this week.'),
]

for sid, q in cases:
    r = analyze_question(q, session_id=sid)
    score = r.get('case', {}).get('_score') if r.get('case') else 'N/A'
    print(f"Q: {q[:70]}")
    print(f"  status={r['status']}  score={score}  title={r.get('title','')[:55]}")
    if r['status'] == 'needs_clarification':
        cqs = r.get('clarifying_questions', [])
        print(f"  questions={cqs[:2]}")
    print()

