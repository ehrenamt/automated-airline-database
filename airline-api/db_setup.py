import os

from dotenv import load_dotenv

from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import Column, Integer, String, Date, Time, ARRAY
from sqlalchemy.orm import declarative_base

load_dotenv()

DB_READONLY_USER = os.getenv("DB_READONLY_USER")
DB_ADMIN_USER_NAME = os.getenv("DB_ADMIN_USER_NAME")
DB_ADMIN_USER_PASS = os.getenv("DB_ADMIN_USER_PASS")
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME", "flightsdb")
DB_PORT = os.getenv("DB_PORT", "5432")

DATABASE_URL = f"postgresql+asyncpg://{DB_ADMIN_USER_NAME}:{DB_ADMIN_USER_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

engine = create_async_engine(DATABASE_URL, echo=True)
Base = declarative_base()


class Flight(Base):
    __tablename__ = 'flights'

    flight_number = Column(String, primary_key=True, index=True)
    origin_icao = Column(String)
    destination_icao = Column(String)
    departure_time_scheduled = Column(Time)
    arrival_time_scheduled = Column(Time)
    types_allowed = Column(ARRAY(String))
    date_dows = Column(ARRAY(String))


class Airport(Base):
    __tablename__ = 'Airports'

    icao = Column(String, primary_key=True)
    iata = Column(String)
    full_airport_name = Column(String, unique=True)
    country = Column(String)
    city = Column(String)
    timezone = Column(String)
