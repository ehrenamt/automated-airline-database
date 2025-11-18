-- 6-cron_schedules.sql
--------------------------------------------------------------------------------
-- Executes after 5-functions.sql
-- Creates pg_cron and schedules the functions defined in  5-functions.sql
--------------------------------------------------------------------------------

\c flightsdb

CREATE EXTENSION IF NOT EXISTS pg_cron;


--------------------------------------------------------------------------------
-- pg_cron schedules
--------------------------------------------------------------------------------


-- Automatically create and update trips.
SELECT cron.schedule(
  'update_trips_each_3min',
  '*/1 * * * *',
  $$ SELECT core.generate_trips_from_schedule(); $$
);


-- Automatically archive trips
SELECT cron.schedule(
  'archive_completed_trips_each_15min',
  '*/15 * * * *',
  $$ SELECT core.archive_completed_trips(); $$
);


-- Automatically update aircraft statuses
SELECT cron.schedule(
  'update_aicraft_statuses_each_1min',
  '*/1 * * * *',
  $$ SELECT core.update_aircraft_statuses(); $$
);


-- Automatically simulate random delays for existing trips
-- Should be 3 - 4 times a day
-- Currently high rate for testing
SELECT cron.schedule(
  'randomly_delay_trip_each_1min',
  '*/5 * * * *',
  $$ SELECT core.simulate_random_delay_or_cancel(); $$
);
