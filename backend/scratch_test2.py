import sys
sys.path.insert(0, '.')
from legal_service import _rank_cases, analyze_question, detect_broad_legal_domain, extract_explicit_facts

# Test 1: salary
q1 = 'My boss has not paid my salary for 3 months. I work at a private company in Mumbai.'
ranked1 = _rank_cases(q1)
print("SALARY CASE ranked:")
for c in (ranked1 or [])[:5]:
    print(f"  score={c['_score']:.1f}  case_id={c['case_id']}  title={c['case_title'][:60]}")
print("  broad_domains:", detect_broad_legal_domain(q1))
print()

# Test 2: consumer/phone
q2 = 'I bought a phone online and the seller sent a broken phone. I have been asking for refund for 2 weeks but they are ignoring me.'
ranked2 = _rank_cases(q2)
print("CONSUMER CASE ranked:")
for c in (ranked2 or [])[:5]:
    print(f"  score={c['_score']:.1f}  case_id={c['case_id']}  title={c['case_title'][:60]}")
print()

# Test 3: assault
q3 = 'My neighbor is threatening me and has physically assaulted me twice this week.'
ranked3 = _rank_cases(q3)
print("ASSAULT CASE ranked:")
for c in (ranked3 or [])[:5]:
    print(f"  score={c['_score']:.1f}  case_id={c['case_id']}  title={c['case_title'][:60]}")
print()

