-- init.sql

CREATE DATABASE flightsdb;

-- Public namespace won't be used. Revoke all access to it.
REVOKE ALL ON SCHEMA public FROM public;

-- Create namespaces to organize tables and enforce stricter permissions.
CREATE SCHEMA core AUTHORIZATION admin_user;
CREATE SCHEMA api AUTHORIZATION admin_user;
CREATE SCHEMA view AUTHORIZATION admin_user;

DROP SCHEMA public CASCADE;

-- Create multiple users to separate admin and user queries.
CREATE ROLE admin_user WITH LOGIN PASSWORD 'strongadminpassword';

CREATE ROLE readonly_user WITH LOGIN PASSWORD 'strongpassword';

-- PURELY for information screens relating to important trips. 
-- Unable to view details of all available trips.
CREATE ROLE readonly_trip_user WITH LOGIN PASSWORD 'strongpassword';


--------------------------------------------------------------------------------
-- Data control
--------------------------------------------------------------------------------

-- admin_user
GRANT ALL PRIVILEGES ON SCHEMA core TO admin_user;
GRANT ALL PRIVILEGES ON SCHEMA api TO admin_user;
GRANT ALL PRIVILEGES ON SCHEMA view TO admin_user;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA core TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA view TO admin_user;

-- read-only user
REVOKE ALL ON SCHEMA public FROM readonly_user;
REVOKE ALL ON DATABASE flightsdb FROM readonly_user;

GRANT CONNECT ON DATABASE flightsdb TO readonly_user;

-- read-only user is allowed to use api, view namespaces and select from them
GRANT USAGE ON SCHEMA api TO readonly_user;
GRANT USAGE ON SCHEMA view TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA api TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA view TO readonly_user;

-- If new tables are added to these namespaces, this user can also use them
ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT SELECT ON TABLES TO readonly_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA view GRANT SELECT ON TABLES TO readonly_user;

-- To be used later when creating time-based functions
CREATE EXTENSION IF NOT EXISTS pg_cron;
