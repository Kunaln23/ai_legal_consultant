-- ========================================================
-- DATABASE: `lex_db` - AI Legal Consultant Database
-- Description: Complete production schema with 15 legal topics,
--              62 distinct comprehensive legal scenarios, 400+ keywords,
--              categorized required documents, step-by-step action plans,
--              legal remedies, statutory sources, and user tables.
-- ========================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Create Database if not exists
CREATE DATABASE IF NOT EXISTS `lex_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `lex_db`;

-- --------------------------------------------------------
-- Drop existing tables in reverse dependency order
-- --------------------------------------------------------
DROP TABLE IF EXISTS `legal_actions`;
DROP TABLE IF EXISTS `legal_documents`;
DROP TABLE IF EXISTS `legal_keywords`;
DROP TABLE IF EXISTS `legal_options`;
DROP TABLE IF EXISTS `legal_sources`;
DROP TABLE IF EXISTS `conversations`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `legal_cases`;
DROP TABLE IF EXISTS `legal_topics`;

-- --------------------------------------------------------
-- 1. Table structure for table `legal_topics`
-- --------------------------------------------------------
CREATE TABLE `legal_topics` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_topics`
INSERT INTO `legal_topics` (`topic_id`, `topic_name`, `description`, `created_at`) VALUES
(1, 'Consumer Law', 'Problems involving defective products, seller refund refusals, warranty denial, e-commerce fraud, and consumer protection rights', '2026-08-21 18:42:34'),
(2, 'Employment Law', 'Issues involving unpaid wages, wrongful termination, employment contracts, workplace harassment (POSH), PF and gratuity dues', '2026-08-21 18:42:34'),
(3, 'Property Law', 'Property title disputes, land possession, illegal encroachment, RERA builder delays, and ancestral property partition', '2026-08-21 18:42:34'),
(4, 'Rental and Tenancy', 'Disputes between landlords and tenants including security deposit refund, illegal eviction, repairs, and rent disputes', '2026-08-21 18:42:34'),
(5, 'Family Law', 'Matrimonial disputes, mutual and contested divorce, child custody and visitation, maintenance/alimony, and domestic violence protection', '2026-08-21 18:42:34'),
(6, 'Cyber Law', 'Online financial fraud, UPI scams, social media hacking, impersonation, online extortion/blackmail, and data leaks', '2026-08-21 18:42:34'),
(7, 'Criminal Law', 'Cognizable complaints, refusal by police to file FIR, bail procedures, cheating and fraud (Sec 420), and criminal defense', '2026-08-21 18:42:34'),
(8, 'Civil Disputes', 'Recovery of money, summary suits (Order 37 CPC), stay order and injunctions, and neighbor nuisance disputes', '2026-08-21 18:42:34'),
(9, 'Contract Law', 'Breach of contract, unpaid commercial invoices, non-disclosure agreement (NDA) violations, and verbal contract disputes', '2026-08-21 18:42:34'),
(10, 'Banking and Finance', 'Cheque bounce (Section 138 NI Act), loan recovery agent harassment, disputed credit card charges, and CIBIL score errors', '2026-08-21 18:42:34'),
(11, 'Insurance', 'Rejected health/mediclaim insurance, repudiation of life insurance death claims, delayed claims, and motor accident damage disputes', '2026-08-21 18:42:34'),
(12, 'Traffic and Motor Vehicle', 'Road accidents, MACT compensation for injury/death, disputed traffic e-challans, and Hit and Run compensation scheme', '2026-08-21 18:42:34'),
(13, 'Intellectual Property', 'Copyright infringement, trademark counterfeiting and passing off, stolen online content, and cybersquatting disputes', '2026-08-21 18:42:34'),
(14, 'Digital Privacy', 'Violations of Digital Personal Data Protection (DPDP Act), unauthorized personal data collection, and Right to be Forgotten', '2026-08-21 18:42:34'),
(15, 'Education', 'College and coaching fee refund refusals, withholding of degree/transfers, ragging harassment, and fake university fraud', '2026-08-21 18:42:34');

