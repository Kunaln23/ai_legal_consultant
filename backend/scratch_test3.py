import sys
sys.path.insert(0, '.')
from legal_service import _rank_cases, _fetch_sources_for_case, _source_is_present

# Check salary case - what score does it need and what sources exist
q1 = 'My boss has not paid my salary for 3 months. I work at a private company in Mumbai.'
ranked1 = _rank_cases(q1)
print("SALARY case_id=8 sources:")
s = _fetch_sources_for_case(8)
print("  has_source:", _source_is_present(s))
print("  sources:", s[:2] if s else [])
print()

# check what the max possible score is by feeding an ideal query
q_ideal_salary = 'unpaid salary wages employer withheld employee payment'
ranked_ideal = _rank_cases(q_ideal_salary)
print("IDEAL SALARY ranked:")
for c in (ranked_ideal or [])[:3]:
    print(f"  score={c['_score']:.1f}  title={c['case_title'][:60]}")
print()

# Check all cases that have sources to understand scoring distribution
from legal_service import _fetch_cases
cases = _fetch_cases()
print(f"Total DB cases: {len(cases) if cases else 0}")

# Check what scores are possible for salary case against DB keywords
from legal_service import normalize_text, tokenize, STOPWORDS
salary_case = next((c for c in (cases or []) if c.get('case_id') == 8), None)
if salary_case:
    print(f"Salary case: {salary_case.get('case_title')}")
    print(f"  situation: {salary_case.get('situation', '')[:100]}")
    print(f"  keywords: {salary_case.get('keywords', '')[:100]}")

