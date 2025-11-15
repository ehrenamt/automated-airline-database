"""
types.py

Strawberry Object Types for entity objects.
"""

# pylint: skip-file

# standard imports
from typing import List

# third-party packages
from datetime import time
import strawberry

# Note to self:
# GraphQL automatically converts variable names to camelCase!
# Trying to query in non-camelCase WILL result in runtime errors!
@strawberry.type
class FlightType:
    """GraphQL type for the flights from the core.flights table."""
    flightNumber: str
    originIcao: str
    destinationIcao: str
    departureTimeScheduled: time
    arrivalTimeScheduled: time
    typesAllowed: List[str]
    dateDows: List[str]


@strawberry.type
class TripType:
    """GraphQL type for the trips from the core.trips table."""
    flightNumber: str
    # departure time is a TIME in the database table
    departureTimeScheduled: str
    # arrival time is a TIME in the database table
    arrivalTimeScheduled: str
    aircraft: str
    tripStatus: str


@strawberry.type
class ArchivedTripType:
    """GraphQL type for the trips from the core.trips table."""
    flightNumber: str
    # departure time is a TIME in the database table
    departureTimeScheduled: str
    # arrival time is a TIME in the database table
    arrivalTimeScheduled: str
    aircraft: str
    tripStatus: str


@strawberry.type
class TripInformationType:
    """GraphQL type for trip information from the api_schema.view_trip_details view."""
    flightNumber: str
    tripDate: str
    originAirport: str
    destinationAirport: str
    departureTimeScheduled: str
    departureTimeScheduled: str
    status: str


@strawberry.type
class AircraftType:
    """GraphQL type for the trips from the core.trips table."""
    registration: str
    manufacturer: str
    model: str
    status: str
