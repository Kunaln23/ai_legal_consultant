"""Idempotent common-language aliases for the Lex legal case database."""
_ALIASES_APPLIED = False
KEYWORD_ALIASES = {29: ['otp scam', 'otp fraud', 'shared otp', 'shared one time password', 'bank employee called me', 'fake bank call', 'bank impersonation', 'unauthorized bank debit', 'money deducted from bank account', 'money debited without permission', 'unknown transaction', 'fraudulent upi transaction', 'upi money deducted', 'account debited', 'money stolen from bank', 'online banking scam', 'fake customer care', 'remote access app fraud', 'screen sharing fraud', 'payment app scam', '1930 cyber financial fraud'], 32: ['private photos blackmail', 'threatening to share photos', 'threat to leak photos', 'blackmail for money', 'pay or photos leaked', 'intimate image blackmail', 'private video blackmail', 'threatening to post private pictures', 'sextortion', 'demanding money to keep photos private', 'online blackmail', 'blackmail on instagram', 'blackmail on whatsapp', 'threatening messages for money', 'extortion through social media'], 4: ['phone stopped working', 'product stopped working', 'seller refuses replacement', 'replacement refused under warranty', 'repair refused under warranty', 'warranty not honoured', 'warranty not honored', 'service centre refusing repair', 'device faulty', 'mobile defective', 'laptop defective', 'product malfunction', 'defective electronics', 'warranty claim refused'], 2: ['online seller refuses refund', 'seller will not refund', 'refund not received', 'seller refusing replacement', 'cancelled order refund', 'money not returned by seller', 'ecommerce refund dispute', 'online purchase refund'], 34: ['morphed private photo', 'fake explicit image', 'ai generated intimate image', 'someone made fake nude photo', 'face morphed into photo', 'deepfake video of me', 'non consensual intimate image'], 33: ['private pictures shared without consent', 'personal details leaked', 'address leaked online', 'phone number published online', 'private information posted online'], 37: ['person took money by lying', 'fraudulent promise', 'deceived into paying', 'someone cheated me for money', 'money taken on false promise', 'investment promise fraud', 'trust breach'], 63: ['someone slapped me', 'someone punched me', 'beaten by a person', 'physical attack', 'hit me during argument', 'injured in a fight'], 65: ['threatened to kill me', 'death threat on phone', 'threatening to harm me', 'receiving threats', 'threats from neighbour', 'threats from someone'], 66: ['my phone was stolen', 'mobile phone stolen', 'wallet stolen', 'someone took my belongings', 'stolen vehicle', 'theft of property'], 17: ['brother denying inheritance', 'share in ancestral property', 'family property share', 'father died without will', 'inheritance without a will', 'legal heir property share'], 19: ['landlord kept my deposit', 'owner not returning deposit', 'rental deposit withheld', 'security money not returned', 'flat owner refusing deposit refund'], 8: ['company has not paid salary', 'salary pending for months', 'employer holding my pay', 'monthly wages not received', 'salary not credited', 'pending salary payment'], 46: ['cheque bounced', 'cheque dishonoured', 'payment cheque returned', 'insufficient funds cheque'], 35: ['police not accepting complaint', 'police refusing complaint', 'police will not register fir', 'station refused to file fir'], 62: ['college ragging', 'senior students harassing me', 'bullied in college', 'harassment in hostel'], 60: ['college not refunding fees', 'admission cancellation refund', 'coaching fees not returned', 'education institute refusing refund'], 52: ['injured in road accident', 'road accident compensation', 'rash driving accident', 'vehicle accident injury claim'], 12: ['fired without notice', 'terminated without notice pay', 'job ended without notice period', 'dismissed suddenly'], 10: ['unwanted touching at work', 'sexual comments at workplace', 'harassed by manager', 'workplace sexual harassment complaint']}

def apply_keyword_aliases(connection):
    """Add common user phrasings once per running process."""
    global _ALIASES_APPLIED
    if _ALIASES_APPLIED:
        return
    cursor = None
    try:
        cursor = connection.cursor()
        for case_id, terms in KEYWORD_ALIASES.items():
            for term in terms:
                cursor.execute(
                    "INSERT INTO legal_keywords (case_id, keyword) "
                    "SELECT %s, %s WHERE NOT EXISTS ("
                    "SELECT 1 FROM legal_keywords WHERE case_id = %s AND LOWER(keyword) = LOWER(%s))",
                    (case_id, term, case_id, term)
                )
        connection.commit()
        _ALIASES_APPLIED = True
    except Exception as exc:
        print("Lex keyword enhancement notice:", exc)
        try: connection.rollback()
        except Exception: pass
    finally:
        if cursor:
            try: cursor.close()
            except Exception: pass
