-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4141
-- Generation Time: Oct 30, 2026 at 06:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lex_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` int(11) NOT NULL,
  `user_message` text NOT NULL,
  `lex_response` text NOT NULL,
  `topic` varchar(255) DEFAULT 'General',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `session_id` varchar(100) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `case_json` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `user_message`, `lex_response`, `topic`, `created_at`, `session_id`, `user_email`, `case_json`) VALUES
(1, 'My employer has not paid my salary for two months', 'Unpaid salary and withheld wages\n\nUnder the Payment of Wages Act 1936, Code on Wages 2019, and Industrial Disputes Act 1947, employers must disburse wages on time. Withholding salary constitutes an illegal act punishable with statutory interest and penalties.', 'Employment Law', '2026-08-24 13:11:14', NULL, NULL, NULL),
(2, 'my friend is refusing to return my money', 'Seller refuses refund or return\n\nUnder Consumer Protection (E-Commerce) Rules 2020 and Consumer Protection Act 2019 Section 2(47), refusal to refund for valid returns constitutes an Unfair Trade Practice punishable with mandatory refunds and compensation.', 'Consumer Law', '2026-08-24 13:11:52', NULL, NULL, NULL),
(3, 'my friend beat me', 'Tell me more about your situation\n\nI can help you understand legal procedures, applicable rights, recommended action steps, and essential documents under Indian law. Please describe what happened (e.g. unpaid salary, security deposit dispute, cyber fraud, defective product, contract violation, divorce or child custody, traffic accident, etc.) with relevant facts.', 'General Legal Information', '2026-08-24 13:13:02', NULL, NULL, NULL),
(4, 'my friend shot  a  bullet  at me', 'Tell me more about your situation\n\nI can help you understand legal procedures, applicable rights, recommended action steps, and essential documents under Indian law. Please describe what happened (e.g. unpaid salary, security deposit dispute, cyber fraud, defective product, contract violation, divorce or child custody, traffic accident, etc.) with relevant facts.', 'General Legal Information', '2026-08-24 13:14:02', NULL, NULL, NULL),
(5, 'gun', 'Tell me more about your situation\n\nI can help you understand legal procedures, applicable rights, recommended action steps, and essential documents under Indian law. Please describe what happened (e.g. unpaid salary, security deposit dispute, cyber fraud, defective product, contract violation, divorce or child custody, traffic accident, etc.) with relevant facts.', 'General Legal Information', '2026-08-24 13:14:13', NULL, NULL, NULL),
(6, 'My employer has not paid my salary for two months', 'Unpaid salary and withheld wages\n\nUnder the Payment of Wages Act 1936, Code on Wages 2019, and Industrial Disputes Act 1947, employers must disburse wages on time. Withholding salary constitutes an illegal act punishable with statutory interest and penalties.', 'Employment Law', '2026-08-24 13:40:19', NULL, NULL, NULL),
(7, 'my friend beat me with stick', 'Physical assault, battery, and violent beating\n\nUnder Sections 319-326 of the Indian Penal Code / Sections 115-118 of Bharatiya Nyaya Sanhita (BNS), causing voluntary hurt or grievous hurt is a cognizable criminal offence punishable with rigorous imprisonment and fine.', 'Criminal Law', '2026-08-24 13:40:44', NULL, NULL, NULL),
(8, 'i saw someone kidnapping my friend', 'Property ownership and title dispute\n\nGoverned by the Transfer of Property Act 1882, Registration Act 1908, and Specific Relief Act 1963. A registered title deed confers legal ownership which can be defended via a Suit for Declaration of Title.', 'Property Law', '2026-08-24 13:41:31', NULL, NULL, NULL),
(9, 'my friend refuse to give my money back', 'Recovery of money and Summary Suit\n\nGoverned by Code of Civil Procedure 1908 (Order XXXVII - Summary Suit) and Limitation Act 1963 (3-year limitation window). Allows fast-track decree without prolonged full trial if debt is supported by documents.', 'Civil Disputes', '2026-08-24 13:42:36', NULL, NULL, NULL),
(10, 'I need legal advice regarding Criminal Law', 'Criminal Law: Select Your Exact Situation\n\nCognizable complaints, refusal by police to file FIR, bail procedures, cheating and fraud (Sec 420), and criminal defense', 'Criminal Law', '2026-08-24 13:42:49', NULL, NULL, NULL),
(11, 'Bail application (Anticipatory and Regular)', 'Bail application (Anticipatory and Regular)\n\nGoverned by Section 437, 438 (Anticipatory Bail), and 439 (Regular Bail) of CrPC / BNSS. Courts evaluate personal liberty against investigation requirements, granting bail on conditions and sureties.', 'Criminal Law', '2026-08-24 13:43:08', NULL, NULL, NULL),
(12, 'I want to understand the mutual consent divorce procedure and child custody', 'Mutual consent divorce procedure\n\nGoverned by Section 13B of Hindu Marriage Act 1955 or Section 28 of Special Marriage Act 1954. It is the fastest divorce procedure, involving First and Second Motion petitions in Family Court.', 'Family Law', '2026-08-24 14:10:53', NULL, NULL, NULL),
(13, 'I need legal advice regarding Education', 'Education: Select Your Exact Situation\n\nCollege and coaching fee refund refusals, withholding of degree/transfers, ragging harassment, and fake university fraud', 'Education', '2026-08-24 14:11:15', NULL, NULL, NULL),
(14, 'Ragging and bullying in educational institution', 'Education: Select Your Exact Situation\n\nCollege and coaching fee refund refusals, withholding of degree/transfers, ragging harassment, and fake university fraud', 'Education', '2026-08-24 14:11:24', NULL, NULL, NULL),
(15, 'Ragging and bullying in educational institution', 'Education: Select Your Exact Situation\n\nCollege and coaching fee refund refusals, withholding of degree/transfers, ragging harassment, and fake university fraud', 'Education', '2026-08-24 14:11:43', NULL, NULL, NULL),
(16, 'Ragging and bullying in educational institution', 'Education: Select Your Exact Situation\n\nCollege and coaching fee refund refusals, withholding of degree/transfers, ragging harassment, and fake university fraud', 'Education', '2026-08-24 14:11:54', NULL, NULL, NULL),
(17, 'My employer has not paid my salary for two months', 'Unpaid salary and withheld wages\n\nUnder the Payment of Wages Act 1936, Code on Wages 2019, and Industrial Disputes Act 1947, employers must disburse wages on time. Withholding salary constitutes an illegal act punishable with statutory interest and penalties.', 'Employment Law', '2026-10-06 13:27:11', NULL, NULL, NULL),
(18, 'my landlord refuses to return my security deposit', 'Security deposit not returned by landlord\n\nYour landlord is refusing to refund your security deposit after you vacated the house. Under Indian Tenancy Laws, a landlord must return your deposit within the agreed time after adjusting genuine pending bills. You can send a formal legal demand notice to recover your full deposit.\n\nUnlawful retention of security deposit without genuine damage repair invoices is a breach of the tenancy agreement and State Rent Control Acts / Model Tenancy Act, recoverable with statutory interest.', 'Rental and Tenancy', '2026-10-06 14:04:12', 'LEX-SESS-TEST-1', 'test@lex.local', '{\"success\": true, \"found\": true, \"is_topic_selection\": false, \"case_ref\": \"LEX-CASE-19-9953\", \"topic\": \"Rental and Tenancy\", \"title\": \"Security deposit not returned by landlord\", \"situation_assessment\": \"Your landlord is refusing to refund your security deposit after you vacated the house. Under Indian Tenancy Laws, a landlord must return your deposit within the agreed time after adjusting genuine pending bills. You can send a formal legal demand notice to recover your full deposit.\", \"explanation\": \"Unlawful retention of security deposit without genuine damage repair invoices is a breach of the tenancy agreement and State Rent Control Acts / Model Tenancy Act, recoverable with statutory interest.\", \"preventions\": [\"Take high-resolution, dated photos and videos of the empty house/flat on the day you vacate.\", \"Hand over the keys only after getting a written receipt or email confirmation from the landlord.\", \"Do not accept unfair deductions for regular wear-and-tear; ask for actual repair bills.\", \"Remember that a landlord cannot cut electricity/water or lock you out without a formal court order.\"], \"options\": [\"Advocate Legal Notice demanding immediate refund with 18% interest.\", \"Complaint before Rent Authority / Rent Tribunal.\", \"Summary Suit under Order 37 CPC in Civil Court.\"], \"actions\": [\"Assemble the rent agreement, initial deposit payment receipt, and move-out photos/videos.\", \"Send a formal demand email requesting deposit return within 7 days, refuting unjustified deductions.\", \"Serve an Advocate Legal Notice demanding refund with 18% per annum interest.\", \"File a complaint before the Rent Authority / Rent Tribunal under State Tenancy Law.\", \"File a Summary Suit under Order 37 CPC in Civil Court for recovery of liquidated debt.\"], \"documents\": [{\"name\": \"Registered / Notarized Rent Agreement\", \"level\": \"Essential\", \"description\": \"Defines security deposit amount, terms of return, and notice period\"}, {\"name\": \"Security Deposit Bank Transfer Receipt / UTR\", \"level\": \"Essential\", \"description\": \"Irrefutable proof of initial deposit payment to landlord\"}, {\"name\": \"Move-out Inspection Photos / Video Handover Proof\", \"level\": \"Essential\", \"description\": \"Proves premises were returned in clean, undamaged condition\"}, {\"name\": \"Written Notice to Vacate & Key Handover Acknowledgment\", \"level\": \"Recommended\", \"description\": \"Confirms timely vacation in accordance with tenancy terms\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides automated legal information based on Indian statutory laws. This information is for guidance and does not replace formal advocate representation.\", \"session_id\": \"LEX-SESS-TEST-1\"}'),
(19, 'My employer has not paid my salary for two months', 'Unpaid salary and withheld wages\n\nYour employer has not paid or has unfairly withheld your earned salary. Under Indian Labour Laws and the Code on Wages 2019, an employer cannot hold back your salary without valid legal reasons. You have the right to claim your full salary along with interest and compensation by reporting to the Labour Commissioner.\n\nUnder the Payment of Wages Act 1936, Code on Wages 2019, and Industrial Disputes Act 1947, employers must disburse wages on time. Withholding salary constitutes an illegal act punishable with statutory interest and penalties.', 'Employment Law', '2026-10-06 14:06:54', 'LEX-SESS-VAL-1', 'test@lex.local', '{\"success\": true, \"found\": true, \"is_topic_selection\": false, \"case_ref\": \"LEX-CASE-8-1343\", \"topic\": \"Employment Law\", \"title\": \"Unpaid salary and withheld wages\", \"situation_assessment\": \"Your employer has not paid or has unfairly withheld your earned salary. Under Indian Labour Laws and the Code on Wages 2019, an employer cannot hold back your salary without valid legal reasons. You have the right to claim your full salary along with interest and compensation by reporting to the Labour Commissioner.\", \"explanation\": \"Under the Payment of Wages Act 1936, Code on Wages 2019, and Industrial Disputes Act 1947, employers must disburse wages on time. Withholding salary constitutes an illegal act punishable with statutory interest and penalties.\", \"preventions\": [\"Do not sign any forced resignation letter or vague exit clearance form under pressure.\", \"Save digital copies of your appointment letter, payslips, attendance logs, and work emails to your personal drive.\", \"Always send your salary demand letter via registered post or official email before approaching the Labour Commissioner.\", \"Under Indian law, employers cannot withhold earned wages or delay Provident Fund (PF) deposits.\"], \"options\": [\"Formal Advocate Demand Notice under Code on Wages 2019.\", \"Complaint before Deputy Labour Commissioner under Payment of Wages Act.\", \"Summary Recovery Suit under Order XXXVII CPC in Civil Court.\"], \"actions\": [\"Collect your offer letter, previous salary slips, timesheets, and bank statement showing unpaid months.\", \"Send a formal written demand email to HR and company directors giving 15 days to disburse all dues.\", \"Serve an Advocate Legal Notice under the Code on Wages 2019 and Payment of Wages Act.\", \"File a formal recovery complaint before the Deputy Labour Commissioner / Labour Conciliation Officer.\", \"File a Summary Recovery Suit under Order 37 CPC or claim in Labour Court.\"], \"documents\": [{\"name\": \"Employment Contract / Offer Letter\", \"level\": \"Essential\", \"description\": \"Establishes employer-employee relationship, salary structure, and pay terms\"}, {\"name\": \"Salary Slips (Previous 3-6 Months)\", \"level\": \"Essential\", \"description\": \"Shows regular salary breakdown, basic pay, allowances, and statutory deductions\"}, {\"name\": \"Bank Account Statement\", \"level\": \"Essential\", \"description\": \"Proves absence of salary credit for the disputed months\"}, {\"name\": \"Timesheet / Attendance / Swipe-in Records\", \"level\": \"Recommended\", \"description\": \"Proves active work performed during the unpaid salary duration\"}, {\"name\": \"Emails & Messages with HR / Management\", \"level\": \"Recommended\", \"description\": \"Evidence of written salary requests and employer replies or silence\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides automated legal information based on Indian statutory laws. This information is for guidance and does not replace formal advocate representation.\", \"session_id\": \"LEX-SESS-VAL-1\"}'),
(20, 'landlord is not returning my security deposit after vacating', 'Security deposit not returned by landlord\n\nYour landlord is refusing to refund your security deposit after you vacated the house. Under Indian Tenancy Laws, a landlord must return your deposit within the agreed time after adjusting genuine pending bills. You can send a formal legal demand notice to recover your full deposit.\n\nUnlawful retention of security deposit without genuine damage repair invoices is a breach of the tenancy agreement and State Rent Control Acts / Model Tenancy Act, recoverable with statutory interest.', 'Rental and Tenancy', '2026-10-06 14:06:54', 'LEX-SESS-VAL-1', 'test@lex.local', '{\"success\": true, \"found\": true, \"is_topic_selection\": false, \"case_ref\": \"LEX-CASE-19-1438\", \"topic\": \"Rental and Tenancy\", \"title\": \"Security deposit not returned by landlord\", \"situation_assessment\": \"Your landlord is refusing to refund your security deposit after you vacated the house. Under Indian Tenancy Laws, a landlord must return your deposit within the agreed time after adjusting genuine pending bills. You can send a formal legal demand notice to recover your full deposit.\", \"explanation\": \"Unlawful retention of security deposit without genuine damage repair invoices is a breach of the tenancy agreement and State Rent Control Acts / Model Tenancy Act, recoverable with statutory interest.\", \"preventions\": [\"Take high-resolution, dated photos and videos of the empty house/flat on the day you vacate.\", \"Hand over the keys only after getting a written receipt or email confirmation from the landlord.\", \"Do not accept unfair deductions for regular wear-and-tear; ask for actual repair bills.\", \"Remember that a landlord cannot cut electricity/water or lock you out without a formal court order.\"], \"options\": [\"Advocate Legal Notice demanding immediate refund with 18% interest.\", \"Complaint before Rent Authority / Rent Tribunal.\", \"Summary Suit under Order 37 CPC in Civil Court.\"], \"actions\": [\"Assemble the rent agreement, initial deposit payment receipt, and move-out photos/videos.\", \"Send a formal demand email requesting deposit return within 7 days, refuting unjustified deductions.\", \"Serve an Advocate Legal Notice demanding refund with 18% per annum interest.\", \"File a complaint before the Rent Authority / Rent Tribunal under State Tenancy Law.\", \"File a Summary Suit under Order 37 CPC in Civil Court for recovery of liquidated debt.\"], \"documents\": [{\"name\": \"Registered / Notarized Rent Agreement\", \"level\": \"Essential\", \"description\": \"Defines security deposit amount, terms of return, and notice period\"}, {\"name\": \"Security Deposit Bank Transfer Receipt / UTR\", \"level\": \"Essential\", \"description\": \"Irrefutable proof of initial deposit payment to landlord\"}, {\"name\": \"Move-out Inspection Photos / Video Handover Proof\", \"level\": \"Essential\", \"description\": \"Proves premises were returned in clean, undamaged condition\"}, {\"name\": \"Written Notice to Vacate & Key Handover Acknowledgment\", \"level\": \"Recommended\", \"description\": \"Confirms timely vacation in accordance with tenancy terms\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides automated legal information based on Indian statutory laws. This information is for guidance and does not replace formal advocate representation.\", \"session_id\": \"LEX-SESS-VAL-1\"}'),
(21, 'a friend beat me and attacked me', 'Physical assault and violent attack\n\nIt appears that your friend physically attacked, beat, or injured you. Under Indian Criminal Law (Sections 115-118 of Bharatiya Nyaya Sanhita / Sections 319-326 IPC), causing physical hurt to anyone on purpose is a crime. You have the full legal right to get medical treatment, an official hospital injury report (MLC), and file a police FIR against the person.\n\nUnder Indian Criminal Law (Sections 115-118 of Bharatiya Nyaya Sanhita / Sections 319-326 IPC), causing physical hurt to anyone is a punishable crime. Police are legally obligated to register an FIR and take action.', 'Criminal Law', '2026-10-06 14:06:54', 'LEX-SESS-VAL-1', 'test@lex.local', '{\"success\": true, \"found\": true, \"is_topic_selection\": false, \"case_ref\": \"LEX-CASE-63-5992\", \"topic\": \"Criminal Law\", \"title\": \"Physical assault and violent attack\", \"situation_assessment\": \"It appears that your friend physically attacked, beat, or injured you. Under Indian Criminal Law (Sections 115-118 of Bharatiya Nyaya Sanhita / Sections 319-326 IPC), causing physical hurt to anyone on purpose is a crime. You have the full legal right to get medical treatment, an official hospital injury report (MLC), and file a police FIR against the person.\", \"explanation\": \"Under Indian Criminal Law (Sections 115-118 of Bharatiya Nyaya Sanhita / Sections 319-326 IPC), causing physical hurt to anyone is a punishable crime. Police are legally obligated to register an FIR and take action.\", \"preventions\": [\"Prioritize your physical safety; seek immediate medical care and obtain a Medico-Legal Certificate (MLC).\", \"Do not meet or negotiate alone with the accused person or assailants.\", \"Preserve all audio call recordings, CCTV footage, and chat messages in their original format.\", \"If the local police refuse to register your FIR, send a written complaint to the Superintendent of Police (SP) under Section 173(4) BNSS / 154(3) CrPC.\"], \"options\": [\"File a Police FIR under Bharatiya Nyaya Sanhita (BNS) / IPC for assault.\", \"File a direct complaint before the local Magistrate if police do not act.\", \"Seek financial compensation in Civil Court for hospital expenses and trauma.\"], \"actions\": [\"Visit the nearest government hospital immediately for medical care and ask for a Medico-Legal Case (MLC) report.\", \"Take clear photos and video of all your injuries and damaged clothing.\", \"Go to the nearest police station or dial 112 to register an FIR for assault.\", \"Collect names of any witnesses and request nearby shops or buildings to save their CCTV footage.\", \"If the police officer refuses to register your FIR, send a written complaint to the Superintendent of Police (SP).\"], \"documents\": [{\"name\": \"Hospital Medical Certificate (MLC Report)\", \"level\": \"Essential\", \"description\": \"Doctor\'s official examination report showing your injuries\"}, {\"name\": \"Photos and Videos of Injuries\", \"level\": \"Essential\", \"description\": \"Visual proof of cuts, bruises, or physical damage\"}, {\"name\": \"Witness Contact Information\", \"level\": \"Recommended\", \"description\": \"Names and phone numbers of people who saw the incident\"}, {\"name\": \"Copy of Police FIR or Complaint\", \"level\": \"Essential\", \"description\": \"Official signed copy received from the police station\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides automated legal information based on Indian statutory laws. This information is for guidance and does not replace formal advocate representation.\", \"session_id\": \"LEX-SESS-VAL-1\"}'),
(22, 'someone stole my phone and money', 'Theft, robbery, and stolen property\n\nRegarding your matter about \'Theft, robbery, and stolen property\', Indian Law provides clear protections and remedies. Someone stole my money, phone, vehicle, jewelry, or belongings.\n\nUnder Indian Criminal Law (Sections 303 & 309 of Bharatiya Nyaya Sanhita / Sections 379 & 390 IPC), theft and robbery are crimes where the police must register an FIR and help trace the stolen items.', 'Criminal Law', '2026-10-06 14:06:54', 'LEX-SESS-VAL-1', 'test@lex.local', '{\"success\": true, \"found\": true, \"is_topic_selection\": false, \"case_ref\": \"LEX-CASE-66-3839\", \"topic\": \"Criminal Law\", \"title\": \"Theft, robbery, and stolen property\", \"situation_assessment\": \"Regarding your matter about \'Theft, robbery, and stolen property\', Indian Law provides clear protections and remedies. Someone stole my money, phone, vehicle, jewelry, or belongings.\", \"explanation\": \"Under Indian Criminal Law (Sections 303 & 309 of Bharatiya Nyaya Sanhita / Sections 379 & 390 IPC), theft and robbery are crimes where the police must register an FIR and help trace the stolen items.\", \"preventions\": [\"Prioritize your physical safety; seek immediate medical care and obtain a Medico-Legal Certificate (MLC).\", \"Do not meet or negotiate alone with the accused person or assailants.\", \"Preserve all audio call recordings, CCTV footage, and chat messages in their original format.\", \"If the local police refuse to register your FIR, send a written complaint to the Superintendent of Police (SP) under Section 173(4) BNSS / 154(3) CrPC.\"], \"options\": [\"Police FIR for theft investigation and recovery of belongings.\", \"Claim insurance compensation based on the police report.\"], \"actions\": [\"Immediately block all stolen SIM cards, bank cards, and payment apps to prevent money loss.\", \"Gather purchase receipts, IMEI numbers (for phones), or vehicle registration papers.\", \"File an FIR at the nearest police station or through your State Police online portal.\", \"Submit the signed FIR copy to your insurance company if the item was insured.\"], \"documents\": [{\"name\": \"Purchase Bill / Proof of Ownership\", \"level\": \"Essential\", \"description\": \"Bill showing product serial/IMEI number or vehicle registration (RC)\"}, {\"name\": \"Police FIR Copy\", \"level\": \"Essential\", \"description\": \"Required for police investigation and insurance claims\"}, {\"name\": \"CCTV Footage of the Theft\", \"level\": \"Recommended\", \"description\": \"Video evidence showing when and how the item was stolen\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides automated legal information based on Indian statutory laws. This information is for guidance and does not replace formal advocate representation.\", \"session_id\": \"LEX-SESS-VAL-1\"}'),
(23, 'how to bake chocolate cookies in microwave', 'Situation Not Found in Legal Database\n\nWe could not find a direct match for this specific situation in our Indian legal database. Please check your query or describe your legal issue with more details (such as the person or authority involved, what occurred, financial or property loss, or the specific dispute type).\n\nOur database covers Indian Laws across 15 domains including: Consumer Rights, Unpaid Salary & Employment, Tenancy & Rent Deposits, Cyber Scams & Online Fraud, Criminal Complaints & FIRs, Cheque Bounce, Family & Divorce Matters, Property Disputes, Insurance Claims, and Motor Vehicle Accidents.', 'General Inquiry', '2026-10-06 14:06:54', 'LEX-SESS-VAL-1', 'test@lex.local', '{\"success\": true, \"found\": false, \"is_topic_selection\": false, \"topic\": \"General Inquiry\", \"title\": \"Situation Not Found in Legal Database\", \"situation_assessment\": \"We could not find a direct match for this specific situation in our Indian legal database. Please check your query or describe your legal issue with more details (such as the person or authority involved, what occurred, financial or property loss, or the specific dispute type).\", \"explanation\": \"Our database covers Indian Laws across 15 domains including: Consumer Rights, Unpaid Salary & Employment, Tenancy & Rent Deposits, Cyber Scams & Online Fraud, Criminal Complaints & FIRs, Cheque Bounce, Family & Divorce Matters, Property Disputes, Insurance Claims, and Motor Vehicle Accidents.\", \"preventions\": [\"Be specific about who is involved (e.g. employer, landlord, bank, seller, or police).\", \"Mention the core incident (e.g. unpaid wages, withheld deposit, cyber scam, physical injury, or defective item).\", \"You can also browse our Legal Topics directory to select a common legal situation.\"], \"actions\": [\"Review your question and rephrase it with the primary legal issue.\", \"Click \'Legal Topics\' from the top bar to browse all standard categories.\", \"Gather any transaction slips, contracts, or notices you have for reference.\"], \"documents\": [{\"name\": \"Identity Proof (Aadhaar / Voter ID / PAN)\", \"level\": \"Essential\", \"description\": \"Required for establishing identity in formal legal complaints\"}, {\"name\": \"Written Incident Notes & Transaction Records\", \"level\": \"Recommended\", \"description\": \"Chronological notes of events, dates, messages, or payments\"}], \"options\": [\"Browse Legal Topics to find the closest match.\", \"Describe the dispute again in simple words.\"], \"disclaimer\": \"Lex provides automated legal information based on Indian statutory frameworks for informational guidance.\", \"session_id\": \"LEX-SESS-VAL-1\"}'),
(24, 'employer not paying me', 'Withholding of PF or Gratuity dues\n\nRegarding your matter about \'Withholding of PF or Gratuity dues\', Indian Law provides clear protections and remedies. My employer refused to release my Provident Fund (PF), update UAN exit date, or pay statutory Gratuity after resignation.\n\nUnder the Payment of Gratuity Act 1972 and EPF & MP Act 1952, gratuity is mandatory after 5 years of continuous service, and PF contributions must be remitted promptly. Delayed payment attracts 10% statutory interest.', 'Employment Law', '2026-10-06 14:18:38', 'LEX-SESS-1791296293-785', 'kunal@lex.local', '{\"success\": true, \"found\": true, \"is_topic_selection\": false, \"case_ref\": \"LEX-CASE-11-3411\", \"topic\": \"Employment Law\", \"title\": \"Withholding of PF or Gratuity dues\", \"situation_assessment\": \"Regarding your matter about \'Withholding of PF or Gratuity dues\', Indian Law provides clear protections and remedies. My employer refused to release my Provident Fund (PF), update UAN exit date, or pay statutory Gratuity after resignation.\", \"explanation\": \"Under the Payment of Gratuity Act 1972 and EPF & MP Act 1952, gratuity is mandatory after 5 years of continuous service, and PF contributions must be remitted promptly. Delayed payment attracts 10% statutory interest.\", \"preventions\": [\"Do not sign any forced resignation letter or vague exit clearance form under pressure.\", \"Save digital copies of your appointment letter, payslips, attendance logs, and work emails to your personal drive.\", \"Always send your salary demand letter via registered post or official email before approaching the Labour Commissioner.\", \"Under Indian law, employers cannot withhold earned wages or delay Provident Fund (PF) deposits.\"], \"options\": [\"Online grievance on EPFiGMS portal (epfigms.gov.in) for PF.\", \"Application to Controlling Authority under Payment of Gratuity Act 1972.\"], \"actions\": [\"Check your EPFO Unified Member Portal for contribution logs and mark of exit date.\", \"Calculate statutory gratuity (15 days salary per year of completed service).\", \"Submit statutory Form I for gratuity payment to the employer management.\", \"File an online grievance on the EPFiGMS portal (epfigms.gov.in) against the employer for PF non-remittance.\", \"File an application before the Controlling Authority under the Payment of Gratuity Act.\"], \"documents\": [{\"name\": \"Form 16 / Relieving Letter\", \"level\": \"Essential\", \"description\": \"Proves total length of service (minimum 5 years for Gratuity) and exit date\"}, {\"name\": \"Salary Slips Showing PF Deductions\", \"level\": \"Essential\", \"description\": \"Shows employee contributions deducted by employer\"}, {\"name\": \"EPFO Member Passbook / UAN Account Details\", \"level\": \"Essential\", \"description\": \"Proves missing PF remittances or failure to mark exit date\"}, {\"name\": \"Form I Application for Gratuity Payment\", \"level\": \"Recommended\", \"description\": \"Statutory demand form served on employer\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides automated legal information based on Indian statutory laws. This information is for guidance and does not replace formal advocate representation.\", \"session_id\": \"LEX-SESS-1791296293-785\"}'),
(25, 'mployer not paying me', 'No Reliable Match Found\n\nI could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\n\nI do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.', 'General', '2026-10-06 18:05:37', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"unsupported\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": false, \"is_topic_selection\": false, \"title\": \"No Reliable Match Found\", \"situation_assessment\": \"I could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\", \"explanation\": \"I do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.\", \"clarifying_questions\": [\"Can you describe what happened in more detail?\", \"Who is involved?\", \"What specific legal outcome are you looking for?\"], \"preventions\": [], \"actions\": [], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"No reliable legal match was found. This is not a statement that no legal remedy exists; it only means Lex cannot currently support one from its available legal database.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"mployer not paying me\", \"continued_consultation\": false, \"consultation_context\": \"mployer not paying me\"}'),
(26, 'employer not paying me', 'More Information Needed\n\nYour message appears to concern Employment Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-06 18:05:54', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Employment Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"What payment or employment issue is involved?\", \"Is it unpaid salary/wages, PF, gratuity, termination, workplace harassment, or something else?\", \"How long has the issue been continuing?\"], \"preventions\": [], \"actions\": [\"What payment or employment issue is involved?\", \"Is it unpaid salary/wages, PF, gratuity, termination, workplace harassment, or something else?\", \"How long has the issue been continuing?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"employer not paying me\", \"continued_consultation\": false, \"consultation_context\": \"employer not paying me\"}'),
(27, 'my salary has not been paid for two months', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:06:07', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.28, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Are you currently working for the employer, or has your employment already ended?\", \"Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?\"], \"preventions\": [], \"actions\": [\"Are you currently working for the employer, or has your employment already ended?\", \"Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 8, \"title\": \"Unpaid salary and withheld wages\", \"situation\": \"My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.\", \"topic\": \"Employment Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"my salary has not been paid for two months\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nemployer not paying me\\n\\nAdditional facts provided by the user:\\nmy salary has not been paid for two months\"}'),
(28, 'I am still working there. My salary for the last two months is unpaid', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:06:18', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.65, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?\"], \"preventions\": [], \"actions\": [\"Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 8, \"title\": \"Unpaid salary and withheld wages\", \"situation\": \"My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.\", \"topic\": \"Employment Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"I am still working there. My salary for the last two months is unpaid\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nemployer not paying me\\n\\nAdditional facts provided by the user:\\nmy salary has not been paid for two months\\n\\nAdditional facts provided by the user:\\nI am still working there. My salary for the last two months is unpaid\"}'),
(29, 'My employer has not paid my salary and says they will pay next month.', 'Unpaid salary and withheld wages\n\nBased only on the information you provided, your question appears relevant to the legal situation described in Lex\'s database. This is a database match, not a determination that the law has been violated.\n\nThe Code on Wages, 2019 contains provisions governing payment of wages. For monthly wage periods, Section 17 provides a statutory payment timeline, subject to the Code\'s applicability. Section 45 provides a claim mechanism for amounts due. The appropriate authority, employee coverage and available relief depend on the facts and applicable establishment/government.', 'General', '2026-10-06 18:06:47', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"answered\", \"confidence\": 0.87, \"found\": true, \"requires_user_input\": false, \"is_topic_selection\": false, \"title\": \"Unpaid salary and withheld wages\", \"situation_assessment\": \"Based only on the information you provided, your question appears relevant to the legal situation described in Lex\'s database. This is a database match, not a determination that the law has been violated.\", \"explanation\": \"The Code on Wages, 2019 contains provisions governing payment of wages. For monthly wage periods, Section 17 provides a statutory payment timeline, subject to the Code\'s applicability. Section 45 provides a claim mechanism for amounts due. The appropriate authority, employee coverage and available relief depend on the facts and applicable establishment/government.\", \"clarifying_questions\": [], \"preventions\": [\"Keep relevant messages, emails, receipts, agreements, notices, and payment records.\", \"Record important dates, amounts, names, and events accurately.\", \"Keep original files where possible and make secure copies of important evidence.\", \"Do not delete or alter potentially relevant evidence.\", \"Do not sign a settlement, resignation, admission, or other legal document without understanding its terms.\"], \"actions\": [{\"action_id\": 34, \"action_text\": \"Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.\", \"step_number\": 1}, {\"action_id\": 35, \"action_text\": \"Prepare a dated record of the employment event, unpaid amounts or disputed decision.\", \"step_number\": 2}, {\"action_id\": 36, \"action_text\": \"Raise the issue in writing with the employer and retain proof of the request and response.\", \"step_number\": 3}, {\"action_id\": 37, \"action_text\": \"Identify the employee category, establishment and state so the applicable labour framework can be verified.\", \"step_number\": 4}, {\"action_id\": 38, \"action_text\": \"If unresolved, consider the appropriate labour authority, statutory claim mechanism or professional legal advice after verifying eligibility and procedure.\", \"step_number\": 5}], \"documents\": [{\"document_id\": 28, \"document_name\": \"Employment Contract / Offer Letter\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 29, \"document_name\": \"Salary Slips (Previous 3-6 Months)\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 30, \"document_name\": \"Bank Account Statement\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 31, \"document_name\": \"Timesheet / Attendance / Swipe-in Records\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 32, \"document_name\": \"Emails & Messages with HR / Management\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}], \"options\": [{\"option_id\": 17, \"option_text\": \"Written employer grievance and applicable labour-authority/claim mechanism.\", \"priority\": 1}, {\"option_id\": 18, \"option_text\": \"Professional legal advice or appropriate labour/court remedy after confirming employee coverage.\", \"priority\": 2}, {\"option_id\": 19, \"option_text\": \"Professional legal advice or appropriate labour/court remedy after confirming employee coverage.\", \"priority\": 3}], \"candidate_cases\": [{\"case_id\": 8, \"title\": \"Unpaid salary and withheld wages\", \"situation\": \"My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.\", \"topic\": \"Employment Law\", \"score\": 86.75}, {\"case_id\": 13, \"title\": \"Unpaid overtime wages\", \"situation\": \"My employer forces me to work beyond statutory working hours without providing overtime pay.\", \"topic\": \"Employment Law\", \"score\": 40.75}, {\"case_id\": 12, \"title\": \"Termination without notice or notice pay\", \"situation\": \"I was fired on the spot without the 30/60/90 days contractual notice period or salary in lieu of notice.\", \"topic\": \"Employment Law\", \"score\": 24.0}], \"case\": {\"case_id\": 8, \"topic_id\": 2, \"case_title\": \"Unpaid salary and withheld wages\", \"situation\": \"My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.\", \"explanation\": \"The Code on Wages, 2019 contains provisions governing payment of wages. For monthly wage periods, Section 17 provides a statutory payment timeline, subject to the Code\'s applicability. Section 45 provides a claim mechanism for amounts due. The appropriate authority, employee coverage and available relief depend on the facts and applicable establishment/government.\", \"urgency\": \"High\", \"jurisdiction\": \"India\", \"topic_name\": \"Employment Law\", \"topic_description\": \"Issues involving unpaid wages, wrongful termination, employment contracts, workplace harassment (POSH), PF and gratuity dues\", \"keywords\": \"unpaid salary | salary not paid | salary delayed | withheld wages | unpaid wages | salary arrears | salary dues | salary withheld | stipend not paid\", \"_score\": 86.75, \"_evidence\": {\"exact_phrases\": [], \"keyword_matches\": [\"unpaid salary (2 words)\", \"salary not paid (2 words)\"], \"title_matches\": [\"salary\", \"salary\", \"unpaid\", \"salary\"], \"situation_matches\": [\"salary\", \"paid\", \"working\", \"salary\", \"employer\", \"paid\", \"salary\"], \"domain_matches\": [{\"domain\": \"employment\", \"overlap\": 3}]}}, \"sources\": [{\"source_id\": 4, \"source_name\": \"Code on Wages 2019 / Payment of Wages Act\", \"source_url\": \"https://labour.gov.in\", \"source_type\": \"Statutory Act\", \"last_verified\": \"2026-08-01\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides database-backed general legal information for Indian-law situations. The database match does not establish that a particular offence, violation, liability, remedy, deadline, or legal entitlement applies to your specific facts. For decisions involving significant rights, money, safety, criminal allegations, or court proceedings, consult a qualified legal professional.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"My employer has not paid my salary and says they will pay next month.\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nOriginal legal situation:\\nemployer not paying me\\n\\nAdditional facts provided by the user:\\nmy salary has not been paid for two months\\n\\nAdditional facts provided by the user:\\nI am still working there. My salary for the last two months is unpaid\\n\\nAdditional facts provided by the user:\\nMy employer has not paid my salary and says they will pay next month.\"}'),
(30, 'my friend beat me', 'More Information Needed\n\nYour message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-06 18:07:33', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"my friend beat me\", \"continued_consultation\": false, \"consultation_context\": \"my friend beat me\"}'),
(31, 'he beat me and threatened me', 'More Information Needed\n\nYour message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-06 18:08:12', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"he beat me and threatened me\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nhe beat me and threatened me\"}');
INSERT INTO `conversations` (`id`, `user_message`, `lex_response`, `topic`, `created_at`, `session_id`, `user_email`, `case_json`) VALUES
(32, 'i was harmed', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:08:32', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.24, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 18, \"title\": \"Lost or missing original property documents\", \"situation\": \"I have lost my original registered sale deed or property title documents and need duplicates.\", \"topic\": \"Property Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"i was harmed\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nhe beat me and threatened me\\n\\nAdditional facts provided by the user:\\ni was harmed\"}'),
(33, 'my friend did it', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:08:52', 'LEX-SESS-1791309921-259', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.36, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 18, \"title\": \"Lost or missing original property documents\", \"situation\": \"I have lost my original registered sale deed or property title documents and need duplicates.\", \"topic\": \"Property Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791309921-259\", \"consultation_id\": \"LEX-CONS-482c964f446e4d95\", \"user_query\": \"my friend did it\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nOriginal legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nhe beat me and threatened me\\n\\nAdditional facts provided by the user:\\ni was harmed\\n\\nAdditional facts provided by the user:\\nmy friend did it\"}'),
(34, 'my friend beat me', 'More Information Needed\n\nYour message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-06 18:09:23', 'LEX-SESS-1791310152-553', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1791310152-553\", \"consultation_id\": \"LEX-CONS-606a3ddfb4d445f0\", \"user_query\": \"my friend beat me\", \"continued_consultation\": false, \"consultation_context\": \"my friend beat me\"}'),
(35, 'hello', 'How Can Lex Help?\n\nPlease describe the legal problem you want help with.\n\nFor example, you can describe a salary dispute, tenancy issue, consumer problem, cyber incident, family matter, contract dispute, accident, or another legal issue.', 'General', '2026-10-06 18:09:41', 'LEX-SESS-1791310168-553', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"How Can Lex Help?\", \"situation_assessment\": \"Please describe the legal problem you want help with.\", \"explanation\": \"For example, you can describe a salary dispute, tenancy issue, consumer problem, cyber incident, family matter, contract dispute, accident, or another legal issue.\", \"clarifying_questions\": [\"What happened?\", \"Who is involved?\", \"What are you trying to achieve?\"], \"preventions\": [], \"actions\": [], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides database-backed legal information and does not replace advice from a qualified lawyer.\", \"session_id\": \"LEX-SESS-1791310168-553\", \"consultation_id\": \"LEX-CONS-c3b5111d76ca4b78\", \"user_query\": \"hello\", \"continued_consultation\": false, \"consultation_context\": \"hello\"}'),
(36, 'what is java', 'No Reliable Match Found\n\nI could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\n\nI do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.', 'General', '2026-10-06 18:09:54', 'LEX-SESS-1791310168-553', 'kunal@lex.local', '{\"success\": true, \"status\": \"unsupported\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": false, \"is_topic_selection\": false, \"title\": \"No Reliable Match Found\", \"situation_assessment\": \"I could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\", \"explanation\": \"I do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.\", \"clarifying_questions\": [\"Can you describe what happened in more detail?\", \"Who is involved?\", \"What specific legal outcome are you looking for?\"], \"preventions\": [], \"actions\": [], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"No reliable legal match was found. This is not a statement that no legal remedy exists; it only means Lex cannot currently support one from its available legal database.\", \"session_id\": \"LEX-SESS-1791310168-553\", \"consultation_id\": \"LEX-CONS-c3b5111d76ca4b78\", \"user_query\": \"what is java\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nhello\\n\\nAdditional facts provided by the user:\\nwhat is java\"}'),
(37, 'what is python', 'No Reliable Match Found\n\nI could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\n\nI do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.', 'General', '2026-10-06 18:10:00', 'LEX-SESS-1791310168-553', 'kunal@lex.local', '{\"success\": true, \"status\": \"unsupported\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": false, \"is_topic_selection\": false, \"title\": \"No Reliable Match Found\", \"situation_assessment\": \"I could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\", \"explanation\": \"I do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.\", \"clarifying_questions\": [\"Can you describe what happened in more detail?\", \"Who is involved?\", \"What specific legal outcome are you looking for?\"], \"preventions\": [], \"actions\": [], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"No reliable legal match was found. This is not a statement that no legal remedy exists; it only means Lex cannot currently support one from its available legal database.\", \"session_id\": \"LEX-SESS-1791310168-553\", \"consultation_id\": \"LEX-CONS-c3b5111d76ca4b78\", \"user_query\": \"what is python\", \"continued_consultation\": false, \"consultation_context\": \"what is python\"}'),
(38, 'how are you', 'No Reliable Match Found\n\nI could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\n\nI do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.', 'General', '2026-10-06 18:10:05', 'LEX-SESS-1791310168-553', 'kunal@lex.local', '{\"success\": true, \"status\": \"unsupported\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": false, \"is_topic_selection\": false, \"title\": \"No Reliable Match Found\", \"situation_assessment\": \"I could not find a sufficiently reliable match for the legal issue you described in Lex\'s current legal database.\", \"explanation\": \"I do not want to invent a legal section, remedy, deadline, procedure, or case that is not supported by the available legal information.\", \"clarifying_questions\": [\"Can you describe what happened in more detail?\", \"Who is involved?\", \"What specific legal outcome are you looking for?\"], \"preventions\": [], \"actions\": [], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"No reliable legal match was found. This is not a statement that no legal remedy exists; it only means Lex cannot currently support one from its available legal database.\", \"session_id\": \"LEX-SESS-1791310168-553\", \"consultation_id\": \"LEX-CONS-c3b5111d76ca4b78\", \"user_query\": \"how are you\", \"continued_consultation\": false, \"consultation_context\": \"how are you\"}'),
(39, 'My employer has not paid my salary for two months and is withholding wages', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:11:11', 'LEX-SESS-1791310168-553', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.51, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 8, \"title\": \"Unpaid salary and withheld wages\", \"situation\": \"My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.\", \"topic\": \"Employment Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791310168-553\", \"consultation_id\": \"LEX-CONS-b7c20c2267a345fa\", \"user_query\": \"My employer has not paid my salary for two months and is withholding wages\", \"continued_consultation\": false, \"consultation_context\": \"My employer has not paid my salary for two months and is withholding wages\"}'),
(40, 'my friend beat me', 'More Information Needed\n\nYour message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-06 18:13:01', 'LEX-SESS-1791310287-467', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1791310287-467\", \"consultation_id\": \"LEX-CONS-e92be2dd9a5349a1\", \"user_query\": \"my friend beat me\", \"continued_consultation\": false, \"consultation_context\": \"my friend beat me\"}'),
(41, 'yes, i am injured', 'Please Clarify the Legal Issue\n\nYour message appears to involve more than one possible legal area, so Lex cannot safely identify the specific issue yet.\n\nPlease describe the main event or dispute and tell Lex what outcome you want help with.', 'General', '2026-10-06 18:13:10', 'LEX-SESS-1791310287-467', 'kunal@lex.local', '{\"success\": true, \"status\": \"ambiguous\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"Please Clarify the Legal Issue\", \"situation_assessment\": \"Your message appears to involve more than one possible legal area, so Lex cannot safely identify the specific issue yet.\", \"explanation\": \"Please describe the main event or dispute and tell Lex what outcome you want help with.\", \"clarifying_questions\": [\"What exactly happened?\", \"Who is involved?\", \"Which part of the situation is causing the legal problem?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Describe the main event in chronological order.\", \"Identify the people, company, seller, landlord, or other party involved.\", \"State what you want Lex to help you achieve.\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex will not select a specific legal case when the available facts point to multiple possible legal areas.\", \"session_id\": \"LEX-SESS-1791310287-467\", \"consultation_id\": \"LEX-CONS-e92be2dd9a5349a1\", \"user_query\": \"yes, i am injured\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nyes, i am injured\"}'),
(42, 'my friend did it', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:13:47', 'LEX-SESS-1791310287-467', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.24, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 18, \"title\": \"Lost or missing original property documents\", \"situation\": \"I have lost my original registered sale deed or property title documents and need duplicates.\", \"topic\": \"Property Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791310287-467\", \"consultation_id\": \"LEX-CONS-e92be2dd9a5349a1\", \"user_query\": \"my friend did it\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nyes, i am injured\\n\\nAdditional facts provided by the user:\\nmy friend did it\"}'),
(43, 'my friend beat me', 'More Information Needed\n\nYour message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-06 18:18:54', 'LEX-SESS-1791310721-817', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Criminal Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Was anyone injured, threatened, or otherwise harmed?\", \"Has a police complaint or FIR already been filed?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1791310721-817\", \"consultation_id\": \"LEX-CONS-1179e7cbd40442df\", \"user_query\": \"my friend beat me\", \"continued_consultation\": false, \"consultation_context\": \"my friend beat me\"}'),
(44, 'yes, I am injured', 'Please Clarify the Legal Issue\n\nYour message appears to involve more than one possible legal area, so Lex cannot safely identify the specific issue yet.\n\nPlease describe the main event or dispute and tell Lex what outcome you want help with.', 'General', '2026-10-06 18:19:12', 'LEX-SESS-1791310721-817', 'kunal@lex.local', '{\"success\": true, \"status\": \"ambiguous\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"Please Clarify the Legal Issue\", \"situation_assessment\": \"Your message appears to involve more than one possible legal area, so Lex cannot safely identify the specific issue yet.\", \"explanation\": \"Please describe the main event or dispute and tell Lex what outcome you want help with.\", \"clarifying_questions\": [\"What exactly happened?\", \"Who is involved?\", \"Which part of the situation is causing the legal problem?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Describe the main event in chronological order.\", \"Identify the people, company, seller, landlord, or other party involved.\", \"State what you want Lex to help you achieve.\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex will not select a specific legal case when the available facts point to multiple possible legal areas.\", \"session_id\": \"LEX-SESS-1791310721-817\", \"consultation_id\": \"LEX-CONS-1179e7cbd40442df\", \"user_query\": \"yes, I am injured\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nyes, I am injured\"}'),
(45, 'He hit me with a stick yesterday.', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:19:28', 'LEX-SESS-1791310721-817', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.24, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe the accident and the type of vehicle involved.\"], \"preventions\": [], \"actions\": [\"Please describe the accident and the type of vehicle involved.\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 54, \"title\": \"Hit and run accident solatium scheme\", \"situation\": \"A victim was injured or killed in a hit-and-run road accident where the offending vehicle fled and is untraced.\", \"topic\": \"Traffic and Motor Vehicle\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791310721-817\", \"consultation_id\": \"LEX-CONS-1179e7cbd40442df\", \"user_query\": \"He hit me with a stick yesterday.\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nyes, I am injured\\n\\nAdditional facts provided by the user:\\nHe hit me with a stick yesterday.\"}'),
(46, 'I have a medical report.', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-06 18:19:47', 'LEX-SESS-1791310721-817', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.24, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe the accident and the type of vehicle involved.\"], \"preventions\": [], \"actions\": [\"Please describe the accident and the type of vehicle involved.\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 54, \"title\": \"Hit and run accident solatium scheme\", \"situation\": \"A victim was injured or killed in a hit-and-run road accident where the offending vehicle fled and is untraced.\", \"topic\": \"Traffic and Motor Vehicle\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1791310721-817\", \"consultation_id\": \"LEX-CONS-1179e7cbd40442df\", \"user_query\": \"I have a medical report.\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nOriginal legal situation:\\nmy friend beat me\\n\\nAdditional facts provided by the user:\\nyes, I am injured\\n\\nAdditional facts provided by the user:\\nHe hit me with a stick yesterday.\\n\\nAdditional facts provided by the user:\\nI have a medical report.\"}'),
(47, 'My landlord refuses to return my rental security deposit after vacating the property', 'Security deposit not returned by landlord\n\nBased only on the information you provided, your question appears relevant to the legal situation described in Lex\'s database. This is a database match, not a determination that the law has been violated.\n\nSecurity-deposit disputes are primarily fact- and contract-dependent and may also be governed by applicable state tenancy law. The lease, deposit amount, agreed deductions, condition of the premises, handover evidence and any applicable local tenancy statute should be reviewed before stating that a particular amount or interest is legally due.', 'General', '2026-10-28 15:32:46', 'LEX-SESS-1793201450-705', 'kunal@lex.local', '{\"success\": true, \"status\": \"answered\", \"confidence\": 0.99, \"found\": true, \"requires_user_input\": false, \"is_topic_selection\": false, \"title\": \"Security deposit not returned by landlord\", \"situation_assessment\": \"Based only on the information you provided, your question appears relevant to the legal situation described in Lex\'s database. This is a database match, not a determination that the law has been violated.\", \"explanation\": \"Security-deposit disputes are primarily fact- and contract-dependent and may also be governed by applicable state tenancy law. The lease, deposit amount, agreed deductions, condition of the premises, handover evidence and any applicable local tenancy statute should be reviewed before stating that a particular amount or interest is legally due.\", \"clarifying_questions\": [], \"preventions\": [\"Keep relevant messages, emails, receipts, agreements, notices, and payment records.\", \"Record important dates, amounts, names, and events accurately.\", \"Keep original files where possible and make secure copies of important evidence.\", \"Do not delete or alter potentially relevant evidence.\", \"Do not sign a settlement, resignation, admission, or other legal document without understanding its terms.\"], \"actions\": [{\"action_id\": 92, \"action_text\": \"Preserve the tenancy agreement, rent/deposit records, notices, photographs and communications.\", \"step_number\": 1}, {\"action_id\": 93, \"action_text\": \"Record the dates of possession, payments, notices, repairs or alleged interference.\", \"step_number\": 2}, {\"action_id\": 94, \"action_text\": \"Check which state tenancy law and contractual terms apply to the premises.\", \"step_number\": 3}, {\"action_id\": 95, \"action_text\": \"Send a clear written communication documenting the dispute and requested resolution.\", \"step_number\": 4}, {\"action_id\": 96, \"action_text\": \"Consider the appropriate rent authority, civil court or other remedy after verifying the local procedure.\", \"step_number\": 5}], \"documents\": [{\"document_id\": 69, \"document_name\": \"Registered / Notarized Rent Agreement\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 70, \"document_name\": \"Security Deposit Bank Transfer Receipt / UTR\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 71, \"document_name\": \"Move-out Inspection Photos / Video Handover Proof\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}, {\"document_id\": 72, \"document_name\": \"Written Notice to Vacate & Key Handover Acknowledgment\", \"required_level\": \"Recommended\", \"description\": \"Potentially useful evidence; whether it is required depends on the applicable procedure and facts.\"}], \"options\": [{\"option_id\": 41, \"option_text\": \"Written contractual/tenancy-law grievance or applicable rent-authority process.\", \"priority\": 1}, {\"option_id\": 42, \"option_text\": \"Civil or tenancy proceeding after confirming the state-specific forum and facts.\", \"priority\": 2}, {\"option_id\": 43, \"option_text\": \"Civil or tenancy proceeding after confirming the state-specific forum and facts.\", \"priority\": 3}], \"candidate_cases\": [{\"case_id\": 19, \"title\": \"Security deposit not returned by landlord\", \"situation\": \"My landlord refuses to return my security deposit after vacating the flat peacefully.\", \"topic\": \"Rental and Tenancy\", \"score\": 120.75}, {\"case_id\": 2, \"title\": \"Seller refuses refund or return\", \"situation\": \"The seller refuses to provide a refund or accept return for a cancelled order, non-delivered item, or eligible return.\", \"topic\": \"Consumer Law\", \"score\": 26.75}, {\"case_id\": 21, \"title\": \"Landlord refusing essential repairs\", \"situation\": \"My landlord refuses to fix structural damages, severe plumbing leaks, or electrical hazards.\", \"topic\": \"Rental and Tenancy\", \"score\": 24.75}], \"case\": {\"case_id\": 19, \"topic_id\": 4, \"case_title\": \"Security deposit not returned by landlord\", \"situation\": \"My landlord refuses to return my security deposit after vacating the flat peacefully.\", \"explanation\": \"Security-deposit disputes are primarily fact- and contract-dependent and may also be governed by applicable state tenancy law. The lease, deposit amount, agreed deductions, condition of the premises, handover evidence and any applicable local tenancy statute should be reviewed before stating that a particular amount or interest is legally due.\", \"urgency\": \"Normal\", \"jurisdiction\": \"India\", \"topic_name\": \"Rental and Tenancy\", \"topic_description\": \"Disputes between landlords and tenants including security deposit refund, illegal eviction, repairs, and rent disputes\", \"keywords\": \"security deposit not returned | landlord not returning deposit | rental deposit refund | deposit deduction dispute | landlord withheld deposit | flat deposit refund\", \"_score\": 120.75, \"_evidence\": {\"exact_phrases\": [\"phrase overlap\"], \"keyword_matches\": [\"security deposit not returned (2 words)\", \"landlord not returning deposit (2 words)\", \"rental deposit refund (2 words)\", \"landlord withheld deposit (2 words)\"], \"title_matches\": [\"landlord\", \"security\", \"deposit\"], \"situation_matches\": [\"landlord\", \"refuses\", \"return\", \"security\", \"deposit\", \"vacating\"], \"domain_matches\": [{\"domain\": \"rent\", \"overlap\": 4}, {\"domain\": \"consumer\", \"overlap\": 1}]}}, \"sources\": [{\"source_id\": 8, \"source_name\": \"Model Tenancy Act / State Rent Control Acts\", \"source_url\": \"https://mohua.gov.in\", \"source_type\": \"Statutory Act\", \"last_verified\": \"2026-08-01\"}], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex provides database-backed general legal information for Indian-law situations. The database match does not establish that a particular offence, violation, liability, remedy, deadline, or legal entitlement applies to your specific facts. For decisions involving significant rights, money, safety, criminal allegations, or court proceedings, consult a qualified legal professional.\", \"session_id\": \"LEX-SESS-1793201450-705\", \"consultation_id\": \"LEX-CONS-9c960c20da9f46a6\", \"user_query\": \"My landlord refuses to return my rental security deposit after vacating the property\", \"continued_consultation\": false, \"consultation_context\": \"My landlord refuses to return my rental security deposit after vacating the property\"}'),
(48, 'boss is not giving salary', 'More Information Needed\n\nYour message appears to concern Employment Law, but it does not contain enough facts to identify a specific legal issue reliably.\n\nLex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.', 'General', '2026-10-28 15:37:49', 'LEX-SESS-1793201669-405', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Your message appears to concern Employment Law, but it does not contain enough facts to identify a specific legal issue reliably.\", \"explanation\": \"Lex will not assume which specific legal case applies. Please provide the relevant facts so the legal issue can be identified safely.\", \"clarifying_questions\": [\"What payment or employment issue is involved?\", \"Is it unpaid salary/wages, PF, gratuity, termination, workplace harassment, or something else?\", \"How long has the issue been continuing?\"], \"preventions\": [], \"actions\": [\"What payment or employment issue is involved?\", \"Is it unpaid salary/wages, PF, gratuity, termination, workplace harassment, or something else?\", \"How long has the issue been continuing?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a determination of which legal provision applies. Lex will not infer facts that you have not provided.\", \"session_id\": \"LEX-SESS-1793201669-405\", \"consultation_id\": \"LEX-CONS-d7d1316e7b514e0c\", \"user_query\": \"boss is not giving salary\", \"continued_consultation\": false, \"consultation_context\": \"boss is not giving salary\"}'),
(49, '2  months', 'More Information Needed\n\nLex has the additional information you provided, but needs a few remaining employment facts before it can determine whether a specific legal case is supported.\n\nLex will not assume your employment status or the employer\'s response to the unpaid-salary issue.', 'General', '2026-10-28 15:39:31', 'LEX-SESS-1793201669-405', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.0, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"Lex has the additional information you provided, but needs a few remaining employment facts before it can determine whether a specific legal case is supported.\", \"explanation\": \"Lex will not assume your employment status or the employer\'s response to the unpaid-salary issue.\", \"clarifying_questions\": [\"Are you currently working for the employer, or has your employment already ended?\", \"Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?\"], \"preventions\": [], \"actions\": [\"Are you currently working for the employer, or has your employment already ended?\", \"Have you asked the employer about the unpaid salary? If yes, what did the employer say or do?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"This is a clarification request, not a finding that a particular legal provision, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1793201669-405\", \"consultation_id\": \"LEX-CONS-d7d1316e7b514e0c\", \"user_query\": \"2  months\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nboss is not giving salary\\n\\nAdditional facts provided by the user:\\n2  months\"}'),
(50, 'i am not working', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-28 15:40:37', 'LEX-SESS-1793201669-405', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.24, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 18, \"title\": \"Lost or missing original property documents\", \"situation\": \"I have lost my original registered sale deed or property title documents and need duplicates.\", \"topic\": \"Property Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1793201669-405\", \"consultation_id\": \"LEX-CONS-d7d1316e7b514e0c\", \"user_query\": \"i am not working\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nboss is not giving salary\\n\\nAdditional facts provided by the user:\\n2  months\\n\\nAdditional facts provided by the user:\\ni am not working\"}'),
(51, 'money', 'More Information Needed\n\nI can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\n\nI do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.', 'General', '2026-10-28 15:41:33', 'LEX-SESS-1793201669-405', 'kunal@lex.local', '{\"success\": true, \"status\": \"needs_clarification\", \"confidence\": 0.36, \"found\": false, \"requires_user_input\": true, \"is_topic_selection\": false, \"title\": \"More Information Needed\", \"situation_assessment\": \"I can see a possible legal area, but I do not have enough facts to safely treat a specific legal situation as your case.\", \"explanation\": \"I do not want to assume facts that you have not provided. Please answer the questions below so Lex can determine whether the available legal information actually applies.\", \"clarifying_questions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"preventions\": [], \"actions\": [\"Please describe exactly what happened.\", \"Who is involved?\", \"When did it happen?\", \"What outcome are you seeking?\"], \"documents\": [], \"options\": [], \"candidate_cases\": [{\"case_id\": 18, \"title\": \"Lost or missing original property documents\", \"situation\": \"I have lost my original registered sale deed or property title documents and need duplicates.\", \"topic\": \"Property Law\"}], \"case\": null, \"sources\": [], \"jurisdiction\": \"India\", \"disclaimer\": \"Lex has not reached a legal conclusion because the available facts are insufficient. The clarification request is not a finding that any particular law, offence, remedy, or procedure applies.\", \"session_id\": \"LEX-SESS-1793201669-405\", \"consultation_id\": \"LEX-CONS-d7d1316e7b514e0c\", \"user_query\": \"money\", \"continued_consultation\": true, \"consultation_context\": \"Original legal situation:\\nOriginal legal situation:\\nOriginal legal situation:\\nboss is not giving salary\\n\\nAdditional facts provided by the user:\\n2  months\\n\\nAdditional facts provided by the user:\\ni am not working\\n\\nAdditional facts provided by the user:\\nmoney\"}');

-- --------------------------------------------------------

--
-- Table structure for table `legal_actions`
--

CREATE TABLE `legal_actions` (
  `action_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `action_text` text NOT NULL,
  `step_number` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_actions`
--

INSERT INTO `legal_actions` (`action_id`, `case_id`, `action_text`, `step_number`) VALUES
(1, 1, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(2, 1, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(3, 1, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(4, 1, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(5, 1, 'Consider a formal consumer or other legal remedy after confirming jurisdiction, limitation and the relief actually available.', 5),
(6, 2, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(7, 2, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(8, 2, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(9, 2, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(10, 2, 'Consider a formal consumer or other legal remedy after confirming jurisdiction, limitation and the relief actually available.', 5),
(11, 3, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(12, 3, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(13, 3, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(14, 3, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(15, 3, 'Consider a formal consumer or other legal remedy after confirming jurisdiction, limitation and the relief actually available.', 5),
(16, 4, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(17, 4, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(18, 4, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(19, 4, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(20, 4, 'Consider a formal consumer or other legal remedy after confirming jurisdiction, limitation and the relief actually available.', 5),
(21, 5, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(22, 5, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(23, 5, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(24, 5, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(25, 5, 'Consider a formal consumer or other legal remedy after confirming jurisdiction, limitation and the relief actually available.', 5),
(26, 6, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(27, 6, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(28, 6, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(29, 6, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(30, 7, 'Preserve the invoice, payment proof, order/warranty records and relevant communications.', 1),
(31, 7, 'Record the product/service issue accurately and keep photographs, videos or other evidence where relevant.', 2),
(32, 7, 'Raise the issue with the seller/service provider through a traceable written channel and keep the response.', 3),
(33, 7, 'If unresolved, check the applicable consumer, regulator or sector-specific grievance mechanism.', 4),
(34, 8, 'Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.', 1),
(35, 8, 'Prepare a dated record of the employment event, unpaid amounts or disputed decision.', 2),
(36, 8, 'Raise the issue in writing with the employer and retain proof of the request and response.', 3),
(37, 8, 'Identify the employee category, establishment and state so the applicable labour framework can be verified.', 4),
(38, 8, 'If unresolved, consider the appropriate labour authority, statutory claim mechanism or professional legal advice after verifying eligibility and procedure.', 5),
(39, 9, 'Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.', 1),
(40, 9, 'Prepare a dated record of the employment event, unpaid amounts or disputed decision.', 2),
(41, 9, 'Raise the issue in writing with the employer and retain proof of the request and response.', 3),
(42, 9, 'Identify the employee category, establishment and state so the applicable labour framework can be verified.', 4),
(43, 9, 'If unresolved, consider the appropriate labour authority, statutory claim mechanism or professional legal advice after verifying eligibility and procedure.', 5),
(44, 10, 'Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.', 1),
(45, 10, 'Prepare a dated record of the employment event, unpaid amounts or disputed decision.', 2),
(46, 10, 'Raise the issue in writing with the employer and retain proof of the request and response.', 3),
(47, 10, 'Identify the employee category, establishment and state so the applicable labour framework can be verified.', 4),
(48, 10, 'If unresolved, consider the appropriate labour authority, statutory claim mechanism or professional legal advice after verifying eligibility and procedure.', 5),
(49, 11, 'Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.', 1),
(50, 11, 'Prepare a dated record of the employment event, unpaid amounts or disputed decision.', 2),
(51, 11, 'Raise the issue in writing with the employer and retain proof of the request and response.', 3),
(52, 11, 'Identify the employee category, establishment and state so the applicable labour framework can be verified.', 4),
(53, 11, 'If unresolved, consider the appropriate labour authority, statutory claim mechanism or professional legal advice after verifying eligibility and procedure.', 5),
(54, 12, 'Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.', 1),
(55, 12, 'Prepare a dated record of the employment event, unpaid amounts or disputed decision.', 2),
(56, 12, 'Raise the issue in writing with the employer and retain proof of the request and response.', 3),
(57, 12, 'Identify the employee category, establishment and state so the applicable labour framework can be verified.', 4),
(58, 13, 'Preserve the employment agreement, wage records, attendance records and communications relevant to the dispute.', 1),
(59, 13, 'Prepare a dated record of the employment event, unpaid amounts or disputed decision.', 2),
(60, 13, 'Raise the issue in writing with the employer and retain proof of the request and response.', 3),
(61, 13, 'Identify the employee category, establishment and state so the applicable labour framework can be verified.', 4),
(62, 14, 'Collect title documents, registration records, agreements, tax or possession records and relevant correspondence.', 1),
(63, 14, 'Create a dated chronology of the ownership, transaction, possession or boundary dispute.', 2),
(64, 14, 'Verify the relevant registration, revenue and land records before alleging title or forgery.', 3),
(65, 14, 'Obtain professional advice on the appropriate civil, revenue or regulatory forum where necessary.', 4),
(66, 14, 'Consider litigation or other relief only after checking jurisdiction, limitation and the evidence supporting the claim.', 5),
(67, 15, 'Collect title documents, registration records, agreements, tax or possession records and relevant correspondence.', 1),
(68, 15, 'Create a dated chronology of the ownership, transaction, possession or boundary dispute.', 2),
(69, 15, 'Verify the relevant registration, revenue and land records before alleging title or forgery.', 3),
(70, 15, 'Obtain professional advice on the appropriate civil, revenue or regulatory forum where necessary.', 4),
(71, 15, 'Consider litigation or other relief only after checking jurisdiction, limitation and the evidence supporting the claim.', 5),
(77, 16, 'Collect title documents, registration records, agreements, tax or possession records and relevant correspondence.', 1),
(78, 16, 'Create a dated chronology of the ownership, transaction, possession or boundary dispute.', 2),
(79, 16, 'Verify the relevant registration, revenue and land records before alleging title or forgery.', 3),
(80, 16, 'Obtain professional advice on the appropriate civil, revenue or regulatory forum where necessary.', 4),
(81, 16, 'Consider litigation or other relief only after checking jurisdiction, limitation and the evidence supporting the claim.', 5),
(82, 17, 'Collect title documents, registration records, agreements, tax or possession records and relevant correspondence.', 1),
(83, 17, 'Create a dated chronology of the ownership, transaction, possession or boundary dispute.', 2),
(84, 17, 'Verify the relevant registration, revenue and land records before alleging title or forgery.', 3),
(85, 17, 'Obtain professional advice on the appropriate civil, revenue or regulatory forum where necessary.', 4),
(86, 17, 'Consider litigation or other relief only after checking jurisdiction, limitation and the evidence supporting the claim.', 5),
(87, 18, 'Collect title documents, registration records, agreements, tax or possession records and relevant correspondence.', 1),
(88, 18, 'Create a dated chronology of the ownership, transaction, possession or boundary dispute.', 2),
(89, 18, 'Verify the relevant registration, revenue and land records before alleging title or forgery.', 3),
(90, 18, 'Obtain professional advice on the appropriate civil, revenue or regulatory forum where necessary.', 4),
(91, 18, 'Consider litigation or other relief only after checking jurisdiction, limitation and the evidence supporting the claim.', 5),
(92, 19, 'Preserve the tenancy agreement, rent/deposit records, notices, photographs and communications.', 1),
(93, 19, 'Record the dates of possession, payments, notices, repairs or alleged interference.', 2),
(94, 19, 'Check which state tenancy law and contractual terms apply to the premises.', 3),
(95, 19, 'Send a clear written communication documenting the dispute and requested resolution.', 4),
(96, 19, 'Consider the appropriate rent authority, civil court or other remedy after verifying the local procedure.', 5),
(97, 20, 'Preserve the tenancy agreement, rent/deposit records, notices, photographs and communications.', 1),
(98, 20, 'Record the dates of possession, payments, notices, repairs or alleged interference.', 2),
(99, 20, 'Check which state tenancy law and contractual terms apply to the premises.', 3),
(100, 20, 'Send a clear written communication documenting the dispute and requested resolution.', 4),
(101, 21, 'Preserve the tenancy agreement, rent/deposit records, notices, photographs and communications.', 1),
(102, 21, 'Record the dates of possession, payments, notices, repairs or alleged interference.', 2),
(103, 21, 'Check which state tenancy law and contractual terms apply to the premises.', 3),
(104, 21, 'Send a clear written communication documenting the dispute and requested resolution.', 4),
(105, 22, 'Preserve the tenancy agreement, rent/deposit records, notices, photographs and communications.', 1),
(106, 22, 'Record the dates of possession, payments, notices, repairs or alleged interference.', 2),
(107, 22, 'Check which state tenancy law and contractual terms apply to the premises.', 3),
(108, 22, 'Send a clear written communication documenting the dispute and requested resolution.', 4),
(109, 23, 'Preserve the tenancy agreement, rent/deposit records, notices, photographs and communications.', 1),
(110, 23, 'Record the dates of possession, payments, notices, repairs or alleged interference.', 2),
(111, 23, 'Check which state tenancy law and contractual terms apply to the premises.', 3),
(112, 23, 'Send a clear written communication documenting the dispute and requested resolution.', 4),
(113, 24, 'Preserve relevant marriage, child, financial, medical and communication records as applicable.', 1),
(114, 24, 'Prepare an accurate chronology of the relationship, separation, dispute or alleged conduct.', 2),
(115, 24, 'Identify the personal law and court jurisdiction applicable to the parties.', 3),
(116, 24, 'Consider consensual settlement or the appropriate family-law proceeding where suitable.', 4),
(117, 24, 'For safety-related matters, address immediate safety first and obtain qualified legal assistance for urgent court relief.', 5),
(118, 25, 'Preserve relevant marriage, child, financial, medical and communication records as applicable.', 1),
(119, 25, 'Prepare an accurate chronology of the relationship, separation, dispute or alleged conduct.', 2),
(120, 25, 'Identify the personal law and court jurisdiction applicable to the parties.', 3),
(121, 25, 'Consider consensual settlement or the appropriate family-law proceeding where suitable.', 4),
(122, 25, 'For safety-related matters, address immediate safety first and obtain qualified legal assistance for urgent court relief.', 5),
(123, 26, 'Preserve relevant marriage, child, financial, medical and communication records as applicable.', 1),
(124, 26, 'Prepare an accurate chronology of the relationship, separation, dispute or alleged conduct.', 2),
(125, 26, 'Identify the personal law and court jurisdiction applicable to the parties.', 3),
(126, 26, 'Consider consensual settlement or the appropriate family-law proceeding where suitable.', 4),
(127, 27, 'Preserve relevant marriage, child, financial, medical and communication records as applicable.', 1),
(128, 27, 'Prepare an accurate chronology of the relationship, separation, dispute or alleged conduct.', 2),
(129, 27, 'Identify the personal law and court jurisdiction applicable to the parties.', 3),
(130, 27, 'Consider consensual settlement or the appropriate family-law proceeding where suitable.', 4),
(131, 28, 'Preserve relevant marriage, child, financial, medical and communication records as applicable.', 1),
(132, 28, 'Prepare an accurate chronology of the relationship, separation, dispute or alleged conduct.', 2),
(133, 28, 'Identify the personal law and court jurisdiction applicable to the parties.', 3),
(134, 28, 'Consider consensual settlement or the appropriate family-law proceeding where suitable.', 4),
(135, 28, 'For safety-related matters, address immediate safety first and obtain qualified legal assistance for urgent court relief.', 5),
(136, 29, 'Preserve screenshots, URLs, account details, transaction IDs, messages and original digital evidence.', 1),
(137, 29, 'Secure affected accounts and financial instruments using the relevant provider\'s official channels where applicable.', 2),
(138, 29, 'Record the date, time, amount and sequence of the incident accurately.', 3),
(139, 29, 'Use the appropriate official cybercrime, bank, platform or regulatory reporting channel after verifying the incident type.', 4),
(140, 29, 'If the conduct may constitute an offence, consider a police/cybercrime complaint and obtain professional advice where necessary.', 5),
(141, 30, 'Preserve screenshots, URLs, account details, transaction IDs, messages and original digital evidence.', 1),
(142, 30, 'Secure affected accounts and financial instruments using the relevant provider\'s official channels where applicable.', 2),
(143, 30, 'Record the date, time, amount and sequence of the incident accurately.', 3),
(144, 30, 'Use the appropriate official cybercrime, bank, platform or regulatory reporting channel after verifying the incident type.', 4),
(145, 30, 'If the conduct may constitute an offence, consider a police/cybercrime complaint and obtain professional advice where necessary.', 5),
(146, 31, 'Preserve screenshots, URLs, account details, transaction IDs, messages and original digital evidence.', 1),
(147, 31, 'Secure affected accounts and financial instruments using the relevant provider\'s official channels where applicable.', 2),
(148, 31, 'Record the date, time, amount and sequence of the incident accurately.', 3),
(149, 31, 'Use the appropriate official cybercrime, bank, platform or regulatory reporting channel after verifying the incident type.', 4),
(150, 32, 'Preserve screenshots, URLs, account details, transaction IDs, messages and original digital evidence.', 1),
(151, 32, 'Secure affected accounts and financial instruments using the relevant provider\'s official channels where applicable.', 2),
(152, 32, 'Record the date, time, amount and sequence of the incident accurately.', 3),
(153, 32, 'Use the appropriate official cybercrime, bank, platform or regulatory reporting channel after verifying the incident type.', 4),
(154, 32, 'If the conduct may constitute an offence, consider a police/cybercrime complaint and obtain professional advice where necessary.', 5),
(155, 33, 'Preserve screenshots, URLs, account details, transaction IDs, messages and original digital evidence.', 1),
(156, 33, 'Secure affected accounts and financial instruments using the relevant provider\'s official channels where applicable.', 2),
(157, 33, 'Record the date, time, amount and sequence of the incident accurately.', 3),
(158, 33, 'Use the appropriate official cybercrime, bank, platform or regulatory reporting channel after verifying the incident type.', 4),
(159, 34, 'Preserve screenshots, URLs, account details, transaction IDs, messages and original digital evidence.', 1),
(160, 34, 'Secure affected accounts and financial instruments using the relevant provider\'s official channels where applicable.', 2),
(161, 34, 'Record the date, time, amount and sequence of the incident accurately.', 3),
(162, 34, 'Use the appropriate official cybercrime, bank, platform or regulatory reporting channel after verifying the incident type.', 4),
(163, 35, 'Preserve relevant messages, documents, photographs, recordings and other original evidence.', 1),
(164, 35, 'Prepare a factual chronology identifying what happened, when, where and who was involved.', 2),
(165, 35, 'Identify the current criminal-law provisions and procedural forum applicable to the alleged conduct.', 3),
(166, 35, 'Use the appropriate police, prosecution or court process after verifying jurisdiction and the nature of the offence.', 4),
(167, 35, 'For arrest, violence or immediate safety concerns, obtain qualified criminal-law assistance promptly.', 5),
(168, 36, 'Preserve relevant messages, documents, photographs, recordings and other original evidence.', 1),
(169, 36, 'Prepare a factual chronology identifying what happened, when, where and who was involved.', 2),
(170, 36, 'Identify the current criminal-law provisions and procedural forum applicable to the alleged conduct.', 3),
(171, 36, 'Use the appropriate police, prosecution or court process after verifying jurisdiction and the nature of the offence.', 4),
(172, 36, 'For arrest, violence or immediate safety concerns, obtain qualified criminal-law assistance promptly.', 5),
(173, 37, 'Preserve relevant messages, documents, photographs, recordings and other original evidence.', 1),
(174, 37, 'Prepare a factual chronology identifying what happened, when, where and who was involved.', 2),
(175, 37, 'Identify the current criminal-law provisions and procedural forum applicable to the alleged conduct.', 3),
(176, 37, 'Use the appropriate police, prosecution or court process after verifying jurisdiction and the nature of the offence.', 4),
(177, 38, 'Preserve relevant messages, documents, photographs, recordings and other original evidence.', 1),
(178, 38, 'Prepare a factual chronology identifying what happened, when, where and who was involved.', 2),
(179, 38, 'Identify the current criminal-law provisions and procedural forum applicable to the alleged conduct.', 3),
(180, 38, 'Use the appropriate police, prosecution or court process after verifying jurisdiction and the nature of the offence.', 4),
(181, 39, 'Preserve contracts, receipts, acknowledgments, notices, messages and other evidence of the claim or dispute.', 1),
(182, 39, 'Calculate the amount or relief claimed from the underlying documents rather than assumptions.', 2),
(183, 39, 'Check the applicable limitation period and jurisdiction before starting proceedings.', 3),
(184, 39, 'Consider negotiation or a formal demand where appropriate, without assuming a notice is legally mandatory.', 4),
(185, 39, 'Select a civil procedure only after confirming that the claim qualifies for that procedure.', 5),
(186, 40, 'Preserve contracts, receipts, acknowledgments, notices, messages and other evidence of the claim or dispute.', 1),
(187, 40, 'Calculate the amount or relief claimed from the underlying documents rather than assumptions.', 2),
(188, 40, 'Check the applicable limitation period and jurisdiction before starting proceedings.', 3),
(189, 40, 'Consider negotiation or a formal demand where appropriate, without assuming a notice is legally mandatory.', 4),
(190, 41, 'Preserve contracts, receipts, acknowledgments, notices, messages and other evidence of the claim or dispute.', 1),
(191, 41, 'Calculate the amount or relief claimed from the underlying documents rather than assumptions.', 2),
(192, 41, 'Check the applicable limitation period and jurisdiction before starting proceedings.', 3),
(193, 41, 'Consider negotiation or a formal demand where appropriate, without assuming a notice is legally mandatory.', 4),
(194, 42, 'Collect the signed contract, amendments, invoices, correspondence and evidence of performance or breach.', 1),
(195, 42, 'Identify the exact contractual obligation allegedly breached and the relevant dates.', 2),
(196, 42, 'Assess the loss actually supported by evidence and any contractual limitation or remedy clause.', 3),
(197, 42, 'Send a written request or default notice where useful, subject to the contract and applicable law.', 4),
(198, 43, 'Collect the signed contract, amendments, invoices, correspondence and evidence of performance or breach.', 1),
(199, 43, 'Identify the exact contractual obligation allegedly breached and the relevant dates.', 2),
(200, 43, 'Assess the loss actually supported by evidence and any contractual limitation or remedy clause.', 3),
(201, 43, 'Send a written request or default notice where useful, subject to the contract and applicable law.', 4),
(202, 44, 'Collect the signed contract, amendments, invoices, correspondence and evidence of performance or breach.', 1),
(203, 44, 'Identify the exact contractual obligation allegedly breached and the relevant dates.', 2),
(204, 44, 'Assess the loss actually supported by evidence and any contractual limitation or remedy clause.', 3),
(205, 44, 'Send a written request or default notice where useful, subject to the contract and applicable law.', 4),
(206, 45, 'Collect the signed contract, amendments, invoices, correspondence and evidence of performance or breach.', 1),
(207, 45, 'Identify the exact contractual obligation allegedly breached and the relevant dates.', 2),
(208, 45, 'Assess the loss actually supported by evidence and any contractual limitation or remedy clause.', 3),
(209, 46, 'Preserve statements, loan/credit documents, notices, payment records and communications with the lender or bureau.', 1),
(210, 46, 'Record the disputed transaction, amount and dates accurately.', 2),
(211, 46, 'Use the lender, credit-bureau or regulated-entity grievance channel applicable to the dispute.', 3),
(212, 46, 'Check the current RBI directions and applicable statutory procedure before asserting a deadline or compensation amount.', 4),
(213, 46, 'Escalate to the appropriate regulator, ombudsman or court only after confirming eligibility and the applicable process.', 5),
(214, 47, 'Preserve statements, loan/credit documents, notices, payment records and communications with the lender or bureau.', 1),
(215, 47, 'Record the disputed transaction, amount and dates accurately.', 2),
(216, 47, 'Use the lender, credit-bureau or regulated-entity grievance channel applicable to the dispute.', 3),
(217, 47, 'Check the current RBI directions and applicable statutory procedure before asserting a deadline or compensation amount.', 4),
(218, 47, 'Escalate to the appropriate regulator, ombudsman or court only after confirming eligibility and the applicable process.', 5),
(219, 48, 'Preserve statements, loan/credit documents, notices, payment records and communications with the lender or bureau.', 1),
(220, 48, 'Record the disputed transaction, amount and dates accurately.', 2),
(221, 48, 'Use the lender, credit-bureau or regulated-entity grievance channel applicable to the dispute.', 3),
(222, 48, 'Check the current RBI directions and applicable statutory procedure before asserting a deadline or compensation amount.', 4),
(223, 49, 'Preserve the policy, proposal/renewal records, claim form, medical or accident records and insurer communications.', 1),
(224, 49, 'Identify the exact reason given for repudiation, delay or deduction.', 2),
(225, 49, 'Check the policy wording and the IRDAI rules applicable to the policy and claim date.', 3),
(226, 49, 'Use the insurer\'s grievance process and the appropriate regulatory/ombudsman route where available.', 4),
(227, 49, 'Consider a consumer or other legal remedy after confirming jurisdiction, limitation and the relief available.', 5),
(228, 50, 'Preserve the policy, proposal/renewal records, claim form, medical or accident records and insurer communications.', 1),
(229, 50, 'Identify the exact reason given for repudiation, delay or deduction.', 2),
(230, 50, 'Check the policy wording and the IRDAI rules applicable to the policy and claim date.', 3),
(231, 50, 'Use the insurer\'s grievance process and the appropriate regulatory/ombudsman route where available.', 4),
(232, 51, 'Preserve the policy, proposal/renewal records, claim form, medical or accident records and insurer communications.', 1),
(233, 51, 'Identify the exact reason given for repudiation, delay or deduction.', 2),
(234, 51, 'Check the policy wording and the IRDAI rules applicable to the policy and claim date.', 3),
(235, 52, 'Preserve the FIR or accident record, photographs, medical records, vehicle documents and insurance correspondence where applicable.', 1),
(236, 52, 'Record the accident date, location, parties, injuries and claim details accurately.', 2),
(237, 52, 'Identify the applicable Motor Vehicles Act route, insurer process and tribunal/court jurisdiction.', 3),
(238, 52, 'Submit the required claim or challenge through the applicable official process after verifying the current procedure.', 4),
(239, 52, 'Obtain professional advice where liability, serious injury/death or substantial compensation is disputed.', 5),
(240, 53, 'Preserve the FIR or accident record, photographs, medical records, vehicle documents and insurance correspondence where applicable.', 1),
(241, 53, 'Record the accident date, location, parties, injuries and claim details accurately.', 2),
(242, 53, 'Identify the applicable Motor Vehicles Act route, insurer process and tribunal/court jurisdiction.', 3),
(243, 53, 'Submit the required claim or challenge through the applicable official process after verifying the current procedure.', 4),
(244, 54, 'Preserve the FIR or accident record, photographs, medical records, vehicle documents and insurance correspondence where applicable.', 1),
(245, 54, 'Record the accident date, location, parties, injuries and claim details accurately.', 2),
(246, 54, 'Identify the applicable Motor Vehicles Act route, insurer process and tribunal/court jurisdiction.', 3),
(247, 54, 'Submit the required claim or challenge through the applicable official process after verifying the current procedure.', 4),
(248, 55, 'Preserve the original work, registration details where any, creation records and evidence of the alleged infringement.', 1),
(249, 55, 'Capture the infringing material, URL, dates and relevant commercial context without altering the original evidence.', 2),
(250, 55, 'Verify ownership, licensing and the exact right allegedly infringed.', 3),
(251, 55, 'Consider a platform complaint, demand letter, mediation or legal proceeding depending on the right involved.', 4),
(252, 55, 'Confirm jurisdiction and available civil/criminal remedies before filing.', 5),
(253, 56, 'Preserve the original work, registration details where any, creation records and evidence of the alleged infringement.', 1),
(254, 56, 'Capture the infringing material, URL, dates and relevant commercial context without altering the original evidence.', 2),
(255, 56, 'Verify ownership, licensing and the exact right allegedly infringed.', 3),
(256, 56, 'Consider a platform complaint, demand letter, mediation or legal proceeding depending on the right involved.', 4),
(257, 57, 'Preserve the original work, registration details where any, creation records and evidence of the alleged infringement.', 1),
(258, 57, 'Capture the infringing material, URL, dates and relevant commercial context without altering the original evidence.', 2),
(259, 57, 'Verify ownership, licensing and the exact right allegedly infringed.', 3),
(260, 57, 'Consider a platform complaint, demand letter, mediation or legal proceeding depending on the right involved.', 4),
(261, 58, 'Preserve copies of the privacy notice, consent screens, messages, URLs and evidence of the data processing or disclosure.', 1),
(262, 58, 'Record what personal data was involved, who processed it and how it was obtained or disclosed.', 2),
(263, 58, 'Check whether the DPDP Act and its rules/commencement provisions apply to the facts.', 3),
(264, 58, 'Use the relevant data-fiduciary grievance mechanism or other official process where applicable.', 4),
(265, 59, 'Preserve copies of the privacy notice, consent screens, messages, URLs and evidence of the data processing or disclosure.', 1),
(266, 59, 'Record what personal data was involved, who processed it and how it was obtained or disclosed.', 2),
(267, 59, 'Check whether the DPDP Act and its rules/commencement provisions apply to the facts.', 3),
(268, 59, 'Use the relevant data-fiduciary grievance mechanism or other official process where applicable.', 4),
(269, 60, 'Preserve admission records, fee receipts, institutional communications and the relevant academic documents.', 1),
(270, 60, 'Record the institution, course, academic year and dates relevant to the dispute.', 2),
(271, 60, 'Identify the regulator or policy applicable to that institution and course.', 3),
(272, 60, 'Raise the issue through the institution\'s documented grievance process and retain proof.', 4),
(273, 60, 'Consider the regulator, consumer, tribunal or court route only after confirming that forum\'s jurisdiction.', 5),
(274, 61, 'Preserve admission records, fee receipts, institutional communications and the relevant academic documents.', 1),
(275, 61, 'Record the institution, course, academic year and dates relevant to the dispute.', 2),
(276, 61, 'Identify the regulator or policy applicable to that institution and course.', 3),
(277, 61, 'Raise the issue through the institution\'s documented grievance process and retain proof.', 4),
(278, 62, 'Preserve admission records, fee receipts, institutional communications and the relevant academic documents.', 1),
(279, 62, 'Record the institution, course, academic year and dates relevant to the dispute.', 2),
(280, 62, 'Identify the regulator or policy applicable to that institution and course.', 3),
(281, 62, 'Raise the issue through the institution\'s documented grievance process and retain proof.', 4),
(282, 62, 'Consider the regulator, consumer, tribunal or court route only after confirming that forum\'s jurisdiction.', 5);

-- --------------------------------------------------------

--
-- Table structure for table `legal_cases`
--

CREATE TABLE `legal_cases` (
  `case_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `case_title` varchar(255) NOT NULL,
  `situation` text NOT NULL,
  `explanation` text NOT NULL,
  `urgency` enum('Low','Normal','High','Emergency') DEFAULT 'Normal',
  `jurisdiction` varchar(100) DEFAULT 'India'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_cases`
--

INSERT INTO `legal_cases` (`case_id`, `topic_id`, `case_title`, `situation`, `explanation`, `urgency`, `jurisdiction`) VALUES
(1, 1, 'Defective product received', 'I purchased a product and it arrived broken, damaged, or defective, and the seller or manufacturer refuses to resolve it.', 'This issue may fall under the Consumer Protection Act, 2019 and related rules, depending on whether the transaction and parties fall within consumer-law coverage. The available remedies can depend on the nature of the defect, warranty terms, seller/manufacturer role, evidence of the defect, and the relief sought.', 'Normal', 'India'),
(2, 1, 'Seller refuses refund or return', 'The seller refuses to provide a refund or accept return for a cancelled order, non-delivered item, or eligible return.', 'A refund or return dispute depends on the transaction, the contract/return terms, the reason for cancellation or return, and whether consumer-protection or e-commerce rules apply. Lex should verify the applicable rule and the seller\'s obligations before stating that a refund is legally due.', 'Normal', 'India'),
(3, 1, 'Online shopping and e-commerce fraud', 'I paid for goods on an online shopping portal or social media page, but the items never arrived and the seller is unreachable.', 'An online purchase where goods are not delivered can involve consumer remedies and, where the facts support dishonest conduct, criminal or cyber-law issues. The correct route depends on the payment method, seller identity, communications, transaction evidence, and whether there is evidence of deception from the outset.', 'High', 'India'),
(4, 1, 'Product warranty denied by manufacturer', 'The authorized service center or manufacturer is refusing to honor the active warranty on my product.', 'A warranty dispute depends on the written warranty terms, the product, the defect, exclusions, and what the service centre or manufacturer has actually refused to do. Consumer-protection remedies may be available where the facts establish a deficiency or other actionable conduct.', 'Normal', 'India'),
(5, 1, 'Deficiency in service', 'I paid for a professional service (flight, hotel, transport, salon, repairs) but the service was substandard, delayed, or not provided.', 'A service dispute may fall within consumer-protection law where the claimant qualifies as a consumer and the service falls within the Act. The available relief depends on the service contract, the nature of the deficiency, evidence of loss, and applicable exclusions.', 'Normal', 'India'),
(6, 1, 'Overcharging beyond MRP', 'A retailer or restaurant charged a price higher than the Maximum Retail Price (MRP) printed on packaged goods.', 'Price and MRP disputes can involve the Legal Metrology Act, 2009 and applicable packaged-commodity rules, but the exact rule depends on the product and the transaction. The bill, package label, quantity, place of sale and seller conduct should be verified before a legal conclusion is made.', 'Low', 'India'),
(7, 1, 'False and misleading advertising', 'A product or service did not deliver what was promised in commercial advertisements, leading to financial loss.', 'Misleading advertising may engage the Consumer Protection Act, 2019 and other sector-specific rules. Whether conduct is legally actionable depends on the exact representation, whether it is misleading, the product or service involved, and the evidence available.', 'Normal', 'India'),
(8, 2, 'Unpaid salary and withheld wages', 'My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.', 'The Code on Wages, 2019 contains provisions governing payment of wages. For monthly wage periods, Section 17 provides a statutory payment timeline, subject to the Code\'s applicability. Section 45 provides a claim mechanism for amounts due. The appropriate authority, employee coverage and available relief depend on the facts and applicable establishment/government.', 'High', 'India'),
(9, 2, 'Wrongful termination and illegal firing', 'I was terminated from my employment abruptly without contractual notice, retrenchment compensation, or fair inquiry.', 'Termination disputes are fact-sensitive. The applicable rules can depend on the employee\'s status, establishment, contract, reason for termination, length of service, and whether retrenchment or another statutory regime applies. The Industrial Relations Code, 2020 and applicable state laws should be checked for the relevant facts and commencement status.', 'High', 'India'),
(10, 2, 'Workplace sexual harassment (POSH)', 'I am facing sexual harassment, unwelcome conduct, or a hostile work environment at my workplace.', 'The Sexual Harassment of Women at Workplace Act, 2013 provides a framework for prevention and redressal of sexual harassment of women at workplaces. The applicable internal or local complaints mechanism depends on the workplace and statutory conditions. Lex should not infer harassment or the outcome of a complaint without the relevant facts.', 'Emergency', 'India'),
(11, 2, 'Withholding of PF or Gratuity dues', 'My employer refused to release my Provident Fund (PF), update UAN exit date, or pay statutory Gratuity after resignation.', 'PF and gratuity are governed by separate statutory frameworks and their applicability depends on the establishment, employee, service history and the nature of the amount claimed. PF administration may involve EPFO processes, while gratuity claims can involve the applicable gratuity authority. Exact eligibility, interest and procedure must be verified from the current law and facts.', 'Normal', 'India'),
(12, 2, 'Termination without notice or notice pay', 'I was fired on the spot without the 30/60/90 days contractual notice period or salary in lieu of notice.', 'Notice or notice-pay disputes generally depend first on the employment contract and the statutory rules applicable to the employee and establishment. Immediate termination does not automatically produce the same remedy in every employment relationship; the contract, employee category, reason for termination and applicable labour law must be checked.', 'High', 'India'),
(13, 2, 'Unpaid overtime wages', 'My employer forces me to work beyond statutory working hours without providing overtime pay.', 'Overtime entitlement depends on the employee\'s coverage and the law applicable to the establishment, including the relevant occupational or state employment rules. Lex should verify working hours, employee category, establishment type and the applicable overtime provision before stating a rate or amount.', 'Normal', 'India'),
(14, 3, 'Property ownership and title dispute', 'Someone is disputing my ownership of my land or apartment, or claiming rights through forged documents.', 'A property title dispute can involve registration records, title documents, succession, conveyances and civil remedies. A registered document is important evidence but does not by itself resolve every competing title issue. The chain of title, encumbrances, possession and alleged forgery must be examined before selecting a remedy.', 'High', 'India'),
(15, 3, 'Builder delay in flat possession (RERA)', 'The builder/developer failed to hand over flat possession within the promised date mentioned in the agreement.', 'Section 18 of the Real Estate (Regulation and Development) Act, 2016 addresses certain consequences of delay in possession, subject to its applicability and the agreement and project facts. The buyer\'s options can differ depending on whether the buyer seeks to continue with the project or withdraw and on the applicable regulatory framework.', 'High', 'India'),
(16, 3, 'Illegal encroachment on land or property', 'A neighbor or third party has illegally built a structure or encroached across my property boundary.', 'A property encroachment dispute can involve boundary records, survey/demarcation, title and possession questions and, in some cases, civil or criminal issues. The appropriate authority and remedy depend on the land records, nature of the encroachment and evidence of ownership or possession.', 'High', 'India'),
(17, 3, 'Ancestral property inheritance dispute', 'Family members are denying my rightful legal share in ancestral land or family property.', 'Inheritance and coparcenary rights depend on the applicable personal law, the nature and history of the property, the date and manner of succession, and the family relationships. The Hindu Succession Act, 1956 may apply in relevant Hindu succession matters, but Lex should not assume that every family property is ancestral/coparcenary property.', 'High', 'India'),
(18, 3, 'Lost or missing original property documents', 'I have lost my original registered sale deed or property title documents and need duplicates.', 'Lost property documents require verification of what document was lost, where it was registered, whether a copy is available, and whether the loss raises any fraud or title concern. Certified copies or registration records may be available through the relevant registration authority; police or public-notice steps depend on the circumstances and local requirements.', 'Normal', 'India'),
(19, 4, 'Security deposit not returned by landlord', 'My landlord refuses to return my security deposit after vacating the flat peacefully.', 'Security-deposit disputes are primarily fact- and contract-dependent and may also be governed by applicable state tenancy law. The lease, deposit amount, agreed deductions, condition of the premises, handover evidence and any applicable local tenancy statute should be reviewed before stating that a particular amount or interest is legally due.', 'Normal', 'India'),
(20, 4, 'Threat of illegal eviction or locked out', 'My landlord is threatening to forcefully throw my belongings out or disconnect electricity and water.', 'Forced dispossession and interference with essential services can raise tenancy, civil and sometimes criminal issues. The applicable protection depends on the tenancy arrangement and state law. Lex should distinguish a threat, an actual lockout, utility disconnection and a formal eviction proceeding rather than assuming one remedy applies to all cases.', 'High', 'India'),
(21, 4, 'Landlord refusing essential repairs', 'My landlord refuses to fix structural damages, severe plumbing leaks, or electrical hazards.', 'Repair obligations depend on the tenancy agreement and applicable state tenancy law. The type and urgency of the repair, prior notice to the landlord, safety implications and any statutory tenant remedies should be established before recommending self-repair or rent deduction.', 'Normal', 'India'),
(22, 4, 'Arbitrary and excessive rent increase', 'My landlord is demanding an unjustified and steep rent hike in the middle of an active lease agreement.', 'Rent increases depend on the lease terms and applicable state tenancy law. A fixed percentage such as 5% or 10% should not be assumed unless the contract or applicable law actually provides it. Lex should ask whether the lease is still within its term, whether an escalation clause exists and which state law applies.', 'Normal', 'India'),
(23, 4, 'Tenant refusing to vacate after lease expiry', 'My tenant refuses to vacate the rented property after the lease agreement has expired and notice was served.', 'After a tenancy ends, the landlord\'s rights and procedure depend on the lease, notice requirements and applicable state law. Section 106 of the Transfer of Property Act may be relevant to certain leases, but state rent-control legislation can alter the procedure. The property, tenancy type and notice history should be checked first.', 'High', 'India'),
(24, 5, 'Mutual consent divorce procedure', 'Both husband and wife agree to separate peacefully and settle alimony, assets, and child custody mutually.', 'Mutual-consent divorce is governed by the personal statute applicable to the marriage. For marriages covered by the Hindu Marriage Act, 1955, Section 13B provides the statutory framework; other marriages may be governed by different law. Court procedure, settlement terms and timing depend on the facts and applicable court.', 'Normal', 'India'),
(25, 5, 'Contested divorce on grounds of cruelty or desertion', 'I need a divorce due to physical/mental cruelty, desertion, or adultery, but my spouse refuses to agree.', 'A contested divorce depends on the personal law governing the marriage and the pleaded ground. Cruelty, desertion and other grounds have specific statutory requirements; for example, desertion has a statutory period under the Hindu Marriage Act. Lex should identify the applicable personal law and facts before stating that a ground is established.', 'High', 'India'),
(26, 5, 'Child custody and visitation rights dispute', 'Separated parents disputing custody, care, and visitation access of their minor children.', 'Custody and visitation decisions are fact-specific and are governed by the applicable guardianship/family-law framework. The child\'s welfare is a central consideration, but the exact orders and parental rights depend on the child\'s circumstances, existing orders and applicable law.', 'High', 'India'),
(27, 5, 'Maintenance and alimony claim', 'A dependent spouse or child seeking monthly financial support and maintenance from the earning spouse.', 'Maintenance can arise under different statutes depending on the relationship and applicable personal law. Since criminal-procedure terminology changed with the BNSS, 2023, Lex should use the current provision applicable to the case rather than automatically quoting old CrPC section numbers. Income, needs, existing orders and other relevant facts affect the result.', 'Normal', 'India'),
(28, 5, 'Domestic violence protection and residence order', 'A woman experiencing domestic abuse, harassment, or threats from spouse or in-laws in a shared household.', 'The Protection of Women from Domestic Violence Act, 2005 provides statutory remedies including protection, residence and monetary relief in qualifying cases. The exact relief depends on the facts, relationship, shared-household circumstances and evidence. Immediate safety concerns should be addressed separately from the legal merits.', 'Emergency', 'India'),
(29, 6, 'Online banking, UPI, and phishing fraud', 'Money was debited fraudulently from my bank account via phishing links, fake customer care, or UPI scams.', 'Online banking, UPI and phishing incidents can involve banking rules, payment-system procedures, the Information Technology Act, 2000 and criminal law depending on the facts. Prompt reporting can be important, but Lex should not promise fund freezing or zero liability because those outcomes depend on the transaction, reporting, bank rules and applicable RBI framework.', 'Emergency', 'India'),
(30, 6, 'Social media account hacked or hijacked', 'Someone hacked my Instagram, Facebook, WhatsApp, or email account and changed recovery credentials.', 'Unauthorized access to an account can involve the Information Technology Act, 2000, platform procedures and, depending on the conduct, other criminal provisions. Recovery of an account is primarily platform-specific, while criminal or civil remedies depend on evidence of unauthorized access and resulting harm.', 'High', 'India'),
(31, 6, 'Online impersonation and fake profiles', 'Someone created a fake profile using my name, photos, and identity to defame me or scam contacts.', 'Online impersonation can involve the Information Technology Act, 2000 and current criminal law where the facts establish personation, cheating, threats or other offences. Platform removal procedures and timelines depend on the content and the applicable intermediary rules; Lex should not promise a fixed takedown period without checking the current rule.', 'High', 'India'),
(32, 6, 'Cyber extortion, blackmail, and sextortion', 'Receiving threatening messages, blackmail, or sextortion demands demanding money online.', 'Cyber blackmail or sextortion can involve criminal law and the Information Technology Act, 2000 depending on the conduct and content. The exact offence should not be selected from the label alone. Preserve messages, payment requests and account details, and address immediate safety risks before choosing a legal route.', 'Emergency', 'India'),
(33, 6, 'Personal data leak and doxxing', 'My private phone number, home address, photos, or confidential documents were published online without consent.', 'Publication of private personal information can involve privacy, cyber, criminal and data-protection issues depending on the information, how it was obtained, who published it and the applicable law. The Digital Personal Data Protection Act, 2023 should not be treated as automatically applicable to every online disclosure.', 'High', 'India'),
(34, 6, 'Deepfake and non-consensual synthetic media', 'Morphed or AI-generated deepfake photos or videos using my face are being circulated online.', 'Deepfake and non-consensual synthetic-media disputes can involve the Information Technology Act, 2000, current criminal law, intermediary rules and privacy-related remedies depending on the content. The exact provisions depend on whether the material is intimate, defamatory, impersonating, threatening or otherwise unlawful.', 'Emergency', 'India'),
(35, 7, 'Police refusal to register FIR', 'The local police station refuses to file or register an FIR for a cognizable crime like theft, assault, or fraud.', 'Police registration of information is governed by the current criminal-procedure law. For a cognizable offence, the applicable BNSS provisions and relevant Supreme Court principles may provide routes for escalation, but the exact procedure depends on the complaint, jurisdiction and nature of the offence. Lex should not guarantee that an FIR must be registered without examining those facts.', 'High', 'India'),
(36, 7, 'Bail application (Anticipatory and Regular)', 'I am apprehending arrest or a family member has been arrested in a non-bailable criminal matter.', 'Bail is governed by the current criminal-procedure framework, including BNSS provisions applicable to regular and anticipatory bail. The correct provision and court depend on the offence, arrest status, jurisdiction and case facts. Bail is discretionary and subject to statutory conditions and judicial assessment.', 'High', 'India'),
(37, 7, 'Cheating and criminal breach of trust', 'I was deceived by an individual or business into transferring funds or property based on fraudulent promises.', 'Cheating and criminal breach of trust are distinct offences with different elements under current criminal law. A failed transaction or unpaid debt does not by itself establish either offence. Lex should identify the alleged dishonest intention, entrustment, conduct and evidence before suggesting criminal proceedings.', 'High', 'India'),
(38, 7, 'Criminal and civil defamation', 'Someone published or spoke false, malicious statements that severely damaged my personal or professional reputation.', 'Defamation can have criminal and civil dimensions, but the elements, defences and procedure must be assessed from the exact publication or statement. Current criminal-law provisions should be used rather than automatically relying on the repealed IPC sections. Civil remedies and available relief depend on the facts and jurisdiction.', 'Normal', 'India'),
(39, 8, 'Recovery of money and Summary Suit', 'I lent money or supplied goods with written proof, but the debtor refuses to repay the outstanding debt.', 'Money-recovery disputes can be contractual or otherwise civil in nature. Order XXXVII of the Code of Civil Procedure provides a summary procedure for specified claims, but it is not available for every debt. The underlying document, cause of action, limitation, jurisdiction and type of claim must be checked before selecting a summary suit.', 'High', 'India'),
(40, 8, 'Temporary injunction and stay order', 'Facing an imminent threat of illegal demolition, dispossession, or property sale requiring an immediate stay order.', 'Interim injunctions are discretionary court remedies. Order XXXIX of the Code of Civil Procedure and the Specific Relief Act may be relevant depending on the dispute. Courts consider the applicable legal tests and facts; an interim stay or ex-parte order is not automatic.', 'High', 'India'),
(41, 8, 'Neighbor nuisance and noise dispute', 'Persistent loud noise, structural hazards, or blocked common passage caused by an uncooperative neighbor.', 'Neighbour nuisance disputes may involve private-law remedies, local municipal rules and, where a public nuisance is established, the applicable criminal-procedure provisions. The correct route depends on the nature of the nuisance, evidence, location and whether the issue is private or affects the public.', 'Normal', 'India'),
(42, 9, 'Breach of contract and compensation for loss', 'The other contracting party failed to perform their contractual commitments, causing severe financial loss.', 'A contractual breach may give rise to damages or other contractual remedies. Sections 73 and 74 of the Indian Contract Act, 1872 can be relevant, but recoverable loss and agreed sums depend on the contract, causation, proof and applicable legal limits. Compensation is not automatically equal to every claimed loss.', 'High', 'India'),
(43, 9, 'Unpaid B2B invoices and MSME payment default', 'A client or corporate buyer has defaulted on paying invoices for supplied goods or rendered services.', 'MSME payment disputes can be governed by Sections 15 and 16 of the MSMED Act, 2006 where the supplier and transaction satisfy the Act. The statutory payment period and interest rules depend on the Act and the facts. Eligibility for the Facilitation Council/Samadhaan process should be verified before advising a particular route.', 'High', 'India'),
(44, 9, 'Breach of Non-Disclosure Agreement (NDA)', 'An ex-employee, partner, or contractor leaked proprietary business trade secrets or confidential data.', 'An NDA dispute is primarily fact- and contract-dependent. The enforceability of particular confidentiality obligations and available injunction or damages remedies depend on the contract, the information involved, applicable law and evidence of disclosure or threatened disclosure.', 'High', 'India'),
(45, 9, 'Verbal agreement and informal contract dispute', 'We entered into a verbal business agreement and the counterparty now denies the agreed terms.', 'Oral agreements can be legally relevant, but enforceability depends on the nature of the agreement, applicable formalities, certainty of terms and proof. Section 10 of the Indian Contract Act is not a blanket rule that every verbal arrangement is enforceable; some transactions require writing or registration under other laws.', 'Normal', 'India'),
(46, 10, 'Cheque bounce (Section 138 NI Act)', 'A bank cheque issued to me was dishonored due to insufficient funds or account closed.', 'Section 138 of the Negotiable Instruments Act, 1881 creates a specific statutory process for qualifying cheque dishonour cases. The statutory notice, payment period and complaint limitation are procedural requirements that must be calculated from the relevant dates; Lex should ask for the cheque, return memo and notice dates before calculating deadlines.', 'High', 'India'),
(47, 10, 'Loan recovery agent harassment', 'Recovery agents are threatening me or my family, using abusive language, or calling outside permitted hours.', 'Recovery-agent conduct is regulated by applicable RBI directions and, depending on the conduct, other law. The exact rule depends on the lender, type of credit and current RBI framework. Lex should verify the lender category and preserve call records, messages and other evidence rather than applying one universal rule.', 'High', 'India'),
(48, 10, 'CIBIL credit score dispute and errors', 'My credit score was damaged due to incorrect loan default status or delayed reporting by the bank.', 'Credit-information disputes are governed by the Credit Information Companies (Regulation) Act, 2005 and applicable RBI directions. Correction timelines and compensation rules depend on the current regulatory framework and the nature of the error. Lex should identify the bureau, reporting entity, disputed entry and dates before stating a deadline or compensation amount.', 'Normal', 'India'),
(49, 11, 'Health / Mediclaim cashless claim rejected', 'The insurance company rejected hospital cashless authorization or reimbursement citing non-disclosure or PED.', 'Health-insurance claim disputes depend on the policy wording, IRDAI rules, claim documents and the reason for repudiation. The moratorium period and other health-insurance rules must be checked in the version applicable to the policy and claim date; Lex should not automatically apply an eight-year rule.', 'High', 'India'),
(50, 11, 'Life insurance death claim repudiated', 'The insurer refused to pay the death claim benefit of a family member citing alleged pre-existing conditions.', 'Life-insurance claim repudiation is governed by the policy, Insurance Act provisions and applicable IRDAI regulations. Section 45 contains statutory limits on questioning a life policy after the specified period, but its application depends on policy dates and the circumstances of the claim. Lex should verify the policy and claim timeline.', 'High', 'India'),
(51, 11, 'Motor vehicle insurance accident claim dispute', 'The motor insurer rejected my car/bike damage reimbursement citing minor delay in reporting or survey dispute.', 'A motor-insurance claim depends on the policy, the nature of the loss, survey findings, notice requirements and applicable IRDAI rules and case law. A delay in intimation is not automatically fatal or automatically harmless; the facts and policy terms must be examined.', 'Normal', 'India'),
(52, 12, 'Motor vehicle accident and MACT compensation', 'I or a family member was injured or killed in a road accident caused by a rash and negligent driver.', 'Road-accident compensation can involve the Motor Vehicles Act, 1988 and proceedings before the appropriate Motor Accident Claims Tribunal. The available claim, liable parties and compensation depend on the accident, injuries or death, evidence, insurance and applicable statutory route.', 'Emergency', 'India'),
(53, 12, 'Disputed traffic e-challan', 'I was issued an incorrect traffic fine / e-challan with wrong vehicle registration or wrong photo evidence.', 'An incorrect e-challan can generally be challenged through the process applicable to the issuing authority and traffic-court system. The available online route depends on the state, challan system and case status. Lex should ask for the challan details and issuing jurisdiction before giving procedural instructions.', 'Normal', 'India'),
(54, 12, 'Hit and run accident solatium scheme', 'A victim was injured or killed in a hit-and-run road accident where the offending vehicle fled and is untraced.', 'Hit-and-run compensation is governed by the Motor Vehicles Act and the applicable central scheme/rules in force for the accident. Eligibility and compensation depend on the statutory definition, injury or death, documentation and the current scheme. Lex should verify the accident date and applicable scheme before quoting an amount.', 'High', 'India'),
(55, 13, 'Copyright infringement and content piracy', 'Someone copied and republished my original article, software code, artwork, video, or music without permission.', 'Copyright disputes are governed principally by the Copyright Act, 1957. Whether a particular use infringes copyright depends on ownership, the protected work, the act complained of, licensing and applicable exceptions. Civil and criminal remedies have different requirements and should not be presented as automatic.', 'High', 'India'),
(56, 13, 'Trademark infringement and brand passing off', 'A competitor business is using a deceptively similar brand name, logo, or packaging to confuse consumers.', 'Trademark infringement and passing off are distinct legal causes. The Trade Marks Act, 1999 governs registered marks and related remedies, while passing off is a separate common-law action. The mark\'s registration status, goods/services, similarity and evidence of confusion should be established before recommending a remedy.', 'High', 'India'),
(57, 13, 'Domain name squatting (Cybersquatting)', 'A third party registered my registered business name as a website domain to sell it back for an extortionate price.', 'Domain-name disputes depend on the domain extension, registration terms and applicable dispute-resolution policy. .IN domains and other generic domains can follow different procedures. Lex should identify the domain extension and complainant\'s rights before selecting an INDRP or UDRP route.', 'Normal', 'India'),
(58, 14, 'Violation of Digital Personal Data Protection (DPDP Act)', 'A company or mobile app collected and shared my personal sensitive data without valid consent.', 'The Digital Personal Data Protection Act, 2023 regulates processing of digital personal data within its scope. Applicability, consent, legitimate uses, obligations and penalties depend on the Act and the rules/commencement applicable at the relevant time. Lex should not assume that every privacy complaint falls under the DPDP Act.', 'Normal', 'India'),
(59, 14, 'Right to be Forgotten and online search delisting', 'Outdated or expunged criminal records and acquitted matters are showing up in search results harming reputation.', 'A request to remove or delist information from search results is fact-sensitive. Privacy, reputation, data-protection, intermediary and constitutional principles may be relevant, but there is no single automatic \'right to be forgotten\' remedy for every search result. The content, source, legal status and jurisdiction must be examined.', 'Normal', 'India'),
(60, 15, 'College or coaching institute fee refund refusal', 'I cancelled my admission or left a coaching institute, but they refuse to refund advance fees.', 'Fee-refund disputes depend on the institution, course, admission year, governing regulator and the applicable fee-refund policy. UGC or other regulator rules may apply to particular institutions, but a universal 100% refund rule should not be assumed without checking the applicable policy and facts.', 'Normal', 'India'),
(61, 15, 'Withholding of degree or transfer certificate', 'A college or school is refusing to release my original marksheets, degree, or TC over disputed fees or arbitrary reasons.', 'Withholding educational certificates can involve education regulations, contract/fee disputes and public-law remedies depending on the institution. The exact institution, document, reason for withholding and applicable regulator should be established before stating that retention is unlawful or recommending a writ.', 'High', 'India'),
(62, 15, 'Ragging and bullying in educational institution', 'A student is facing physical, verbal, or mental ragging and harassment inside the college campus or hostel.', 'Ragging is prohibited under the UGC framework and can also involve current criminal law. The applicable institutional and reporting process depends on the facts and institution. Lex should distinguish ragging from ordinary disciplinary disputes and should prioritise immediate safety where there is a risk of harm.', 'Emergency', 'India');

-- --------------------------------------------------------

--
-- Table structure for table `legal_documents`
--

CREATE TABLE `legal_documents` (
  `document_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `required_level` enum('Essential','Recommended','Optional') DEFAULT 'Recommended',
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_documents`
--

INSERT INTO `legal_documents` (`document_id`, `case_id`, `document_name`, `required_level`, `description`) VALUES
(1, 1, 'Tax Invoice / Retail Bill', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(2, 1, 'Payment Receipt / Bank Statement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(3, 1, 'Photographs & Unboxing Video of Defect', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(4, 1, 'Warranty Card / Manual', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(5, 1, 'Written Communication / Grievance Tickets', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(6, 2, 'Order Confirmation & Invoice', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(7, 2, 'Cancellation / Return Request Screenshot', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(8, 2, 'Merchant Return Policy Copy', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(9, 2, 'Bank Account Debit Statement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(10, 3, 'Bank Account / UPI Transaction Statement with UTR', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(11, 3, 'Product Webpage / Social Media Ad Screenshots', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(12, 3, 'WhatsApp / Chat Conversation Logs', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(13, 3, 'National Cybercrime Portal Acknowledgment', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(14, 4, 'Original Purchase Bill', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(15, 4, 'Original Manufacturer Warranty Card', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(16, 4, 'Service Center Job Sheet / Inspection Report', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(17, 4, 'Email Correspondence with Customer Support', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(18, 5, 'Service Contract / Booking Confirmation Voucher', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(19, 5, 'Payment Receipt / Invoices', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(20, 5, 'Evidence of Substandard Service / Cancellation Proof', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(21, 5, 'Written Notice to Service Provider', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(22, 6, 'Retail Invoice / Merchant Cash Slip', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(23, 6, 'Product Package with Printed MRP', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(24, 6, 'Store Address & GST Details', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(25, 7, 'Copy / Screenshot / Video of Misleading Advertisement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(26, 7, 'Purchase Bill of Product/Service', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(27, 7, 'Technical Report / Evidence of Non-Conformity', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(28, 8, 'Employment Contract / Offer Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(29, 8, 'Salary Slips (Previous 3-6 Months)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(30, 8, 'Bank Account Statement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(31, 8, 'Timesheet / Attendance / Swipe-in Records', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(32, 8, 'Emails & Messages with HR / Management', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(33, 9, 'Appointment Letter & Service Terms', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(34, 9, 'Termination Letter / Email', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(35, 9, 'Performance Appraisal & Review Records', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(36, 9, 'Full and Final Settlement Statement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(37, 10, 'Formal Written Complaint to ICC', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(38, 10, 'Electronic Evidence (WhatsApp, Slack, Emails, Call Logs)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(39, 10, 'Witness Statements / Colleague Corroboration', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(40, 10, 'Medical / Psychological Counseling Records', 'Optional', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(41, 11, 'Form 16 / Relieving Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(42, 11, 'Salary Slips Showing PF Deductions', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(43, 11, 'EPFO Member Passbook / UAN Account Details', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(44, 11, 'Form I Application for Gratuity Payment', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(45, 12, 'Employment Agreement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(46, 12, 'Immediate Termination Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(47, 12, 'Last Drawn Salary Slips', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(48, 13, 'Work Timesheet / Biometric Swipe Logs', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(49, 13, 'Employment Contract / Shift Schedule', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(50, 13, 'Salary Slips Showing Basic Hourly Rates', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(51, 14, 'Registered Sale Deed / Title Deed', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(52, 14, 'Encumbrance Certificate (30-Year EC)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(53, 14, 'Revenue Mutation / Khata Certificate / Patta', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(54, 14, 'Property Tax Receipts', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(55, 15, 'Builder-Buyer Agreement (BBA) / Allotment Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(56, 15, 'All Payment Receipts & Bank Account Statements', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(57, 15, 'Home Loan Sanction & Disbursement Schedule', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(58, 15, 'Builder Delay Notices & Written Correspondence', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(59, 16, 'Registered Title Deed & Approved Site Map', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(60, 16, 'Government Revenue Demarcation / Survey Report', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(61, 16, 'Date-Stamped Photographs of Encroachment', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(62, 17, 'Title Deeds of all Joint Ancestral Properties', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(63, 17, 'Genealogical Family Tree / Pedigree Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(64, 17, 'Death Certificates of Deceased Predecessors', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(65, 17, 'Revenue 7/12 Extract / RTC / Jamabandi Records', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(66, 18, 'Police Non-Cognizable Report (NCR) / Missing Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(67, 18, 'Newspaper Public Notice Clippings (English & Vernacular)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(68, 18, 'Sub-Registrar Certified Copy Application', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(69, 19, 'Registered / Notarized Rent Agreement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(70, 19, 'Security Deposit Bank Transfer Receipt / UTR', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(71, 19, 'Move-out Inspection Photos / Video Handover Proof', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(72, 19, 'Written Notice to Vacate & Key Handover Acknowledgment', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(73, 20, 'Active Rental Agreement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(74, 20, 'Rent Payment Receipts / Bank Transfers', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(75, 20, 'Audio / Video / WhatsApp Threat Evidence', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(76, 21, 'Date-Stamped Photos / Videos of Damaged Area', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(77, 21, 'Written Repair Notices Sent to Landlord', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(78, 21, 'Repair Cost Estimates / Invoices from Licensed Contractor', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(79, 22, 'Executed Lease Agreement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(80, 22, 'All Rent Payment Slips to Date', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(81, 22, 'Landlord Rent Increase Demand Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(82, 23, 'Expired Lease Agreement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(83, 23, 'Notice to Quit under Section 106 TPA with Postal Tracking', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(84, 23, 'Property Ownership Proof / Tax Receipts', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(85, 24, 'Marriage Certificate / Wedding Card with Photographs', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(86, 24, 'Settlement Agreement / MoU on Stamp Paper', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(87, 24, 'Identity & Address Proofs of Both Spouses (Aadhaar/Passport)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(88, 24, 'Income Tax Returns / Income Affidavits (3 Years)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(89, 25, 'Marriage Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(90, 25, 'Evidence of Cruelty, Desertion, or Adultery', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(91, 25, 'Mandatory Affidavit of Assets and Liabilities', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(92, 26, 'Child Birth Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(93, 26, 'School Progress Reports & Fee Receipts', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(94, 26, 'Income Proof & Residence Details of Petitioning Parent', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(95, 27, 'Comprehensive Affidavit of Assets and Liabilities (Rajnesh v. Neha)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(96, 27, 'Proof of Spouse Income / Lifestyle / Company Filings', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(97, 27, 'Proof of Monthly Living Expenses of Claimant & Children', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(98, 28, 'Medico-Legal Certificate (MLC) / Hospital Injury Report', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(99, 28, 'Audio / Video / WhatsApp Evidence of Threats & Abuse', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(100, 28, 'Police Complaint / Daily Diary Entry Copy', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(101, 29, 'Bank Account Statement Highlighting Fraudulent Debits', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(102, 29, 'Transaction Reference Numbers (UTR / RRN)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(103, 29, 'Phishing SMS / Link / Call Log Screenshots', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(104, 29, 'National Cyber Crime Portal Complaint PDF (cybercrime.gov.in)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(105, 30, 'Screenshots of Hacked Profile / Changed Email Alerts', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(106, 30, 'Original Account Creation Email / Username History', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(107, 31, 'Screenshots of Fake Profile & Exact URL / Handle', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(108, 31, 'Government Photo ID (Aadhaar / Passport)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(109, 32, 'Unedited Chat Transcripts & Payment Demand Screenshots', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(110, 32, 'Extortionist Phone Number / UPI ID / Profile Links', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(111, 33, 'Screenshots & Live URLs of Leaked Confidential Data', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(112, 33, 'Proof of Identity / Ownership of Compromised Data', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(113, 34, 'URLs & Screenshots of Deepfake / Morphed Content', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(114, 34, 'Original Unaltered Photographs / Videos', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(115, 35, 'Detailed Signed Written Complaint', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(116, 35, 'Speed Post / Registered Post Receipt & Tracking to SP Office', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(117, 36, 'Certified Copy of FIR & Remand Application', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(118, 36, 'Accused Identity & Local Permanent Address Proof', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(119, 36, 'Surety Identity & Solvency Documents (Property Tax / Land Records)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(120, 37, 'Contract / Agreement / Purchase Order', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(121, 37, 'Bank Statements Showing Fund Transfer to Accused', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(122, 37, 'Written Communications Showing Fraudulent Intent', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(123, 38, 'Copy / URL / Audio-Video Recording of Defamatory Statement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(124, 38, 'Proof of Publication to Third Parties', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(125, 38, 'Evidence of Harm to Reputation / Business Loss', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(126, 39, 'Promissory Note / Loan Agreement / Invoices', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(127, 39, 'Bank Statement Showing Disbursal of Loan / Funds', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(128, 39, 'Statutory Demand Notice & Postal Acknowledgment', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(129, 40, 'Title Deeds & Sanctioned Plan Proving Prima Facie Right', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(130, 40, 'Photographs & Notices Proving Imminent Threat', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(131, 41, 'Audio-Video Recordings with Time & Decibel Logs', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(132, 41, 'RWA / Housing Society Complaint Letters', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(133, 42, 'Executed Agreement with all Annexures', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(134, 42, 'Default Notice / Cure Notice Served on Defaulting Party', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(135, 42, 'Financial Audit / Invoices Proving Direct Losses', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(136, 43, 'MSME Udyam Registration Certificate (if applicable)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(137, 43, 'Purchase Orders (PO) & Tax Invoices', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(138, 43, 'Proof of Goods Delivery (Signed Challan / Work Completion)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(139, 44, 'Signed Non-Disclosure Agreement (NDA)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(140, 44, 'Digital Forensic Logs (Email Forwards, USB Downloads, File Access)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(141, 45, 'WhatsApp / Text / Email Communications Referencing Deal', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(142, 45, 'Bank Statements Showing Consideration Transferred', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(143, 46, 'Original Dishonored Cheque', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(144, 46, 'Original Cheque Return Memo with Bank Seal', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(145, 46, 'Statutory 15-Day Demand Notice & Speed Post Receipts', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(146, 46, 'Speed Post Tracking Delivery Confirmation', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(147, 47, 'Audio Call Recordings of Threatening Agents', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(148, 47, 'Call Detail Logs Showing Odd-Hour Calls (before 8 AM / after 7 PM)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(149, 47, 'Loan Account Sanction Letter & Statement', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(150, 48, 'Official CIBIL / Experian Credit Report with Control Number', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(151, 48, 'No Dues Certificate (NDC) / Loan Closure Letter from Bank', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(152, 49, 'Health Insurance Policy Document & Schedule', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(153, 49, 'Formal Claim Rejection Letter with Reason Code', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(154, 49, 'Hospital Discharge Summary & Indoor Case Papers (ICP)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(155, 49, 'Treating Doctor Certificate on Non-Pre-Existing Status', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(156, 49, 'Original Medical Bills, Pharmacy Receipts & Diagnostic Reports', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(157, 50, 'Original Life Insurance Policy Bond', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(158, 50, 'Official Death Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(159, 50, 'Claim Repudiation Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(160, 51, 'Motor Insurance Policy Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(161, 51, 'Vehicle Registration Certificate (RC) & Driver Driving License', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(162, 51, 'Authorized Garage Repair Estimate & Tax Invoices', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(163, 52, 'Police FIR, Site Panchnama & Detailed Accident Report (DAR)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(164, 52, 'Medico-Legal Certificate (MLC) & Post-Mortem Report (if death)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(165, 52, 'Disability Certificate Issued by Government Medical Board', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(166, 52, 'Salary Slips / ITR / Income Proof of Victim', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(167, 52, 'Offending Vehicle RC & Insurance Policy Copy', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(168, 53, 'Copy of Electronic Traffic Challan with Photographic Evidence', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(169, 53, 'Vehicle Registration Certificate (RC)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(170, 53, 'Toll Receipts / GPS / Dashcam Proof Showing Vehicle Elsewhere', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(171, 54, 'Police FIR for Hit and Run Accident', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(172, 54, 'Police Untraced / Final Report', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(173, 54, 'MLC / Post-Mortem Report & Legal Heir Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(174, 55, 'Original Work File with Creation Timestamp / Git History', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(175, 55, 'Copyright Registration Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(176, 55, 'Infringing Material URLs, Screenshots & Archive Links', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(177, 56, 'Trademark Registration Certificate / TM Application', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(178, 56, 'Invoices & Marketing Materials Showing Prior Commercial Use', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(179, 56, 'Photographs Comparing Genuine and Counterfeit Products', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(180, 57, 'Trademark Certificate / Business Incorporation Certificate', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(181, 57, 'WHOIS Record of Disputed Domain Name', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(182, 57, 'Evidence of Bad Faith (Extortionate Sale Offer / Fake Ads)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(183, 58, 'Screenshots of App Permissions / Account Privacy Settings', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(184, 58, 'Written Communications with Data Protection Officer (DPO)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(185, 59, 'Certified Copy of Acquittal Order / Settlement Decree', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(186, 59, 'Specific URLs to be Delisted from Search Engines', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(187, 60, 'Admission Fee Receipts & Bank Transfer Challans', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(188, 60, 'Admission Withdrawal Application with Date Stamp / Email', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(189, 60, 'Copy of Official UGC Fee Refund Policy Notification', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(190, 61, 'Mark Sheets / Proof of Course Completion', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(191, 61, 'Written Application & College Rejection / Demand Letter', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(192, 62, 'Written Ragging Complaint with Names, Dates & Place', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(193, 62, 'Medical Injury Report (if physical harm occurred)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.'),
(194, 62, 'National Anti-Ragging Helpline Reference Ticket (1800-180-5522)', 'Recommended', 'Potentially useful evidence; whether it is required depends on the applicable procedure and facts.');

-- --------------------------------------------------------

--
-- Table structure for table `legal_keywords`
--

CREATE TABLE `legal_keywords` (
  `keyword_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `keyword` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_keywords`
--

INSERT INTO `legal_keywords` (`keyword_id`, `case_id`, `keyword`) VALUES
(1, 1, 'defective product'),
(2, 1, 'broken item'),
(3, 1, 'damaged goods'),
(4, 1, 'faulty product'),
(5, 1, 'manufacturing defect'),
(6, 1, 'product defect'),
(7, 1, 'damaged delivery'),
(8, 2, 'refund refused'),
(9, 2, 'seller not refunding'),
(10, 2, 'return rejected'),
(11, 2, 'refund denied'),
(12, 2, 'money not returned'),
(13, 2, 'order cancellation refund'),
(14, 3, 'online shopping fraud'),
(15, 3, 'ecommerce fraud'),
(16, 3, 'fake shopping website'),
(17, 3, 'goods not delivered'),
(18, 3, 'instagram store scam'),
(19, 3, 'shopping scam'),
(20, 4, 'warranty refused'),
(21, 4, 'warranty denied'),
(22, 4, 'warranty claim rejected'),
(23, 4, 'service center refused warranty'),
(24, 4, 'product warranty'),
(25, 5, 'deficiency in service'),
(26, 5, 'flight cancellation refund'),
(27, 5, 'bad service'),
(28, 5, 'hotel booking dispute'),
(29, 5, 'service not provided'),
(30, 5, 'poor service quality'),
(31, 6, 'mrp overcharging'),
(32, 6, 'charged more than mrp'),
(33, 6, 'dual mrp'),
(34, 6, 'overpriced product'),
(35, 6, 'mrp violation'),
(36, 7, 'misleading advertisement'),
(37, 7, 'fake claims'),
(38, 7, 'false advertising'),
(39, 7, 'deceptive marketing'),
(40, 7, 'misleading ad'),
(41, 8, 'unpaid salary'),
(42, 8, 'salary not paid'),
(43, 8, 'salary delayed'),
(44, 8, 'withheld wages'),
(45, 8, 'unpaid wages'),
(46, 8, 'salary arrears'),
(47, 8, 'salary dues'),
(48, 8, 'salary withheld'),
(49, 8, 'stipend not paid'),
(50, 9, 'wrongful termination'),
(51, 9, 'fired unfairly'),
(52, 9, 'illegal termination'),
(53, 9, 'terminated without cause'),
(54, 9, 'forced resignation'),
(55, 9, 'illegal firing'),
(56, 10, 'workplace harassment'),
(57, 10, 'posh complaint'),
(58, 10, 'sexual harassment workplace'),
(59, 10, 'hostile work environment'),
(60, 10, 'boss harassment'),
(61, 10, 'internal complaints committee'),
(62, 11, 'gratuity not paid'),
(63, 11, 'pf not transferred'),
(64, 11, 'epfo complaint'),
(65, 11, 'uan exit mark'),
(66, 11, 'provident fund withheld'),
(67, 11, 'gratuity calculation'),
(68, 12, 'termination without notice'),
(69, 12, 'notice pay not given'),
(70, 12, 'immediate termination'),
(71, 12, 'fired without notice period'),
(72, 13, 'unpaid overtime'),
(73, 13, 'overtime wages'),
(74, 13, 'working extra hours without pay'),
(75, 13, 'overtime pay dispute'),
(76, 14, 'property ownership dispute'),
(77, 14, 'title dispute'),
(78, 14, 'property dispute'),
(79, 14, 'forged sale deed'),
(80, 14, 'land ownership dispute'),
(81, 14, 'property title'),
(82, 15, 'builder delay possession'),
(83, 15, 'rera complaint'),
(84, 15, 'rera flat delay'),
(85, 15, 'possession delayed flat'),
(86, 15, 'builder refund rera'),
(87, 15, 'builder not giving flat'),
(88, 16, 'land encroachment'),
(89, 16, 'illegal construction boundary'),
(90, 16, 'boundary encroachment'),
(91, 16, 'neighbor encroached land'),
(92, 16, 'illegal land grabbing'),
(93, 17, 'ancestral property dispute'),
(94, 17, 'partition suit'),
(95, 17, 'inheritance dispute'),
(96, 17, 'father property share'),
(97, 17, 'daughter property rights'),
(98, 17, 'coparcenary rights'),
(99, 18, 'lost property documents'),
(100, 18, 'lost sale deed'),
(101, 18, 'duplicate sale deed'),
(102, 18, 'misplaced property registry'),
(103, 18, 'missing land documents'),
(104, 19, 'security deposit not returned'),
(105, 19, 'landlord not returning deposit'),
(106, 19, 'rental deposit refund'),
(107, 19, 'deposit deduction dispute'),
(108, 19, 'landlord withheld deposit'),
(109, 19, 'flat deposit refund'),
(110, 20, 'threat of eviction'),
(111, 20, 'landlord throwing out'),
(112, 20, 'forced eviction'),
(113, 20, 'illegal eviction'),
(114, 20, 'landlord cutting electricity water'),
(115, 20, 'eviction notice dispute'),
(116, 21, 'landlord refusing repairs'),
(117, 21, 'rental maintenance dispute'),
(118, 21, 'water leakage flat landlord'),
(119, 21, 'house repairs landlord not fixing'),
(120, 22, 'rent increase dispute'),
(121, 22, 'landlord increased rent excessive'),
(122, 22, 'unfair rent hike'),
(123, 22, 'mid lease rent increment'),
(124, 23, 'tenant refusing to vacate'),
(125, 23, 'evicting tenant'),
(126, 23, 'tenant not leaving after agreement expired'),
(127, 23, 'overstaying tenant'),
(128, 24, 'mutual consent divorce'),
(129, 24, 'mutual divorce procedure'),
(130, 24, 'amicable divorce'),
(131, 24, 'divorce by mutual agreement'),
(132, 24, 'section 13b divorce'),
(133, 25, 'contested divorce'),
(134, 25, 'divorce on cruelty'),
(135, 25, 'desertion divorce'),
(136, 25, 'filing divorce against spouse'),
(137, 25, 'divorce petition'),
(138, 26, 'child custody dispute'),
(139, 26, 'child visitation rights'),
(140, 26, 'custody of minor child'),
(141, 26, 'custody battle'),
(142, 26, 'father visitation child'),
(143, 26, 'mother custody rights'),
(144, 27, 'maintenance claim'),
(145, 27, 'alimony claim'),
(146, 27, 'wife maintenance'),
(147, 27, 'section 125 crpc'),
(148, 27, 'interim maintenance'),
(149, 27, 'child maintenance'),
(150, 28, 'domestic violence'),
(151, 28, 'dv act complaint'),
(152, 28, 'protection order'),
(153, 28, 'in laws harassment'),
(154, 28, 'husband domestic abuse'),
(155, 28, '498a domestic violence'),
(156, 29, 'online payment fraud'),
(157, 29, 'upi scam'),
(158, 29, 'bank fraud online'),
(159, 29, 'money stolen online'),
(160, 29, 'phishing scam'),
(161, 29, 'qr code fraud'),
(162, 29, 'unauthorized transaction'),
(163, 29, 'cyber fraud 1930'),
(164, 30, 'social media account hacked'),
(165, 30, 'instagram hacked'),
(166, 30, 'facebook account hacked'),
(167, 30, 'whatsapp hacked'),
(168, 30, 'account hijacked'),
(169, 30, 'email hacked'),
(170, 31, 'online impersonation'),
(171, 31, 'fake profile'),
(172, 31, 'fake instagram account'),
(173, 31, 'identity theft online'),
(174, 31, 'someone pretending to be me'),
(175, 32, 'cyber extortion'),
(176, 32, 'blackmail online'),
(177, 32, 'threatening messages online'),
(178, 32, 'sextortion scam'),
(179, 32, 'threatened on whatsapp'),
(180, 32, 'ransom demands online'),
(181, 33, 'data leak'),
(182, 33, 'doxxing'),
(183, 33, 'personal information leaked'),
(184, 33, 'phone number leaked online'),
(185, 33, 'private photos leaked'),
(186, 34, 'deepfake'),
(187, 34, 'morphed photo'),
(188, 34, 'fake nude image'),
(189, 34, 'ai generated fake image'),
(190, 34, 'non consensual image sharing'),
(191, 35, 'police refusing fir'),
(192, 35, 'fir not registered'),
(193, 35, 'police complaint rejected'),
(194, 35, 'how to file fir'),
(195, 35, 'police station refused to file case'),
(196, 36, 'anticipatory bail'),
(197, 36, 'regular bail'),
(198, 36, 'bail application'),
(199, 36, 'arrested by police'),
(200, 36, 'how to get bail'),
(201, 36, 'criminal defense lawyer'),
(202, 37, 'cheating case 420'),
(203, 37, 'section 420 ipc'),
(204, 37, 'criminal breach of trust'),
(205, 37, 'money cheated'),
(206, 37, 'fraud complaint police'),
(207, 38, 'defamation case'),
(208, 38, 'criminal defamation'),
(209, 38, 'slander libel'),
(210, 38, 'reputation damaged false allegations'),
(211, 38, 'defamatory social media post'),
(212, 39, 'recovery of money'),
(213, 39, 'money recovery suit'),
(214, 39, 'summary suit order 37'),
(215, 39, 'lent money not returned'),
(216, 39, 'debtor not paying back'),
(217, 40, 'stay order'),
(218, 40, 'temporary injunction'),
(219, 40, 'order 39 cpc'),
(220, 40, 'stop demolition court'),
(221, 40, 'restrain property sale stay'),
(222, 41, 'neighbor dispute'),
(223, 41, 'noise nuisance neighbor'),
(224, 41, 'neighbor blocking road'),
(225, 41, 'section 133 crpc nuisance'),
(226, 41, 'neighbor harassment'),
(227, 42, 'contract breach'),
(228, 42, 'breach of contract'),
(229, 42, 'agreement violated'),
(230, 42, 'contract terms broken'),
(231, 42, 'contractual dispute damages'),
(232, 43, 'unpaid invoice'),
(233, 43, 'b2b payment default'),
(234, 43, 'client not paying invoice'),
(235, 43, 'msme samadhaan complaint'),
(236, 43, 'vendor payment delayed'),
(237, 44, 'nda breach'),
(238, 44, 'non disclosure agreement violated'),
(239, 44, 'trade secret leaked'),
(240, 44, 'confidential data leaked employee'),
(241, 45, 'verbal agreement dispute'),
(242, 45, 'oral contract'),
(243, 45, 'oral agreement broken'),
(244, 45, 'unwritten deal dispute'),
(245, 46, 'cheque bounce'),
(246, 46, 'section 138 ni act'),
(247, 46, 'bounced cheque'),
(248, 46, 'dishonoured cheque'),
(249, 46, 'insufficient funds cheque'),
(250, 46, 'cheque bounce legal notice'),
(251, 47, 'recovery agent harassment'),
(252, 47, 'loan agent threatening'),
(253, 47, 'rbi recovery agent rules'),
(254, 47, 'loan recovery abuse'),
(255, 47, 'loan app harassment'),
(256, 48, 'cibil dispute'),
(257, 48, 'credit score error'),
(258, 48, 'cibil wrong default'),
(259, 48, 'credit bureau correction'),
(260, 48, 'cibil report dispute'),
(261, 49, 'insurance claim rejected'),
(262, 49, 'health insurance denied'),
(263, 49, 'mediclaim claim rejected'),
(264, 49, 'cashless claim denied'),
(265, 49, 'pre existing disease claim rejection'),
(266, 49, 'insurance ombudsman complaint'),
(267, 50, 'life insurance claim rejected'),
(268, 50, 'death claim repudiation'),
(269, 50, 'term insurance claim rejected'),
(270, 50, 'section 45 insurance act 3 years'),
(271, 51, 'motor insurance claim rejected'),
(272, 51, 'car insurance claim denied'),
(273, 51, 'vehicle accident claim dispute'),
(274, 51, 'own damage claim delayed'),
(275, 52, 'motor accident'),
(276, 52, 'car accident claim'),
(277, 52, 'mact compensation claim'),
(278, 52, 'road accident injury claim'),
(279, 52, 'hit and run accident'),
(280, 52, 'road traffic accident death compensation'),
(281, 53, 'traffic fine dispute'),
(282, 53, 'wrong traffic challan'),
(283, 53, 'contest echallan'),
(284, 53, 'fake traffic penalty'),
(285, 53, 'disputed virtual court challan'),
(286, 54, 'hit and run compensation'),
(287, 54, 'untraced vehicle accident'),
(288, 54, 'hit and run scheme 2022'),
(289, 54, 'victim compensation road accident'),
(290, 55, 'copyright infringement'),
(291, 55, 'copied content online'),
(292, 55, 'plagiarism'),
(293, 55, 'stolen code art video'),
(294, 55, 'dmca takedown notice'),
(295, 56, 'trademark infringement'),
(296, 56, 'brand name copied'),
(297, 56, 'logo stolen'),
(298, 56, 'passing off brand'),
(299, 56, 'counterfeit brand goods'),
(300, 57, 'cybersquatting'),
(301, 57, 'domain squatting'),
(302, 57, 'brand domain name stolen'),
(303, 57, 'indrp dispute nixi'),
(304, 57, 'udrp domain dispute'),
(305, 58, 'dpdp act privacy'),
(306, 58, 'digital privacy violation'),
(307, 58, 'unauthorized data collection'),
(308, 58, 'data fiduciary violation'),
(309, 58, 'data protection board complaint'),
(310, 59, 'right to be forgotten'),
(311, 59, 'delisting google search'),
(312, 59, 'remove online records'),
(313, 59, 'article 21 privacy delisting'),
(314, 60, 'college fee refund'),
(315, 60, 'coaching institute fee refund'),
(316, 60, 'ugc fee refund guidelines'),
(317, 60, 'admission cancellation refund'),
(318, 60, 'fees not returned by college'),
(319, 61, 'college withholding degree'),
(320, 61, 'marksheet withheld by college'),
(321, 61, 'transfer certificate denied'),
(322, 61, 'school withholding tc'),
(323, 62, 'ragging complaint'),
(324, 62, 'anti ragging helpline 1800-180-5522'),
(325, 62, 'college ragging bullying'),
(326, 62, 'hostel ragging complaint');

-- --------------------------------------------------------

--
-- Table structure for table `legal_options`
--

CREATE TABLE `legal_options` (
  `option_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `option_text` text NOT NULL,
  `priority` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_options`
--

INSERT INTO `legal_options` (`option_id`, `case_id`, `option_text`, `priority`) VALUES
(1, 1, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(2, 1, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(3, 1, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 3),
(4, 2, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(5, 2, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(6, 3, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(7, 3, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(8, 3, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 3),
(9, 4, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(10, 4, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(11, 5, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(12, 5, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(13, 6, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(14, 6, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(15, 7, 'Seller/service-provider grievance or consumer helpline route, if applicable.', 1),
(16, 7, 'Consumer Commission or sector-specific remedy after confirming jurisdiction and eligibility.', 2),
(17, 8, 'Written employer grievance and applicable labour-authority/claim mechanism.', 1),
(18, 8, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 2),
(19, 8, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 3),
(20, 9, 'Written employer grievance and applicable labour-authority/claim mechanism.', 1),
(21, 9, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 2),
(22, 10, 'Written employer grievance and applicable labour-authority/claim mechanism.', 1),
(23, 10, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 2),
(24, 11, 'Written employer grievance and applicable labour-authority/claim mechanism.', 1),
(25, 11, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 2),
(26, 12, 'Written employer grievance and applicable labour-authority/claim mechanism.', 1),
(27, 12, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 2),
(28, 13, 'Written employer grievance and applicable labour-authority/claim mechanism.', 1),
(29, 13, 'Professional legal advice or appropriate labour/court remedy after confirming employee coverage.', 2),
(30, 14, 'Relevant revenue/registration/property authority process, where applicable.', 1),
(31, 14, 'Civil court remedy after title, jurisdiction and limitation are verified.', 2),
(32, 15, 'Relevant revenue/registration/property authority process, where applicable.', 1),
(33, 15, 'Civil court remedy after title, jurisdiction and limitation are verified.', 2),
(34, 16, 'Relevant revenue/registration/property authority process, where applicable.', 1),
(35, 16, 'Civil court remedy after title, jurisdiction and limitation are verified.', 2),
(36, 16, 'Civil court remedy after title, jurisdiction and limitation are verified.', 3),
(37, 17, 'Relevant revenue/registration/property authority process, where applicable.', 1),
(38, 17, 'Civil court remedy after title, jurisdiction and limitation are verified.', 2),
(39, 18, 'Relevant revenue/registration/property authority process, where applicable.', 1),
(40, 18, 'Civil court remedy after title, jurisdiction and limitation are verified.', 2),
(41, 19, 'Written contractual/tenancy-law grievance or applicable rent-authority process.', 1),
(42, 19, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 2),
(43, 19, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 3),
(44, 20, 'Written contractual/tenancy-law grievance or applicable rent-authority process.', 1),
(45, 20, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 2),
(46, 20, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 3),
(47, 21, 'Written contractual/tenancy-law grievance or applicable rent-authority process.', 1),
(48, 21, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 2),
(49, 22, 'Written contractual/tenancy-law grievance or applicable rent-authority process.', 1),
(50, 22, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 2),
(51, 23, 'Written contractual/tenancy-law grievance or applicable rent-authority process.', 1),
(52, 23, 'Civil or tenancy proceeding after confirming the state-specific forum and facts.', 2),
(53, 24, 'Family-court or statutory family-law remedy applicable to the marriage/relationship.', 1),
(54, 24, 'Settlement/mediation or urgent protective relief where appropriate.', 2),
(55, 25, 'Family-court or statutory family-law remedy applicable to the marriage/relationship.', 1),
(56, 25, 'Settlement/mediation or urgent protective relief where appropriate.', 2),
(57, 26, 'Family-court or statutory family-law remedy applicable to the marriage/relationship.', 1),
(58, 26, 'Settlement/mediation or urgent protective relief where appropriate.', 2),
(59, 27, 'Family-court or statutory family-law remedy applicable to the marriage/relationship.', 1),
(60, 27, 'Settlement/mediation or urgent protective relief where appropriate.', 2),
(61, 28, 'Family-court or statutory family-law remedy applicable to the marriage/relationship.', 1),
(62, 28, 'Settlement/mediation or urgent protective relief where appropriate.', 2),
(63, 29, 'Official cybercrime/platform/bank reporting route applicable to the incident.', 1),
(64, 29, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 2),
(65, 29, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 3),
(66, 30, 'Official cybercrime/platform/bank reporting route applicable to the incident.', 1),
(67, 30, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 2),
(68, 31, 'Official cybercrime/platform/bank reporting route applicable to the incident.', 1),
(69, 31, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 2),
(70, 32, 'Official cybercrime/platform/bank reporting route applicable to the incident.', 1),
(71, 32, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 2),
(72, 33, 'Official cybercrime/platform/bank reporting route applicable to the incident.', 1),
(73, 33, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 2),
(74, 34, 'Official cybercrime/platform/bank reporting route applicable to the incident.', 1),
(75, 34, 'Criminal, civil or regulatory remedy after the alleged conduct and evidence are verified.', 2),
(76, 35, 'Police/prosecution procedure applicable to the alleged offence.', 1),
(77, 35, 'Court remedy or qualified criminal-law representation after verifying the current procedure.', 2),
(78, 35, 'Court remedy or qualified criminal-law representation after verifying the current procedure.', 3),
(79, 36, 'Police/prosecution procedure applicable to the alleged offence.', 1),
(80, 36, 'Court remedy or qualified criminal-law representation after verifying the current procedure.', 2),
(81, 37, 'Police/prosecution procedure applicable to the alleged offence.', 1),
(82, 37, 'Court remedy or qualified criminal-law representation after verifying the current procedure.', 2),
(83, 38, 'Police/prosecution procedure applicable to the alleged offence.', 1),
(84, 38, 'Court remedy or qualified criminal-law representation after verifying the current procedure.', 2),
(85, 38, 'Court remedy or qualified criminal-law representation after verifying the current procedure.', 3),
(86, 39, 'Civil demand, negotiation or mediation where appropriate.', 1),
(87, 39, 'Civil court procedure after limitation, jurisdiction and claim type are verified.', 2),
(88, 40, 'Civil demand, negotiation or mediation where appropriate.', 1),
(89, 40, 'Civil court procedure after limitation, jurisdiction and claim type are verified.', 2),
(90, 41, 'Civil demand, negotiation or mediation where appropriate.', 1),
(91, 41, 'Civil court procedure after limitation, jurisdiction and claim type are verified.', 2),
(92, 42, 'Contractual dispute-resolution mechanism, including negotiation or mediation where applicable.', 1),
(93, 42, 'Arbitration or court remedy after checking the contract and jurisdiction.', 2),
(94, 43, 'Contractual dispute-resolution mechanism, including negotiation or mediation where applicable.', 1),
(95, 43, 'Arbitration or court remedy after checking the contract and jurisdiction.', 2),
(96, 44, 'Contractual dispute-resolution mechanism, including negotiation or mediation where applicable.', 1),
(97, 44, 'Arbitration or court remedy after checking the contract and jurisdiction.', 2),
(98, 45, 'Contractual dispute-resolution mechanism, including negotiation or mediation where applicable.', 1),
(99, 45, 'Arbitration or court remedy after checking the contract and jurisdiction.', 2),
(100, 46, 'Lender/bureau grievance and applicable RBI-regulated escalation route.', 1),
(101, 46, 'Ombudsman, regulatory or court remedy after confirming eligibility.', 2),
(102, 46, 'Ombudsman, regulatory or court remedy after confirming eligibility.', 3),
(103, 47, 'Lender/bureau grievance and applicable RBI-regulated escalation route.', 1),
(104, 47, 'Ombudsman, regulatory or court remedy after confirming eligibility.', 2),
(105, 48, 'Lender/bureau grievance and applicable RBI-regulated escalation route.', 1),
(106, 48, 'Ombudsman, regulatory or court remedy after confirming eligibility.', 2),
(107, 49, 'Insurer grievance and applicable ombudsman/regulatory route.', 1),
(108, 49, 'Consumer or other legal remedy after checking policy, jurisdiction and limitation.', 2),
(109, 50, 'Insurer grievance and applicable ombudsman/regulatory route.', 1),
(110, 50, 'Consumer or other legal remedy after checking policy, jurisdiction and limitation.', 2),
(111, 51, 'Insurer grievance and applicable ombudsman/regulatory route.', 1),
(112, 51, 'Consumer or other legal remedy after checking policy, jurisdiction and limitation.', 2),
(113, 52, 'Insurer/transport authority/tribunal process applicable to the matter.', 1),
(114, 52, 'MACT, traffic-court or civil remedy after verifying the accident and jurisdiction.', 2),
(115, 53, 'Insurer/transport authority/tribunal process applicable to the matter.', 1),
(116, 53, 'MACT, traffic-court or civil remedy after verifying the accident and jurisdiction.', 2),
(117, 54, 'Insurer/transport authority/tribunal process applicable to the matter.', 1),
(118, 54, 'MACT, traffic-court or civil remedy after verifying the accident and jurisdiction.', 2),
(119, 55, 'Rights-holder/platform or formal demand route where appropriate.', 1),
(120, 55, 'Civil or other IP proceeding after ownership and infringement are established.', 2),
(121, 55, 'Civil or other IP proceeding after ownership and infringement are established.', 3),
(122, 56, 'Rights-holder/platform or formal demand route where appropriate.', 1),
(123, 56, 'Civil or other IP proceeding after ownership and infringement are established.', 2),
(124, 57, 'Rights-holder/platform or formal demand route where appropriate.', 1),
(125, 57, 'Civil or other IP proceeding after ownership and infringement are established.', 2),
(126, 58, 'Data-fiduciary grievance or other applicable official privacy process.', 1),
(127, 58, 'Regulatory or judicial remedy after confirming DPDP applicability and forum.', 2),
(128, 59, 'Data-fiduciary grievance or other applicable official privacy process.', 1),
(129, 59, 'Regulatory or judicial remedy after confirming DPDP applicability and forum.', 2),
(130, 60, 'Institutional grievance and applicable regulator process.', 1),
(131, 60, 'Consumer, public-law or other court remedy after confirming jurisdiction and policy.', 2),
(132, 61, 'Institutional grievance and applicable regulator process.', 1),
(133, 61, 'Consumer, public-law or other court remedy after confirming jurisdiction and policy.', 2),
(134, 62, 'Institutional grievance and applicable regulator process.', 1),
(135, 62, 'Consumer, public-law or other court remedy after confirming jurisdiction and policy.', 2);

-- --------------------------------------------------------

--
-- Table structure for table `legal_sources`
--

CREATE TABLE `legal_sources` (
  `source_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `source_name` varchar(255) DEFAULT NULL,
  `source_url` text DEFAULT NULL,
  `source_type` varchar(100) DEFAULT NULL,
  `last_verified` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_sources`
--

INSERT INTO `legal_sources` (`source_id`, `case_id`, `source_name`, `source_url`, `source_type`, `last_verified`) VALUES
(1, 1, 'Consumer Protection Act 2019', 'https://consumeraffairs.nic.in/acts-and-rules/consumer-protection', 'Statutory Act', '2026-08-01'),
(2, 1, 'National Consumer Helpline', 'https://consumerhelpline.gov.in', 'Official Portal', '2026-08-01'),
(3, 3, 'National Cyber Crime Reporting Portal', 'https://cybercrime.gov.in', 'Official Portal', '2026-08-01'),
(4, 8, 'Code on Wages 2019 / Payment of Wages Act', 'https://labour.gov.in', 'Statutory Act', '2026-08-01'),
(5, 10, 'POSH Act 2013 & SHe-Box Portal', 'https://shebox.nic.in', 'Government Portal', '2026-08-01'),
(6, 11, 'EPFO Grievance Portal', 'https://epfigms.gov.in', 'Official Portal', '2026-08-01'),
(7, 15, 'Real Estate (Regulation and Development) Act 2016', 'https://mohua.gov.in/cms/rera.php', 'Statutory Act', '2026-08-01'),
(8, 19, 'Model Tenancy Act / State Rent Control Acts', 'https://mohua.gov.in', 'Statutory Act', '2026-08-01'),
(9, 24, 'Hindu Marriage Act 1955 (Section 13B)', 'https://legislative.gov.in', 'Statutory Act', '2026-08-01'),
(10, 28, 'Protection of Women from Domestic Violence Act 2005', 'https://wcd.nic.in', 'Statutory Act', '2026-08-01'),
(11, 29, 'RBI Zero Liability Electronic Banking Circular (2017)', 'https://rbi.org.in', 'Regulatory Circular', '2026-08-01'),
(12, 35, 'Section 154(3) CrPC / Section 173 BNSS', 'https://legislative.gov.in', 'Statutory Act', '2026-08-01'),
(13, 43, 'MSME Samadhaan Portal', 'https://samadhaan.msme.gov.in', 'Official Portal', '2026-08-01'),
(14, 46, 'Negotiable Instruments Act 1881 (Section 138)', 'https://legislative.gov.in', 'Statutory Act', '2026-08-01'),
(15, 47, 'RBI Master Directions on Loan Recovery (2022)', 'https://rbi.org.in', 'Regulatory Direction', '2026-08-01'),
(16, 49, 'Insurance Ombudsman Council', 'https://cioins.co.in', 'Official Portal', '2026-08-01'),
(17, 52, 'Motor Vehicles Act 1988 (MACT Compensation)', 'https://morth.nic.in', 'Statutory Act', '2026-08-01'),
(18, 55, 'Copyright Act 1957 (Section 51 & 63)', 'https://copyright.gov.in', 'Statutory Act', '2026-08-01'),
(19, 58, 'Digital Personal Data Protection Act 2023', 'https://meity.gov.in', 'Statutory Act', '2026-08-01'),
(20, 60, 'UGC Fee Refund Policy Guidelines', 'https://ugc.ac.in', 'Regulatory Notification', '2026-08-01'),
(21, 62, 'National Anti-Ragging Portal', 'https://antiragging.in', 'Official Portal', '2026-08-01');

-- --------------------------------------------------------

--
-- Table structure for table `legal_topics`
--

CREATE TABLE `legal_topics` (
  `topic_id` int(11) NOT NULL,
  `topic_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `legal_topics`
