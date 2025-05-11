-- load.sql
-- load in some artificial data

INSERT INTO airport (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYYZ',
    'YYZ',
    'Toronto Pearson International Airport',
    'Canada',
    'Toronto',
    'America/New_York'
);


INSERT INTO airport (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYTZ',
    'YTZ',
    'Billy Bishop Toronto City Airport',
    'Canada',
    'Toronto',
    'America/New_York'
);


INSERT INTO airport (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYUL',
    'YUL',
    'Montréal–Trudeau International Airport',
    'Canada',
    'Montreal',
    'America/New_York'
);
