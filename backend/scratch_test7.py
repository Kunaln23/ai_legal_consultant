import sys
sys.path.insert(0, '.')
from legal_service import _fetch_cases, normalize_text

cases = _fetch_cases()

# Find what cases exist and their topics  
for c in (cases or []):
    if 'seller' in normalize_text(c.get('case_title', '')) or 'defect' in normalize_text(c.get('case_title', '')) or 'refund' in normalize_text(c.get('case_title', '')):
        print(f"case_id={c['case_id']}  topic={c.get('topic_name','')}  title={c.get('case_title','')}")
        print(f"  keywords={c.get('keywords','')[:80]}")
        print()

