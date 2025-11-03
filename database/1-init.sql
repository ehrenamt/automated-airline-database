-- init.sql
--------------------------------------------------------------------------------
-- This file should be run after connecting to the porstgreSQL database.
-- Then the schema should be executed.

-- This is not meant to be a production-grade solution! 
-- This serves only as a proof-of-concept and demonstration of ability.
--------------------------------------------------------------------------------


CREATE DATABASE flightsdb;

-- connect to flightsdb to create schemas
\c flightsdb

-- Create multiple users to separate admin and user queries.
CREATE ROLE admin_user WITH LOGIN PASSWORD 'strongadminpassword';

CREATE ROLE readonly_user WITH LOGIN PASSWORD 'strongpassword';

-- CREATE ROLE admin_user WITH LOGIN PASSWORD '${ADMIN_USER_PASSWORD}';
-- CREATE ROLE readonly_user WITH LOGIN PASSWORD '${READONLY_USER_PASSWORD}';


-- PURELY for information screens relating to important trips. 
-- Unable to view details of all available trips.
CREATE ROLE readonly_trip_user WITH LOGIN PASSWORD 'strongpassword';

-- A role for safe updates from backend or third-parties.
-- In principle, we won't need this.
-- However, including it will allow easy and fasy integration with the backend.
CREATE ROLE update_user WITH LOGIN PASSWORD 'strongupdatepassword';


-- Create namespaces to organize tables and enforce stricter permissions.
CREATE SCHEMA core AUTHORIZATION admin_user;
CREATE SCHEMA api_schema AUTHORIZATION admin_user;
CREATE SCHEMA view_schema AUTHORIZATION admin_user;


--------------------------------------------------------------------------------
-- Data control
--------------------------------------------------------------------------------

-- admin_user
GRANT CONNECT ON DATABASE flightsdb TO admin_user;

GRANT ALL PRIVILEGES ON SCHEMA core TO admin_user;
GRANT ALL PRIVILEGES ON SCHEMA api_schema TO admin_user;
GRANT ALL PRIVILEGES ON SCHEMA view_schema TO admin_user;

-- for privileges on tables, see 3-permissions.sql

-- read-only user
REVOKE ALL ON DATABASE flightsdb FROM readonly_user;
GRANT CONNECT ON DATABASE flightsdb TO readonly_user;

-- read-only user is allowed to use api, view namespaces and select from them
GRANT USAGE ON SCHEMA api_schema TO readonly_user;
GRANT USAGE ON SCHEMA view_schema TO readonly_user;

-- for privileges on tables, see 3-permissions.sql


-- If new tables are added to these namespaces, this user can also use them
ALTER DEFAULT PRIVILEGES IN SCHEMA api_schema GRANT SELECT ON TABLES TO readonly_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA view_schema GRANT SELECT ON TABLES TO readonly_user;

-- read-only trip user
-- REVOKE ALL ON SCHEMA public FROM readonly_trip_user;
REVOKE ALL ON DATABASE flightsdb FROM readonly_trip_user;

GRANT CONNECT ON DATABASE flightsdb TO readonly_trip_user;

-- temporary
GRANT USAGE ON SCHEMA api_schema TO readonly_trip_user;
GRANT USAGE ON SCHEMA view_schema TO readonly_trip_user;

-- update_user
-- REVOKE ALL ON SCHEMA public FROM update_user;
REVOKE ALL ON DATABASE flightsdb FROM update_user;

GRANT CONNECT ON DATABASE flightsdb TO update_user;

-- Allow this user to update certain core tables
GRANT USAGE ON SCHEMA core TO readonly_user;

-- Public namespace won't be used. Revoke all access to it.
REVOKE ALL ON SCHEMA public FROM public;
DROP SCHEMA public CASCADE;
