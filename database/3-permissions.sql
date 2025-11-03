--------------------------------------------------------------------------------
-- Table and access permissions
--------------------------------------------------------------------------------

\c flightsdb

-- admin_user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA core TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api_schema TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA view_schema TO admin_user;


-- readonly_user
GRANT SELECT ON ALL TABLES IN SCHEMA api_schema TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA view_schema TO readonly_user;
