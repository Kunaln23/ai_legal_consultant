# ==================================================
# DATABASE CONNECTION (MySQL Primary + SQLite Fallback)
# ==================================================

import os
import re
import time
import sqlite3
try:
    import mysql.connector
except ImportError:  # SQLite mode remains usable without the optional MySQL driver
    mysql = None
from config import (
    MYSQL_HOST,
    MYSQL_USER,
    MYSQL_PASSWORD,
    MYSQL_DATABASE,
    MYSQL_PORT,
    FALLBACK_PASSWORDS
)

_cached_params = None
_last_mysql_check = 0
_mysql_check_cooldown = 15.0  # seconds between retry when MySQL is offline
_sqlite_db_path = os.path.join(os.path.dirname(__file__), "lex_db.sqlite")


# --------------------------------------------------
# SQLite Compatibility Layer for MySQL Syntax
# --------------------------------------------------

class SQLiteCursorWrapper:
    """Provides dictionary-mode and MySQL %s parameter compatibility for SQLite."""

    def __init__(self, cursor, dictionary=False):
        self.cursor = cursor
        self.dictionary = dictionary
        self.rowcount = -1

    def execute(self, query, params=None):
        clean_q = query.strip()
        # Convert MySQL %s placeholders to SQLite ? placeholders
        clean_q = clean_q.replace("%s", "?")
        # Convert GROUP_CONCAT(x SEPARATOR y) to GROUP_CONCAT(x, y)
        clean_q = re.sub(
            r"GROUP_CONCAT\((.*?)\s+SEPARATOR\s+(.*?)\)",
            r"GROUP_CONCAT(\1, \2)",
            clean_q,
            flags=re.IGNORECASE
        )
        # Convert MySQL table syntax
        clean_q = re.sub(r"ENGINE=InnoDB[^\n;]*", "", clean_q, flags=re.IGNORECASE)
        clean_q = re.sub(r"DEFAULT CHARSET=[^\n;]*", "", clean_q, flags=re.IGNORECASE)
        clean_q = re.sub(r"COLLATE=[^\n;]*", "", clean_q, flags=re.IGNORECASE)
        clean_q = re.sub(r"AUTO_INCREMENT", "AUTOINCREMENT", clean_q, flags=re.IGNORECASE)
        clean_q = re.sub(r"INT AUTOINCREMENT PRIMARY KEY", "INTEGER PRIMARY KEY AUTOINCREMENT", clean_q, flags=re.IGNORECASE)
        clean_q = re.sub(r"LONGTEXT", "TEXT", clean_q, flags=re.IGNORECASE)

        if params is not None:
            if isinstance(params, (list, tuple)):
                self.cursor.execute(clean_q, params)
            else:
                self.cursor.execute(clean_q, (params,))
        else:
            self.cursor.execute(clean_q)

        self.rowcount = self.cursor.rowcount
        return self

    def fetchall(self):
        rows = self.cursor.fetchall()
        if self.dictionary and self.cursor.description:
            cols = [d[0] for d in self.cursor.description]
            return [dict(zip(cols, row)) for row in rows]
        return rows

    def fetchone(self):
        row = self.cursor.fetchone()
        if row is None:
            return None
        if self.dictionary and self.cursor.description:
            cols = [d[0] for d in self.cursor.description]
            return dict(zip(cols, row))
        return row

    def close(self):
        try:
            self.cursor.close()
        except Exception:
            pass

    @property
    def description(self):
        return self.cursor.description


class SQLiteConnectionWrapper:
    """Wraps sqlite3.Connection with MySQL connector semantics."""

    def __init__(self, conn):
        self.conn = conn

    def cursor(self, dictionary=False):
        return SQLiteCursorWrapper(self.conn.cursor(), dictionary=dictionary)

    def commit(self):
        self.conn.commit()

    def rollback(self):
        self.conn.rollback()

    def close(self):
        try:
            self.conn.close()
        except Exception:
            pass

    def is_connected(self):
        return True


def _ensure_sqlite_db():
    """Ensure SQLite database exists and is populated from convert_db or lex_db.sql."""
    if not os.path.exists(_sqlite_db_path):
        try:
            import convert_db
            convert_db.build_sqlite()
        except Exception as e:
            print("SQLite initialization notice:", e)


# --------------------------------------------------
# Main Connection Getter
# --------------------------------------------------

def get_connection():
    global _cached_params, _last_mysql_check

    # 1. If we have known working cached parameters, use them
    if _cached_params and mysql is not None:
        try:
            return mysql.connector.connect(**_cached_params)
        except Exception:
            _cached_params = None

    # 2. Try MySQL connection if not in cooldown
    now = time.time()
    if mysql is not None and (now - _last_mysql_check) >= _mysql_check_cooldown:
        _last_mysql_check = now
        hosts_to_try = [MYSQL_HOST, "127.0.0.1", "localhost"]
        pwds_to_try = [MYSQL_PASSWORD] + [p for p in FALLBACK_PASSWORDS if p != MYSQL_PASSWORD]
        ports_to_try = [MYSQL_PORT, 3306, 4141, 3307]

        seen_ports = set()
        unique_ports = [p for p in ports_to_try if not (p in seen_ports or seen_ports.add(p))]

        for host in hosts_to_try:
            for port in unique_ports:
                for pwd in pwds_to_try:
                    try:
                        conn = mysql.connector.connect(
                            host=host,
                            user=MYSQL_USER,
                            password=pwd,
                            database=MYSQL_DATABASE,
                            port=port,
                            connection_timeout=0.1
                        )
                        _cached_params = {
                            "host": host,
                            "user": MYSQL_USER,
                            "password": pwd,
                            "database": MYSQL_DATABASE,
                            "port": port
                        }
                        return conn
                    except Exception:
                        continue

    # 3. Seamless SQLite Fallback (Ensures 100% database availability)
    _ensure_sqlite_db()
    if os.path.exists(_sqlite_db_path):
        try:
            sqlite_conn = sqlite3.connect(_sqlite_db_path)
            return SQLiteConnectionWrapper(sqlite_conn)
        except Exception as err:
            print("SQLite connection error:", err)

    print("Database connection error: Unable to connect to MySQL or SQLite.")
    return None
