import sys
sys.path.insert(0, '.')
from legal_service import _fetch_cases, normalize_text, tokenize

cases = _fetch_cases()

# Check case 1 (defective) and 2 (refund) keywords in detail
for c in (cases or []):
    if c.get('case_id') in [1, 2]:
        print(f"case_id={c['case_id']}  title={c.get('case_title','')}")
        print(f"  keywords={c.get('keywords','')}")
        kw_tokens = set(tokenize(normalize_text(c.get('keywords', ''))))
        title_tokens = set(tokenize(normalize_text(c.get('case_title', ''))))
        print(f"  title_tokens={title_tokens}")
        print()

# Check what case 33 has
for c in (cases or []):
    if c.get('case_id') == 33:
        print(f"case_id={c['case_id']}  title={c.get('case_title','')}")
        print(f"  keywords={c.get('keywords','')[:100]}")
        print(f"  situation={c.get('situation','')[:100]}")

