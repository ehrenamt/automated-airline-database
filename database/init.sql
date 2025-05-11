-- init.sql
--------------------------------------------------------------------------------
-- This file should be run after connecting to the porstgreSQL database.
-- Then the schema should be executed.

-- This is not meant to be a production-grade solution! 
-- This serves only as a proof-of-concept and demonstration of ability.
--------------------------------------------------------------------------------


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

-- A role for safe updates from backend or third-parties.
-- In principle, we won't need this.
-- However, including it will allow easy and fasy integration with the backend.
CREATE ROLE update_user WITH LOGIN PASSWORD 'strongupdatepassword';


--------------------------------------------------------------------------------
-- Data control
--------------------------------------------------------------------------------

-- admin_user
GRANT CONNECT ON DATABASE flightsdb TO admin_user;

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

-- read-only trip user
REVOKE ALL ON SCHEMA public FROM readonly_trip_user;
REVOKE ALL ON DATABASE flightsdb FROM readonly_trip_user;

GRANT CONNECT ON DATABASE flightsdb TO readonly_trip_user;

-- temporary
GRANT USAGE ON SCHEMA api TO readonly_trip_user;
GRANT USAGE ON SCHEMA view TO readonly_trip_user;

-- update_user
REVOKE ALL ON SCHEMA public FROM update_user;
REVOKE ALL ON DATABASE flightsdb FROM update_user;

GRANT CONNECT ON DATABASE flightsdb TO update_user;

-- Allow this user to update certain core tables
GRANT USAGE ON SCHEMA core TO readonly_user;