--

INSERT INTO `legal_topics` (`topic_id`, `topic_name`, `description`, `created_at`) VALUES
(1, 'Consumer Law', 'Problems involving defective products, seller refund refusals, warranty denial, e-commerce fraud, and consumer protection rights', '2026-08-21 18:42:34'),
(2, 'Employment Law', 'Issues involving unpaid wages, wrongful termination, employment contracts, workplace harassment (POSH), PF and gratuity dues', '2026-08-21 18:42:34'),
(3, 'Property Law', 'Property title disputes, land possession, illegal encroachment, RERA builder delays, and ancestral property partition', '2026-08-21 18:42:34'),
(4, 'Rental and Tenancy', 'Disputes between landlords and tenants including security deposit refund, illegal eviction, repairs, and rent disputes', '2026-08-21 18:42:34'),
(5, 'Family Law', 'Matrimonial disputes, mutual and contested divorce, child custody and visitation, maintenance/alimony, and domestic violence protection', '2026-08-21 18:42:34'),
(6, 'Cyber Law', 'Online financial fraud, UPI scams, social media hacking, impersonation, online extortion/blackmail, and data leaks', '2026-08-21 18:42:34'),
(7, 'Criminal Law', 'Criminal-law complaints, investigation, bail, cheating/fraud and criminal procedure under the law currently in force.', '2026-08-21 18:42:34'),
(8, 'Civil Disputes', 'Recovery of money, summary suits (Order 37 CPC), stay order and injunctions, and neighbor nuisance disputes', '2026-08-21 18:42:34'),
(9, 'Contract Law', 'Breach of contract, unpaid commercial invoices, non-disclosure agreement (NDA) violations, and verbal contract disputes', '2026-08-21 18:42:34'),
(10, 'Banking and Finance', 'Cheque dishonour, regulated lending/recovery conduct, credit reporting and other banking/finance disputes.', '2026-08-21 18:42:34'),
(11, 'Insurance', 'Rejected health/mediclaim insurance, repudiation of life insurance death claims, delayed claims, and motor accident damage disputes', '2026-08-21 18:42:34'),
(12, 'Traffic and Motor Vehicle', 'Road accidents, MACT compensation for injury/death, disputed traffic e-challans, and Hit and Run compensation scheme', '2026-08-21 18:42:34'),
(13, 'Intellectual Property', 'Copyright infringement, trademark counterfeiting and passing off, stolen online content, and cybersquatting disputes', '2026-08-21 18:42:34'),
(14, 'Digital Privacy', 'Digital privacy, personal-data processing and related privacy or online-removal issues under applicable current law.', '2026-08-21 18:42:34'),
(15, 'Education', 'College and coaching fee refund refusals, withholding of degree/transfers, ragging harassment, and fake university fraud', '2026-08-21 18:42:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT '',
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `phone`, `created_at`) VALUES
(1, 'Demo', 'User', 'demo@lex.local', 'admin123', '9876543210', '2026-08-24 13:08:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `legal_actions`
--
ALTER TABLE `legal_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `legal_cases`
--
ALTER TABLE `legal_cases`
  ADD PRIMARY KEY (`case_id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Indexes for table `legal_documents`
--
ALTER TABLE `legal_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `legal_keywords`
--
ALTER TABLE `legal_keywords`
  ADD PRIMARY KEY (`keyword_id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `idx_keyword` (`keyword`);

--
-- Indexes for table `legal_options`
--
ALTER TABLE `legal_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `legal_sources`
--
ALTER TABLE `legal_sources`
  ADD PRIMARY KEY (`source_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `legal_topics`
--
ALTER TABLE `legal_topics`
  ADD PRIMARY KEY (`topic_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `legal_actions`
--
ALTER TABLE `legal_actions`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=283;

--
-- AUTO_INCREMENT for table `legal_cases`
--
ALTER TABLE `legal_cases`
  MODIFY `case_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `legal_documents`
--
ALTER TABLE `legal_documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;

--
-- AUTO_INCREMENT for table `legal_keywords`
--
ALTER TABLE `legal_keywords`
  MODIFY `keyword_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- AUTO_INCREMENT for table `legal_options`
--
ALTER TABLE `legal_options`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `legal_sources`
--
ALTER TABLE `legal_sources`
  MODIFY `source_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `legal_topics`
--
ALTER TABLE `legal_topics`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `legal_actions`
--
ALTER TABLE `legal_actions`
  ADD CONSTRAINT `legal_actions_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE;

--
-- Constraints for table `legal_cases`
--
ALTER TABLE `legal_cases`
  ADD CONSTRAINT `legal_cases_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `legal_topics` (`topic_id`) ON DELETE CASCADE;

--
-- Constraints for table `legal_documents`
--
ALTER TABLE `legal_documents`
  ADD CONSTRAINT `legal_documents_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE;

--
-- Constraints for table `legal_keywords`
--
ALTER TABLE `legal_keywords`
  ADD CONSTRAINT `legal_keywords_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE;

--
-- Constraints for table `legal_options`
--
ALTER TABLE `legal_options`
  ADD CONSTRAINT `legal_options_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE;

--
-- Constraints for table `legal_sources`
--
ALTER TABLE `legal_sources`
  ADD CONSTRAINT `legal_sources_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
