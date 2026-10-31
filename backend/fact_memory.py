# ================================================================
# LEX FACT & CONTEXT MEMORY ENGINE
# Indian Law Legal Consultant | Entity, Pronoun, & Detail Tracking
# ================================================================
"""
This module provides continuous session-wide memory and entity tracking:
- Recognizes person names, roles, and titles (e.g. Ramesh, Mr. Sharma, Priya).
- Tracks subject/object/possessive pronouns (he/him/his, she/her/hers, they/them).
- Associates pronouns with the identified named parties and roles.
- Tracks specific factual details: financial amounts, durations, locations,
  existing agreements, and communication history across multi-turn chats.
- Evaluates whether the legal situation is sufficiently defined to conclude
  a specific violation or if progressive clarification is required.
- Dynamically personalizes legal action roadmaps, required documents, and
  formal violation names with the remembered details.
"""

import re
from typing import Any, Dict, List, Optional, Tuple


# ================================================================
# ACCURATE STATUTORY VIOLATION MAPPINGS (INDIAN LAW)
# ================================================================
STATUTORY_VIOLATIONS = {
    # Consumer Law (1-7)
    1: {
        "name": "Supply of Defective Goods & Failure of Product Liability",
        "statute": "Consumer Protection Act, 2019 (Sections 84-87) & Sale of Goods Act, 1930",
        "category": "Consumer Rights & Statutory Product Liability",
        "type": "Civil Breach & Consumer Dispute"
    },
    2: {
        "name": "Unfair Trade Practice & Deficiency of Service (Refund Refusal)",
        "statute": "Consumer Protection Act, 2019 (Section 2(11) & Section 2(47))",
        "category": "Unfair Trade Practice",
        "type": "Consumer Protection Statutory Violation"
    },
    3: {
        "name": "E-Commerce Fraud & Deceptive Trading Practice",
        "statute": "Consumer Protection (E-Commerce) Rules, 2020 & Information Technology Act, 2000 (Section 66D)",
        "category": "E-Commerce Violation & Cheating",
        "type": "Civil Dispute & Criminal Cheating"
    },
    4: {
        "name": "Denial of Manufacturer Warranty & Statutory Service Default",
        "statute": "Consumer Protection Act, 2019 (Section 2(11) - Deficiency in Service)",
        "category": "Warranty Default",
        "type": "Consumer Statutory Violation"
    },
    5: {
        "name": "Actionable Deficiency in Professional / Commercial Service",
        "statute": "Consumer Protection Act, 2019 (Section 2(11) & Section 35)",
        "category": "Deficiency in Service",
        "type": "Consumer Redressal Claim"
    },
    6: {
        "name": "Overcharging Above Maximum Retail Price (MRP Violation)",
        "statute": "Legal Metrology Act, 2009 (Section 36) & Legal Metrology (Packaged Commodities) Rules, 2011",
        "category": "Pricing Violation",
        "type": "Statutory Penalty & Consumer Offence"
    },
    7: {
        "name": "False, Misleading & Deceptive Commercial Advertisement",
        "statute": "Consumer Protection Act, 2019 (Section 2(28) & Section 89)",
        "category": "Misleading Advertisement",
        "type": "Statutory Penalty & Consumer Misrepresentation"
    },

    # Employment Law (8-13)
    8: {
        "name": "Unlawful Withholding of Earned Salary & Wages",
        "statute": "Payment of Wages Act, 1936 (Section 15) & Industrial Disputes Act, 1947 (Section 33C) / BNS Section 318 (Criminal Breach of Trust)",
        "category": "Wage Default & Breach of Employment Contract",
        "type": "Labour Law Statutory Violation & Civil Recovery"
    },
    9: {
        "name": "Illegal Termination of Employment & Retrenchment Default",
        "statute": "Industrial Disputes Act, 1947 (Section 25F) & State Shops and Establishments Act",
        "category": "Wrongful Dismissal",
        "type": "Labour Law Violation & Contract Breach"
    },
    10: {
        "name": "Workplace Sexual Harassment & Hostile Work Environment",
        "statute": "Sexual Harassment of Women at Workplace (Prevention, Prohibition and Redressal) Act, 2013 (POSH Act) & Bharatiya Nyaya Sanhita, 2023 (Section 75 / IPC Section 354A)",
        "category": "Workplace Harassment",
        "type": "Statutory POSH Violation & Cognizable Criminal Offence"
    },
    11: {
        "name": "Unlawful Withholding of Statutory Provident Fund (PF) & Gratuity",
        "statute": "Employees' Provident Funds and Miscellaneous Provisions Act, 1952 (Section 14) & Payment of Gratuity Act, 1972 (Section 4 & 7)",
        "category": "Statutory Benefits Default",
        "type": "Statutory Labour Offence & Summary Recovery"
    },
    12: {
        "name": "Summary Termination Without Notice or Notice Pay in Lieu",
        "statute": "State Shops and Establishments Act & Indian Contract Act, 1872 (Section 73)",
        "category": "Notice Default",
        "type": "Breach of Employment Contract"
    },
    13: {
        "name": "Non-Payment of Mandatory Overtime Wages",
        "statute": "Factories Act, 1948 (Section 59) & State Shops and Commercial Establishments Act",
        "category": "Wage Violation",
        "type": "Statutory Labour Non-Compliance"
    },

    # Property Law (14-18)
    14: {
        "name": "Property Title Dispute & Adverse Cloud on Real Estate Ownership",
        "statute": "Specific Relief Act, 1963 (Section 34 - Declaration of Title) & Transfer of Property Act, 1882",
        "category": "Title Dispute",
        "type": "Civil Property Suit"
    },
    15: {
        "name": "Delay in Possession of Real Estate Unit & Default under RERA",
        "statute": "Real Estate (Regulation and Development) Act, 2016 (RERA, Section 18)",
        "category": "Builder Default",
        "type": "Statutory RERA Violation & Interest/Refund Claim"
    },
    16: {
        "name": "Illegal Encroachment on Real Property & Criminal Trespass",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 329 / IPC Section 441) & Specific Relief Act, 1963 (Section 38 - Injunction)",
        "category": "Property Encroachment",
        "type": "Civil Trespass & Criminal Offence"
    },
    17: {
        "name": "Denial of Coparcenary Legal Share in Ancestral Property",
        "statute": "Hindu Succession Act, 1956 (Section 6, amended 2005) & Partition Act, 1893",
        "category": "Inheritance & Partition",
        "type": "Civil Suit for Partition and Separate Possession"
    },
    18: {
        "name": "Loss of Original Title Deeds & Reconstruction of Property Records",
        "statute": "Registration Act, 1908 (Section 57) & Indian Evidence Act / BSA 2023 (Secondary Evidence)",
        "category": "Title Documentation",
        "type": "Administrative / Registration Rectification"
    },

    # Rental and Tenancy (19-23)
    19: {
        "name": "Unlawful Retention of Security Deposit & Breach of Tenancy Contract",
        "statute": "Model Tenancy Act (Section 13) / State Rent Control Act & Indian Contract Act, 1872 (Section 73)",
        "category": "Rental Deposit Dispute",
        "type": "Tenancy Breach & Civil Recovery Claim"
    },
    20: {
        "name": "Threat of Illegal Eviction & Forcible Dispossession Without Due Process",
        "statute": "Specific Relief Act, 1963 (Section 6) & Bharatiya Nyaya Sanhita, 2023 (Section 329 / IPC Section 441 - Criminal Trespass)",
        "category": "Unlawful Eviction",
        "type": "Emergency Civil Dispossession & Criminal Offence"
    },
    21: {
        "name": "Breach of Landlord's Statutory Duty of Tenantable Repair",
        "statute": "Model Tenancy Act (Section 15) & State Rent Control Regulations",
        "category": "Property Maintenance",
        "type": "Tenancy Statutory Default"
    },
    22: {
        "name": "Arbitrary & Uncontractual Rent Escalation During Active Lease",
        "statute": "Model Tenancy Act (Section 9 & 10) & Indian Contract Act, 1872",
        "category": "Rent Dispute",
        "type": "Breach of Lease Agreement"
    },
    23: {
        "name": "Unlawful Overstay & Failure to Vacate After Lease Expiry",
        "statute": "Transfer of Property Act, 1882 (Section 106 & 111) & State Rent Control Act",
        "category": "Holding Over",
        "type": "Civil Eviction Petition & Mesne Profits Claim"
    },

    # Family Law (24-28)
    24: {
        "name": "Dissolution of Marriage by Mutual Consent",
        "statute": "Hindu Marriage Act, 1955 (Section 13B) / Special Marriage Act, 1954 (Section 28)",
        "category": "Mutual Consent Divorce",
        "type": "Family Court Joint Petition"
    },
    25: {
        "name": "Matrimonial Cruelty & Desertion (Contested Divorce)",
        "statute": "Hindu Marriage Act, 1955 (Section 13(1)(ia) & 13(1)(ib))",
        "category": "Contested Matrimonial Dispute",
        "type": "Family Court Petition on Statutory Grounds"
    },
    26: {
        "name": "Custody Dispute & Welfare of the Minor Child",
        "statute": "Guardians and Wards Act, 1890 & Hindu Minority and Guardianship Act, 1956",
        "category": "Child Custody & Visitation",
        "type": "Family Court Custody Proceeding"
    },
    27: {
        "name": "Neglect and Refusal of Maintenance to Dependent Spouse / Child",
        "statute": "Bharatiya Nagarik Suraksha Sanhita, 2023 (Section 144 / Section 125 CrPC) & Hindu Marriage Act, 1955 (Sections 24 & 25)",
        "category": "Spousal & Child Maintenance",
        "type": "Statutory Maintenance Claim"
    },
    28: {
        "name": "Domestic Violence, Physical/Mental Harassment & Matrimonial Cruelty",
        "statute": "Protection of Women from Domestic Violence Act, 2005 (PWDVA, Sections 18-22) & Bharatiya Nyaya Sanhita, 2023 (Section 85 / IPC Section 498A)",
        "category": "Domestic Violence",
        "type": "Emergency Protection Proceeding & Cognizable Criminal Offence"
    },

    # Cyber Law (29-34)
    29: {
        "name": "Cyber Financial Fraud, Identity Theft & Unauthorized Electronic Transfer",
        "statute": "Information Technology Act, 2000 (Section 66C & 66D) & Bharatiya Nyaya Sanhita, 2023 (Section 318(4) / IPC Section 420 - Cheating)",
        "category": "Cyber Financial Fraud",
        "type": "Cyber Crime & Cognizable Criminal Offence"
    },
    30: {
        "name": "Unauthorized Digital Access & Hacking of Social Media / Device",
        "statute": "Information Technology Act, 2000 (Section 43 & Section 66)",
        "category": "Cyber Hacking",
        "type": "Cognizable Cyber Crime"
    },
    31: {
        "name": "Digital Impersonation & Cheating by Personation",
        "statute": "Information Technology Act, 2000 (Section 66D) & Bharatiya Nyaya Sanhita, 2023 (Section 319 / IPC Section 416)",
        "category": "Online Impersonation",
        "type": "Cognizable Offence"
    },
    32: {
        "name": "Cyber Blackmail, Extortion & Transmission of Obscene Content",
        "statute": "Information Technology Act, 2000 (Section 67 & 67A) & Bharatiya Nyaya Sanhita, 2023 (Section 308 / IPC Section 384 - Extortion)",
        "category": "Cyber Extortion",
        "type": "Serious Cognizable Cyber Offence"
    },
    33: {
        "name": "Unauthorized Personal Data Leak & Breach of Information Security",
        "statute": "Digital Personal Data Protection Act, 2023 (DPDP Act) & IT Act, 2000 (Section 43A)",
        "category": "Data Privacy Breach",
        "type": "Statutory Data Protection Violation"
    },
    34: {
        "name": "Creation and Circulation of Non-Consensual Synthetic Media (Deepfakes)",
        "statute": "Information Technology Act, 2000 (Section 66E, 67, 67A) & BNS 2023 (Section 79 / IPC Section 509)",
        "category": "Deepfake & Privacy Infringement",
        "type": "Cognizable Cyber Offence"
    },

    # Criminal Law (35-39, 63-66)
    35: {
        "name": "Unlawful Refusal by Police Officer to Register Cognizable FIR",
        "statute": "Bharatiya Nagarik Suraksha Sanhita, 2023 (Section 173 & Section 175(3) / Section 154 & 156(3) CrPC) & Lalita Kumari v. Govt of UP (2014)",
        "category": "Police Default",
        "type": "Criminal Procedural Default & Remedy Before Magistrate"
    },
    36: {
        "name": "Deprivation of Personal Liberty & Arrest Without Statutory Grounds",
        "statute": "Bharatiya Nagarik Suraksha Sanhita, 2023 (Section 482 - Anticipatory Bail & Section 480 - Regular Bail / Section 438 & 437 CrPC) & Constitution of India (Article 21)",
        "category": "Bail & Personal Liberty",
        "type": "Criminal Bail Proceeding"
    },
    37: {
        "name": "Cheating, Dishonest Inducement & Criminal Breach of Trust",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 316 - Criminal Breach of Trust & Section 318 - Cheating / IPC Section 406 & 420)",
        "category": "Cheating & Criminal Breach of Trust",
        "type": "Cognizable Criminal Offence"
    },
    38: {
        "name": "Criminal Defamation & Intentional Harm to Reputation",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 356 / IPC Section 499 & 500) & Civil Law of Torts",
        "category": "Defamation",
        "type": "Criminal Complaint & Civil Damages Suit"
    },
    63: {
        "name": "Voluntarily Causing Hurt / Grievous Hurt & Physical Assault",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 115 - Voluntarily Causing Hurt & Section 117 - Grievous Hurt / IPC Section 323, 325 & 352)",
        "category": "Physical Assault",
        "type": "Cognizable Criminal Offence & Police FIR"
    },
    64: {
        "name": "Attempt to Murder & Armed Assault with Dangerous Weapons",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 109 - Attempt to Murder / IPC Section 307) & Arms Act, 1959",
        "category": "Heinous Violent Crime",
        "type": "Non-Bailable Cognizable Criminal Offence"
    },
    65: {
        "name": "Criminal Intimidation & Death Threats",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 351 - Criminal Intimidation / IPC Section 506)",
        "category": "Criminal Threat",
        "type": "Cognizable Criminal Offence"
    },
    66: {
        "name": "Theft, Extortion & Robbery of Personal Property",
        "statute": "Bharatiya Nyaya Sanhita, 2023 (Section 303 - Theft & Section 309 - Robbery / IPC Section 379 & 392)",
        "category": "Property Crime",
        "type": "Cognizable Criminal Offence"
    },

    # Civil Disputes & Injunctions (39-41)
    39: {
        "name": "Default in Liquidated Debt & Summary Recovery of Money",
        "statute": "Code of Civil Procedure, 1908 (Order 37 - Summary Suits) & Commercial Courts Act, 2015",
        "category": "Debt Recovery",
        "type": "Summary Civil Suit for Recovery"
    },
    40: {
        "name": "Imminent Threat to Property Rights (Temporary Injunction)",
        "statute": "Code of Civil Procedure, 1908 (Order 39 Rules 1 & 2) & Specific Relief Act, 1963",
        "category": "Injunction & Stay Order",
        "type": "Civil Interlocutory Injunction"
    },
    41: {
        "name": "Private Nuisance & Substantial Interference with Peaceful Enjoyment",
        "statute": "Law of Torts (Private Nuisance) & Bharatiya Nagarik Suraksha Sanhita, 2023 (Section 152 / Section 133 CrPC)",
        "category": "Nuisance",
        "type": "Civil Injunction & Magistrate Conditional Order"
    },

    # Contract Law (42-45)
    42: {
        "name": "Breach of Commercial Agreement & Claim for Consequential Damages",
        "statute": "Indian Contract Act, 1872 (Section 73 - Compensation for Loss or Damage & Section 74)",
        "category": "Breach of Contract",
        "type": "Civil Suit for Damages and Breach"
    },
    43: {
        "name": "Statutory Payment Default to MSME Enterprise",
        "statute": "Micro, Small and Medium Enterprises Development Act, 2006 (MSMED Act, Sections 15-18)",
        "category": "MSME Payment Default",
        "type": "Statutory MSME Samadhaan Facilitation Council Claim"
    },
    44: {
        "name": "Breach of Non-Disclosure Agreement (NDA) & Trade Secret Misappropriation",
        "statute": "Indian Contract Act, 1872 (Section 73) & Specific Relief Act, 1963 (Injunction Against Disclosure)",
        "category": "Confidentiality Breach",
        "type": "Civil Breach & Injunction"
    },
    45: {
        "name": "Breach of Oral / Informal Contract",
        "statute": "Indian Contract Act, 1872 (Section 10 - Valid Agreements & Section 73)",
        "category": "Oral Contract Default",
        "type": "Civil Suit on Proof of Consensus Ad Idem"
    },

    # Banking & Finance (46-48)
    46: {
        "name": "Dishonour of Cheque for Insufficiency of Funds (Cheque Bounce)",
        "statute": "Negotiable Instruments Act, 1881 (Section 138 to 142)",
        "category": "Cheque Bounce",
        "type": "Quasi-Criminal Statutory Complaint Before Magistrate"
    },
    47: {
        "name": "Unlawful Intimidation & Harassment by Loan Recovery Agents",
        "statute": "RBI Master Directions on Lending & Guidelines on Recovery Agents, 2022 & Bharatiya Nyaya Sanhita, 2023 (Section 351)",
        "category": "Loan Recovery Harassment",
        "type": "RBI Regulatory Violation & Criminal Intimidation"
    },
    48: {
        "name": "Inaccurate Credit Reporting & Default under Credit Information Act",
        "statute": "Credit Information Companies (Regulation) Act, 2005 (CICRA, Section 21) & RBI Ombudsman Scheme",
        "category": "Credit Bureau Error",
        "type": "Regulatory Dispute & Rectification"
    },

    # Insurance (49-51)
    49: {
        "name": "Arbitrary Repudiation of Mediclaim / Cashless Health Insurance",
        "statute": "Insurance Regulatory and Development Authority of India (IRDAI) Health Regulations & Consumer Protection Act, 2019",
        "category": "Insurance Claim Denial",
        "type": "Insurance Ombudsman Complaint & Consumer Dispute"
    },
    50: {
        "name": "Unlawful Repudiation of Life Insurance Death Claim",
        "statute": "Insurance Act, 1938 (Section 45 - Non-Challengeability After 3 Years) & IRDAI Guidelines",
        "category": "Life Insurance Dispute",
        "type": "Insurance Ombudsman & Consumer Forum Claim"
    },
    51: {
        "name": "Arbitrary Deduction or Rejection of Motor Accident Damage Claim",
        "statute": "Motor Vehicles Act, 1988 & IRDAI (Protection of Policyholders' Interests) Regulations, 2017",
        "category": "Motor Insurance Dispute",
        "type": "Consumer Complaint & Insurance Ombudsman"
    },

    # Traffic and Motor Accidents (52-54)
    52: {
        "name": "Rash and Negligent Driving Causing Motor Accident, Injury, or Death",
        "statute": "Motor Vehicles Act, 1988 (Section 166 - MACT Claim) & Bharatiya Nyaya Sanhita, 2023 (Section 281 & Section 125(b) / IPC Section 279 & 338)",
        "category": "Motor Accident Compensation",
        "type": "MACT Statutory Claim & Criminal Police FIR"
    },
    53: {
        "name": "Wrongful Issuance of Disputed Traffic Electronic Challan",
        "statute": "Motor Vehicles Act, 1988 & Central Motor Vehicles Rules (Rule 167A - Electronic Monitoring)",
        "category": "Traffic Challan Dispute",
        "type": "Traffic Virtual Court Challenge"
    },
    54: {
        "name": "Hit and Run Motor Vehicle Accident Solatium Claim",
        "statute": "Motor Vehicles Act, 1988 (Section 161) & Compensation to Victims of Hit and Run Motor Accidents Scheme, 2022",
        "category": "Hit and Run Victim Relief",
        "type": "Statutory Solatium Compensation Claim"
    },

    # Intellectual Property (55-57)
    55: {
        "name": "Unauthorized Copying & Piracy of Copyrighted Work",
        "statute": "Copyright Act, 1957 (Sections 51, 63 & 64)",
        "category": "Copyright Infringement",
        "type": "Civil Injunction/Damages & Cognizable Criminal Offence"
    },
    56: {
        "name": "Counterfeiting, Trademark Infringement & Passing Off",
        "statute": "Trade Marks Act, 1999 (Sections 29 & 103)",
        "category": "Trademark Infringement",
        "type": "Commercial Court Injunction & Criminal Seizure"
    },
    57: {
        "name": "Bad-Faith Registration of Domain Name (Cybersquatting)",
        "statute": ".IN Dispute Resolution Policy (INDRP) & Trade Marks Act, 1999",
        "category": "Domain Squatting",
        "type": "Arbitration & Commercial Injunction"
    },

    # Digital Privacy (58-59)
    58: {
        "name": "Unauthorized Processing & Breach of Digital Personal Data",
        "statute": "Digital Personal Data Protection Act, 2023 (DPDP Act, Sections 4-8)",
        "category": "Personal Data Violation",
        "type": "Data Protection Board Complaint & Statutory Penalty"
    },
    59: {
        "name": "Infringement of Personal Dignity & Right to be Forgotten",
        "statute": "Constitution of India (Article 21 - K.S. Puttaswamy Judgment) & Information Technology (Intermediary Guidelines) Rules, 2021",
        "category": "Digital Privacy Right",
        "type": "High Court Writ Petition / Intermediary Grievance"
    },

    # Education (60-62)
    60: {
        "name": "Unlawful Forfeiture & Refusal to Refund Educational Fees",
        "statute": "UGC Guidelines on Fee Refund (2023/2024), AICTE Norms & Consumer Protection Act, 2019",
        "category": "Fee Refund Refusal",
        "type": "Regulatory UGC Grievance & Consumer Redressal"
    },
    61: {
        "name": "Unlawful Withholding of Academic Degree or Transfer Certificate",
        "statute": "UGC Mandate (Redressal of Grievances of Students Regulations, 2023) & Article 226 Writ Jurisdiction",
        "category": "Academic Records Withholding",
        "type": "Writ Petition & UGC Redressal"
    },
    62: {
        "name": "Institutional Ragging, Criminal Intimidation & Bullying",
        "statute": "UGC Regulations on Curbing the Menace of Ragging in Higher Educational Institutions, 2009 & BNS 2023 (Sections 115, 351)",
        "category": "Anti-Ragging Violation",
        "type": "Mandatory Police FIR & Institutional Disciplinary Action"
    }
}


