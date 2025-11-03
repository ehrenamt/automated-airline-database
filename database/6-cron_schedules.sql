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
  '*/3 * * * *',
  $$ SELECT core.generate_trips_from_schedule(); $$
);


-- Automatically archive trips
SELECT cron.schedule(
  'archive_completed_trips_each_30min',
  '*/30 * * * *',
  $$ SELECT core.archive_completed_trips(); $$
);
