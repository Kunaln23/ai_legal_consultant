import sys
sys.path.insert(0, '.')
from legal_service import PHRASE_GROUPS

print("defective_product phrases:")
for p in sorted(PHRASE_GROUPS.get('defective_product', [])):
    print(f"  '{p}'")

print()
print("unpaid_salary phrases count:", len(PHRASE_GROUPS.get('unpaid_salary', [])))