def get_violation_for_case(case_id: int, fallback_title: str = "") -> Dict[str, str]:
    """Return verified statutory violation metadata for a given case ID."""
    if case_id in STATUTORY_VIOLATIONS:
        return STATUTORY_VIOLATIONS[case_id]
    return {
        "name": f"Actionable Statutory Breach - {fallback_title or 'General Legal Dispute'}",
        "statute": "Indian Statutory Law & Code of Civil / Criminal Procedure",
        "category": "Statutory Dispute",
        "type": "Civil or Statutory Remedial Claim"
    }


# ================================================================
# FACT MEMORY EXTRACTOR & CONTAINER
# ================================================================

class LegalMemory:
    """Session-wide memory tracking named parties, pronouns, and specific details."""

    def __init__(self, session_id: str, consultation_id: Optional[str] = None):
        self.session_id: str = session_id
        self.consultation_id: Optional[str] = consultation_id
        self.parties: Dict[str, Dict[str, Any]] = {}  # key: name.lower()
        self.primary_party: Optional[Dict[str, Any]] = None
        self.pronouns_used: List[str] = []
        self.amounts: List[str] = []
        self.timeframes: List[str] = []
        self.locations: List[str] = []
        self.items: List[str] = []
        self.documents_mentioned: List[str] = []
        self.actions_taken: List[str] = []
        self.all_statements: List[str] = []
        self.domain: Optional[str] = None
        self.topic: Optional[str] = None
        self.case_id: Optional[int] = None
        self.status: str = "new"
        self.turns_count: int = 0

    def to_dict(self) -> Dict[str, Any]:
        return {
            "session_id": self.session_id,
            "consultation_id": self.consultation_id,
            "parties": list(self.parties.values()),
            "primary_party": self.primary_party,
            "pronouns_used": list(set(self.pronouns_used)),
            "amounts": list(dict.fromkeys(self.amounts)),
            "timeframes": list(dict.fromkeys(self.timeframes)),
            "locations": list(dict.fromkeys(self.locations)),
            "items": list(dict.fromkeys(self.items)),
            "documents_mentioned": list(dict.fromkeys(self.documents_mentioned)),
            "actions_taken": list(dict.fromkeys(self.actions_taken)),
            "domain": self.domain,
            "topic": self.topic,
            "turns_count": self.turns_count
        }


