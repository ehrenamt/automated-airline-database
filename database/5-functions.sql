-- 5-functions.sql
--------------------------------------------------------------------------------

\c flightsdb

-- --------------------------------------------------------------------------------
-- -- Functions
-- --------------------------------------------------------------------------------


-- Adds upcoming trips to to the trip table based on dates in flight table.
CREATE FUNCTION core.generate_trips_from_schedule()
RETURNS void AS $$
DECLARE
    day_of_week INT;
    flight_record RECORD;
    aircraft_record RECORD;
    current_time TIME := CURRENT_TIME;
BEGIN
    day_of_week := EXTRACT(DOW FROM CURRENT_DATE) + 1;

    FOR flight_record IN
        SELECT *
        FROM core.flights
        WHERE date_dows[day_of_week]
        AND arrival_time_scheduled >= (current_time - INTERVAL '3 hours')::TIME
        -- TODO: we'll later make this a window that can include the next day, for better information
        -- AND arrival_time_scheduled < ( current_time + INTERVAL '8 hours')::TIME
    LOOP
        -- IF NOT EXISTS is to ensure we do not add a flight with an identical number to the table.
        -- Even if they are on different days, this can result in confusion.
        IF NOT EXISTS (
            SELECT 1 FROM core.trips
            WHERE flight_number = flight_record.flight_number
        ) THEN
            SELECT * INTO aircraft_record FROM core.aircraft
            WHERE status = 'FREE'
            AND model = ANY(flight_record.types_allowed)
            LIMIT 1;

            IF FOUND THEN 
                INSERT INTO core.trips (flight_number, trip_date, departure_time_scheduled, arrival_time_scheduled, aircraft, trip_status)
                VALUES 
                (flight_record.flight_number, NOW(), flight_record.departure_time_scheduled, flight_record.arrival_time_scheduled, aircraft_record.registration, 'SCHEDULED');



                UPDATE core.aircraft 
                SET status = 'IN SERVICE'
                WHERE registration = aircraft_record.registration;
            END IF;
        END IF;
    END LOOP;

    UPDATE core.trips
    SET trip_status = 'IN FLIGHT'
    WHERE departure_time_scheduled <= CURRENT_TIME
    AND arrival_time_scheduled > CURRENT_TIME;

    UPDATE core.trips
    SET trip_status = 'LANDED'
    WHERE arrival_time_scheduled < CURRENT_TIME;

END;
$$ LANGUAGE plpgsql;


-- Move all trips that have landed or been cancelled into the archive table, after a few hours grace period.
CREATE FUNCTION core.archive_completed_trips()
RETURNS void AS $$
BEGIN
    INSERT INTO past_trips
    SELECT * FROM core.trips t JOIN core.flights f
    WHERE
        t.arrival_time_scheduled < (CURRENT_TIME - INTERVAL '3 hours')::TIME
        AND
        t.status = 'LANDED'
        OR
        t.status = 'CANCELED';

    DELETE FROM core.trips
    WHERE id IN (
        SELECT id FROM past_trips
    );
END;
$$ LANGUAGE plpgsql;
