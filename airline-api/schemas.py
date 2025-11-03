# third-party packages
from datetime import datetime, date, time
import strawberry
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import text
import typing
from typing import List, Optional

# project imports
import db_setup

engine = db_setup.engine
Session = sessionmaker(bind=engine)


# Note to self:
# GraphQL automatically converts variable names to camelCase!
# Trying to query in non-camelCase WILL result in runtime errors!
@strawberry.type
class FlightType:
    flightNumber: str
    originIcao: str
    destinationIcao: str
    departureTimeScheduled: time
    arrivalTimeScheduled: time
    typesAllowed: List[str]
    dateDows: List[str] 


# TODO: Format the query properly
@strawberry.type
class Query:
    flights: typing.List[FlightType]

    @strawberry.field
    def get_flights(self, flight_number: Optional[str] = None, origin: Optional[str] = None, destination: Optional[str] = None) -> List[FlightType]:
        
        with Session() as session:
            query = "SELECT * FROM core.flights"
            filters = []

            if flight_number:
                filters.append(f"flight_number = '%{flight_number}%'")

            if origin:
                filters.append(f"origin_icao = '%{origin}%'")

            if destination:
                filters.append(f"destination_icao = '%{destination}%'")
                
            if filters:
                query += " WHERE " + " AND ".join(filters)

            query = text(query)

            result = session.execute(query)
            return [FlightType(
                flight_number=flight.flight_number, 
                origin_icao=flight.origin_icao, 
                destination_icao=flight.destination_icao,
                departure_time_scheduled=flight.departure_time_scheduled,
                arrival_time_scheduled=flight.arrival_time_scheduled,
                types_allowed=flight.types_allowed,
                date_dows=flight.date_dows
                ) for flight in result.scalars()]