# Global in-memory cache keyed by session_id
SESSION_MEMORIES: Dict[str, LegalMemory] = {}


def get_or_create_memory(session_id: str, consultation_id: Optional[str] = None) -> LegalMemory:
    """Retrieve existing memory for session or initialize new one."""
    if not session_id:
        session_id = "DEFAULT_SESSION"
    if session_id not in SESSION_MEMORIES:
        SESSION_MEMORIES[session_id] = LegalMemory(session_id, consultation_id)
    elif consultation_id and not SESSION_MEMORIES[session_id].consultation_id:
        SESSION_MEMORIES[session_id].consultation_id = consultation_id
    return SESSION_MEMORIES[session_id]


# Regex patterns for Entity & Detail extraction
ROLE_TERMS = [
    "landlord", "landlady", "tenant", "employer", "boss", "company", "firm",
    "manager", "supervisor", "colleague", "coworker", "employee", "contractor",
    "builder", "developer", "seller", "shopkeeper", "vendor", "buyer", "client",
    "customer", "friend", "neighbor", "neighbour", "spouse", "husband", "wife",
    "partner", "in-laws", "inlaws", "father-in-law", "mother-in-law", "brother",
    "sister", "doctor", "hospital", "broker", "agent", "driver", "attacker",
    "scammer", "bank", "police", "officer"
]