-- --------------------------------------------------------
-- 2. Table structure for table `legal_cases`
-- --------------------------------------------------------
CREATE TABLE `legal_cases` (
  `case_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `case_title` varchar(255) NOT NULL,
  `situation` text NOT NULL,
  `explanation` text NOT NULL,
  `urgency` enum('Low','Normal','High','Emergency') DEFAULT 'Normal',
  `jurisdiction` varchar(100) DEFAULT 'India',
  PRIMARY KEY (`case_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `legal_cases_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `legal_topics` (`topic_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_cases`
INSERT INTO `legal_cases` (`case_id`, `topic_id`, `case_title`, `situation`, `explanation`, `urgency`, `jurisdiction`) VALUES
-- TOPIC 1: CONSUMER LAW
(1, 1, 'Defective product received', 'I purchased a product and it arrived broken, damaged, or defective, and the seller or manufacturer refuses to resolve it.', 'Under the Consumer Protection Act 2019 (Sections 84-87), consumers have the right to replacement, repair, or full refund. Manufacturers and sellers are strictly liable for product defects and consequential damages.', 'Normal', 'India'),
(2, 1, 'Seller refuses refund or return', 'The seller refuses to provide a refund or accept return for a cancelled order, non-delivered item, or eligible return.', 'Under Consumer Protection (E-Commerce) Rules 2020 and Consumer Protection Act 2019 Section 2(47), refusal to refund for valid returns constitutes an Unfair Trade Practice punishable with mandatory refunds and compensation.', 'Normal', 'India'),
(3, 1, 'Online shopping and e-commerce fraud', 'I paid for goods on an online shopping portal or social media page, but the items never arrived and the seller is unreachable.', 'This constitutes criminal cheating (Section 420 IPC / BNS) and deficiency of service under Consumer Protection (E-Commerce) Rules 2020. The buyer can seek both criminal recovery and consumer compensation.', 'High', 'India'),
(4, 1, 'Product warranty denied by manufacturer', 'The authorized service center or manufacturer is refusing to honor the active warranty on my product.', 'A product warranty is a binding legal contract. Refusing legitimate service under warranty violates Section 2(11) (Deficiency in Service) and Section 2(47) of the Consumer Protection Act 2019.', 'Normal', 'India'),
(5, 1, 'Deficiency in service', 'I paid for a professional service (flight, hotel, transport, salon, repairs) but the service was substandard, delayed, or not provided.', 'Under Section 2(11) of the Consumer Protection Act 2019, deficiency in service entitles the customer to a full refund, compensation for mental harassment, and reimbursement of all incurred litigation costs.', 'Normal', 'India'),
(6, 1, 'Overcharging beyond MRP', 'A retailer or restaurant charged a price higher than the Maximum Retail Price (MRP) printed on packaged goods.', 'Charging above MRP is illegal under the Legal Metrology Act 2009 and the Legal Metrology (Packaged Commodities) Rules 2011. It attracts heavy fines and refund obligations.', 'Low', 'India'),
(7, 1, 'False and misleading advertising', 'A product or service did not deliver what was promised in commercial advertisements, leading to financial loss.', 'Under Section 2(28) and Section 89 of CPA 2019, misleading advertisements can attract penalties from the Central Consumer Protection Authority (CCPA) and entitle consumers to product replacement and damages.', 'Normal', 'India'),

-- TOPIC 2: EMPLOYMENT LAW
(8, 2, 'Unpaid salary and withheld wages', 'My employer has not paid my monthly salary, wages, or final settlement dues despite working full time.', 'Under the Payment of Wages Act 1936, Code on Wages 2019, and Industrial Disputes Act 1947, employers must disburse wages on time. Withholding salary constitutes an illegal act punishable with statutory interest and penalties.', 'High', 'India'),
(9, 2, 'Wrongful termination and illegal firing', 'I was terminated from my employment abruptly without contractual notice, retrenchment compensation, or fair inquiry.', 'Under Section 25F of the Industrial Disputes Act 1947 and State Shops & Establishments Acts, arbitrary termination without statutory notice pay or severance is unlawful and actionable before the Labour Court.', 'High', 'India'),
(10, 2, 'Workplace sexual harassment (POSH)', 'I am facing sexual harassment, unwelcome conduct, or a hostile work environment at my workplace.', 'Governed by the POSH Act 2013 (Prevention, Prohibition and Redressal of Sexual Harassment of Women at Workplace). Employers with 10+ staff must maintain an active Internal Complaints Committee (ICC).', 'Emergency', 'India'),
(11, 2, 'Withholding of PF or Gratuity dues', 'My employer refused to release my Provident Fund (PF), update UAN exit date, or pay statutory Gratuity after resignation.', 'Under the Payment of Gratuity Act 1972 and EPF & MP Act 1952, gratuity is mandatory after 5 years of continuous service, and PF contributions must be remitted promptly. Delayed payment attracts 10% statutory interest.', 'Normal', 'India'),
(12, 2, 'Termination without notice or notice pay', 'I was fired on the spot without the 30/60/90 days contractual notice period or salary in lieu of notice.', 'Contractual notice clauses are legally binding. Immediate termination without paying salary in lieu of notice violates the contract terms and State Shops and Establishments Act.', 'High', 'India'),
(13, 2, 'Unpaid overtime wages', 'My employer forces me to work beyond statutory working hours without providing overtime pay.', 'Under the Factories Act 1948 and State Shops and Establishments Acts, overtime work beyond standard hours (normally 8-9 hours/day or 48 hours/week) must be paid at double the ordinary hourly wage rate.', 'Normal', 'India'),

-- TOPIC 3: PROPERTY LAW
(14, 3, 'Property ownership and title dispute', 'Someone is disputing my ownership of my land or apartment, or claiming rights through forged documents.', 'Governed by the Transfer of Property Act 1882, Registration Act 1908, and Specific Relief Act 1963. A registered title deed confers legal ownership which can be defended via a Suit for Declaration of Title.', 'High', 'India'),
(15, 3, 'Builder delay in flat possession (RERA)', 'The builder/developer failed to hand over flat possession within the promised date mentioned in the agreement.', 'Under Section 18 of Real Estate (Regulation and Development) Act 2016 (RERA), home buyers are entitled to monthly interest for the entire delayed period or a 100% refund of paid amounts with prescribed interest.', 'High', 'India'),
(16, 3, 'Illegal encroachment on land or property', 'A neighbor or third party has illegally built a structure or encroached across my property boundary.', 'Illegal encroachment is criminal trespass (Section 441 IPC / BNS) and a civil violation. The owner can file an application for revenue demarcation and a Civil Suit for Injunction and Demolition.', 'High', 'India'),
(17, 3, 'Ancestral property inheritance dispute', 'Family members are denying my rightful legal share in ancestral land or family property.', 'Under Hindu Succession Act 1956 (amended 2005, giving equal coparcenary rights to daughters) and Indian Succession Act, co-heirs are entitled to equal partition and separate possession through a Partition Suit.', 'High', 'India'),
(18, 3, 'Lost or missing original property documents', 'I have lost my original registered sale deed or property title documents and need duplicates.', 'Requires registering a Police Non-Cognizable Report (NCR), publishing a public notice in two local newspapers, and applying for Certified True Copies from the Sub-Registrar Office where the deed was registered.', 'Normal', 'India'),

-- TOPIC 4: RENTAL AND TENANCY
(19, 4, 'Security deposit not returned by landlord', 'My landlord refuses to return my security deposit after vacating the flat peacefully.', 'Unlawful retention of security deposit without genuine damage repair invoices is a breach of the tenancy agreement and State Rent Control Acts / Model Tenancy Act, recoverable with statutory interest.', 'Normal', 'India'),
(20, 4, 'Threat of illegal eviction or locked out', 'My landlord is threatening to forcefully throw my belongings out or disconnect electricity and water.', 'Landlords cannot forcefully dispossess tenants or cut essential utility connections without obtaining a formal eviction decree from a competent Rent Controller or Civil Court.', 'High', 'India'),
(21, 4, 'Landlord refusing essential repairs', 'My landlord refuses to fix structural damages, severe plumbing leaks, or electrical hazards.', 'Under tenancy laws, landlords have a statutory obligation to maintain tenantable repair. Tenants can serve written notice and, upon default, execute repairs or approach the Rent Controller.', 'Normal', 'India'),
(22, 4, 'Arbitrary and excessive rent increase', 'My landlord is demanding an unjustified and steep rent hike in the middle of an active lease agreement.', 'Rent increases during an active lease term must strictly follow the contractual escalation clause (usually 5% to 10% annually upon renewal) and local tenancy regulations.', 'Normal', 'India'),
(23, 4, 'Tenant refusing to vacate after lease expiry', 'My tenant refuses to vacate the rented property after the lease agreement has expired and notice was served.', 'Under Section 106 of the Transfer of Property Act 1882, the landlord can serve a formal Notice to Quit and file an Eviction Petition before the Rent Authority / Small Causes Court along with damages (mesne profits).', 'High', 'India'),

-- TOPIC 5: FAMILY LAW
(24, 5, 'Mutual consent divorce procedure', 'Both husband and wife agree to separate peacefully and settle alimony, assets, and child custody mutually.', 'Governed by Section 13B of Hindu Marriage Act 1955 or Section 28 of Special Marriage Act 1954. It is the fastest divorce procedure, involving First and Second Motion petitions in Family Court.', 'Normal', 'India'),
(25, 5, 'Contested divorce on grounds of cruelty or desertion', 'I need a divorce due to physical/mental cruelty, desertion, or adultery, but my spouse refuses to agree.', 'Governed by Section 13(1) of Hindu Marriage Act or relevant personal laws. The petitioner must establish grounds such as mental/physical cruelty, desertion for 2+ years, or adultery in Family Court.', 'High', 'India'),
(26, 5, 'Child custody and visitation rights dispute', 'Separated parents disputing custody, care, and visitation access of their minor children.', 'Governed by the Guardians and Wards Act 1890 and Hindu Minority and Guardianship Act 1956. The paramount consideration of the Family Court is strictly the "Welfare of the Child".', 'High', 'India'),
(27, 5, 'Maintenance and alimony claim', 'A dependent spouse or child seeking monthly financial support and maintenance from the earning spouse.', 'Governed by Section 125 CrPC / Section 144 BNSS, Section 24 & 25 of Hindu Marriage Act, and DV Act 2005. Courts award interim and permanent maintenance based on the standard of living and income disclosure.', 'Normal', 'India'),
(28, 5, 'Domestic violence protection and residence order', 'A woman experiencing domestic abuse, harassment, or threats from spouse or in-laws in a shared household.', 'Under Protection of Women from Domestic Violence Act 2005 (PWDVA), the victim can obtain immediate Protection Orders (Sec 18), Residence Orders (Sec 19), Monetary Relief (Sec 20), and emergency police aid.', 'Emergency', 'India'),

-- TOPIC 6: CYBER LAW
(29, 6, 'Online banking, UPI, and phishing fraud', 'Money was debited fraudulently from my bank account via phishing links, fake customer care, or UPI scams.', 'Governed by IT Act 2000 (Sections 43 & 66D) and RBI Zero Liability circular (2017). Immediate reporting within 24 hours freezes fraudulent fund movement via National Cybercrime Helpline 1930.', 'Emergency', 'India'),
(30, 6, 'Social media account hacked or hijacked', 'Someone hacked my Instagram, Facebook, WhatsApp, or email account and changed recovery credentials.', 'Hacking and unauthorized computer system access is a criminal offence under Sections 43 & 66 of the Information Technology Act 2000, punishable with up to 3 years imprisonment and fine.', 'High', 'India'),
(31, 6, 'Online impersonation and fake profiles', 'Someone created a fake profile using my name, photos, and identity to defame me or scam contacts.', 'Governed by Section 66D of IT Act 2000 (cheating by personation using computer resource) and Section 419/500 IPC/BNS. Platforms must remove the fake profile within 24 hours under IT Rules 2021.', 'High', 'India'),
(32, 6, 'Cyber extortion, blackmail, and sextortion', 'Receiving threatening messages, blackmail, or sextortion demands demanding money online.', 'Cyber extortion is punishable under Sections 384, 506 IPC/BNS and Section 66E/67 of the IT Act. Victims should never pay and immediately report to the Cyber Crime Cell and dial 1930.', 'Emergency', 'India'),
(33, 6, 'Personal data leak and doxxing', 'My private phone number, home address, photos, or confidential documents were published online without consent.', 'Violates Section 43A, 72A of the IT Act 2000 and Digital Personal Data Protection Act 2023 (DPDP Act). Victims can mandate immediate webmaster takedowns under IT Intermediary Rules 2021.', 'High', 'India'),
(34, 6, 'Deepfake and non-consensual synthetic media', 'Morphed or AI-generated deepfake photos or videos using my face are being circulated online.', 'Strictly prohibited under Sections 66E, 67, 67A of IT Act 2000 and Section 354C IPC/BNS. Social media platforms are legally mandated to take down non-consensual intimate imagery within 24 hours.', 'Emergency', 'India'),

-- TOPIC 7: CRIMINAL LAW
(35, 7, 'Police refusal to register FIR', 'The local police station refuses to file or register an FIR for a cognizable crime like theft, assault, or fraud.', 'Under Supreme Court ruling (Lalita Kumari v. Govt of UP) and Section 154(3) CrPC / Section 173 BNSS, registration of FIR is mandatory for cognizable offences. Citizens can escalate to the SP or Judicial Magistrate.', 'High', 'India'),
(36, 7, 'Bail application (Anticipatory and Regular)', 'I am apprehending arrest or a family member has been arrested in a non-bailable criminal matter.', 'Governed by Section 437, 438 (Anticipatory Bail), and 439 (Regular Bail) of CrPC / BNSS. Courts evaluate personal liberty against investigation requirements, granting bail on conditions and sureties.', 'High', 'India'),
(37, 7, 'Cheating and criminal breach of trust', 'I was deceived by an individual or business into transferring funds or property based on fraudulent promises.', 'Governed by Section 415, 420 (Cheating) and Section 405, 406 (Criminal Breach of Trust) of IPC / BNS. Actionable by filing an FIR at the police station or a direct criminal complaint before the Magistrate.', 'High', 'India'),
(38, 7, 'Criminal and civil defamation', 'Someone published or spoke false, malicious statements that severely damaged my personal or professional reputation.', 'Governed by Section 499 & 500 IPC / BNS (Criminal Defamation with up to 2 years imprisonment) and Law of Torts for civil monetary compensation and public retraction.', 'Normal', 'India'),

-- TOPIC 8: CIVIL DISPUTES
(39, 8, 'Recovery of money and Summary Suit', 'I lent money or supplied goods with written proof, but the debtor refuses to repay the outstanding debt.', 'Governed by Code of Civil Procedure 1908 (Order XXXVII - Summary Suit) and Limitation Act 1963 (3-year limitation window). Allows fast-track decree without prolonged full trial if debt is supported by documents.', 'High', 'India'),
(40, 8, 'Temporary injunction and stay order', 'Facing an imminent threat of illegal demolition, dispossession, or property sale requiring an immediate stay order.', 'Governed by Specific Relief Act 1963 and Order XXXIX Rules 1 & 2 CPC. Court grants ex-parte stay upon showing a prima facie case, balance of convenience, and irreparable injury.', 'High', 'India'),
(41, 8, 'Neighbor nuisance and noise dispute', 'Persistent loud noise, structural hazards, or blocked common passage caused by an uncooperative neighbor.', 'Actionable under Section 133 CrPC / BNSS (Conditional Order for removal of public nuisance by Executive Magistrate / SDM) and civil suit for private nuisance and permanent injunction.', 'Normal', 'India'),

-- TOPIC 9: CONTRACT LAW
(42, 9, 'Breach of contract and compensation for loss', 'The other contracting party failed to perform their contractual commitments, causing severe financial loss.', 'Governed by Sections 73 & 74 of the Indian Contract Act 1872. The aggrieved party is legally entitled to compensation for direct financial loss or liquidated damages specified in the contract.', 'High', 'India'),
(43, 9, 'Unpaid B2B invoices and MSME payment default', 'A client or corporate buyer has defaulted on paying invoices for supplied goods or rendered services.', 'Under Section 15 & 16 of the MSMED Act 2006, buyers must pay within 45 days, failing which compound interest at 3 times the RBI bank rate is mandatory via the MSME Samadhaan portal.', 'High', 'India'),
(44, 9, 'Breach of Non-Disclosure Agreement (NDA)', 'An ex-employee, partner, or contractor leaked proprietary business trade secrets or confidential data.', 'Actionable under the Indian Contract Act 1872 and Specific Relief Act. Entitles the business to an urgent injunction, seizure of infringing data, and punitive civil damages.', 'High', 'India'),
(45, 9, 'Verbal agreement and informal contract dispute', 'We entered into a verbal business agreement and the counterparty now denies the agreed terms.', 'Under Section 10 of the Indian Contract Act 1872, oral contracts are valid if they have lawful offer, acceptance, and consideration. Proving terms requires circumstantial digital trails and conduct.', 'Normal', 'India'),

-- TOPIC 10: BANKING AND FINANCE
(46, 10, 'Cheque bounce (Section 138 NI Act)', 'A bank cheque issued to me was dishonored due to insufficient funds or account closed.', 'Under Section 138 of Negotiable Instruments Act 1881, cheque dishonour is a criminal offence punishable with up to 2 years imprisonment or a fine up to double the cheque amount, plus 20% interim compensation.', 'High', 'India'),
(47, 10, 'Loan recovery agent harassment', 'Recovery agents are threatening me or my family, using abusive language, or calling outside permitted hours.', 'Violates RBI Master Directions and Fair Practices Code (2022). Recovery agents are strictly barred from calling before 8 AM / after 7 PM, using abusive language, or harassing family members.', 'High', 'India'),
(48, 10, 'CIBIL credit score dispute and errors', 'My credit score was damaged due to incorrect loan default status or delayed reporting by the bank.', 'Under the Credit Information Companies (Regulation) Act 2005 (CICRA), banks must resolve credit bureau errors within 30 days, failing which RBI mandates a penalty of Rs 100 per day of delay.', 'Normal', 'India'),

-- TOPIC 11: INSURANCE
(49, 11, 'Health / Mediclaim cashless claim rejected', 'The insurance company rejected hospital cashless authorization or reimbursement citing non-disclosure or PED.', 'Governed by IRDAI regulations. After 8 years of continuous coverage (moratorium period), claims cannot be repudiated for non-disclosure. Disputed claims can be appealed to the Insurance Ombudsman for free.', 'High', 'India'),
(50, 11, 'Life insurance death claim repudiated', 'The insurer refused to pay the death claim benefit of a family member citing alleged pre-existing conditions.', 'Under Section 45 of the Insurance Act 1938, no life insurance policy can be called in question on any ground whatsoever after the expiry of 3 years from the date of policy issuance.', 'High', 'India'),
(51, 11, 'Motor vehicle insurance accident claim dispute', 'The motor insurer rejected my car/bike damage reimbursement citing minor delay in reporting or survey dispute.', 'The Supreme Court of India has held that genuine accident claims cannot be rejected mechanically on grounds of minor procedural delay in intimating the insurer.', 'Normal', 'India'),

-- TOPIC 12: TRAFFIC AND MOTOR VEHICLE
(52, 12, 'Motor vehicle accident and MACT compensation', 'I or a family member was injured or killed in a road accident caused by a rash and negligent driver.', 'Governed by the Motor Vehicles Act 1988 (amended 2019). The Motor Accident Claims Tribunal (MACT) awards compensation for medical expenses, permanent disability, loss of earnings, and loss of life.', 'Emergency', 'India'),
(53, 12, 'Disputed traffic e-challan', 'I was issued an incorrect traffic fine / e-challan with wrong vehicle registration or wrong photo evidence.', 'Under the Motor Vehicles Act 1988, citizens have the right to contest erroneous virtual challans online via the Parivahan portal or before the Virtual Traffic Court / National Lok Adalat.', 'Normal', 'India'),
(54, 12, 'Hit and run accident solatium scheme', 'A victim was injured or killed in a hit-and-run road accident where the offending vehicle fled and is untraced.', 'Under Section 161 of the Motor Vehicles Act (Scheme for Compensation of Hit and Run Motor Accidents 2022), statutory solatium of Rs 2,00,000 for death and Rs 50,000 for grievous injury is provided.', 'High', 'India'),

-- TOPIC 13: INTELLECTUAL PROPERTY
(55, 13, 'Copyright infringement and content piracy', 'Someone copied and republished my original article, software code, artwork, video, or music without permission.', 'Governed by Section 51 & 63 of the Copyright Act 1957. Copyright exists automatically upon creation. Infringement attracts civil injunctions, damages, and criminal imprisonment up to 3 years.', 'High', 'India'),
(56, 13, 'Trademark infringement and brand passing off', 'A competitor business is using a deceptively similar brand name, logo, or packaging to confuse consumers.', 'Under the Trade Marks Act 1999 (Section 29) and Common Law of Passing Off, the owner can obtain an immediate ex-parte injunction restraining the competitor and seize counterfeit inventory.', 'High', 'India'),
(57, 13, 'Domain name squatting (Cybersquatting)', 'A third party registered my registered business name as a website domain to sell it back for an extortionate price.', 'Governed by the .IN Dispute Resolution Policy (INDRP) for .in domains and ICANN Uniform Domain Name Dispute Resolution Policy (UDRP) through WIPO to transfer domain ownership.', 'Normal', 'India'),

-- TOPIC 14: DIGITAL PRIVACY
(58, 14, 'Violation of Digital Personal Data Protection (DPDP Act)', 'A company or mobile app collected and shared my personal sensitive data without valid consent.', 'Governed by the Digital Personal Data Protection Act 2023 (DPDP Act). Data fiduciaries face statutory penalties up to Rs 250 Crore for failing to protect personal data or respect consent withdrawal.', 'Normal', 'India'),
(59, 14, 'Right to be Forgotten and online search delisting', 'Outdated or expunged criminal records and acquitted matters are showing up in search results harming reputation.', 'Recognized under Article 21 (Fundamental Right to Privacy) by the Supreme Court of India. Aggrieved individuals can request search engine delisting or file a Writ Petition in the High Court.', 'Normal', 'India'),

-- TOPIC 15: EDUCATION
(60, 15, 'College or coaching institute fee refund refusal', 'I cancelled my admission or left a coaching institute, but they refuse to refund advance fees.', 'Under UGC Guidelines on Fee Refund and landmark NCDRC consumer judgments, educational institutes cannot retain full multi-year fees upon student withdrawal and must refund after deducting nominal processing fees.', 'Normal', 'India'),
(61, 15, 'Withholding of degree or transfer certificate', 'A college or school is refusing to release my original marksheets, degree, or TC over disputed fees or arbitrary reasons.', 'The Supreme Court and High Courts have established that educational certificates are the personal property of the student and cannot be held as security or lien by institutions for disputed dues.', 'High', 'India'),
(62, 15, 'Ragging and bullying in educational institution', 'A student is facing physical, verbal, or mental ragging and harassment inside the college campus or hostel.', 'Ragging is a cognizable criminal offence strictly prohibited under UGC Anti-Ragging Regulations 2009. Institutions must act within 24 hours, failing which institutional heads face criminal prosecution.', 'Emergency', 'India'),
(63, 7, 'Physical assault, battery, and violent beating', 'A friend, acquaintance, or third party physically attacked, punched, hit, or beat me causing bodily injury.', 'Under Sections 319-326 of the Indian Penal Code / Sections 115-118 of Bharatiya Nyaya Sanhita (BNS), causing voluntary hurt or grievous hurt is a cognizable criminal offence punishable with rigorous imprisonment and fine.', 'High', 'India'),
(64, 7, 'Attempt to murder, gun violence, and armed attack', 'Someone fired a gun, shot a bullet at me, used a firearm, or attacked me with a deadly weapon attempting to kill me.', 'Under Section 307 of the Indian Penal Code / Section 109 of Bharatiya Nyaya Sanhita (BNS) and the Arms Act 1959, attempt to murder and armed gun attacks are heinous, non-bailable offences punishable with up to life imprisonment.', 'Emergency', 'India'),
(65, 7, 'Death threats and criminal intimidation', 'Someone is threatening to kill me, physically harm me, or intimidate me with weapons or hired goons.', 'Under Section 503 and 506 of the Indian Penal Code / Section 351 of Bharatiya Nyaya Sanhita (BNS), threatening any person with injury to their person, reputation, or property is criminal intimidation punishable with imprisonment.', 'High', 'India'),
(66, 7, 'Theft, robbery, and stolen property', 'Someone stole my money, vehicle, mobile phone, jewelry, or personal belongings without my consent.', 'Under Sections 378, 379, 390 of the Indian Penal Code / Sections 303, 309 of Bharatiya Nyaya Sanhita (BNS), theft and robbery are cognizable offences for which police must register an immediate FIR and initiate recovery.', 'Normal', 'India');

-- --------------------------------------------------------
-- 3. Table structure for table `legal_keywords`
-- --------------------------------------------------------
CREATE TABLE `legal_keywords` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `keyword` varchar(100) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  KEY `case_id` (`case_id`),
  KEY `idx_keyword` (`keyword`),
  CONSTRAINT `legal_keywords_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_keywords`
INSERT INTO `legal_keywords` (`keyword_id`, `case_id`, `keyword`) VALUES
-- Case 1: Defective product
(1, 1, 'defective product'), (2, 1, 'broken item'), (3, 1, 'damaged goods'), (4, 1, 'faulty product'), (5, 1, 'manufacturing defect'), (6, 1, 'product defect'), (7, 1, 'damaged delivery'),
-- Case 2: Refund refused
(8, 2, 'refund refused'), (9, 2, 'seller not refunding'), (10, 2, 'return rejected'), (11, 2, 'refund denied'), (12, 2, 'money not returned'), (13, 2, 'order cancellation refund'),
-- Case 3: Online shopping fraud
(14, 3, 'online shopping fraud'), (15, 3, 'ecommerce fraud'), (16, 3, 'fake shopping website'), (17, 3, 'goods not delivered'), (18, 3, 'instagram store scam'), (19, 3, 'shopping scam'),
-- Case 4: Warranty denied
(20, 4, 'warranty refused'), (21, 4, 'warranty denied'), (22, 4, 'warranty claim rejected'), (23, 4, 'service center refused warranty'), (24, 4, 'product warranty'),
-- Case 5: Deficiency in service
(25, 5, 'deficiency in service'), (26, 5, 'flight cancellation refund'), (27, 5, 'bad service'), (28, 5, 'hotel booking dispute'), (29, 5, 'service not provided'), (30, 5, 'poor service quality'),
-- Case 6: Overcharging MRP
(31, 6, 'mrp overcharging'), (32, 6, 'charged more than mrp'), (33, 6, 'dual mrp'), (34, 6, 'overpriced product'), (35, 6, 'mrp violation'),
-- Case 7: Misleading ad
(36, 7, 'misleading advertisement'), (37, 7, 'fake claims'), (38, 7, 'false advertising'), (39, 7, 'deceptive marketing'), (40, 7, 'misleading ad'),
-- Case 8: Unpaid salary
(41, 8, 'unpaid salary'), (42, 8, 'salary not paid'), (43, 8, 'salary delayed'), (44, 8, 'withheld wages'), (45, 8, 'unpaid wages'), (46, 8, 'salary arrears'), (47, 8, 'salary dues'), (48, 8, 'salary withheld'), (49, 8, 'stipend not paid'),
-- Case 9: Wrongful termination
(50, 9, 'wrongful termination'), (51, 9, 'fired unfairly'), (52, 9, 'illegal termination'), (53, 9, 'terminated without cause'), (54, 9, 'forced resignation'), (55, 9, 'illegal firing'),
-- Case 10: POSH harassment
(56, 10, 'workplace harassment'), (57, 10, 'posh complaint'), (58, 10, 'sexual harassment workplace'), (59, 10, 'hostile work environment'), (60, 10, 'boss harassment'), (61, 10, 'internal complaints committee'),
-- Case 11: PF / Gratuity
(62, 11, 'gratuity not paid'), (63, 11, 'pf not transferred'), (64, 11, 'epfo complaint'), (65, 11, 'uan exit mark'), (66, 11, 'provident fund withheld'), (67, 11, 'gratuity calculation'),
-- Case 12: Notice pay termination
(68, 12, 'termination without notice'), (69, 12, 'notice pay not given'), (70, 12, 'immediate termination'), (71, 12, 'fired without notice period'),
-- Case 13: Unpaid overtime
(72, 13, 'unpaid overtime'), (73, 13, 'overtime wages'), (74, 13, 'working extra hours without pay'), (75, 13, 'overtime pay dispute'),
-- Case 14: Property title dispute
(76, 14, 'property ownership dispute'), (77, 14, 'title dispute'), (78, 14, 'property dispute'), (79, 14, 'forged sale deed'), (80, 14, 'land ownership dispute'), (81, 14, 'property title'),
-- Case 15: Builder delay RERA
(82, 15, 'builder delay possession'), (83, 15, 'rera complaint'), (84, 15, 'rera flat delay'), (85, 15, 'possession delayed flat'), (86, 15, 'builder refund rera'), (87, 15, 'builder not giving flat'),
-- Case 16: Encroachment
(88, 16, 'land encroachment'), (89, 16, 'illegal construction boundary'), (90, 16, 'boundary encroachment'), (91, 16, 'neighbor encroached land'), (92, 16, 'illegal land grabbing'),
-- Case 17: Ancestral property partition
(93, 17, 'ancestral property dispute'), (94, 17, 'partition suit'), (95, 17, 'inheritance dispute'), (96, 17, 'father property share'), (97, 17, 'daughter property rights'), (98, 17, 'coparcenary rights'),
-- Case 18: Lost property documents
(99, 18, 'lost property documents'), (100, 18, 'lost sale deed'), (101, 18, 'duplicate sale deed'), (102, 18, 'misplaced property registry'), (103, 18, 'missing land documents'),
-- Case 19: Security deposit
(104, 19, 'security deposit not returned'), (105, 19, 'landlord not returning deposit'), (106, 19, 'rental deposit refund'), (107, 19, 'deposit deduction dispute'), (108, 19, 'landlord withheld deposit'), (109, 19, 'flat deposit refund'),
-- Case 20: Threat of eviction
(110, 20, 'threat of eviction'), (111, 20, 'landlord throwing out'), (112, 20, 'forced eviction'), (113, 20, 'illegal eviction'), (114, 20, 'landlord cutting electricity water'), (115, 20, 'eviction notice dispute'),
-- Case 21: Landlord repairs
(116, 21, 'landlord refusing repairs'), (117, 21, 'rental maintenance dispute'), (118, 21, 'water leakage flat landlord'), (119, 21, 'house repairs landlord not fixing'),
-- Case 22: Rent increase
(120, 22, 'rent increase dispute'), (121, 22, 'landlord increased rent excessive'), (122, 22, 'unfair rent hike'), (123, 22, 'mid lease rent increment'),
-- Case 23: Tenant refusing to vacate
(124, 23, 'tenant refusing to vacate'), (125, 23, 'evicting tenant'), (126, 23, 'tenant not leaving after agreement expired'), (127, 23, 'overstaying tenant'),
-- Case 24: Mutual divorce
(128, 24, 'mutual consent divorce'), (129, 24, 'mutual divorce procedure'), (130, 24, 'amicable divorce'), (131, 24, 'divorce by mutual agreement'), (132, 24, 'section 13b divorce'),
-- Case 25: Contested divorce
(133, 25, 'contested divorce'), (134, 25, 'divorce on cruelty'), (135, 25, 'desertion divorce'), (136, 25, 'filing divorce against spouse'), (137, 25, 'divorce petition'),
-- Case 26: Child custody
(138, 26, 'child custody dispute'), (139, 26, 'child visitation rights'), (140, 26, 'custody of minor child'), (141, 26, 'custody battle'), (142, 26, 'father visitation child'), (143, 26, 'mother custody rights'),
-- Case 27: Maintenance / Alimony
(144, 27, 'maintenance claim'), (145, 27, 'alimony claim'), (146, 27, 'wife maintenance'), (147, 27, 'section 125 crpc'), (148, 27, 'interim maintenance'), (149, 27, 'child maintenance'),
-- Case 28: Domestic violence
(150, 28, 'domestic violence'), (151, 28, 'dv act complaint'), (152, 28, 'protection order'), (153, 28, 'in laws harassment'), (154, 28, 'husband domestic abuse'), (155, 28, '498a domestic violence'),
-- Case 29: Online payment fraud / UPI scam
(156, 29, 'online payment fraud'), (157, 29, 'upi scam'), (158, 29, 'bank fraud online'), (159, 29, 'money stolen online'), (160, 29, 'phishing scam'), (161, 29, 'qr code fraud'), (162, 29, 'unauthorized transaction'), (163, 29, 'cyber fraud 1930'),
-- Case 30: Account hacked
(164, 30, 'social media account hacked'), (165, 30, 'instagram hacked'), (166, 30, 'facebook account hacked'), (167, 30, 'whatsapp hacked'), (168, 30, 'account hijacked'), (169, 30, 'email hacked'),
-- Case 31: Online impersonation
(170, 31, 'online impersonation'), (171, 31, 'fake profile'), (172, 31, 'fake instagram account'), (173, 31, 'identity theft online'), (174, 31, 'someone pretending to be me'),
-- Case 32: Cyber extortion
(175, 32, 'cyber extortion'), (176, 32, 'blackmail online'), (177, 32, 'threatening messages online'), (178, 32, 'sextortion scam'), (179, 32, 'threatened on whatsapp'), (180, 32, 'ransom demands online'),
-- Case 33: Data leak
(181, 33, 'data leak'), (182, 33, 'doxxing'), (183, 33, 'personal information leaked'), (184, 33, 'phone number leaked online'), (185, 33, 'private photos leaked'),
-- Case 34: Deepfake
(186, 34, 'deepfake'), (187, 34, 'morphed photo'), (188, 34, 'fake nude image'), (189, 34, 'ai generated fake image'), (190, 34, 'non consensual image sharing'),
-- Case 35: FIR refused
(191, 35, 'police refusing fir'), (192, 35, 'fir not registered'), (193, 35, 'police complaint rejected'), (194, 35, 'how to file fir'), (195, 35, 'police station refused to file case'),
-- Case 36: Bail application
(196, 36, 'anticipatory bail'), (197, 36, 'regular bail'), (198, 36, 'bail application'), (199, 36, 'arrested by police'), (200, 36, 'how to get bail'), (201, 36, 'criminal defense lawyer'),
-- Case 37: Cheating 420
(202, 37, 'cheating case 420'), (203, 37, 'section 420 ipc'), (204, 37, 'criminal breach of trust'), (205, 37, 'money cheated'), (206, 37, 'fraud complaint police'),
-- Case 38: Defamation
(207, 38, 'defamation case'), (208, 38, 'criminal defamation'), (209, 38, 'slander libel'), (210, 38, 'reputation damaged false allegations'), (211, 38, 'defamatory social media post'),
-- Case 39: Recovery of money
(212, 39, 'recovery of money'), (213, 39, 'money recovery suit'), (214, 39, 'summary suit order 37'), (215, 39, 'lent money not returned'), (216, 39, 'debtor not paying back'),
-- Case 40: Stay order / Injunction
(217, 40, 'stay order'), (218, 40, 'temporary injunction'), (219, 40, 'order 39 cpc'), (220, 40, 'stop demolition court'), (221, 40, 'restrain property sale stay'),
-- Case 41: Neighbor nuisance
(222, 41, 'neighbor dispute'), (223, 41, 'noise nuisance neighbor'), (224, 41, 'neighbor blocking road'), (225, 41, 'section 133 crpc nuisance'), (226, 41, 'neighbor harassment'),
-- Case 42: Breach of contract
(227, 42, 'contract breach'), (228, 42, 'breach of contract'), (229, 42, 'agreement violated'), (230, 42, 'contract terms broken'), (231, 42, 'contractual dispute damages'),
-- Case 43: Unpaid B2B invoices / MSME
(232, 43, 'unpaid invoice'), (233, 43, 'b2b payment default'), (234, 43, 'client not paying invoice'), (235, 43, 'msme samadhaan complaint'), (236, 43, 'vendor payment delayed'),
-- Case 44: NDA Breach
(237, 44, 'nda breach'), (238, 44, 'non disclosure agreement violated'), (239, 44, 'trade secret leaked'), (240, 44, 'confidential data leaked employee'),
-- Case 45: Verbal agreement
(241, 45, 'verbal agreement dispute'), (242, 45, 'oral contract'), (243, 45, 'oral agreement broken'), (244, 45, 'unwritten deal dispute'),
-- Case 46: Cheque bounce
(245, 46, 'cheque bounce'), (246, 46, 'section 138 ni act'), (247, 46, 'bounced cheque'), (248, 46, 'dishonoured cheque'), (249, 46, 'insufficient funds cheque'), (250, 46, 'cheque bounce legal notice'),
-- Case 47: Loan recovery agent harassment
(251, 47, 'recovery agent harassment'), (252, 47, 'loan agent threatening'), (253, 47, 'rbi recovery agent rules'), (254, 47, 'loan recovery abuse'), (255, 47, 'loan app harassment'),
-- Case 48: CIBIL dispute
(256, 48, 'cibil dispute'), (257, 48, 'credit score error'), (258, 48, 'cibil wrong default'), (259, 48, 'credit bureau correction'), (260, 48, 'cibil report dispute'),
-- Case 49: Health insurance rejected
(261, 49, 'insurance claim rejected'), (262, 49, 'health insurance denied'), (263, 49, 'mediclaim claim rejected'), (264, 49, 'cashless claim denied'), (265, 49, 'pre existing disease claim rejection'), (266, 49, 'insurance ombudsman complaint'),
-- Case 50: Life insurance death claim
(267, 50, 'life insurance claim rejected'), (268, 50, 'death claim repudiation'), (269, 50, 'term insurance claim rejected'), (270, 50, 'section 45 insurance act 3 years'),
-- Case 51: Motor insurance claim
(271, 51, 'motor insurance claim rejected'), (272, 51, 'car insurance claim denied'), (273, 51, 'vehicle accident claim dispute'), (274, 51, 'own damage claim delayed'),
-- Case 52: Motor accident MACT
(275, 52, 'motor accident'), (276, 52, 'car accident claim'), (277, 52, 'mact compensation claim'), (278, 52, 'road accident injury claim'), (279, 52, 'hit and run accident'), (280, 52, 'road traffic accident death compensation'),
-- Case 53: Disputed traffic challan
(281, 53, 'traffic fine dispute'), (282, 53, 'wrong traffic challan'), (283, 53, 'contest echallan'), (284, 53, 'fake traffic penalty'), (285, 53, 'disputed virtual court challan'),
-- Case 54: Hit and run solatium
(286, 54, 'hit and run compensation'), (287, 54, 'untraced vehicle accident'), (288, 54, 'hit and run scheme 2022'), (289, 54, 'victim compensation road accident'),
-- Case 55: Copyright infringement
(290, 55, 'copyright infringement'), (291, 55, 'copied content online'), (292, 55, 'plagiarism'), (293, 55, 'stolen code art video'), (294, 55, 'dmca takedown notice'),
-- Case 56: Trademark infringement
(295, 56, 'trademark infringement'), (296, 56, 'brand name copied'), (297, 56, 'logo stolen'), (298, 56, 'passing off brand'), (299, 56, 'counterfeit brand goods'),
-- Case 57: Cybersquatting
(300, 57, 'cybersquatting'), (301, 57, 'domain squatting'), (302, 57, 'brand domain name stolen'), (303, 57, 'indrp dispute nixi'), (304, 57, 'udrp domain dispute'),
-- Case 58: DPDP Act Privacy
(305, 58, 'dpdp act privacy'), (306, 58, 'digital privacy violation'), (307, 58, 'unauthorized data collection'), (308, 58, 'data fiduciary violation'), (309, 58, 'data protection board complaint'),
-- Case 59: Right to be Forgotten
(310, 59, 'right to be forgotten'), (311, 59, 'delisting google search'), (312, 59, 'remove online records'), (313, 59, 'article 21 privacy delisting'),
-- Case 60: College fee refund
(314, 60, 'college fee refund'), (315, 60, 'coaching institute fee refund'), (316, 60, 'ugc fee refund guidelines'), (317, 60, 'admission cancellation refund'), (318, 60, 'fees not returned by college'),
-- Case 61: Degree / TC withheld
(319, 61, 'college withholding degree'), (320, 61, 'marksheet withheld by college'), (321, 61, 'transfer certificate denied'), (322, 61, 'school withholding tc'),
-- Case 62: Ragging complaint
(323, 62, 'ragging complaint'), (324, 62, 'anti ragging helpline 1800-180-5522'), (325, 62, 'college ragging bullying'), (326, 62, 'hostel ragging complaint'),
-- Case 39 additional keywords for friend money
(327, 39, 'friend refusing to return money'), (328, 39, 'friend not returning money'), (329, 39, 'my friend is refusing to return my money'), (330, 39, 'lent money to friend'), (331, 39, 'borrowed money from me'), (332, 39, 'gave money to friend not returning'), (333, 39, 'personal loan to friend default'),
-- Case 63: Physical assault & beating
(334, 63, 'beat me'), (335, 63, 'friend beat me'), (336, 63, 'my friend beat me'), (337, 63, 'physically assaulted'), (338, 63, 'physical attack'), (339, 63, 'beaten up'), (340, 63, 'punched me'), (341, 63, 'hit me'), (342, 63, 'physical violence assault'), (343, 63, 'assault and battery'),
-- Case 64: Gun violence / shot bullet / attempt to murder
(344, 64, 'gun'), (345, 64, 'bullet'), (346, 64, 'shot a bullet'), (347, 64, 'my friend shot a bullet at me'), (348, 64, 'shot me with gun'), (349, 64, 'gun attack'), (350, 64, 'gun violence'), (351, 64, 'shooting'), (352, 64, 'attempt to murder'), (353, 64, 'section 307 ipc'), (354, 64, 'firearm attack'), (355, 64, 'armed attack'),
-- Case 65: Death threats & intimidation
(356, 65, 'threatened to kill me'), (357, 65, 'death threat'), (358, 65, 'criminal intimidation'), (359, 65, 'threatening to murder'), (360, 65, 'threatening my life'), (361, 65, 'threatened with weapon'),
-- Case 66: Theft / Stolen items
(362, 66, 'stolen money'), (363, 66, 'theft'), (364, 66, 'stolen phone'), (365, 66, 'stolen bike vehicle'), (366, 66, 'robbery'), (367, 66, 'house theft burglary');

-- --------------------------------------------------------
-- 4. Table structure for table `legal_documents`
-- --------------------------------------------------------
CREATE TABLE `legal_documents` (
  `document_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `required_level` enum('Essential','Recommended','Optional') DEFAULT 'Recommended',
  `description` text DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `legal_documents_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_documents`
INSERT INTO `legal_documents` (`document_id`, `case_id`, `document_name`, `required_level`, `description`) VALUES
-- Case 1: Defective product
(1, 1, 'Tax Invoice / Retail Bill', 'Essential', 'Proof of purchase, date, product model, and total price paid'),
(2, 1, 'Payment Receipt / Bank Statement', 'Essential', 'Proves transaction execution and merchant recipient details'),
(3, 1, 'Photographs & Unboxing Video of Defect', 'Essential', 'Visual evidence demonstrating the physical or technical defect with visible serial number'),
(4, 1, 'Warranty Card / Manual', 'Recommended', 'Specifies warranty tenure, terms, and manufacturer coverage commitments'),
(5, 1, 'Written Communication / Grievance Tickets', 'Recommended', 'Records attempts made to resolve the defect with the seller/manufacturer'),

-- Case 2: Refund refused
(6, 2, 'Order Confirmation & Invoice', 'Essential', 'Shows purchase details, items, and date'),
(7, 2, 'Cancellation / Return Request Screenshot', 'Essential', 'Shows timely submission of return request within policy window'),
(8, 2, 'Merchant Return Policy Copy', 'Recommended', 'Proves seller published terms that are being violated'),
(9, 2, 'Bank Account Debit Statement', 'Essential', 'Confirms deduction of funds from customer account'),

-- Case 3: Online shopping fraud
(10, 3, 'Bank Account / UPI Transaction Statement with UTR', 'Essential', 'Identifies recipient account, UPI ID, and exact transaction time'),
(11, 3, 'Product Webpage / Social Media Ad Screenshots', 'Essential', 'Captures product claims, advertised price, and seller profile URL'),
(12, 3, 'WhatsApp / Chat Conversation Logs', 'Essential', 'Shows fraudulent promises and subsequent avoidance or blocking'),
(13, 3, 'National Cybercrime Portal Acknowledgment', 'Recommended', 'Complaint submission slip from cybercrime.gov.in (1930)'),

-- Case 4: Warranty denied
(14, 4, 'Original Purchase Bill', 'Essential', 'Validates warranty start date and authorized purchase channel'),
(15, 4, 'Original Manufacturer Warranty Card', 'Essential', 'Establishes warranty duration and manufacturer obligations'),
(16, 4, 'Service Center Job Sheet / Inspection Report', 'Essential', 'Document indicating refusal reason or repair estimate'),
(17, 4, 'Email Correspondence with Customer Support', 'Recommended', 'Shows nodal escalation attempts'),

-- Case 5: Deficiency in service
(18, 5, 'Service Contract / Booking Confirmation Voucher', 'Essential', 'Proves terms, scope, and schedule of the agreed service'),
(19, 5, 'Payment Receipt / Invoices', 'Essential', 'Proves full or partial payment made for the service'),
(20, 5, 'Evidence of Substandard Service / Cancellation Proof', 'Essential', 'Photographs, cancellation emails, or flight delay certificates'),
(21, 5, 'Written Notice to Service Provider', 'Recommended', 'Formal grievance demanding refund or rectification'),

-- Case 6: Overcharging MRP
(22, 6, 'Retail Invoice / Merchant Cash Slip', 'Essential', 'Shows the billed price charged by the seller'),
(23, 6, 'Product Package with Printed MRP', 'Essential', 'Physical packaging showing printed Maximum Retail Price and batch details'),
(24, 6, 'Store Address & GST Details', 'Recommended', 'Identifies legal business entity for Legal Metrology complaint'),

-- Case 7: Misleading ad
(25, 7, 'Copy / Screenshot / Video of Misleading Advertisement', 'Essential', 'Captures deceptive product claims or false performance metrics'),
(26, 7, 'Purchase Bill of Product/Service', 'Essential', 'Establishes consumer standing as an affected purchaser'),
(27, 7, 'Technical Report / Evidence of Non-Conformity', 'Recommended', 'Shows product failure to match advertised performance'),

-- Case 8: Unpaid salary
(28, 8, 'Employment Contract / Offer Letter', 'Essential', 'Establishes employer-employee relationship, salary structure, and pay terms'),
(29, 8, 'Salary Slips (Previous 3-6 Months)', 'Essential', 'Shows regular salary breakdown, basic pay, allowances, and statutory deductions'),
(30, 8, 'Bank Account Statement', 'Essential', 'Proves absence of salary credit for the disputed months'),
(31, 8, 'Timesheet / Attendance / Swipe-in Records', 'Recommended', 'Proves active work performed during the unpaid salary duration'),
(32, 8, 'Emails & Messages with HR / Management', 'Recommended', 'Evidence of written salary requests and employer replies or silence'),

-- Case 9: Wrongful termination
(33, 9, 'Appointment Letter & Service Terms', 'Essential', 'Shows termination clauses, notice period obligations, and severance terms'),
(34, 9, 'Termination Letter / Email', 'Essential', 'Shows date, alleged grounds, and method of termination'),
(35, 9, 'Performance Appraisal & Review Records', 'Recommended', 'Refutes pretextual poor performance claims'),
(36, 9, 'Full and Final Settlement Statement', 'Recommended', 'Shows unpaid notice pay, leave encashment, and severance dues'),

-- Case 10: POSH harassment
(37, 10, 'Formal Written Complaint to ICC', 'Essential', 'Detailed, dated description of harassment incidents, names, and timeline'),
(38, 10, 'Electronic Evidence (WhatsApp, Slack, Emails, Call Logs)', 'Essential', 'Direct evidence of inappropriate messages, calls, or images'),
(39, 10, 'Witness Statements / Colleague Corroboration', 'Recommended', 'Statements from co-workers who witnessed conduct or changes in environment'),
(40, 10, 'Medical / Psychological Counseling Records', 'Optional', 'Evidence of severe distress or trauma resulting from harassment'),

-- Case 11: PF / Gratuity
(41, 11, 'Form 16 / Relieving Letter', 'Essential', 'Proves total length of service (minimum 5 years for Gratuity) and exit date'),
(42, 11, 'Salary Slips Showing PF Deductions', 'Essential', 'Shows employee contributions deducted by employer'),
(43, 11, 'EPFO Member Passbook / UAN Account Details', 'Essential', 'Proves missing PF remittances or failure to mark exit date'),
(44, 11, 'Form I Application for Gratuity Payment', 'Recommended', 'Statutory demand form served on employer'),

-- Case 12: Notice pay termination
(45, 12, 'Employment Agreement', 'Essential', 'Shows mandatory notice period duration (30/60/90 days)'),
(46, 12, 'Immediate Termination Letter', 'Essential', 'Proves termination without serving contractual notice'),
(47, 12, 'Last Drawn Salary Slips', 'Essential', 'Used to calculate exact notice pay amount due'),

-- Case 13: Unpaid overtime
(48, 13, 'Work Timesheet / Biometric Swipe Logs', 'Essential', 'Proves hours worked beyond standard shift limits'),
(49, 13, 'Employment Contract / Shift Schedule', 'Essential', 'Defines standard working hours and shift terms'),
(50, 13, 'Salary Slips Showing Basic Hourly Rates', 'Essential', 'Required to compute double hourly overtime rate'),

-- Case 14: Property title dispute
(51, 14, 'Registered Sale Deed / Title Deed', 'Essential', 'Primary document proving legal ownership and registration'),
(52, 14, 'Encumbrance Certificate (30-Year EC)', 'Essential', 'Shows clean title history and absence of registered encumbrances or mortgages'),
(53, 14, 'Revenue Mutation / Khata Certificate / Patta', 'Essential', 'Revenue records showing owner in government tax rolls'),
(54, 14, 'Property Tax Receipts', 'Essential', 'Continuous proof of physical possession and tax payment'),

-- Case 15: Builder delay RERA
(55, 15, 'Builder-Buyer Agreement (BBA) / Allotment Letter', 'Essential', 'Shows agreed flat possession date, grace period, and unit details'),
(56, 15, 'All Payment Receipts & Bank Account Statements', 'Essential', 'Proves total amount paid to builder till date'),
(57, 15, 'Home Loan Sanction & Disbursement Schedule', 'Recommended', 'Shows EMI burden borne by buyer during delayed period'),
(58, 15, 'Builder Delay Notices & Written Correspondence', 'Recommended', 'Written records of repeated false possession promises'),

-- Case 16: Land encroachment
(59, 16, 'Registered Title Deed & Approved Site Map', 'Essential', 'Proves legal boundaries and exact land dimensions'),
(60, 16, 'Government Revenue Demarcation / Survey Report', 'Essential', 'Official survey conducted by Tehsildar / Taluk office verifying encroachment'),
(61, 16, 'Date-Stamped Photographs of Encroachment', 'Essential', 'Visual evidence of unauthorized construction on demarcated land'),

-- Case 17: Ancestral property partition
(62, 17, 'Title Deeds of all Joint Ancestral Properties', 'Essential', 'Establishes that the properties were acquired by common ancestors'),
(63, 17, 'Genealogical Family Tree / Pedigree Certificate', 'Essential', 'Shows lineage, all legal heirs, and legitimate coparceners'),
(64, 17, 'Death Certificates of Deceased Predecessors', 'Essential', 'Proves succession devolution upon death of ancestors'),
(65, 17, 'Revenue 7/12 Extract / RTC / Jamabandi Records', 'Essential', 'Current revenue status of joint family land parcels'),

-- Case 18: Lost property documents
(66, 18, 'Police Non-Cognizable Report (NCR) / Missing Certificate', 'Essential', 'Official police record confirming loss of original document'),
(67, 18, 'Newspaper Public Notice Clippings (English & Vernacular)', 'Essential', 'Proves public notice was given inviting any claims/objections'),
(68, 18, 'Sub-Registrar Certified Copy Application', 'Essential', 'Receipt for certified true copy extraction under Registration Act'),

-- Case 19: Security deposit
(69, 19, 'Registered / Notarized Rent Agreement', 'Essential', 'Defines security deposit amount, terms of return, and notice period'),
(70, 19, 'Security Deposit Bank Transfer Receipt / UTR', 'Essential', 'Irrefutable proof of initial deposit payment to landlord'),
(71, 19, 'Move-out Inspection Photos / Video Handover Proof', 'Essential', 'Proves premises were returned in clean, undamaged condition'),
(72, 19, 'Written Notice to Vacate & Key Handover Acknowledgment', 'Recommended', 'Confirms timely vacation in accordance with tenancy terms'),

-- Case 20: Threat of eviction
(73, 20, 'Active Rental Agreement', 'Essential', 'Proves ongoing tenancy and unexpired lease period'),
(74, 20, 'Rent Payment Receipts / Bank Transfers', 'Essential', 'Demonstrates up-to-date rent payment with no default'),
(75, 20, 'Audio / Video / WhatsApp Threat Evidence', 'Recommended', 'Records unlawful threats, harassment, or attempts to cut utilities'),

-- Case 21: Landlord repairs
(76, 21, 'Date-Stamped Photos / Videos of Damaged Area', 'Essential', 'Visual evidence of leakage, structural hazard, or faulty wiring'),
(77, 21, 'Written Repair Notices Sent to Landlord', 'Essential', 'Proves landlord was formally informed and given time to repair'),
(78, 21, 'Repair Cost Estimates / Invoices from Licensed Contractor', 'Recommended', 'Itemized cost estimation if tenant undertakes repair'),

-- Case 22: Rent increase
(79, 22, 'Executed Lease Agreement', 'Essential', 'Shows agreed monthly rent and contractual escalation percentage clause'),
(80, 22, 'All Rent Payment Slips to Date', 'Essential', 'Proves regular compliance with agreed rent'),
(81, 22, 'Landlord Rent Increase Demand Letter', 'Recommended', 'Evidence of arbitrary mid-lease hike demand'),

-- Case 23: Tenant refusing to vacate
(82, 23, 'Expired Lease Agreement', 'Essential', 'Proves tenancy term has concluded'),
(83, 23, 'Notice to Quit under Section 106 TPA with Postal Tracking', 'Essential', 'Proves statutory 15/30 day eviction notice was duly served'),
(84, 23, 'Property Ownership Proof / Tax Receipts', 'Essential', 'Proves landlord ownership and locus standi'),

-- Case 24: Mutual divorce
(85, 24, 'Marriage Certificate / Wedding Card with Photographs', 'Essential', 'Proves solemnization and validity of marriage'),
(86, 24, 'Settlement Agreement / MoU on Stamp Paper', 'Essential', 'Outlines agreed terms for permanent alimony, asset division, and child custody'),
(87, 24, 'Identity & Address Proofs of Both Spouses (Aadhaar/Passport)', 'Essential', 'Required for court records and verification'),
(88, 24, 'Income Tax Returns / Income Affidavits (3 Years)', 'Recommended', 'Supports financial settlement disclosure'),

-- Case 25: Contested divorce
(89, 25, 'Marriage Certificate', 'Essential', 'Proof of valid marriage'),
(90, 25, 'Evidence of Cruelty, Desertion, or Adultery', 'Essential', 'Medical reports, police complaints, WhatsApp chats, call recordings, emails'),
(91, 25, 'Mandatory Affidavit of Assets and Liabilities', 'Essential', 'Detailed financial disclosure under Supreme Court guidelines'),

-- Case 26: Child custody
(92, 26, 'Child Birth Certificate', 'Essential', 'Proves parentage and exact age of minor child'),
(93, 26, 'School Progress Reports & Fee Receipts', 'Essential', 'Demonstrates active involvement in child education and daily welfare'),
(94, 26, 'Income Proof & Residence Details of Petitioning Parent', 'Essential', 'Establishes financial and residential suitability for child care'),

-- Case 27: Maintenance / Alimony
(95, 27, 'Comprehensive Affidavit of Assets and Liabilities (Rajnesh v. Neha)', 'Essential', 'Detailed disclosure of bank accounts, properties, income, and liabilities'),
(96, 27, 'Proof of Spouse Income / Lifestyle / Company Filings', 'Essential', 'Salary slips, ITR, LinkedIn profiles, vehicle ownership, GST returns'),
(97, 27, 'Proof of Monthly Living Expenses of Claimant & Children', 'Recommended', 'School fees, medical bills, rent receipts, utility bills'),

-- Case 28: Domestic violence
(98, 28, 'Medico-Legal Certificate (MLC) / Hospital Injury Report', 'Essential', 'Doctor-certified evidence of physical assault or injuries'),
(99, 28, 'Audio / Video / WhatsApp Evidence of Threats & Abuse', 'Essential', 'Demonstrates mental, emotional, or verbal violence'),
(100, 28, 'Police Complaint / Daily Diary Entry Copy', 'Recommended', 'Shows prior reports to local police station or Women Helpline'),

-- Case 29: Online banking / UPI fraud
(101, 29, 'Bank Account Statement Highlighting Fraudulent Debits', 'Essential', 'Shows unauthorized debit amount, time, and recipient reference numbers'),
(102, 29, 'Transaction Reference Numbers (UTR / RRN)', 'Essential', 'Required by Cyber Crime Cell and banks to freeze destination wallets'),
(103, 29, 'Phishing SMS / Link / Call Log Screenshots', 'Essential', 'Shows fraudulent modus operandi used by scammers'),
(104, 29, 'National Cyber Crime Portal Complaint PDF (cybercrime.gov.in)', 'Essential', 'Official cybercrime complaint acknowledgment'),

-- Case 30: Account hacked
(105, 30, 'Screenshots of Hacked Profile / Changed Email Alerts', 'Essential', 'Proves unauthorized change of recovery email/phone number'),
(106, 30, 'Original Account Creation Email / Username History', 'Recommended', 'Helps verify rightful owner identity with platform security teams'),

-- Case 31: Online impersonation
(107, 31, 'Screenshots of Fake Profile & Exact URL / Handle', 'Essential', 'Captures unauthorized use of your name, photos, or bio'),
(108, 31, 'Government Photo ID (Aadhaar / Passport)', 'Essential', 'Proves real identity to platform Grievance Officer and police'),

-- Case 32: Cyber extortion
(109, 32, 'Unedited Chat Transcripts & Payment Demand Screenshots', 'Essential', 'Proves extortion demands, wallet addresses, and threat language'),
(110, 32, 'Extortionist Phone Number / UPI ID / Profile Links', 'Essential', 'Used by Cyber Police for electronic tracing and bank freezes'),

-- Case 33: Data leak
(111, 33, 'Screenshots & Live URLs of Leaked Confidential Data', 'Essential', 'Captures unlawful public exposure of private information'),
(112, 33, 'Proof of Identity / Ownership of Compromised Data', 'Essential', 'Validates that the leaked information belongs to the complainant'),

-- Case 34: Deepfake
(113, 34, 'URLs & Screenshots of Deepfake / Morphed Content', 'Essential', 'Evidence of synthesized imagery for mandatory 24-hour takedown'),
(114, 34, 'Original Unaltered Photographs / Videos', 'Essential', 'Proves source imagery was digitally manipulated'),

-- Case 35: FIR refused
(115, 35, 'Detailed Signed Written Complaint', 'Essential', 'Describes the cognizable offence, accused identity, dates, and witnesses'),
(116, 35, 'Speed Post / Registered Post Receipt & Tracking to SP Office', 'Essential', 'Proves escalation under Section 154(3) CrPC before moving Magistrate'),

-- Case 36: Bail application
(117, 36, 'Certified Copy of FIR & Remand Application', 'Essential', 'Contains exact penal sections invoked against the accused'),
(118, 36, 'Accused Identity & Local Permanent Address Proof', 'Essential', 'Assures court that accused is not a flight risk'),
(119, 36, 'Surety Identity & Solvency Documents (Property Tax / Land Records)', 'Essential', 'Required for executing bail bonds upon release order'),

-- Case 37: Cheating 420
(120, 37, 'Contract / Agreement / Purchase Order', 'Essential', 'Proves terms and promises dishonored by accused'),
(121, 37, 'Bank Statements Showing Fund Transfer to Accused', 'Essential', 'Financial proof of money parted with based on deceit'),
(122, 37, 'Written Communications Showing Fraudulent Intent', 'Essential', 'Chats/emails showing inducement from inception'),

-- Case 38: Defamation
(123, 38, 'Copy / URL / Audio-Video Recording of Defamatory Statement', 'Essential', 'Exact evidence of defamatory words published or spoken'),
(124, 38, 'Proof of Publication to Third Parties', 'Essential', 'Shows statement reached public, colleagues, or community'),
(125, 38, 'Evidence of Harm to Reputation / Business Loss', 'Recommended', 'Loss of clients, contracts, or documented mental distress'),

-- Case 39: Recovery of money
(126, 39, 'Promissory Note / Loan Agreement / Invoices', 'Essential', 'Written instrument proving debt and repayment terms'),
(127, 39, 'Bank Statement Showing Disbursal of Loan / Funds', 'Essential', 'Irrefutable proof that funds were transferred to debtor'),
(128, 39, 'Statutory Demand Notice & Postal Acknowledgment', 'Essential', 'Proves legal demand was served giving 15 days to pay'),

-- Case 40: Stay order / Injunction
(129, 40, 'Title Deeds & Sanctioned Plan Proving Prima Facie Right', 'Essential', 'Establishes lawful interest in the disputed subject matter'),
(130, 40, 'Photographs & Notices Proving Imminent Threat', 'Essential', 'Demonstrates immediate danger of demolition or sale'),

-- Case 41: Neighbor nuisance
(131, 41, 'Audio-Video Recordings with Time & Decibel Logs', 'Essential', 'Objective evidence of excessive noise, obstruction, or hazard'),
(132, 41, 'RWA / Housing Society Complaint Letters', 'Recommended', 'Shows prior attempts at amicable resolution'),

-- Case 42: Breach of contract
(133, 42, 'Executed Agreement with all Annexures', 'Essential', 'Defines rights, obligations, milestone deadlines, and liability terms'),
(134, 42, 'Default Notice / Cure Notice Served on Defaulting Party', 'Essential', 'Proves counterparty was given contractual opportunity to rectify'),
(135, 42, 'Financial Audit / Invoices Proving Direct Losses', 'Essential', 'Quantifies actual monetary damages claimed'),

-- Case 43: Unpaid B2B invoices / MSME
(136, 43, 'MSME Udyam Registration Certificate (if applicable)', 'Essential', 'Invokes fast-track MSMED Act 45-day payment protections'),
(137, 43, 'Purchase Orders (PO) & Tax Invoices', 'Essential', 'Shows agreed scope, rates, and billing details'),
(138, 43, 'Proof of Goods Delivery (Signed Challan / Work Completion)', 'Essential', 'Proves satisfactory delivery of goods or services'),

-- Case 44: NDA Breach
(139, 44, 'Signed Non-Disclosure Agreement (NDA)', 'Essential', 'Shows confidentiality obligations and scope of proprietary data'),
(140, 44, 'Digital Forensic Logs (Email Forwards, USB Downloads, File Access)', 'Essential', 'Forensic proof of unauthorized data exfiltration or disclosure'),

-- Case 45: Verbal agreement
(141, 45, 'WhatsApp / Text / Email Communications Referencing Deal', 'Essential', 'Written digital trail acknowledging understanding and terms'),
(142, 45, 'Bank Statements Showing Consideration Transferred', 'Essential', 'Demonstrates performance of obligations by claimant'),

-- Case 46: Cheque bounce
(143, 46, 'Original Dishonored Cheque', 'Essential', 'The primary negotiable instrument returned unpaid'),
(144, 46, 'Original Cheque Return Memo with Bank Seal', 'Essential', 'Proves reason for dishonor (Insufficient Funds) and start of 30-day notice window'),
(145, 46, 'Statutory 15-Day Demand Notice & Speed Post Receipts', 'Essential', 'Mandatory condition precedent under Section 138 NI Act'),
(146, 46, 'Speed Post Tracking Delivery Confirmation', 'Essential', 'Proves statutory notice was delivered to drawer'),

-- Case 47: Loan recovery agent harassment
(147, 47, 'Audio Call Recordings of Threatening Agents', 'Essential', 'Captures abusive words, intimidation, and agent identity'),
(148, 47, 'Call Detail Logs Showing Odd-Hour Calls (before 8 AM / after 7 PM)', 'Essential', 'Demonstrates violation of RBI Fair Practices Code'),
(149, 47, 'Loan Account Sanction Letter & Statement', 'Recommended', 'Shows active loan details and principal lender'),

-- Case 48: CIBIL dispute
(150, 48, 'Official CIBIL / Experian Credit Report with Control Number', 'Essential', 'Highlights incorrect default, overdue, or wrong account tags'),
(151, 48, 'No Dues Certificate (NDC) / Loan Closure Letter from Bank', 'Essential', 'Proof that loan was fully paid and closed'),

-- Case 49: Health insurance rejected
(152, 49, 'Health Insurance Policy Document & Schedule', 'Essential', 'Shows coverage sum insured, inception date, and active policy term'),
(153, 49, 'Formal Claim Rejection Letter with Reason Code', 'Essential', 'Documents insurer grounds for rejection'),
(154, 49, 'Hospital Discharge Summary & Indoor Case Papers (ICP)', 'Essential', 'Complete medical history and treatment records during hospitalization'),
(155, 49, 'Treating Doctor Certificate on Non-Pre-Existing Status', 'Essential', 'Medical specialist certification refuting insurer pre-existing disease allegations'),
(156, 49, 'Original Medical Bills, Pharmacy Receipts & Diagnostic Reports', 'Essential', 'Proves total incurred healthcare expenses'),

-- Case 50: Life insurance death claim
(157, 50, 'Original Life Insurance Policy Bond', 'Essential', 'Proves policy commencement date and sum assured benefit'),
(158, 50, 'Official Death Certificate', 'Essential', 'Proves fact, date, and cause of demise'),
(159, 50, 'Claim Repudiation Letter', 'Essential', 'Contains insurer rejection rationale (applicable under 3-year Section 45 bar)'),

-- Case 51: Motor insurance claim
(160, 51, 'Motor Insurance Policy Certificate', 'Essential', 'Shows comprehensive coverage and active validity'),
(161, 51, 'Vehicle Registration Certificate (RC) & Driver Driving License', 'Essential', 'Validates lawful vehicle registration and driver eligibility'),
(162, 51, 'Authorized Garage Repair Estimate & Tax Invoices', 'Essential', 'Details accidental damage repair expenses'),

-- Case 52: Motor accident MACT
(163, 52, 'Police FIR, Site Panchnama & Detailed Accident Report (DAR)', 'Essential', 'Proves rash and negligent driving by offending vehicle'),
(164, 52, 'Medico-Legal Certificate (MLC) & Post-Mortem Report (if death)', 'Essential', 'Official medical documentation of injuries or cause of demise'),
(165, 52, 'Disability Certificate Issued by Government Medical Board', 'Essential (for injury)', 'Certifies percentage of permanent physical disability'),
(166, 52, 'Salary Slips / ITR / Income Proof of Victim', 'Essential', 'Basis for calculating multiplier compensation for loss of dependency'),
(167, 52, 'Offending Vehicle RC & Insurance Policy Copy', 'Essential', 'Identifies respondent insurance company liable to indemnify award'),

-- Case 53: Disputed traffic challan
(168, 53, 'Copy of Electronic Traffic Challan with Photographic Evidence', 'Essential', 'Shows disputed registration number, violation code, and timestamp'),
(169, 53, 'Vehicle Registration Certificate (RC)', 'Essential', 'Proves genuine vehicle make, model, and correct number plate format'),
(170, 53, 'Toll Receipts / GPS / Dashcam Proof Showing Vehicle Elsewhere', 'Recommended', 'Alibi proof showing vehicle was in another location during violation'),

-- Case 54: Hit and run solatium
(171, 54, 'Police FIR for Hit and Run Accident', 'Essential', 'Documents accident involving untraced, fleeing vehicle'),
(172, 54, 'Police Untraced / Final Report', 'Essential', 'Official certification that offending vehicle could not be identified'),
(173, 54, 'MLC / Post-Mortem Report & Legal Heir Certificate', 'Essential', 'Required for release of statutory solatium compensation (Rs 2 Lakh)'),

-- Case 55: Copyright infringement
(174, 55, 'Original Work File with Creation Timestamp / Git History', 'Essential', 'Proves prior creation and authorship'),
(175, 55, 'Copyright Registration Certificate', 'Recommended', 'Prima facie statutory proof of ownership'),
(176, 55, 'Infringing Material URLs, Screenshots & Archive Links', 'Essential', 'Captures unauthorized distribution or reproduction'),

-- Case 56: Trademark infringement
(177, 56, 'Trademark Registration Certificate / TM Application', 'Essential', 'Proves registered statutory monopoly over mark, word, or logo'),
(178, 56, 'Invoices & Marketing Materials Showing Prior Commercial Use', 'Essential', 'Establishes continuous business goodwill and market presence'),
(179, 56, 'Photographs Comparing Genuine and Counterfeit Products', 'Essential', 'Demonstrates deceptive similarity and customer confusion'),

-- Case 57: Cybersquatting
(180, 57, 'Trademark Certificate / Business Incorporation Certificate', 'Essential', 'Proves brand ownership prior to domain creation'),
(181, 57, 'WHOIS Record of Disputed Domain Name', 'Essential', 'Shows registration date and details of cybersquatter'),
(182, 57, 'Evidence of Bad Faith (Extortionate Sale Offer / Fake Ads)', 'Essential', 'Mandatory criterion under INDRP / UDRP rules'),

-- Case 58: DPDP Act Privacy
(183, 58, 'Screenshots of App Permissions / Account Privacy Settings', 'Essential', 'Shows data collected without lawful consent or clear notice'),
(184, 58, 'Written Communications with Data Protection Officer (DPO)', 'Essential', 'Proves grievance was formally raised with company'),

-- Case 59: Right to be Forgotten
(185, 59, 'Certified Copy of Acquittal Order / Settlement Decree', 'Essential', 'Proves clean legal status and termination of past proceedings'),
(186, 59, 'Specific URLs to be Delisted from Search Engines', 'Essential', 'Pinpoints offending links causing ongoing reputational harm'),

-- Case 60: College fee refund
(187, 60, 'Admission Fee Receipts & Bank Transfer Challans', 'Essential', 'Proves full payment of fees to college or coaching institute'),
(188, 60, 'Admission Withdrawal Application with Date Stamp / Email', 'Essential', 'Proves timely withdrawal within UGC refund schedule window'),
(189, 60, 'Copy of Official UGC Fee Refund Policy Notification', 'Essential', 'Legal authority mandating refund with max Rs 1000 deduction'),

-- Case 61: Degree / TC withheld
(190, 61, 'Mark Sheets / Proof of Course Completion', 'Essential', 'Proves student successfully cleared academic requirements'),
(191, 61, 'Written Application & College Rejection / Demand Letter', 'Essential', 'Evidence of wrongful certificate retention'),

-- Case 62: Ragging complaint
(192, 62, 'Written Ragging Complaint with Names, Dates & Place', 'Essential', 'Submitted to Anti-Ragging Committee and Principal'),
(193, 62, 'Medical Injury Report (if physical harm occurred)', 'Essential (if injured)', 'Certifies physical assault or trauma'),
(194, 62, 'National Anti-Ragging Helpline Reference Ticket (1800-180-5522)', 'Recommended', 'Federal escalation record triggering mandatory UGC inquiry'),
-- Case 63: Physical assault
(195, 63, 'Medico-Legal Certificate (MLC) / Hospital Injury Report', 'Essential', 'Official medical report from government/private hospital documenting wounds and trauma'),
(196, 63, 'Photographs & Videos of Injuries / Damaged Property', 'Essential', 'Visual proof of bruises, cuts, fractures, or torn clothes'),
(197, 63, 'Eyewitness Statements & Contact Details', 'Recommended', 'Testimonies of individuals who witnessed the attack'),
(198, 63, 'Police Complaint / FIR Copy under Section 323/324 IPC', 'Essential', 'Official police registration of cognizable assault'),
-- Case 64: Gun violence / Attempt to murder
(199, 64, 'Medico-Legal Certificate (MLC) & Emergency Trauma Treatment Records', 'Essential', 'Proves gunshot wounds, entry/exit bullet wounds, or severe trauma'),
(200, 64, 'Police FIR under Section 307 IPC / BNS & Arms Act', 'Essential', 'Mandatory registration of heinous crime by Police'),
(201, 64, 'Ballistic & Forensic Evidence Reports / Cartridge Details', 'Recommended', 'Scientific evidence collected from crime scene'),
(202, 64, 'CCTV Footage / Audio-Video Recordings of Incident', 'Essential', 'Direct electronic recording of the armed attack'),
-- Case 65: Death threats
(203, 65, 'Audio Call Recordings & Voicemails of Threats', 'Essential', 'Captures threat words, extortion, and speaker voice'),
(204, 65, 'Screenshots of WhatsApp / SMS / Social Media Threat Messages', 'Essential', 'Timestamped digital trail of threatening communication'),
(205, 65, 'Police Complaint / Daily Diary Entry (NCR) Copy', 'Essential', 'Proof of formal intimation to law enforcement'),
-- Case 66: Theft
(206, 66, 'Purchase Invoices / Proof of Ownership of Stolen Property', 'Essential', 'Proves lawful ownership, serial numbers, IMEI number, or vehicle chassis details'),
(207, 66, 'Police FIR Copy for Theft under Section 379 IPC', 'Essential', 'Required for insurance claims and police recovery investigations'),
(208, 66, 'CCTV Footage of Theft Occurrence', 'Recommended', 'Visual evidence showing the identity of perpetrator');

-- --------------------------------------------------------
-- 5. Table structure for table `legal_actions`
-- --------------------------------------------------------
CREATE TABLE `legal_actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `action_text` text NOT NULL,
  `step_number` int(11) DEFAULT 1,
  PRIMARY KEY (`action_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `legal_actions_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_actions`
INSERT INTO `legal_actions` (`action_id`, `case_id`, `action_text`, `step_number`) VALUES
-- Case 1: Defective product
(1, 1, 'Preserve the original purchase invoice, packaging, and digital payment receipts.', 1),
(2, 1, 'Record high-resolution photos and an unboxing video clearly displaying the product defect and serial number.', 2),
(3, 1, 'Submit a formal written grievance via email or customer support ticket giving a 7-day deadline for replacement or refund.', 3),
(4, 1, 'File an official consumer grievance on the National Consumer Helpline portal (consumerhelpline.gov.in or Call 1915).', 4),
(5, 1, 'If unresolved, file a formal complaint before the District Consumer Disputes Redressal Commission via e-Daakhil (edaakhil.nic.in).', 5),

-- Case 2: Refund refused
(6, 2, 'Save the order invoice, cancellation acknowledgment, and seller written return policy.', 1),
(7, 2, 'Send a formal email quoting the return policy and Consumer Protection (E-Commerce) Rules 2020.', 2),
(8, 2, 'Raise a transaction chargeback dispute with your credit/debit card issuing bank citing non-receipt of refund.', 3),
(9, 2, 'Lodge a complaint on the National Consumer Helpline (NCH - 1915).', 4),
(10, 2, 'Serve an Advocate Legal Notice demanding immediate refund with 18% annual interest and damages.', 5),

-- Case 3: Online shopping fraud
(11, 3, 'Take complete screenshots of the website/ad, transaction UTR number, and chat conversation logs.', 1),
(12, 3, 'Immediately call the National Cyber Crime Helpline at 1930 to initiate account freezing for the fraudulent recipient.', 2),
(13, 3, 'File an official online cyber fraud complaint on cybercrime.gov.in under financial fraud.', 3),
(14, 3, 'Submit a written fraud notification to your home bank branch within 72 hours to claim zero customer liability.', 4),
(15, 3, 'Report the fraudulent merchant URL and payment gateway to the National Consumer Helpline.', 5),

-- Case 4: Warranty denied
(16, 4, 'Collect the original invoice, warranty booklet, and service center job sheet stating refusal reasons.', 1),
(17, 4, 'Send a formal escalation email to the brand Principal Nodal Officer citing deficiency of service under CPA 2019.', 2),
(18, 4, 'Lodge a complaint on National Consumer Helpline (1915).', 3),
(19, 4, 'Send an Advocate Legal Notice to the manufacturer registered corporate office.', 4),
(20, 4, 'File a petition on e-Daakhil claiming repair/replacement, compensation for harassment, and litigation costs.', 5),

-- Case 5: Deficiency in service
(21, 5, 'Compile booking contracts, payment receipts, and communications with the service provider.', 1),
(22, 5, 'Document the service failure using photos, cancellation messages, or witness accounts.', 2),
(23, 5, 'Submit a formal refund claim to the service provider grievance officer.', 3),
(24, 5, 'Lodge a grievance on the National Consumer Helpline (1915) or sector regulator (e.g. DGCA for airlines).', 4),
(25, 5, 'File a case in District Consumer Disputes Redressal Commission via e-Daakhil.', 5),

-- Case 6: Overcharging MRP
(26, 6, 'Retain the physical package showing the printed MRP and the retailer billing receipt.', 1),
(27, 6, 'Lodge an online complaint with the State Legal Metrology Department.', 2),
(28, 6, 'Register a complaint on the National Consumer Helpline portal (1915).', 3),
(29, 6, 'File a claim before the Consumer Commission for Unfair Trade Practice compensation.', 4),

-- Case 7: Misleading ad
(30, 7, 'Save timestamped recordings/screenshots of the deceptive commercial advertisement.', 1),
(31, 7, 'Document the discrepancy between advertised claims and actual product performance.', 2),
(32, 7, 'File an online complaint with the Advertising Standards Council of India (ASCI) at ascionline.in.', 3),
(33, 7, 'Submit a petition to the Central Consumer Protection Authority (CCPA) and District Consumer Commission.', 4),

-- Case 8: Unpaid salary
(34, 8, 'Collect your offer letter, previous salary slips, timesheets, and bank statement showing unpaid months.', 1),
(35, 8, 'Send a formal written demand email to HR and company directors giving 15 days to disburse all dues.', 2),
(36, 8, 'Serve an Advocate Legal Notice under the Code on Wages 2019 and Payment of Wages Act.', 3),
(37, 8, 'File a formal recovery complaint before the Deputy Labour Commissioner / Labour Conciliation Officer.', 4),
(38, 8, 'File a Summary Recovery Suit under Order 37 CPC or claim in Labour Court.', 5),

-- Case 9: Wrongful termination
(39, 9, 'Preserve the employment contract, appraisal reports, and termination letter.', 1),
(40, 9, 'Do not sign coerced resignation letters or disputed full-and-final settlement waivers under duress.', 2),
(41, 9, 'Send a formal legal reply challenging the illegal termination and claiming severance/notice pay.', 3),
(42, 9, 'File an industrial dispute petition before the Labour Conciliation Officer under Section 2A of Industrial Disputes Act.', 4),
(43, 9, 'Seek reinstatement with full back wages or damages for breach of contract.', 5),

-- Case 10: POSH harassment
(44, 10, 'Maintain a confidential, detailed diary of all incidents with dates, times, words, and locations.', 1),
(45, 10, 'Save screenshots of all relevant WhatsApp chats, emails, and voice recordings.', 2),
(46, 10, 'Submit a formal written complaint to the Internal Complaints Committee (ICC) within 3 months.', 3),
(47, 10, 'Request interim relief (transfer of respondent or paid leave) during the ongoing inquiry.', 4),
(48, 10, 'If company has no ICC or fails to act, file a police complaint under Section 354A IPC / BNS and She-Box portal.', 5),

-- Case 11: PF / Gratuity
(49, 11, 'Check your EPFO Unified Member Portal for contribution logs and mark of exit date.', 1),
(50, 11, 'Calculate statutory gratuity (15 days salary per year of completed service).', 2),
(51, 11, 'Submit statutory Form I for gratuity payment to the employer management.', 3),
(52, 11, 'File an online grievance on the EPFiGMS portal (epfigms.gov.in) against the employer for PF non-remittance.', 4),
(53, 11, 'File an application before the Controlling Authority under the Payment of Gratuity Act.', 5),

-- Case 12: Notice pay termination
(54, 12, 'Examine the notice period clause in your employment agreement.', 1),
(55, 12, 'Calculate the exact gross salary due in lieu of the unserved notice period.', 2),
(56, 12, 'Send a formal demand letter to the employer claiming notice pay and leave encashment.', 3),
(57, 12, 'Serve an Advocate Demand Notice and file a claim with the State Labour Department.', 4),

-- Case 13: Unpaid overtime
(58, 13, 'Gather biometric swipe logs, timesheets, and sent email timestamps proving extra hours.', 1),
(59, 13, 'Calculate total overtime hours and computed double wages due.', 2),
(60, 13, 'Submit a formal overtime claim to the employer under State Shops and Establishments Act.', 3),
(61, 13, 'Lodge a complaint with the local Labour Inspector for statutory inspection and recovery.', 4),

-- Case 14: Property title dispute
(62, 14, 'Obtain certified copies of the registered sale deed, 30-year Encumbrance Certificate, and mutation entries.', 1),
(63, 14, 'Conduct an official search at the Sub-Registrar Office to verify the chain of title.', 2),
(64, 14, 'Engage a property advocate to issue a public notice in local newspapers asserting ownership.', 3),
(65, 14, 'File a Civil Suit for Declaration of Title and Permanent Injunction under the Specific Relief Act 1963.', 4),
(66, 14, 'If forged documents were created, file an immediate criminal complaint / FIR for forgery (Section 467/468/471 IPC/BNS).', 5),

-- Case 15: Builder delay RERA
(67, 15, 'Review the Builder-Buyer Agreement (BBA) and note the promised delivery date including grace period.', 1),
(68, 15, 'Calculate delayed possession interest (usually SBI MCLR + 2%) from the promised delivery date.', 2),
(69, 15, 'Send a formal Advocate Legal Notice demanding immediate possession with interest or full refund.', 3),
(70, 15, 'File an online complaint before the State Real Estate Regulatory Authority (RERA) under Section 18.', 4),
(71, 15, 'Seek execution of RERA order through the Adjudicating Officer / District Collector.', 5),

-- Case 16: Land encroachment
(77, 16, 'Gather registered title deeds, sanctioned site plan, and property tax receipts.', 1),
(78, 16, 'Apply for official boundary demarcation before the Revenue Tehsildar / Taluk Surveyor.', 2),
(79, 16, 'Take dated photographs and video evidence of the encroached boundary.', 3),
(80, 16, 'File a police complaint for criminal trespass (Section 441 IPC / BNS).', 4),
(81, 16, 'File a Civil Suit for Mandatory Injunction, Demolition, and Recovery of Possession in Civil Court.', 5),

-- Case 17: Ancestral property partition
(82, 17, 'Prepare a detailed family pedigree tree and collect title deeds of all joint family properties.', 1),
(83, 17, 'Obtain updated 7/12 extracts, mutation records, and death certificates of common ancestors.', 2),
(84, 17, 'Send an Advocate Legal Notice to all coparceners proposing an amicable partition deed.', 3),
(85, 17, 'If partition is denied, file a Civil Suit for Partition and Separate Possession in the Civil Court.', 4),
(86, 17, 'Apply for an interim injunction restraining co-heirs from selling or transferring any joint properties.', 5),

-- Case 18: Lost property documents
(87, 18, 'File an immediate Non-Cognizable Report (NCR) / Missing Document complaint at the local police station.', 1),
(88, 18, 'Publish a Lost Document Notice in two local newspapers (one English and one regional language).', 2),
(89, 18, 'Apply for a Certified True Copy of the Sale Deed at the Sub-Registrar Office where it was registered.', 3),
(90, 18, 'Execute an Affidavit and Indemnity Bond attested by a Notary Public stating loss of original deed.', 4),
(91, 18, 'Obtain an updated 30-year Encumbrance Certificate to confirm clean title status.', 5),

-- Case 19: Security deposit
(92, 19, 'Assemble the rent agreement, initial deposit payment receipt, and move-out photos/videos.', 1),
(93, 19, 'Send a formal demand email requesting deposit return within 7 days, refuting unjustified deductions.', 2),
(94, 19, 'Serve an Advocate Legal Notice demanding refund with 18% per annum interest.', 3),
(95, 19, 'File a complaint before the Rent Authority / Rent Tribunal under State Tenancy Law.', 4),
(96, 19, 'File a Summary Suit under Order 37 CPC in Civil Court for recovery of liquidated debt.', 5),

-- Case 20: Threat of eviction
(97, 20, 'Keep copies of the active rent agreement and proof of regular rent payments handy.', 1),
(98, 20, 'Record audio/video evidence if the landlord issues verbal threats or tries to disconnect utilities.', 2),
(99, 20, 'If utilities are disconnected, file an urgent police complaint and application before Rent Controller.', 3),
(100, 20, 'File a Civil Suit for Injunction restraining the landlord from dispossession without due process of law.', 4),

-- Case 21: Landlord repairs
(101, 21, 'Document property defects with date-stamped photographs and video walkthrough.', 1),
(102, 21, 'Send a formal written repair notice giving the landlord 15 to 30 days to execute repairs.', 2),
(103, 21, 'Obtain an itemized quotation from a licensed contractor.', 3),
(104, 21, 'Approach the Rent Controller to order mandatory repairs or authorize deduction from future rent.', 4),

-- Case 22: Rent increase
(105, 22, 'Review the rent escalation clause in your executed rental agreement.', 1),
(106, 22, 'Send a polite written response refusing arbitrary mid-tenancy hike beyond contractual terms.', 2),
(107, 22, 'Continue transferring the agreed monthly rent via traceable bank transfer (NEFT/UPI).', 3),
(108, 22, 'If landlord refuses to accept rent, deposit rent before the Rent Controller.', 4),

-- Case 23: Tenant refusing to vacate
(109, 23, 'Verify expiry of the lease agreement and calculate unpaid rent arrears.', 1),
(110, 23, 'Do not attempt forceful physical eviction or cut basic utility connections.', 2),
(111, 23, 'Serve a statutory Notice to Quit under Section 106 Transfer of Property Act via Speed Post.', 3),
(112, 23, 'File an Eviction Petition before the Rent Court / Small Causes Court along with a claim for mesne profits.', 4),

-- Case 24: Mutual divorce
(113, 24, 'Draft and execute a comprehensive Memorandum of Understanding (MoU) on Stamp Paper covering alimony and custody.', 1),
(114, 24, 'File a joint First Motion Petition under Section 13B Hindu Marriage Act in the Family Court.', 2),
(115, 24, 'Appear for First Motion statement recording before the Family Court Judge.', 3),
(116, 24, 'File an application for waiver of the 6-month statutory cooling-off period if all issues are settled.', 4),
(117, 24, 'File the Second Motion Petition and obtain the Final Decree of Divorce.', 5),

-- Case 25: Contested divorce
(118, 25, 'Chronologically document all instances of mental/physical cruelty, desertion, or misconduct.', 1),
(119, 25, 'Collect supporting WhatsApp chats, emails, call logs, medical records, and police complaints.', 2),
(120, 25, 'Engage a matrimonial advocate to serve a Legal Notice for dissolution of marriage.', 3),
(121, 25, 'File a Divorce Petition in the Family Court within territorial jurisdiction under Section 13(1) HMA.', 4),
(122, 25, 'Participate in court-mandated mediation and pursue trial if mediation fails.', 5),

-- Case 26: Child custody
(123, 26, 'Compile evidence of your active emotional involvement, schooling records, and stable home environment.', 1),
(124, 26, 'File a Custody / Guardianship Petition under Guardians and Wards Act 1890 before the Family Court.', 2),
(125, 26, 'File an urgent interim application for daily video calls and weekend physical visitation rights.', 3),
(126, 26, 'Present a structured parenting plan focusing on the paramount welfare and best interest of the child.', 4),

-- Case 27: Maintenance / Alimony
(127, 27, 'Gather full proof of the respondent spouse income, company directorships, lifestyle, and properties.', 1),
(128, 27, 'Prepare and file the mandatory Affidavit of Assets and Liabilities mandated by Supreme Court in Rajnesh v. Neha.', 2),
(129, 27, 'File an application for Interim Maintenance under Section 125 CrPC / BNSS or Section 24 HMA.', 3),
(130, 27, 'Seek salary attachment orders if the respondent fails to pay awarded interim maintenance.', 4),

-- Case 28: Domestic violence
(131, 28, 'Ensure immediate personal physical safety; dial National Emergency 112 or Women Helpline 181.', 1),
(132, 28, 'Get immediate medical treatment at a government hospital and obtain a Medico-Legal Certificate (MLC).', 2),
(133, 28, 'Approach the Protection Officer (PO) appointed under the DV Act in your district.', 3),
(134, 28, 'File an urgent application under Section 12 DV Act before the Judicial Magistrate for Protection & Residence Orders.', 4),
(135, 28, 'Obtain ex-parte Protection Orders restraining the respondent from entering the shared household.', 5),

-- Case 29: Online banking / UPI fraud
(136, 29, 'Immediately dial 1930 (National Cybercrime Helpline) within the Golden Hour to freeze destination bank accounts.', 1),
(137, 29, 'File a complaint on the National Cyber Crime Reporting Portal (cybercrime.gov.in) and note the acknowledgment number.', 2),
(138, 29, 'Submit a written notification along with the cyber complaint to your bank branch within 72 hours.', 3),
(139, 29, 'Block all compromised debit/credit cards, change net banking passwords, and disable UPI IDs.', 4),
(140, 29, 'If bank fails to resolve within 30 days, escalate to the RBI Integrated Ombudsman on cms.rbi.org.in.', 5),

-- Case 30: Account hacked
(141, 30, 'Use platform account recovery mechanisms (instagram.com/hacked or Facebook Compromised Account).', 1),
(142, 30, 'Warn your friends and family across other channels not to send money or respond to messages from the hacked profile.', 2),
(143, 30, 'Preserve screenshots of changed security email alerts and recovery failure logs.', 3),
(144, 30, 'File a complaint on cybercrime.gov.in under Social Media Crime.', 4),
(145, 30, 'Submit a formal grievance ticket to the platform Grievance Officer in India.', 5),

-- Case 31: Online impersonation
(146, 31, 'Take screenshots of the fake profile, bio, handle, and full URL.', 1),
(147, 31, 'Report the profile directly through the in-app reporting button for Impersonation.', 2),
(148, 31, 'File an online cybercrime complaint on cybercrime.gov.in.', 3),
(149, 31, 'Send a formal takedown notice to the platform Grievance Officer under IT Rules 2021 demanding removal within 24 hours.', 4),

-- Case 32: Cyber extortion
(150, 32, 'Do not pay any ransom or send money to the extortionist.', 1),
(151, 32, 'Take unedited screenshots of all messages, payment demands, sender handles, and phone numbers.', 2),
(152, 32, 'Immediately dial 1930 and file an emergency complaint on cybercrime.gov.in.', 3),
(153, 32, 'Block the blackmailer and lock all your social media profiles to private mode.', 4),
(154, 32, 'Approach the Cyber Crime Police Cell for registering an FIR under Section 384 IPC/BNS and Section 66E/67 IT Act.', 5),

-- Case 33: Data leak
(155, 33, 'Archive and take certified screenshots of the webpages where your confidential data is exposed.', 1),
(156, 33, 'Send an emergency takedown notice to the hosting website webmaster and domain registrar.', 2),
(157, 33, 'File a complaint on cybercrime.gov.in under Privacy Violation / DPDP Act.', 3),
(158, 33, 'Submit a delisting request to search engines (Google Removal Form) to de-index the URLs.', 4),

-- Case 34: Deepfake
(159, 34, 'Record URLs and save screenshot evidence of the synthesized fake content.', 1),
(160, 34, 'Submit emergency takedown requests to platform Grievance Officers (mandating removal within 24 hours under IT Rules).', 2),
(161, 34, 'Create a digital hash on StopNCII.org to prevent non-consensual image sharing across platforms.', 3),
(162, 34, 'File a high-priority FIR on cybercrime.gov.in and before the Cyber Crime Police Station.', 4),

-- Case 35: FIR refused
(163, 35, 'Draft a comprehensive written complaint signed with date and time describing the cognizable offence.', 1),
(164, 35, 'Send the complaint via Speed Post to the Superintendent of Police (SP) / Police Commissioner under Section 154(3) CrPC.', 2),
(165, 35, 'Preserve the postal dispatch receipt and online delivery tracking report.', 3),
(166, 35, 'If police still fail to investigate, file an Application under Section 156(3) CrPC / BNSS before the Judicial Magistrate.', 4),
(167, 35, 'The Magistrate will order the police station to register an FIR and submit a compliance report.', 5),

-- Case 36: Bail application
(168, 36, 'Obtain a certified copy of the FIR, Remand Application, and arrest memo.', 1),
(169, 36, 'Engage an experienced criminal defense advocate immediately.', 2),
(170, 36, 'File an Anticipatory Bail petition under Section 438 CrPC before Sessions Court or High Court if arrest is apprehended.', 3),
(171, 36, 'If already arrested, file a Regular Bail application under Section 437/439 CrPC.', 4),
(172, 36, 'Arrange local solvent sureties and execute bail bonds upon grant of bail order.', 5),

-- Case 37: Cheating 420
(173, 37, 'Compile all agreements, invoices, bank statements, and chat logs showing fraudulent promises.', 1),
(174, 37, 'Draft a comprehensive criminal complaint demonstrating fraudulent intention from inception.', 2),
(175, 37, 'Submit the complaint to the Economic Offences Wing (EOW) or local police station for FIR registration.', 3),
(176, 37, 'If police delay, file a Private Criminal Complaint under Section 200 CrPC before the Judicial Magistrate.', 4),

-- Case 38: Defamation
(177, 38, 'Preserve exact clippings, URLs, video recordings, and proof of publication to third parties.', 1),
(178, 38, 'Issue an Advocate Cease & Desist Legal Notice demanding an unconditional public apology and retraction within 7 days.', 2),
(179, 38, 'File a Criminal Defamation complaint under Section 499 & 500 IPC / BNS before the Magistrate Court.', 3),
(180, 38, 'File a Civil Suit for Damages in Civil Court claiming financial compensation for injury to reputation.', 4),

-- Case 39: Recovery of money
(181, 39, 'Verify the 3-year statutory limitation period from the date of default or acknowledgment of debt.', 1),
(182, 39, 'Collect loan agreements, promissory notes, bank statements, and email acknowledgments.', 2),
(183, 39, 'Serve a formal Advocate Legal Notice demanding payment within 15 days along with statutory interest.', 3),
(184, 39, 'File a fast-track Summary Suit under Order XXXVII CPC in the competent Civil Court.', 4),
(185, 39, 'Execute the decree against debtor bank accounts and properties upon non-appearance.', 5),

-- Case 40: Stay order / Injunction
(186, 40, 'Collect title documents, sanctioned plans, and proof of possession establishing a prima facie case.', 1),
(187, 40, 'Document the urgent threat (demolition notice, construction photos, encroachment).', 2),
(188, 40, 'File a Civil Plaint along with an Application for Ex-Parte Ad-Interim Injunction under Order XXXIX Rules 1 & 2 CPC.', 3),
(189, 40, 'Move an urgent mentioning before the Vacation / Duty Judge for immediate interim stay.', 4),

-- Case 41: Neighbor nuisance
(190, 41, 'Log all instances of nuisance with timestamped audio/video recordings and decibel measurements.', 1),
(191, 41, 'Send a formal written complaint to the Housing Society Managing Committee / RWA.', 2),
(192, 41, 'File a petition before the Sub-Divisional Magistrate (SDM) under Section 133 CrPC for removal of public nuisance.', 3),
(193, 41, 'File a Civil Suit for Permanent Injunction and tortious damages in Civil Court.', 4),

-- Case 42: Breach of contract
(194, 42, 'Review the contract terms, dispute resolution clause, and termination provisions.', 1),
(195, 42, 'Issue a formal Cure Notice / Default Notice giving 15 to 30 days to remedy the contractual breach.', 2),
(196, 42, 'Audit and quantify direct financial damages suffered as a consequence of non-performance.', 3),
(197, 42, 'Invoke the Arbitration clause under Arbitration and Conciliation Act 1996 or file a Commercial Suit.', 4),

-- Case 43: Unpaid B2B invoices / MSME
(198, 43, 'Collate all purchase orders, tax invoices, and signed delivery challans / completion certificates.', 1),
(199, 43, 'If registered as MSME, register an online recovery case on the MSME Samadhaan portal (samadhaan.msme.gov.in).', 2),
(200, 43, 'Serve a statutory Demand Notice under Section 8 of the Insolvency and Bankruptcy Code (IBC) for corporate debtors.', 3),
(201, 43, 'Pursue conciliation before the Micro & Small Enterprises Facilitation Council (MSEFC).', 4),

-- Case 44: NDA Breach
(202, 44, 'Perform a forensic audit of company email servers, file download logs, and USB transfer records.', 1),
(203, 44, 'Serve an urgent Cease and Desist Legal Notice demanding return and destruction of proprietary data.', 2),
(204, 44, 'File a Commercial Suit in Commercial Court seeking an ex-parte injunction and seizure of stolen materials.', 3),
(205, 44, 'File a criminal complaint under Section 72A Information Technology Act for disclosure of confidential information.', 4),

-- Case 45: Verbal agreement
(206, 45, 'Collect all WhatsApp chats, email chains, payment receipts, and witness statements corroborating the deal.', 1),
(207, 45, 'Serve an Advocate Legal Notice setting out the sequence of oral agreements, consideration paid, and default.', 2),
(208, 45, 'File a Civil Recovery Suit in the Civil Court based on documentary and circumstantial corroboration.', 3),

-- Case 46: Cheque bounce
(209, 46, 'Receive the original Dishonored Cheque and Bank Return Memo with reason (e.g. Insufficient Funds).', 1),
(210, 46, 'Serve a mandatory **Statutory Legal Notice** via Speed Post within **30 days** of receiving memo, giving **15 days** to pay.', 2),
(211, 46, 'Track and save the Speed Post delivery confirmation report.', 3),
(212, 46, 'If drawer fails to pay within 15 days, file a Criminal Complaint under Section 138 NI Act in Magistrate Court within **30 days**.', 4),
(213, 46, 'Apply for mandatory 20% interim compensation under Section 143A of the Negotiable Instruments Act.', 5),

-- Case 47: Loan recovery agent harassment
(214, 47, 'Record all telephone calls, voicemails, and preserve threatening text messages.', 1),
(215, 47, 'Note agent names, phone numbers, agency, and loan account details.', 2),
(216, 47, 'Submit a formal written complaint to the Bank Principal Nodal Officer and Chief Grievance Officer.', 3),
(217, 47, 'File an online complaint with the RBI Integrated Ombudsman on cms.rbi.org.in.', 4),
(218, 47, 'Lodge a Police Complaint for criminal intimidation and extortion under Section 506 IPC/BNS.', 5),

-- Case 48: CIBIL dispute
(219, 48, 'Download your official CIBIL/Experian credit report and identify the specific erroneous account entry.', 1),
(220, 48, 'Collect the No Dues Certificate (NDC) or Loan Closure Letter from the lending bank.', 2),
(221, 48, 'Raise an online dispute on the CIBIL Dispute Resolution Portal with supporting closure documents.', 3),
(222, 48, 'If not updated within 30 days, file a complaint on RBI CMS portal to claim Rs 100/day statutory compensation.', 4),

-- Case 49: Health insurance rejected
(223, 49, 'Carefully review the insurer rejection letter and identify the specific policy exclusion clause invoked.', 1),
(224, 49, 'Obtain a detailed Treating Doctor Certificate confirming the illness was acute or not pre-existing.', 2),
(225, 49, 'Submit a formal representation to the Insurer Internal Grievance Redressal Officer (GRO).', 3),
(226, 49, 'If rejected or pending for 30 days, file an online complaint before the Insurance Ombudsman (cioins.co.in).', 4),
(227, 49, 'The Insurance Ombudsman hearing is free, fast, and awards binding orders on insurance companies.', 5),

-- Case 50: Life insurance death claim
(228, 50, 'Verify policy commencement date against date of death (invoking Section 45 Insurance Act 3-year incontestability clause).', 1),
(229, 50, 'Assemble policy bond, death certificate, hospital medical papers, and claim repudiation letter.', 2),
(230, 50, 'Submit a formal petition to the Insurer Claims Review Committee.', 3),
(231, 50, 'File a petition before the Insurance Ombudsman or District/State Consumer Disputes Redressal Commission.', 4),

-- Case 51: Motor insurance claim
(232, 51, 'Collect accident photographs, surveyor inspection report, repair estimates, and claim rejection letter.', 1),
(233, 51, 'Send a representation to the insurer GRO citing Supreme Court rulings on procedural delays.', 2),
(234, 51, 'File a complaint before the Insurance Ombudsman for full reimbursement of repair bills.', 3),

-- Case 52: Motor accident MACT
(235, 52, 'Ensure immediate medical treatment and obtain the Medico-Legal Certificate (MLC) from hospital.', 1),
(236, 52, 'Ensure the local police station registers an FIR and prepares the Detailed Accident Report (DAR) within 90 days.', 2),
(237, 52, 'Obtain the offending vehicle insurance certificate, RC, and driver license details.', 3),
(238, 52, 'File a Motor Accident Claim Petition before the MACT Tribunal in whose jurisdiction accident occurred or claimant resides.', 4),
(239, 52, 'MACT will award comprehensive compensation for medical costs, future loss of income, pain, suffering, and disability.', 5),

-- Case 53: Disputed traffic challan
(240, 53, 'Inspect the challan photographic evidence on the Parivahan portal (echallan.parivahan.gov.in).', 1),
(241, 53, 'Identify vehicle mismatch, number plate error, or erroneous violation detection.', 2),
(242, 53, 'Submit an online grievance on the State Traffic Police portal with your RC copy and photos.', 3),
(243, 53, 'If not cancelled, contest the challan before the Virtual Traffic Court Magistrate or National Lok Adalat.', 4),

-- Case 54: Hit and run solatium
(244, 54, 'Ensure an FIR is registered specifically for a Hit and Run road accident.', 1),
(245, 54, 'Obtain the Untraced Final Report from the investigating police officer.', 2),
(246, 54, 'Submit Form I application to the Sub-Divisional Magistrate (Claim Enquiry Officer) within 6 months.', 3),
(247, 54, 'The District Magistrate / Claim Settlement Commissioner will sanction Rs 2,00,000 for death or Rs 50,000 for grievous hurt.', 4),

-- Case 55: Copyright infringement
(248, 55, 'Preserve original work files with timestamped creation metadata or git logs.', 1),
(249, 55, 'Archive the infringing webpage/content using web archive tools and screenshots.', 2),
(250, 55, 'Issue a formal DMCA Takedown Notice and Cease and Desist Letter to the infringer and hosting platform.', 3),
(251, 55, 'File a Commercial Suit in High Court/District Court for permanent injunction, damages, and rendition of accounts.', 4),
(252, 55, 'File a criminal complaint under Section 63 of Copyright Act for seizure of infringing copies.', 5),

-- Case 56: Trademark infringement
(253, 56, 'Gather your Trademark Registration Certificate and invoices showing prior continuous commercial use.', 1),
(254, 56, 'Purchase a sample of the infringing counterfeit product and preserve the invoice as physical proof.', 2),
(255, 56, 'Serve an Advocate Cease & Desist Notice demanding immediate withdrawal and destruction of fake goods.', 3),
(256, 56, 'File a Commercial Suit seeking an Ex-Parte Ad-Interim Injunction and appointment of a Local Commissioner to seize inventory.', 4),

-- Case 57: Cybersquatting
(257, 57, 'Collate your registered trademark certificates and domain registration history.', 1),
(258, 57, 'Document bad faith intention (extortionate sale price demand or deceptive landing pages).', 2),
(259, 57, 'File an INDRP Complaint before the National Internet Exchange of India (NIXI) for .in domains or WIPO for .com domains.', 3),
(260, 57, 'Arbitrator will order unconditional transfer of the domain name to the rightful trademark owner.', 4),

-- Case 58: DPDP Act Privacy
(261, 58, 'Preserve proof of privacy policy violations, unauthorized data sharing, or denied consent withdrawal.', 1),
(262, 58, 'Submit a formal grievance to the company Data Protection Officer (DPO).', 2),
(263, 58, 'If unresolved within 30 days, file an online complaint before the Data Protection Board of India (DPBI).', 3),
(264, 58, 'DPBI can impose heavy statutory financial penalties on the non-compliant data fiduciary.', 4),

-- Case 59: Right to be Forgotten
(265, 59, 'Obtain certified copies of the acquittal judgment or quashing order.', 1),
(266, 59, 'Submit a formal Delisting Request to Google / Bing Legal Removal Portal identifying the specific URLs.', 2),
(267, 59, 'If search engines refuse, file a Writ Petition under Article 226 of the Constitution in the High Court.', 3),
(268, 59, 'High Court will direct search engines and portals to mask names and remove indexing.', 4),

-- Case 60: College fee refund
(269, 60, 'Review your admission cancellation date against the UGC Fee Refund Policy timeline.', 1),
(270, 60, 'Submit a formal written application citing UGC guidelines and demanding 100% refund.', 2),
(271, 60, 'File an online grievance on the UGC e-Samadhan portal (samadhaan.ugc.ac.in).', 3),
(272, 60, 'Serve an Advocate Legal Notice to the college trust / coaching institute management.', 4),
(273, 60, 'File a complaint before the District Consumer Disputes Redressal Commission for refund plus mental agony damages.', 5),

-- Case 61: Degree / TC withheld
(274, 61, 'Submit a formal written requisition for release of original marksheets, degree, and TC.', 1),
(275, 61, 'File a grievance with the University Vice-Chancellor and State Higher Education Department.', 2),
(276, 61, 'Issue an Advocate Legal Notice citing Supreme Court rulings prohibiting document retention for disputed fees.', 3),
(277, 61, 'File a Writ Petition (Mandamus) in the High Court for immediate release of educational certificates.', 4),

-- Case 62: Ragging complaint
(278, 62, 'Immediately dial the 24x7 National Anti-Ragging Toll-Free Helpline at **1800-180-5522** or email helpline@antiragging.in.', 1),
(279, 62, 'Submit an urgent written complaint to the Head of the Institution (Principal/Director) and Anti-Ragging Committee.', 2),
(280, 62, 'The institution is legally mandated to lodge a Police FIR within 24 hours of receiving a ragging complaint.', 3),
(281, 62, 'If college authorities fail to act, file a direct Police FIR under relevant criminal provisions.', 4),
(282, 62, 'Escalate to the UGC and State Anti-Ragging Monitoring Committee.', 5),
-- Case 63: Physical assault
(283, 63, 'Immediately seek emergency medical attention at the nearest hospital and request an official Medico-Legal Case (MLC).', 1),
(284, 63, 'Take clear date-stamped photographs and video recordings of all physical injuries, bruises, and scene of attack.', 2),
(285, 63, 'Go to the nearest police station or dial 112 to lodge an immediate FIR under Sections 323/324/325 IPC / BNS for assault.', 3),
(286, 63, 'Provide names and contact numbers of eyewitnesses and preserve any CCTV footage from nearby buildings.', 4),
(287, 63, 'If police refuse to register FIR, submit written complaint to Superintendent of Police (SP) under Section 154(3) CrPC.', 5),
-- Case 64: Gun violence / Attempt to murder
(288, 64, 'Prioritize immediate life safety; dial 112 (Police & Ambulance) and seek emergency trauma care.', 1),
(289, 64, 'Ensure the government hospital prepares a Medico-Legal Certificate (MLC) documenting firearm wounds.', 2),
(290, 64, 'Police are legally mandated to register an immediate FIR under Section 307 IPC (Attempt to Murder) and Arms Act.', 3),
(291, 64, 'Provide weapon descriptions, assailant details, vehicle numbers, and secure crime scene for ballistic recovery.', 4),
(292, 64, 'Record victim statement under Section 164 CrPC / BNSS before Judicial Magistrate for unshakeable prosecution evidence.', 5),
-- Case 65: Death threats
(293, 65, 'Do not confront the accused directly; preserve all call recordings, voicemails, and chat screenshots.', 1),
(294, 65, 'Lodge an immediate written complaint / FIR at the local police station under Section 506 IPC / BNS.', 2),
(295, 65, 'Submit a formal application requesting police protection if you perceive imminent physical danger.', 3),
(296, 65, 'If threats are received online or over phone, report caller numbers to the Cyber Crime Cell and 1930.', 4),
-- Case 66: Theft
(297, 66, 'Block stolen bank cards, SIM cards, or online accounts immediately to prevent secondary financial loss.', 1),
(298, 66, 'Collate purchase bills, IMEI numbers (for mobile phones), or vehicle registration documents.', 2),
(299, 66, 'Lodge an immediate FIR at the local police station under Section 379 IPC / BNS or via State Police Citizen Portal.', 3),
(300, 66, 'Obtain a signed copy of the FIR and submit a claim to your insurance provider within policy notification timelines.', 4);

-- --------------------------------------------------------
-- 6. Table structure for table `legal_options`
-- --------------------------------------------------------
CREATE TABLE `legal_options` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `option_text` text NOT NULL,
  `priority` int(11) DEFAULT 1,
  PRIMARY KEY (`option_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `legal_options_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_options`
INSERT INTO `legal_options` (`option_id`, `case_id`, `option_text`, `priority`) VALUES
-- Case 1
(1, 1, 'National Consumer Helpline (NCH 1915 / consumerhelpline.gov.in) grievance.', 1),
(2, 1, 'Advocate Legal Notice demanding replacement, refund, and damages.', 2),
(3, 1, 'District Consumer Disputes Redressal Commission (e-Daakhil) complaint.', 3),
-- Case 2
(4, 2, 'Credit card / bank payment chargeback dispute for non-delivery of refund.', 1),
(5, 2, 'Consumer forum petition for Unfair Trade Practice under CPA 2019.', 2),
-- Case 3
(6, 3, 'National Cyber Crime Reporting Portal (1930 / cybercrime.gov.in) emergency fund freeze.', 1),
(7, 3, 'Zero Liability claim before home bank branch within 72 hours.', 2),
(8, 3, 'Police Cyber Cell FIR for cheating (Sec 420 IPC/BNS).', 3),
-- Case 4
(9, 4, 'Direct brand nodal escalation for warranty compliance.', 1),
(10, 4, 'Consumer Court petition claiming replacement and compensation.', 2),
-- Case 5
(11, 5, 'Alternative Dispute Resolution / Sectoral Regulator grievance.', 1),
(12, 5, 'District Consumer Commission suit for deficiency in service.', 2),
-- Case 6
(13, 6, 'State Legal Metrology Department complaint for penalty on merchant.', 1),
(14, 6, 'Consumer Forum claim for refund of excess charge and litigation costs.', 2),
-- Case 7
(15, 7, 'Complaint to Central Consumer Protection Authority (CCPA).', 1),
(16, 7, 'Advertising Standards Council of India (ASCI) complaint.', 2),
-- Case 8
(17, 8, 'Formal Advocate Demand Notice under Code on Wages 2019.', 1),
(18, 8, 'Complaint before Deputy Labour Commissioner under Payment of Wages Act.', 2),
(19, 8, 'Summary Recovery Suit under Order XXXVII CPC in Civil Court.', 3),
-- Case 9
(20, 9, 'Conciliation proceedings before Labour Conciliation Officer.', 1),
(21, 9, 'Civil Suit for damages and severance pay for wrongful termination.', 2),
-- Case 10
(22, 10, 'Internal Complaints Committee (ICC) formal inquiry under POSH Act.', 1),
(23, 10, 'Police FIR under Section 354A / 509 IPC / BNS and She-Box portal.', 2),
-- Case 11
(24, 11, 'Online grievance on EPFiGMS portal (epfigms.gov.in) for PF.', 1),
(25, 11, 'Application to Controlling Authority under Payment of Gratuity Act 1972.', 2),
-- Case 12
(26, 12, 'Advocate Demand Notice for recovery of notice period salary.', 1),
(27, 12, 'Complaint to State Labour Department.', 2),
-- Case 13
(28, 13, 'Labour Inspector inspection and penalty claim.', 1),
(29, 13, 'Statutory claim under State Shops & Establishments Act for double wages.', 2),
-- Case 14
(30, 14, 'Civil Suit for Declaration of Title and Permanent Injunction.', 1),
(31, 14, 'Criminal FIR for forgery and fraudulent registration (Sec 467/468/471 IPC).', 2),
-- Case 15
(32, 15, 'RERA Complaint under Section 18 for delayed possession interest / full refund.', 1),
(33, 15, 'National Consumer Disputes Redressal Commission (NCDRC) petition.', 2),
-- Case 16
(34, 16, 'Demarcation application before Revenue Tehsildar / Patwari.', 1),
(35, 16, 'Civil Suit for Injunction and Demolition of illegal encroachment.', 2),
(36, 16, 'Police complaint for Criminal Trespass (Sec 441 IPC/BNS).', 3),
-- Case 17
(37, 17, 'Registered Partition Deed through mutual consensus among legal heirs.', 1),
(38, 17, 'Civil Suit for Partition and Separate Possession with interim stay.', 2),
-- Case 18
(39, 18, 'Obtaining Certified True Copies from Sub-Registrar Office.', 1),
(40, 18, 'Indemnity Bond and public notice title reconstruction.', 2),
-- Case 19
(41, 19, 'Advocate Legal Notice demanding immediate refund with 18% interest.', 1),
(42, 19, 'Complaint before Rent Authority / Rent Tribunal.', 2),
(43, 19, 'Summary Suit under Order 37 CPC in Civil Court.', 3),
-- Case 20
(44, 20, 'Urgent Civil Injunction restraining illegal dispossession.', 1),
(45, 20, 'Rent Controller application for restoration of basic amenities.', 2),
(46, 20, 'Police protection complaint against physical threats.', 3),
-- Case 21
(47, 21, 'Written notice to landlord and self-repair deduction under tenancy rules.', 1),
(48, 21, 'Rent Controller petition to order mandatory structural repairs.', 2),
-- Case 22
(49, 22, 'Formal dispute response adhering to agreement escalation clause.', 1),
(50, 22, 'Standard rent determination application before Rent Tribunal.', 2),
-- Case 23
(51, 23, 'Statutory Notice to Quit under Section 106 Transfer of Property Act.', 1),
(52, 23, 'Eviction Petition before Rent Court / Small Causes Court with mesne profits.', 2),
-- Case 24
(53, 24, 'Joint Mutual Consent Divorce Petition (Section 13B Hindu Marriage Act).', 1),
(54, 24, 'Application for waiver of 6-month statutory cooling-off period.', 2),
-- Case 25
(55, 25, 'Contested Divorce Petition in Family Court under Section 13(1) HMA.', 1),
(56, 25, 'Interim maintenance application under Section 24 HMA during pendency.', 2),
-- Case 26
(57, 26, 'Guardianship and Custody petition under Guardians & Wards Act 1890.', 1),
(58, 26, 'Interim visitation and shared parenting order application.', 2),
-- Case 27
(59, 27, 'Interim maintenance petition under Section 125 CrPC / Section 144 BNSS.', 1),
(60, 27, 'Salary attachment application for non-compliance with maintenance awards.', 2),
-- Case 28
(61, 28, 'Emergency Protection Order (Sec 18) and Residence Order (Sec 19) under DV Act.', 1),
(62, 28, 'Police FIR under Section 498A / 354 IPC and Domestic Violence Act.', 2),
-- Case 29
(63, 29, 'Immediate 1930 Cyber Helpline reporting within Golden Hour for fund freezing.', 1),
(64, 29, 'RBI Integrated Ombudsman complaint for zero liability recovery.', 2),
(65, 29, 'Cyber Crime Police FIR.', 3),
-- Case 30
(66, 30, 'Platform Grievance Officer escalation for account recovery.', 1),
(67, 30, 'Cyber Crime Cell report for account takedown and IP logging.', 2),
-- Case 31
(68, 31, 'Mandatory 24-hour takedown under IT Intermediary Rules 2021.', 1),
(69, 31, 'Police FIR under Section 66D IT Act (cheating by personation).', 2),
-- Case 32
(70, 32, 'Emergency Cybercrime Police FIR for extortion (Sec 384 IPC / Sec 66E IT Act).', 1),
(71, 32, 'Immediate bank account freeze of extortionist via 1930.', 2),
-- Case 33
(72, 33, 'Emergency takedown notice under Rule 3(2)(b) IT Rules 2021.', 1),
(73, 33, 'Complaint before Data Protection Board of India for breach of privacy.', 2),
-- Case 34
(74, 34, 'Mandatory 24-hour platform takedown under IT Rules and StopNCII hash matching.', 1),
(75, 34, 'Cyber Police FIR under Section 66E/67A IT Act and Section 354C IPC.', 2),
-- Case 35
(76, 35, 'Representation to Superintendent of Police (SP) under Section 154(3) CrPC.', 1),
(77, 35, 'Application under Section 156(3) CrPC before Judicial Magistrate to order FIR.', 2),
(78, 35, 'Writ of Mandamus before the High Court.', 3),
-- Case 36
(79, 36, 'Anticipatory Bail petition under Section 438 CrPC before Sessions/High Court.', 1),
(80, 36, 'Regular Bail application under Section 439 CrPC post-arrest.', 2),
-- Case 37
(81, 37, 'Police FIR under Section 420 (Cheating) and 406 (Breach of Trust) IPC/BNS.', 1),
(82, 37, 'Private Criminal Complaint before Magistrate under Section 200 CrPC.', 2),
-- Case 38
(83, 38, 'Advocate Cease & Desist Notice demanding unconditional public retraction.', 1),
(84, 38, 'Criminal Defamation complaint under Section 500 IPC before Magistrate.', 2),
(85, 38, 'Civil Suit for financial damages for loss of reputation.', 3),
-- Case 39
(86, 39, 'Statutory Demand Notice followed by Summary Suit under Order XXXVII CPC.', 1),
(87, 39, 'Pre-Institution Commercial Mediation.', 2),
-- Case 40
(88, 40, 'Ex-Parte Ad-Interim Injunction Order under Order XXXIX Rules 1 & 2 CPC.', 1),
(89, 40, 'Contempt application for breach of stay order under Order 39 Rule 2A CPC.', 2),
-- Case 41
(90, 41, 'Executive Magistrate conditional order under Section 133 CrPC / BNSS.', 1),
(91, 41, 'Civil Suit for Permanent Injunction against private nuisance.', 2),
-- Case 42
(92, 42, 'Arbitration invocation under Arbitration & Conciliation Act 1996.', 1),
(93, 42, 'Commercial Suit for direct financial damages under Section 73 Contract Act.', 2),
-- Case 43
(94, 43, 'Online MSME Samadhaan Facilitation Council conciliation & arbitration.', 1),
(95, 43, 'Section 8 IBC Statutory Demand Notice for corporate debtors.', 2),
-- Case 44
(96, 44, 'Emergency Commercial Injunction restraining disclosure of trade secrets.', 1),
(97, 44, 'Civil Suit for punitive damages and criminal complaint under Sec 72A IT Act.', 2),
-- Case 45
(98, 45, 'Advocate Legal Notice demanding written acknowledgment of debt.', 1),
(99, 45, 'Civil Recovery Suit based on digital corroboration and bank trails.', 2),
-- Case 46
(100, 46, 'Mandatory 15-Day Statutory Legal Notice under Section 138 NI Act.', 1),
(101, 46, 'Criminal Complaint under Section 138 NI Act within 30 days of default.', 2),
(102, 46, 'Interim compensation application under Section 143A NI Act (up to 20%).', 3),
-- Case 47
(103, 47, 'Complaint on RBI CMS Portal (cms.rbi.org.in) against recovery agency abuse.', 1),
(104, 47, 'Police FIR for criminal intimidation under Section 506 IPC/BNS.', 2),
-- Case 48
(105, 48, 'Online dispute resolution on CIBIL portal with No Dues Certificate.', 1),
(106, 48, 'Escalation to RBI Ombudsman for statutory delay compensation (Rs 100/day).', 2),
-- Case 49
(107, 49, 'Online petition before Insurance Ombudsman (cioins.co.in - free & binding).', 1),
(108, 49, 'District Consumer Disputes Redressal Commission petition for claim + interest.', 2),
-- Case 50
(109, 50, 'Representation under Section 45 Insurance Act (3-year incontestability rule).', 1),
(110, 50, 'Insurance Ombudsman petition / State Consumer Commission complaint.', 2),
-- Case 51
(111, 51, 'Grievance before Insurance Ombudsman for motor damage reimbursement.', 1),
(112, 51, 'Consumer Court petition against unfair claim repudiation.', 2),
-- Case 52
(113, 52, 'Motor Accident Claim Petition before MACT for comprehensive compensation.', 1),
(114, 52, 'National Lok Adalat expedited settlement with motor insurance company.', 2),
-- Case 53
(115, 53, 'Online grievance submission on Parivahan e-Challan portal.', 1),
(116, 53, 'Contesting before Virtual Traffic Court Magistrate or Lok Adalat.', 2),
-- Case 54
(117, 54, 'Form I application to Claim Settlement Commissioner (District Magistrate).', 1),
(118, 54, 'General Insurance Council solatium scheme disbursement (Rs 2 Lakh).', 2),
-- Case 55
(119, 55, 'DMCA / Intermediary Takedown Notice to web host & platforms.', 1),
(120, 55, 'Commercial Suit for Permanent Injunction, Damages & Rendition of Accounts.', 2),
(121, 55, 'Police FIR under Section 63 Copyright Act for seizure of copies.', 3),
-- Case 56
(122, 56, 'Cease & Desist Legal Notice demanding immediate withdrawal of fake goods.', 1),
(123, 56, 'Commercial Court Suit with Local Commissioner search and seizure order.', 2),
-- Case 57
(124, 57, 'INDRP Arbitration complaint before NIXI (.in domain transfer).', 1),
(125, 57, 'UDRP Arbitration complaint before WIPO (.com domain transfer).', 2),
-- Case 58
(126, 58, 'Grievance to Company Data Protection Officer (DPO).', 1),
(127, 58, 'Complaint before Data Protection Board of India for statutory penalties.', 2),
-- Case 59
(128, 59, 'Search Engine Delisting Request (Google/Bing Legal Removal Form).', 1),
(129, 59, 'High Court Writ Petition under Article 226 for Right to be Forgotten.', 2),
-- Case 60
(130, 60, 'Grievance on UGC e-Samadhan Portal (samadhaan.ugc.ac.in).', 1),
(131, 60, 'Consumer Commission petition for 100% refund plus compensation.', 2),
-- Case 61
(132, 61, 'University Vice-Chancellor / Higher Education Directorate grievance.', 1),
(133, 61, 'High Court Writ of Mandamus for immediate release of certificates.', 2),
-- Case 62
(134, 62, 'Emergency National Anti-Ragging Helpline report (1800-180-5522).', 1),
(135, 62, 'Mandatory Police FIR by Institution within 24 hours under UGC Regulations.', 2),
-- Case 63
(136, 63, 'Police FIR under Sections 323, 324, 325 IPC / BNS for voluntary hurt & assault.', 1),
(137, 63, 'Private Criminal Complaint before Judicial Magistrate under Section 200 CrPC.', 2),
(138, 63, 'Civil Suit for financial damages and compensation for medical expenses & trauma.', 3),
-- Case 64
(139, 64, 'Immediate Police FIR under Section 307 IPC / Section 109 BNS & Arms Act 1959.', 1),
(140, 64, 'Judicial Magistrate Statement recording under Section 164 CrPC / BNSS.', 2),
(141, 64, 'Opposing bail petitions in Sessions Court / High Court for heinous armed violence.', 3),
-- Case 65
(142, 65, 'Police FIR under Section 506 IPC / BNS for Criminal Intimidation.', 1),
(143, 65, 'Emergency Police Protection Application before the Commissioner / SP.', 2),
-- Case 66
(144, 66, 'Police FIR under Section 379 IPC / BNS for theft investigation and property recovery.', 1),
(145, 66, 'Insurance claim settlement based on Police Untraced Final Report.', 2);

-- --------------------------------------------------------
-- 7. Table structure for table `legal_sources`
-- --------------------------------------------------------
CREATE TABLE `legal_sources` (
  `source_id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` int(11) NOT NULL,
  `source_name` varchar(255) DEFAULT NULL,
  `source_url` text DEFAULT NULL,
  `source_type` varchar(100) DEFAULT NULL,
  `last_verified` date DEFAULT NULL,
  PRIMARY KEY (`source_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `legal_sources_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `legal_cases` (`case_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `legal_sources`
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
(21, 62, 'National Anti-Ragging Portal', 'https://antiragging.in', 'Official Portal', '2026-08-01'),
(22, 63, 'Indian Penal Code Sections 319-326 / BNS 115-118', 'https://legislative.gov.in', 'Statutory Act', '2026-08-01'),
(23, 64, 'Section 307 IPC & Arms Act 1959', 'https://mha.gov.in', 'Statutory Act', '2026-08-01'),
(24, 65, 'Section 503 & 506 IPC (Criminal Intimidation)', 'https://legislative.gov.in', 'Statutory Act', '2026-08-01'),
(25, 66, 'Section 378-382 IPC (Theft & Recovery)', 'https://legislative.gov.in', 'Statutory Act', '2026-08-01');

-- --------------------------------------------------------
-- 8. Table structure for table `users`
-- --------------------------------------------------------
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT '',
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample admin/demo user (password: admin123)
INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `phone`, `created_at`) VALUES
(1, 'Demo', 'User', 'demo@lex.local', 'admin123', '9876543210', current_timestamp());

-- --------------------------------------------------------
-- 9. Table structure for table `conversations`
-- --------------------------------------------------------
CREATE TABLE `conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_message` text NOT NULL,
  `lex_response` text NOT NULL,
  `topic` varchar(255) DEFAULT 'General',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Commit transaction
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
