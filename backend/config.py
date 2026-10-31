# ==================================================
# LEX CONFIGURATION
# ==================================================

import os

MYSQL_HOST = os.getenv("MYSQL_HOST", "127.0.0.1")
MYSQL_USER = os.getenv("MYSQL_USER", "root")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "")
MYSQL_DATABASE = os.getenv("MYSQL_DATABASE", "lex_db")
MYSQL_PORT = int(os.getenv("MYSQL_PORT", 4141))

# Fallback credentials if primary connection fails
FALLBACK_PASSWORDS = ["admin", "", "root", "1234", "123456", "password"]
FALLBACK_PORTS = [1400, 8082, 4141, 3307]

# Flask configuration
DEBUG = True
HOST = "127.0.0.1"
PORT = 5000