SALUTATIONS = ["mr", "mr.", "mrs", "mrs.", "ms", "ms.", "dr", "dr.", "adv", "adv."]

COMMON_NAMES = {
    "ramesh", "suresh", "mahesh", "rahul", "rohit", "amit", "vikram", "anil",
    "sunil", "ajay", "vijay", "priya", "pooja", "sunita", "anita", "sneha",
    "neha", "rajesh", "sharma", "verma", "gupta", "mehta", "singh", "kumar",
    "patel", "shah", "agarwal", "reddy", "nair", "rao", "joshi", "kulkarni",
    "john", "david", "alex", "mohammed", "ali", "khan", "flipkart", "amazon",
    "swiggy", "zomato", "uber", "ola", "paytm", "phonepe", "meesho"
}


def extract_and_merge_facts(text: str, memory: LegalMemory) -> LegalMemory:
    """
    Extract person names, pronouns, amounts, timeframes, and key facts
    from text and merge them into persistent LegalMemory.
    """
    if not text:
        return memory

    memory.turns_count += 1
    memory.all_statements.append(text.strip())
    raw_lower = text.lower()

    # 1. Pronoun Detection
    pronoun_map = {
        "he": "male", "him": "male", "his": "male", "himself": "male",
        "she": "female", "her": "female", "hers": "female", "herself": "female",
        "they": "plural/neutral", "them": "plural/neutral", "their": "plural/neutral", "theirs": "plural/neutral"
    }
    for pron, gender in pronoun_map.items():
        if re.search(r"\b" + re.escape(pron) + r"\b", raw_lower):
            if pron not in memory.pronouns_used:
                memory.pronouns_used.append(pron)

    # 2. Extract Person Names & Roles
    # Pattern A: "landlord Ramesh", "my boss Mr. Sharma", "friend Rahul"
    role_pattern = r"\b(?:my\s+)?(" + "|".join(ROLE_TERMS) + r")[ \t]+(?:named[ \t]+|called[ \t]+)?((?:(?:Mr\.|Mrs\.|Ms\.|Dr\.|Adv\.)[ \t]+)?[A-Z][a-z]+(?:[ \t]+[A-Z][a-z]+)?)\b"
    for match in re.finditer(role_pattern, text):
        role = match.group(1).lower()
        name = match.group(2).strip()
        _register_party(memory, name, role)

    # Pattern B: "Mr. Sharma", "Dr. Mehta"
    salut_pattern = r"\b(Mr\.|Mrs\.|Ms\.|Dr\.|Adv\.)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b"
    for match in re.finditer(salut_pattern, text):
        title = match.group(1).strip()
        name = f"{title} {match.group(2).strip()}"
        _register_party(memory, name, "involved party")

    # Pattern C: "his/her name is Ramesh", "name is Priya", "name is Mr. Sharma"
    name_is_pattern = r"\b(?:his|her|their|landlord['’]?s?|boss['’]?s?)?\s*name\s+(?:is|was)\s+((?:(?:Mr\.|Mrs\.|Ms\.|Dr\.|Adv\.)[ \t]+)?[A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b"
    for match in re.finditer(name_is_pattern, text, re.IGNORECASE):
        name = match.group(1).strip()
        # deduce role if nearby words indicate or inherit existing specific role
        role = "opposing party"
        for r in ROLE_TERMS:
            if r in raw_lower:
                role = r
                break
        if role == "opposing party" and memory.primary_party and memory.primary_party.get("role") in ROLE_TERMS:
            role = memory.primary_party["role"]
        _register_party(memory, name, role)

    # Pattern D: Recognized capitalized name at start of sentence performing an action
    # e.g., "Ramesh refused to pay", "Sharma has withheld"
    action_verbs = r"(?:has|have|is|was|refused|refuses|withheld|withholds|fired|threatened|cheated|scammed|owes|demanded|took|hit|attacked|cut|locked)"
    cap_name_pattern = r"\b([A-Z][a-z]+)\s+" + action_verbs + r"\b"
    for match in re.finditer(cap_name_pattern, text):
        name = match.group(1).strip()
        if name.lower() not in {"he", "she", "they", "it", "my", "our", "the", "this", "that", "lex"}:
            role = "opposing party"
            for r in ROLE_TERMS:
                if r in raw_lower:
                    role = r
                    break
            if role == "opposing party" and memory.primary_party and memory.primary_party.get("role") in ROLE_TERMS:
                role = memory.primary_party["role"]
            _register_party(memory, name, role)

    # Pattern E: Known names mentioned even if lowercase
    for name_candidate in COMMON_NAMES:
        if re.search(r"\b" + re.escape(name_candidate) + r"\b", raw_lower):
            proper_name = name_candidate.capitalize()
            # Avoid adding if already part of an existing registered party (e.g. 'mr. gupta')
            already_covered = any(name_candidate in existing_key for existing_key in memory.parties.keys())
            if not already_covered:
                role = "involved party"
                for r in ROLE_TERMS:
                    if r in raw_lower:
                        role = r
                        break
                if role == "involved party" and memory.primary_party and memory.primary_party.get("role") in ROLE_TERMS:
                    role = memory.primary_party["role"]
                _register_party(memory, proper_name, role)

    # If no name registered yet but a role was explicitly stated (e.g. "my landlord")
    for r in ROLE_TERMS:
        if re.search(r"\b(?:my\s+)?" + re.escape(r) + r"\b", raw_lower):
            if not memory.primary_party:
                title_role = r.capitalize()
                _register_party(memory, f"the {title_role}", r)

    # 3. Associate Pronouns with Primary Party
    if memory.primary_party:
        party_pronouns = []
        role_str = (memory.primary_party.get("role") or "").lower()
        if any(p in memory.pronouns_used for p in ["he", "him", "his"]) or role_str in ["husband", "father-in-law"]:
            party_pronouns = ["he", "him", "his"]
            memory.primary_party["gender"] = "male"
        elif any(p in memory.pronouns_used for p in ["she", "her", "hers"]) or role_str in ["wife", "mother-in-law", "landlady"]:
            party_pronouns = ["she", "her", "hers"]
            memory.primary_party["gender"] = "female"
        elif any(p in memory.pronouns_used for p in ["they", "them", "their"]):
            party_pronouns = ["they", "them", "their"]
            memory.primary_party["gender"] = "plural/organization"
        memory.primary_party["pronouns"] = party_pronouns

    # 4. Extract Financial Amounts
    # e.g., "Rs 50,000", "50000 rs", "₹1.5 lakh", "50k", "two months salary"
    amount_patterns = [
        r"(?:₹|rs\.?|inr)\s*(\d+(?:,\d+)*(?:\.\d+)?\s*(?:lakhs?|crores?|k)?)",
        r"\b(\d+(?:,\d+)*(?:\.\d+)?)\s*(?:₹|rs\.?|inr|rupees|lakhs?|crores?)\b",
        r"\b((?:\d+|one|two|three|four|five|six|seven|eight|nine|ten)\s+months?['’]?\s+salary)\b"
    ]
    for pat in amount_patterns:
        for match in re.finditer(pat, text, re.IGNORECASE):
            amt_val = match.group(0).strip()
            # clean formatting
            amt_clean = re.sub(r"\s+", " ", amt_val)
            if not amt_clean.startswith("₹") and not re.search(r"rs|inr|rupee|salary", amt_clean, re.I):
                amt_clean = f"₹{amt_clean}"
            elif amt_clean.lower().startswith("rs"):
                num_only = re.sub(r"^rs\.?\s*", "", amt_clean, flags=re.I)
                amt_clean = f"₹{num_only}"
            if amt_clean not in memory.amounts:
                memory.amounts.append(amt_clean)

    # 5. Extract Timeframes & Durations
    # e.g., "2 months", "since January", "15 days ago", "yesterday", "last week"
    time_patterns = [
        r"\b(?:\d+|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)\s+(?:days?|weeks?|months?|years?)\s*(?:ago)?\b",
        r"\b(?:yesterday|today|tomorrow|last\s+week|last\s+month|last\s+year)\b",
        r"\bsince\s+([A-Z][a-z]+|\d{4})\b"
    ]
    for pat in time_patterns:
        for match in re.finditer(pat, text, re.IGNORECASE):
            t_val = match.group(0).strip()
            if t_val not in memory.timeframes:
                memory.timeframes.append(t_val)

    # 6. Extract Mentioned Documents
    doc_keywords = [
        "rental agreement", "lease agreement", "rent agreement", "tenancy agreement",
        "employment contract", "offer letter", "appointment letter", "salary slip",
        "salary slips", "payslip", "payslips", "bank statement", "passbook",
        "invoice", "bill", "tax invoice", "receipt", "warranty card",
        "whatsapp chat", "whatsapp messages", "email", "emails", "notice",
        "legal notice", "fir", "police complaint", "mlc", "medical certificate",
        "cheque", "bounced cheque", "bank memo", "cctv footage", "sale deed"
    ]
    for doc in doc_keywords:
        if doc in raw_lower:
            if doc not in memory.documents_mentioned:
                memory.documents_mentioned.append(doc)

    # 7. Extract Actions Already Taken
    action_keywords = [
        "sent notice", "served notice", "sent legal notice", "called them",
        "asked them", "emailed", "emailed hr", "complained to police",
        "filed fir", "went to police station", "blocked my number",
        "stopped responding", "refused verbally", "handed over keys",
        "vacated the flat", "moved out", "reported to bank", "disputed transaction"
    ]
    for act in action_keywords:
        if act in raw_lower:
            if act not in memory.actions_taken:
                memory.actions_taken.append(act)

    # 8. Extract Locations / Properties
    loc_pattern = r"\b(?:in|at)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b"
    known_cities = ["mumbai", "pune", "delhi", "bengaluru", "bangalore", "hyderabad", "chennai", "kolkata", "ahmedabad", "noida", "gurgaon", "gurugram"]
    for city in known_cities:
        if city in raw_lower and city.capitalize() not in memory.locations:
            memory.locations.append(city.capitalize())

    return memory


