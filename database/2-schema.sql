-- schema.sql
--------------------------------------------------------------------------------
-- Execute this after init.sql

-- This is not meant to be a production-grade solution! 
-- This serves only as a proof-of-concept and demonstration of ability.
--------------------------------------------------------------------------------


\c flightsdb

--------------------------------------------------------------------------------
-- TYPES
--------------------------------------------------------------------------------
-- Note that enums do not affect normalization.
-- These act merely as constraints when inserting values.
--------------------------------------------------------------------------------


CREATE TYPE core.manufacturer_type AS ENUM (
    'AIRBUS',
    'BOEING',
    'BOMBARDIER',
    'CESSNA',
    'DOUGLAS CORPORATION',
    'EMBRAER',
    'MCDONNELL DOUGLAS'
);


CREATE TYPE core.aircraft_model_type AS ENUM (
    'A220-100',
    'A220-300',
    'A319NEO',
    'A350-1000',
    'B787-9',
    'Dash 8 Q400',
    'E175',
    'E195',
    '208B GRAND CARAVAN'
);


CREATE TYPE core.aircraft_status_type AS ENUM (
    'IN SERVICE',
    'UNDER MAINTENANCE',
    'FREE'
);

CREATE TYPE core.trip_status_type AS ENUM (
    'SCHEDULED',
    'DELAYED',
    'IN FLIGHT',
    'LANDED',
    'CANCELED'
);


--------------------------------------------------------------------------------
-- TABLES
--------------------------------------------------------------------------------
-- NOTES:
-- No columns are named "name" to avoid conflicts.
-- For normalization, computed values are included in views, not tables.
--------------------------------------------------------------------------------


CREATE TABLE core.airports (
    icao CHAR(4) PRIMARY KEY,
    iata CHAR(3) UNIQUE NOT NULL,
    full_airport_name TEXT UNIQUE NOT NULL,
    country TEXT NOT NULL,
    city TEXT,
    timezone TEXT NOT NULL
);


CREATE TABLE core.seating_configurations (
    configuration_name TEXT PRIMARY KEY,
    first_class SMALLINT DEFAULT 0,
    business_class SMALLINT DEFAULT 0,
    economy_class SMALLINT DEFAULT 0,
    CHECK (first_class >= 0 AND business_class >= 0 AND economy_class >= 0)
);


CREATE TABLE core.aircraft (
    id SERIAL PRIMARY KEY,
    registration TEXT UNIQUE NOT NULL,
    manufacturer core.manufacturer_type NOT NULL,
    model core.aircraft_model_type NOT NULL,
    configuration_name TEXT,
    expected_free TIMESTAMPTZ DEFAULT NOW(),
    destination_icao_last CHAR(4) NOT NULL,
    destination_icao_next CHAR(4),
    status core.aircraft_status_type NOT NULL,
    FOREIGN KEY (configuration_name) REFERENCES core.seating_configurations(configuration_name),
    FOREIGN KEY (destination_icao_last) REFERENCES core.airports(icao),
    FOREIGN KEY (destination_icao_next) REFERENCES core.airports(icao),
    CHECK (destination_icao_last NOT LIKE destination_icao_next)
);


-- Flight time is not an attribute. It is computable, so it will be computed in a view.
CREATE TABLE core.flights (
    flight_number TEXT PRIMARY KEY,
    origin_icao CHAR(4) NOT NULL,
    destination_icao CHAR(4) NOT NULL,
    departure_time_scheduled TIME NOT NULL,
    arrival_time_scheduled TIME NOT NULL,
    types_allowed core.aircraft_model_type[] NOT NULL,
    date_from DATE NOT NULL, -- first day of operation
    date_to DATE NOT NULL, -- final day of operation
    date_dows BOOLEAN[7] NOT NUll, -- days of the week that this flight operates on
    created_at TIMESTAMPTZ DEFAULT NOW(), -- for traceability & debugging later
    FOREIGN KEY (origin_icao) REFERENCES core.airports(icao),
    FOREIGN KEY (destination_icao) REFERENCES core.airports(icao),
    CHECK (origin_icao NOT LIKE destination_icao),
    CHECK (cardinality(types_allowed) >= 1)
);


-- This table is automatically modified by functions to crerating a moving time window that displays recent, current, and upcoming flights.
-- TODO:
-- Scheduled departure and arrival should not be attributes here as they can be joined?
-- Or we include them for efficiency, to skip a more expensive join?
CREATE TABLE core.trips (
    id SERIAL PRIMARY KEY,
    flight_number TEXT NOT NULL,
    trip_date DATE NOT NULL,
    departure_time_scheduled TIME NOT NULL,
    departure_time_actual TIMESTAMPTZ, -- actual departure time is indeterministic?
    arrival_time_scheduled TIME NOT NULL,
    arrival_time_actual TIMESTAMPTZ, -- actual departure time is indeterministic?
    aircraft TEXT NOT NULL,
    trip_status core.trip_status_type NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(), -- for traceability & debugging
    FOREIGN KEY (flight_number) REFERENCES core.flights(flight_number),
    FOREIGN KEY (aircraft) REFERENCES core.aircraft(registration)
);


-- This table serves as an archive
-- A cron task calling a function should regularly update this table over time.
CREATE TABLE core.past_trips (LIKE core.trips INCLUDING ALL);


--------------------------------------------------------------------------------
-- Indices
--------------------------------------------------------------------------------


-- For interfaces that search by flight number (end users)
CREATE INDEX idx_trip_flight_number ON core.trips(flight_number);

-- For interfaces that search by date (arrival / departure screens)
CREATE INDEX idx_trip_date ON core.trips(trip_date);

CREATE INDEX idx_aircraft_registration ON core.aircraft(registration);

-- Composite index for flight, date queries
CREATE INDEX idx_trip_flight_date ON core.trips(flight_number, trip_date);


--------------------------------------------------------------------------------
-- Views
--------------------------------------------------------------------------------
-- Views reflect changes in the tables they query from.
-- No need to make triggers here.
--------------------------------------------------------------------------------

-- For viewing recent current, and upcoming trips
-- i.e. for airport information screens
CREATE VIEW api_schema.view_trip_details AS
SELECT
t.flight_number,
t.trip_date,
f.origin_icao,
origin_airport.full_airport_name AS origin_airport_name,
f.destination_icao,
destination_airport.full_airport_name AS destination_airport_name,
f.departure_time_scheduled AS scheduled_departure,
f.arrival_time_scheduled AS scheduled_arrival,
t.status as status
FROM core.trips t JOIN core.flights f ON t.flight_number = f.flight_number
JOIN core.airports origin_airport ON f.origin_icao = origin_airport.icao
JOIN core.airports destination_airport ON f.destination_icao = destination_airport.icao;
