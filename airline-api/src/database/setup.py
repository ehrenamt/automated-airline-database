"""
setup.py

Configure ENV variables and construct connection strings.
"""

# pylint: skip-file

# standard imports
import os
from dotenv import load_dotenv

load_dotenv()

DB_READONLY_USER_NAME = os.getenv("DB_READONLY_USER_NAME")
DB_READONLY_USER_PASS = os.getenv("DB_READONLY_USER_PASS")
DB_ADMIN_USER_NAME = os.getenv("DB_ADMIN_USER_NAME")
DB_ADMIN_USER_PASS = os.getenv("DB_ADMIN_USER_PASS")
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME", "flightsdb")
DB_PORT = os.getenv("DB_PORT", "5432")

# switch to asyncpg later
DATABASE_URL_ADMIN = f"postgresql+psycopg2://{DB_ADMIN_USER_NAME}:{DB_ADMIN_USER_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
DATABASE_URL_READONLY_USER = f"postgresql+psycopg2://{DB_READONLY_USER_NAME}:{DB_READONLY_USER_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