INVALID_NAMES = {
    "additional", "original", "legal", "situation", "user", "client",
    "matter", "lex", "facts", "provided", "statement", "the", "an", "a",
    "this", "that", "there", "here", "today", "yesterday", "tomorrow",
    "month", "months", "year", "years", "day", "days", "week", "weeks",
    "mr", "mrs", "ms", "dr", "adv"
}

def _register_party(memory: LegalMemory, name: str, role: str):
    """Helper to register party into memory and set primary party."""
    if not name:
        return
    # Strip any trailing conjunctions or verbs
    name = re.sub(r"\s+(?:and|or|who|which|that|he|she|they|with|refused|withheld|is|has|was)\b.*$", "", name, flags=re.I).strip()
    key = name.strip().lower()
    if not key or key in {"i", "me", "my", "myself", "we", "us"} or key in INVALID_NAMES:
        return

    # Normalize name formatting
    clean_name = " ".join([word.capitalize() if word.lower() not in SALUTATIONS else word for word in name.split()])
    if clean_name.lower() in INVALID_NAMES:
        return

    if key not in memory.parties:
        # If replacing a generic placeholder (e.g. 'the landlord', 'the employer')
        if memory.primary_party and memory.primary_party.get("name", "").lower().startswith("the "):
            old_placeholder_role = memory.primary_party.get("role")
            if (not role or role in ["involved party", "opposing party"]) and old_placeholder_role:
                role = old_placeholder_role
            old_key = memory.primary_party["name"].lower()
            memory.parties.pop(old_key, None)

        party_data = {
            "name": clean_name,
            "role": role,
            "gender": "unknown",
            "pronouns": []
        }
        memory.parties[key] = party_data
        if (
            not memory.primary_party
            or memory.primary_party.get("role") in ["involved party", "opposing party"]
            or memory.primary_party.get("name", "").lower().startswith("the ")
        ):
            memory.primary_party = party_data
    else:
        if role and role != "involved party":
            memory.parties[key]["role"] = role
            if memory.primary_party and memory.primary_party["name"].lower() == key:
                memory.primary_party["role"] = role


