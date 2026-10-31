# Convert lex_db.sql to backend/lex_db.sqlite
import sqlite3
import re
import os

def build_sqlite():
    sql_path = r"c:\Kunal\sem 5\mini project changed\lex_db.sql"
    db_path = os.path.join(os.path.dirname(__file__), "lex_db.sqlite")

    if os.path.exists(db_path):
        try:
            os.remove(db_path)
        except Exception:
            pass

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    with open(sql_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    # Split into statements while respecting strings
    statements = []
    current = []
    in_str = False
    quote_char = None
    escape = False

    for char in content:
        if escape:
            current.append(char)
            escape = False
            continue
        if char == '\\':
            current.append(char)
            escape = True
            continue
        if char in ("'", '"'):
            if not in_str:
                in_str = True
                quote_char = char
            elif char == quote_char:
                in_str = False
                quote_char = None
            current.append(char)
            continue
        if char == ';' and not in_str:
            stmt = "".join(current).strip()
            if stmt:
                statements.append(stmt)
            current = []
            continue
        current.append(char)

    if current:
        stmt = "".join(current).strip()
        if stmt:
            statements.append(stmt)

    for i, stmt in enumerate(statements):
        clean = stmt.strip()
        clean_no_comment = re.sub(r'/\*.*?\*/', '', clean, flags=re.DOTALL)
        clean_no_comment = re.sub(r'--[^\n]*', '', clean_no_comment).strip()
        if not clean_no_comment:
            continue
        upper = clean_no_comment.upper()
        if upper.startswith(("SET ", "START ", "COMMIT", "CREATE DATABASE", "USE ")):
            continue
        if upper.startswith("DROP TABLE"):
            tbl_match = re.search(r'DROP TABLE IF EXISTS `?(\w+)`?', clean_no_comment, re.IGNORECASE)
            if tbl_match:
                cursor.execute(f"DROP TABLE IF EXISTS {tbl_match.group(1)}")
            continue

        if upper.startswith("CREATE TABLE"):
            if "`CONVERSATIONS`" in upper or "CONVERSATIONS (" in upper:
                continue
            s = clean_no_comment
            s = re.sub(r'ENGINE=InnoDB[^\n;]*', '', s, flags=re.IGNORECASE)
            s = re.sub(r'DEFAULT CHARSET=[^\n;]*', '', s, flags=re.IGNORECASE)
            s = re.sub(r'COLLATE=[^\n;]*', '', s, flags=re.IGNORECASE)
            s = re.sub(r'`?(\w+)`?\s+int\(\d+\)\s+NOT\s+NULL\s+AUTO_INCREMENT', r'`\1` INTEGER PRIMARY KEY AUTOINCREMENT', s, flags=re.IGNORECASE)
            s = re.sub(r'int\(\d+\)', 'INTEGER', s, flags=re.IGNORECASE)
            s = re.sub(r'enum\([^)]+\)', 'TEXT', s, flags=re.IGNORECASE)
            s = re.sub(r'current_timestamp\(\)', 'CURRENT_TIMESTAMP', s, flags=re.IGNORECASE)
            s = re.sub(r',\s*PRIMARY KEY\s*\([^)]+\)', '', s, flags=re.IGNORECASE)
            s = re.sub(r',\s*(?:UNIQUE\s+)?KEY\s+`?\w+`?\s*\([^)]+\)', '', s, flags=re.IGNORECASE)
            # Remove CONSTRAINT ... FOREIGN KEY ...
            s = re.sub(r',\s*CONSTRAINT\s+`?\w+`?\s+FOREIGN KEY\s*\([^)]+\)\s*REFERENCES\s*`?\w+`?\s*\([^)]+\)(?:\s+ON DELETE [A-Z]+)?(?:\s+ON UPDATE [A-Z]+)?', '', s, flags=re.IGNORECASE)
            try:
                cursor.execute(s)
            except Exception as e:
                print(f"Error on CREATE TABLE:\n{s}\nError: {e}")
            continue

        if upper.startswith("INSERT INTO"):
            s = clean_no_comment
            s = s.replace(r"\'", "''")
            s = s.replace(r'\"', '"')
            s = s.replace(r'\n', '\n')
            s = s.replace(r'\r', '\r')
            try:
                cursor.execute(s)
            except Exception as e:
                print(f"Error on INSERT (first 100 chars: {s[:100]}):\nError: {e}")
            continue

    conn.commit()

    # Create conversations table if not created
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS conversations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_message TEXT NOT NULL,
            lex_response TEXT NOT NULL,
            topic VARCHAR(255) DEFAULT 'General',
            session_id VARCHAR(100) DEFAULT NULL,
            user_email VARCHAR(255) DEFAULT NULL,
            case_json TEXT DEFAULT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()

    # Print summary counts
    tables = ['legal_topics', 'legal_cases', 'legal_keywords', 'legal_documents', 'legal_actions', 'legal_options', 'legal_sources', 'conversations']
    for t in tables:
        try:
            cursor.execute(f"SELECT COUNT(*) FROM {t}")
            cnt = cursor.fetchone()[0]
            print(f"Table {t}: {cnt} rows")
        except Exception as e:
            print(f"Table {t} error: {e}")

    conn.close()
    print("Done building lex_db.sqlite")

if __name__ == "__main__":
    build_sqlite()
