"""
schemas.py

Defines the strawberry query type and fields to resolve GraphQL queries.
"""

# pylint: skip-file

# standard imports
from typing import List, Optional

# third-party packages
import strawberry
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import text

# project imports
# This may be an ugly way to separate and include code.
# However, it is simple, intuitive, and working for our purposes.
from . import setup
from .types import *

engine = create_engine(setup.DATABASE_URL_ADMIN, echo=True)
Session = sessionmaker(bind=engine)

@strawberry.type
class Query:

    @strawberry.field
    def get_flights(self, flight_number: Optional[str] = None,
        origin_icao: Optional[str] = None,
        destination: Optional[str] = None
        ) -> List[FlightType]:
        """
        Selects all flights matching the specified criteria 
        and returns them as a list of FlightType objects.
        """


        with Session() as session:
            query = "SELECT * FROM core.flights"
            filters = []

            if flight_number:
                filters.append(f"flight_number ILIKE :flight_number")

            if origin_icao:
                filters.append(f"origin_icao ILIKE :origin_icao")

            if destination:
                filters.append(f"destination_icao ILIKE :destination")

            if filters:
                query += " WHERE " + " AND ".join(filters)

            query_statement = text(query)

            params = {}
            if flight_number:
                params["flight_number"] = f"%{flight_number}%"
            if origin_icao:
                params["origin_icao"] = f"%{origin_icao}%"
            if destination:
                params["destination"] = f"%{destination}%"

            result = session.execute(query_statement, params)

            fetched_flights = result.fetchall()

            return [FlightType(
                flightNumber=flight.flight_number,
                originIcao=flight.origin_icao,
                destinationIcao=flight.destination_icao,
                departureTimeScheduled=flight.departure_time_scheduled,
                arrivalTimeScheduled=flight.arrival_time_scheduled,
                typesAllowed=flight.types_allowed,
                dateDows=flight.date_dows
                ) for flight in fetched_flights]


    @strawberry.field
    def get_trips(self) -> List[TripType]:

        with Session() as session:
            query = "SELECT * FROM core.trips"

            query += " ORDER BY departure_time_scheduled ASC"

            query_statement = text(query)

            params = {}

            result = session.execute(query_statement, params)

            fetched_trips = result.fetchall()

            return [TripType(
                flightNumber=trip.flight_number,
                departureTimeScheduled=trip.departure_time_scheduled.strftime("%H:%M:%S"),
                arrivalTimeScheduled=trip.arrival_time_scheduled.strftime("%H:%M:%S"),
                aircraft=trip.aircraft,
                tripStatus=trip.trip_status
                ) for trip in fetched_trips]
    
    
    @strawberry.field
    def getTripInformation(self) -> List[TripInformationType]:
        
        with Session() as session:
            query = "SELECT * FROM api_schema.view_trip_details"

            query += " ORDER BY scheduled_departure ASC, RANDOM()"

            query_statement = text(query)

            params = {}

            result = session.execute(query_statement, params)

            fetched_tripinfos = result.fetchall()

            return [TripInformationType(
                flightNumber=trip.flight_number,
                aircraftModel=trip.aircraft_model,
                # tripDate=trip.trip_date,
                originAirport=trip.origin_airport_name,
                destinationAirport=trip.destination_airport_name,
                departureTimeScheduled=trip.scheduled_departure.strftime("%H:%M:%S"),
                arrivalTimeScheduled=trip.scheduled_arrival.strftime("%H:%M:%S"),
                status=trip.status
                ) for trip in fetched_tripinfos]


    @strawberry.field
    def get_archived_trips(self) -> List[ArchivedTripType]:

        with Session() as session:
            query = "SELECT * FROM core.past_trips"

            query_statement = text(query)

            params = {}

            result = session.execute(query_statement, params)

            fetched_trips = result.fetchall()

            return [TripType(
                flightNumber=trip.flight_number,
                departureTimeScheduled=trip.departure_time_scheduled.strftime("%H:%M:%S"),
                arrivalTimeScheduled=trip.arrival_time_scheduled.strftime("%H:%M:%S"),
                aircraft=trip.aircraft,
                tripStatus=trip.trip_status
                ) for trip in fetched_trips]
        

    @strawberry.field
    def get_aircraft(self) -> List[AircraftType]:

        with Session() as session:
            query = "SELECT * FROM core.aircraft"

            query += " ORDER BY status DESC"

            query_statement = text(query)

            params = {}

            result = session.execute(query_statement, params)

            fetched_aircraft = result.fetchall()

            return [AircraftType(
                registration=aircraft.registration,
                manufacturer=aircraft.manufacturer,
                model=aircraft.model,
                status=aircraft.status
                ) for aircraft in fetched_aircraft]