# ================================================================
# SITUATION DEFINITION EVALUATOR (MULTI-TURN CLARIFICATION)
# ================================================================

def evaluate_situation_definition(
    text: str,
    memory: LegalMemory,
    domain: Optional[str] = None
) -> Tuple[bool, List[str], str]:
    """
    Evaluates whether the given situation sufficiently defines the legal problem.

    Returns:
        (is_defined: bool, clarifying_questions: List[str], assessment_lead: str)

    If the problem is not defined, it asks targeted follow-up questions
    until the whole situation is understood by Lex.
    """
    combined_text = " ".join(memory.all_statements).lower()
    norm_text = text.lower()

    # Build greeting / party lead string
    party_lead = ""
    if memory.primary_party:
        name = memory.primary_party.get("name", "")
        role = memory.primary_party.get("role", "")
        pronouns = memory.primary_party.get("pronouns", [])
        pron_str = f" ({pronouns[0]})" if pronouns else ""
        if name.startswith("the ") or not name:
            party_lead = f"your {role}"
        else:
            party_lead = f"{name}{pron_str} (your {role})" if role and role != "involved party" else f"{name}{pron_str}"

    missing_questions: List[str] = []

    # 1. Extremely brief or vague statements
    tokens = [w for w in re.findall(r"\w+", norm_text) if len(w) > 2]
    if len(tokens) <= 3 and not memory.amounts and not memory.timeframes:
        return False, [
            "What specific event or dispute occurred?",
            "Who is the other party involved (e.g. employer, landlord, seller)?",
            "What financial amount, duration, or property is involved?"
        ], "Your description is very brief. Please provide details so Lex can assess the specific legal violation."

    # 2. Domain-Specific Definition Checks
    active_domain = domain or memory.domain

    # Domain: Tenancy
    if active_domain == "Rental and Tenancy" or "landlord" in combined_text or "rent" in combined_text or "tenant" in combined_text:
        # Determine specific conflict: deposit, eviction, repairs, rent hike
        has_deposit_issue = any(w in combined_text for w in ["deposit", "security", "refund", "return money"])
        has_eviction_issue = any(w in combined_text for w in ["evict", "eviction", "throw out", "lock", "locked", "vacate"])
        has_repair_issue = any(w in combined_text for w in ["repair", "leak", "fix", "damage", "maintenance"])
        has_rent_hike = any(w in combined_text for w in ["hike", "increase rent", "steep rent"])

        if not (has_deposit_issue or has_eviction_issue or has_repair_issue or has_rent_hike):
            q_lead = f"Regarding your dispute with {party_lead or 'the landlord'}:"
            return False, [
                f"{q_lead} What is the exact issue (e.g., withholding security deposit, threat of eviction, or excessive rent increase)?",
                "What is the name of your landlord and location of the property?",
                "Do you have a registered or written tenancy agreement?"
            ], f"Lex recognizes a tenancy matter with {party_lead or 'your landlord'}, but needs the specific conflict to identify the violation."

        if has_deposit_issue:
            # Need to know if vacated and amount
            if not memory.amounts:
                missing_questions.append(f"What was the total security deposit amount paid to {party_lead or 'the landlord'}?")
            has_vacated = any(w in combined_text for w in ["vacate", "vacated", "moved out", "left", "handed over", "returned keys"])
            if not has_vacated and memory.turns_count <= 2:
                missing_questions.append("Have you already vacated the property and handed over the keys, or are you still residing there?")

    # Domain: Employment
    elif active_domain == "Employment Law" or any(w in combined_text for w in ["employer", "boss", "salary", "job", "wages", "fired"]):
        has_salary = any(w in combined_text for w in ["salary", "wage", "wages", "pay", "dues", "arrears", "stipend"])
        has_termination = any(w in combined_text for w in ["fired", "terminate", "termination", "dismissed", "resigned", "notice"])
        has_posh = any(w in combined_text for w in ["harassment", "posh", "sexual harassment", "inappropriate"])
        has_pf = any(w in combined_text for w in ["pf", "provident", "gratuity"])

        if not (has_salary or has_termination or has_posh or has_pf):
            q_lead = f"Regarding {party_lead or 'your employer'}:"
            return False, [
                f"{q_lead} What is the specific problem (e.g. unpaid salary, illegal termination, or withholding PF/gratuity)?",
                "For what duration or amount has the issue persisted?",
                "What explanation or response did the employer give?"
            ], f"Lex understands there is an employment dispute involving {party_lead or 'your employer'}, but needs to know the exact breach."

        if has_salary:
            if not memory.timeframes and not memory.amounts:
                missing_questions.append("For how many months (or what specific amount) has your salary been withheld?")
            has_asked = any(w in combined_text for w in ["asked", "told", "demanded", "emailed", "reason", "refused", "promised", "said"])
            if not has_asked and memory.turns_count <= 2:
                missing_questions.append(f"Have you formally asked {party_lead or 'the employer'} for payment, and what reason was given?")

    # Domain: Consumer / Product / Refund
    elif active_domain == "Consumer Law" or any(w in combined_text for w in ["product", "bought", "purchase", "seller", "refund", "warranty"]):
        has_item = len(memory.items) > 0 or any(w in combined_text for w in ["laptop", "phone", "mobile", "tv", "item", "order", "clothes", "car"])
        if not has_item and memory.turns_count <= 2:
            missing_questions.append("What specific product or service did you purchase, and from which seller/platform?")
        has_action = any(w in combined_text for w in ["defective", "broken", "damaged", "refuse", "not delivered", "fake", "cancelled"])
        if not has_action:
            missing_questions.append("What exact problem occurred with the purchase (e.g. arrived damaged, seller refused return/refund, or warranty denied)?")

    # Domain: Cyber Fraud
    elif active_domain == "Cyber Law" or any(w in combined_text for w in ["scam", "fraud", "upi", "hacked", "phishing", "blackmail"]):
        if not memory.amounts and not any(w in combined_text for w in ["hacked", "account", "doxxed", "photos", "blackmail"]):
            missing_questions.append("How much money was fraudulently deducted or transferred?")
        has_time = len(memory.timeframes) > 0 or any(w in combined_text for w in ["today", "yesterday", "hours", "days", "recently"])
        if not has_time and memory.turns_count <= 2:
            missing_questions.append("When did the fraudulent transaction occur (golden hour report within 24-48 hours)?")

    # Domain: Assault / Criminal
    elif active_domain == "Criminal Law" or any(w in combined_text for w in ["assault", "beat", "hit", "attack", "threat", "fir", "police"]):
        has_injury = any(w in combined_text for w in ["injured", "injury", "blood", "hospital", "doctor", "mlc", "fracture", "bruise"])
        has_fir = any(w in combined_text for w in ["fir", "police", "complaint", "ncr", "station"])
        if not has_injury and not has_fir and memory.turns_count <= 2:
            missing_questions.append("Did you sustain physical injury, and have you undergone a Medical Legal Certificate (MLC) at a hospital?")
            missing_questions.append("Has a formal complaint or FIR been reported to the nearest police station?")

    # Domain: Cheque Bounce
    elif "cheque" in combined_text or "check" in combined_text:
        has_memo = any(w in combined_text for w in ["bounce", "bounced", "dishonoured", "memo", "insufficient", "signature"])
        if not has_memo:
            missing_questions.append("Was the cheque dishonoured by the bank, and what return reason is stated on the bank return memo?")
        if not memory.amounts:
            missing_questions.append("What was the monetary value of the dishonoured cheque?")

    # Generic check if still incomplete
    if missing_questions:
        assessment_msg = "Lex has registered the following facts: "
        fact_snippets = []
        if party_lead:
            fact_snippets.append(f"Involved party: {party_lead}")
        if memory.amounts:
            fact_snippets.append(f"Amount: {', '.join(memory.amounts)}")
        if memory.timeframes:
            fact_snippets.append(f"Duration: {', '.join(memory.timeframes)}")
        if fact_snippets:
            assessment_msg += " | ".join(fact_snippets) + ". However, critical details are still needed to complete your legal assessment."
        else:
            assessment_msg = "To provide an accurate roadmap and identify the precise legal violation, Lex needs a few more details."

        return False, missing_questions, assessment_msg

    # Situation is adequately defined!
    return True, [], "The legal situation is sufficiently defined."


