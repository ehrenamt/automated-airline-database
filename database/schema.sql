-- schema.sql
--------------------------------------------------------------------------------
-- Execute this after init.sql

-- This is not meant to be a production-grade solution! 
-- This serves only as a proof-of-concept and demonstration of ability.
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- TYPES
--------------------------------------------------------------------------------
-- Note that enums do not affect normalization.
-- These act merely as constraints when inserting values.
--------------------------------------------------------------------------------


CREATE TYPE AS manufacturer_type ENUM (
    'AIRBUS',
    'BOEING',
    'BOMBARDIER',
    'CESSNA',
    'DOUGLAS CORPORATION',
    'EMBRAER',
    'MCDONNELL DOUGLAS'
);

CREATE TYPE AS aircraft_status_type ENUM (
    'IN SERVICE',
    'UNDER MAINTENANCE',
    'FREE'
);

CREATE TYPE AS trip_status_type ENUM (
    'SCHEDULED',
    'DELAYED',
    'IN FLIGHT',
    'CANCELED'
);


--------------------------------------------------------------------------------
-- TABLES
--------------------------------------------------------------------------------
-- NOTES:
-- No columns are named "name" to avoid conflicts.
-- For normalization, computed values are included in views, not tables.
--------------------------------------------------------------------------------


CREATE TABLE airport (
    icao CHAR(4) PRIMARY KEY,
    iata CHAR(3) UNIQUE NOT NULL,
    full_airport_name TEXT UNIQUE NOT NULL,
    country TEXT NOT NULL,
    city TEXT,
    timezone TEXT NOT NULL
);

CREATE TABLE seating_configuration (
    configuration_name TEXT PRIMARY KEY,
    first_class SMALLINT DEFAULT 0,
    business_class SMALLINT DEFAULT 0,
    economy_class SMALLINT DEFAULT 0,
    CHECK (first_class >= 0 AND business_class >= 0 AND economy_class >= 0)
);


CREATE TABLE aircraft (
    id SERIAL PRIMARY KEY,
    registration TEXT UNIQUE NOT NULL,
    manufacturer manufacturer_type NOT NULL,
    model TEXT NOT NULL,
    configuration_name TEXT,
    FOREIGN KEY (configuration_name) REFERENCES seating_configuration(configuration_name)
);


-- Flight time is not an attribute. It is computable, so it will be computed in a view.
CREATE TABLE flight (
    flight_number TEXT PRIMARY KEY,
    origin_icao CHAR(4) NOT NULL,
    destination_icao CHAR(4) NOT NULL,
    departure_time_scheduled TIMESTAMPTZ NOT NULL,
    arrival_time_scheduled TIMESTAMPTZ NOT NULL,
    date_from DATE NOT NULL, -- first day of operation
    date_to DATE NOT NULL, -- final day of operation
    date_dows BOOLEAN[7] NOT NUll, -- days of the week that this flight operates on
    created_at TIMESTAMPTZ DEFAULT NOW(), -- for traceability & debugging
    FOREIGN KEY (origin_icao) REFERENCES airport(icao),
    FOREIGN KEY (destination_icao) REFERENCES airport(icao),
    CHECK ( origin_icao NOT LIKE destination_icao)
);


-- This table is automatically modified by functions to crerating a moving time window that displays recent, current, and upcoming flights.
-- Scheduled departure and arrival are not attributes here as they can be joined 
CREATE TABLE trip (
    id SERIAL PRIMARY KEY,
    flight_number TEXT NOT NULL,
    trip_date DATE NOT NULL,
    departure_time_actual TIMESTAMPTZ, -- actual departure time is indeterministic?
    arrival_time_actual TIMESTAMPTZ, -- actual departure time is indeterministic?
    aircraft INTEGER NOT NULL,
    trip_status trip_status_type NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(), -- for traceability & debugging
    FOREIGN KEY (flight_number) REFERENCES flight(flight_number),
    FOREIGN KEY (aircraft) REFERENCES aircraft(id)
);


-- This table serves as an archive 
CREATE TABLE past_trip (LIKE trip INCLUDING ALL) PARTITION BY RANGE (trip_date);


--------------------------------------------------------------------------------
-- Indices
--------------------------------------------------------------------------------


-- For interfaces that search by flight number (end users)
CREATE INDEX idx_trip_flight_number ON trip(flight_number);

-- For interfaces that search by date (arrival / departure screens)
CREATE INDEX idx_trip_date ON trip(trip_date);

CREATE INDEX idx_aircraft_registration ON aircraft(registration);

-- Composite index for flight, date queries
CREATE INDEX idx_trip_flight_date ON trip(flight_number, trip_date);


--------------------------------------------------------------------------------
-- Views
--------------------------------------------------------------------------------
-- Views reflect changes in the tables they query from.
-- No need to make triggers here.
--------------------------------------------------------------------------------


CREATE VIEW view_trip_details AS
SELECT
t.flight_number,
t.trip_date,
f.origin_icao,
origin_airport.full_airport_name AS origin_airport_name,
f.destination_icao,
destination_airport.full_airport_name AS destination_airport_name,
f.departure_time_scheduled AS scheduled_departure,
f.arrival_time_scheduled AS schedul_arrival
FROM trip t JOIN flight f ON t.flight_number = f.flight_number
JOIN airport origin_airport ON f.origin_icao = origin_airport.icao
JOIN airport destination_airport ON f.destination_icao = destination_airport.icao;


--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------


-- Adds upcoming trips to to the trip table based on dates in flight table.
CREATE FUNCTION generate_trips_from_schedule()
RETURNS void AS $$
BEGIN
END;
$$ LANGUAGE plpgsql;

-- Move all trips that have ended or have been cancelled more than 24 hours ago into the archive table.
CREATE FUNCTION archive_completed_trips()
RETURNS void 
AS $$
BEGIN
    INSERT INTO past_trip
    SELECT * FROM trip JOIN flight f
    WHERE
        departure_time_actual IS NOT NULL
        AND
        arrival_time_actual IS NOT NULL
        AND
        arrival_time_actual < NOW() - INTERVAl '24 hours'
        OR
        trip_status LIKE 'CANCELED'
        AND 
        f.scheduled_departure < NOW() - INTERVAl '24 hours';

    DELETE FROM trip
    WHERE id IN (
        SELECT id FROM trip
        WHERE
        departure_time_actual IS NOT NULL AND
        arrival_time_actual IS NOT NULL AND
        arrival_time_actual < NOW() - INTERVAL '24 hours'
    );
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- pg_cron schedules
--------------------------------------------------------------------------------


CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Hourly call for the function to archive trips
SELECT cron.schedule(
    'archive_completed_trips_hourly',
    '0 * * * *',
    $$ CALL archive_completed_trips(); $$
);