# ================================================================
# RESPONSE PERSONALIZATION ENGINE
# ================================================================

def personalize_legal_response(
    raw_response: Dict[str, Any],
    memory: LegalMemory
) -> Dict[str, Any]:
    """
    Personalize legal advice with remembered entity names, pronouns,
    amounts, timeframes, and explicit statutory violation names.
    """
    case = raw_response.get("case") or {}
    case_id = int(case.get("case_id") or 0)
    case_title = case.get("case_title") or raw_response.get("title") or "Legal Situation"

    # 1. Attach Specific Statutory Violation
    violation_meta = get_violation_for_case(case_id, case_title)
    raw_response["violation_name"] = violation_meta["name"]
    raw_response["violation_statute"] = violation_meta["statute"]
    raw_response["violation_type"] = violation_meta["type"]
    raw_response["violation_category"] = violation_meta["category"]

    # 2. Extract Remembered Party particulars
    primary = memory.primary_party or {}
    party_name = primary.get("name")
    generic_party_names = {"someone", "somebody", "a person", "person", "the person", "the employee", "the employer", "the seller", "the landlord", "the opposing party"}
    has_specific_party_name = bool(party_name) and str(party_name).strip().lower() not in generic_party_names and not str(party_name).strip().lower().startswith("the ")
    party_role = primary.get("role") or "other party"
    pronouns = primary.get("pronouns") or []
    pron_subj = pronouns[0] if pronouns else ("he/she" if primary.get("gender") == "unknown" else ("he" if primary.get("gender") == "male" else "she"))
    pron_obj = pronouns[1] if len(pronouns) > 1 else ("him/her" if primary.get("gender") == "unknown" else ("him" if primary.get("gender") == "male" else "her"))
    pron_poss = pronouns[2] if len(pronouns) > 2 else ("his/her" if primary.get("gender") == "unknown" else ("his" if primary.get("gender") == "male" else "her"))

    # Determine reference string for party
    if has_specific_party_name:
        party_ref = f"{party_name} ({party_role})"
        clean_name = party_name
    elif party_role:
        party_ref = f"your {party_role}"
        clean_name = f"the {party_role}"
    else:
        party_ref = "the opposing party"
        clean_name = "the opposing party"

    amount_str = memory.amounts[0] if memory.amounts else ""
    time_str = memory.timeframes[0] if memory.timeframes else ""

    # 3. Personalize Title & Situation Assessment
    if has_specific_party_name:
        raw_response["title"] = f"{case_title} — Involving {party_name}"
    else:
        raw_response["title"] = case_title

    # Build dynamic situation assessment referencing remembered facts
    assessment_parts = []
    assessment_parts.append(f"Based on the facts you provided, your legal situation with {party_ref}")
    if amount_str:
        assessment_parts.append(f"involving an amount of {amount_str}")
    if time_str:
        assessment_parts.append(f"over a period of {time_str}")
    assessment_parts.append("appears to relate to a potential legal issue under Indian law; this is a preliminary database match, not a finding that anyone has violated the law.")
    assessment_parts.append(f"The potentially relevant legal framework is **{violation_meta['name']}**, with reference to {violation_meta['statute']}. Its application depends on the complete facts and current law.")
    if primary and pronouns:
        assessment_parts.append(f"The other party is identified from your description as {clean_name}; responsibility has not been legally determined.")

    raw_response["situation_assessment"] = " ".join(assessment_parts)

    # 4. Personalize Action Steps
    original_actions = raw_response.get("actions") or []
    personalized_actions = []

    for idx, act in enumerate(original_actions):
        act_text = act if isinstance(act, str) else (act.get("action_text") or act.get("text") or "")
        if not act_text:
            continue

        # Replace generic terms with actual names, pronouns, amounts
        t = act_text
        t = re.sub(r"\bthe employer\b", clean_name, t, flags=re.I)
        t = re.sub(r"\bthe landlord\b", clean_name, t, flags=re.I)
        t = re.sub(r"\bthe seller\b", clean_name, t, flags=re.I)
        t = re.sub(r"\bthe other party\b", clean_name, t, flags=re.I)
        t = re.sub(r"\bopposite party\b", clean_name, t, flags=re.I)

        if amount_str:
            t = re.sub(r"\bthe unpaid salary\b", f"the unpaid salary of {amount_str}", t, flags=re.I)
            t = re.sub(r"\bthe deposit\b", f"the security deposit of {amount_str}", t, flags=re.I)
            t = re.sub(r"\bthe refund\b", f"the refund of {amount_str}", t, flags=re.I)
            t = re.sub(r"\bthe dues\b", f"the outstanding dues of {amount_str}", t, flags=re.I)

        if time_str:
            t = re.sub(r"\bthe period\b", f"the {time_str} duration", t, flags=re.I)

        # Personalize first step to emphasize legal notice
        if idx == 0 and not re.search(r"demand notice|formal notice", t, re.I):
            t = f"Serve a formal written demand notice upon {clean_name} requiring compliance regarding {violation_meta['name']}. {t}"

        personalized_actions.append(t)

    raw_response["actions"] = personalized_actions

    # 5. Personalize Required Documents
    original_docs = raw_response.get("documents") or []
    personalized_docs = []

    for doc in original_docs:
        doc_dict = doc if isinstance(doc, dict) else {"name": str(doc), "level": "Essential", "description": ""}
        d_name = doc_dict.get("name") or doc_dict.get("document_name") or ""
        d_level = doc_dict.get("level") or doc_dict.get("required_level") or "Essential"
        d_desc = doc_dict.get("description") or ""

        # Personalize doc descriptions with names/amounts
        if "agreement" in d_name.lower() or "contract" in d_name.lower():
            if has_specific_party_name:
                d_desc = f"Executed contract / agreement with {clean_name} establishing binding contractual terms."
        elif "receipt" in d_name.lower() or "bank" in d_name.lower() or "slip" in d_name.lower():
            if amount_str:
                d_desc = f"Payment record establishing transaction of {amount_str}."
        elif "communication" in d_name.lower() or "notice" in d_name.lower() or "messages" in d_name.lower():
            if clean_name:
                d_desc = f"WhatsApp chats, emails, and demand notices sent to {clean_name} ({pron_obj})."

        personalized_docs.append({
            "name": d_name,
            "level": d_level,
            "description": d_desc
        })

    # Add specific tailored document if not already in checklist
    existing_doc_names = [d["name"].lower() for d in personalized_docs]
    if "written communications / whatsapp chats" not in " ".join(existing_doc_names):
        personalized_docs.append({
            "name": f"Written Communications & WhatsApp / Email Records with {clean_name}",
            "level": "Essential",
            "description": f"Conclusive proof of demands, replies, or default by {clean_name} ({pron_obj})."
        })

    raw_response["documents"] = personalized_docs

    # 6. Include Remembered Details Payload
    raw_response["remembered_details"] = memory.to_dict()

    return raw_response
