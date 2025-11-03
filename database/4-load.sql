-- load.sql
--------------------------------------------------------------------------------
-- Executes after 3-permissions.sql
-- Loads in fictional data regarding aircraft, flights, and trips.
--------------------------------------------------------------------------------

\c flightsdb

--------------------------------------------------------------------------------
-- Airports
--------------------------------------------------------------------------------


INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYYZ',
    'YYZ',
    'Toronto Pearson International Airport',
    'Canada',
    'Toronto',
    'America/New_York'
);


INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYTZ',
    'YTZ',
    'Billy Bishop Toronto City Airport',
    'Canada',
    'Toronto',
    'America/New_York'
);


INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYUL',
    'YUL',
    'Montréal–Trudeau International Airport',
    'Canada',
    'Montreal',
    'America/New_York'
);


-- temp timezone
INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYHZ',
    'YHZ',
    'Halifax Stanfield International Airport',
    'Canada',
    'Halifax',
    'America/New_York'
);


-- temp timezone
INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'CYOW',
    'YOW',
    'Ottawa Macdonald–Cartier International Airport',
    'Canada',
    'Ottawa',
    'America/New_York'
);


-- temp timezone
INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'KEWR',
    'EWR',
    'Newark Liberty International Airport',
    'United States',
    'Newark',
    'America/New_York'
);


-- temp timezone
INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'EHAM',
    'AMS',
    'Amsterdam Airport Schiphol',
    'Netherlands',
    'Amsterdam',
    'America/New_York'
);


-- temp timezone
INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'EDDF',
    'FRA',
    'Frankfurt Airport',
    'Germany',
    'Frankfurt',
    'America/New_York'
);


-- temp timezone
INSERT INTO core.airports (icao, iata, full_airport_name, country, city, timezone)
VALUES (
    'EKCH',
    'CPH',
    'Copenhagen Airport',
    'Denmark',
    'Copenhagen',
    'America/New_York'
);

--------------------------------------------------------------------------------
-- Aircraft (of various types)
--------------------------------------------------------------------------------


INSERT INTO core.aircraft (registration, manufacturer, model, destination_icao_last, status)
VALUES 
('C-A1A1', 'BOEING','B787-9'::core.aircraft_model_type, 'CYYZ', 'FREE'),
('C-A1A2', 'BOEING','B787-9'::core.aircraft_model_type, 'CYYZ', 'UNDER MAINTENANCE'),
('C-A1A3', 'BOEING','B787-9'::core.aircraft_model_type, 'CYUL', 'FREE'),
('C-A1A4', 'BOEING','B787-9'::core.aircraft_model_type, 'CYUL', 'FREE'),
('C-A1A5', 'BOEING','B787-9'::core.aircraft_model_type, 'CYUL', 'FREE'),
('C-A1A6', 'BOEING','B787-9'::core.aircraft_model_type, 'CYUL', 'FREE'),
('C-B1A1', 'BOMBARDIER','Dash 8 Q400'::core.aircraft_model_type, 'CYTZ', 'FREE'),
('C-B1A2', 'BOMBARDIER','Dash 8 Q400'::core.aircraft_model_type, 'CYYZ', 'FREE'),
('C-B1A3', 'BOMBARDIER','Dash 8 Q400'::core.aircraft_model_type, 'CYOW', 'FREE'),
('C-C1A1', 'AIRBUS','A220-300'::core.aircraft_model_type, 'CYUL', 'UNDER MAINTENANCE'),
('C-C1A2', 'AIRBUS','A220-300'::core.aircraft_model_type, 'CYYZ', 'FREE'),
('C-C1A3', 'AIRBUS','A220-300'::core.aircraft_model_type, 'CYOW', 'FREE'),
('C-C1A4', 'AIRBUS','A220-300'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-C2A1', 'AIRBUS','A220-100'::core.aircraft_model_type, 'CYYZ', 'FREE'),
('C-C2A2', 'AIRBUS','A220-100'::core.aircraft_model_type, 'CYOW', 'FREE'),
('C-D1A1', 'EMBRAER','E195'::core.aircraft_model_type, 'CYHZ', 'UNDER MAINTENANCE'),
('C-D1A2', 'EMBRAER','E195'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-D1A3', 'EMBRAER','E195'::core.aircraft_model_type, 'CYHZ', 'UNDER MAINTENANCE'),
('C-D2A1', 'EMBRAER','E175'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-D2A2', 'EMBRAER','E175'::core.aircraft_model_type, 'CYHZ', 'UNDER MAINTENANCE'),
('C-D2A3', 'EMBRAER','E175'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-E1A1', 'AIRBUS','A350-1000'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-E1A2', 'AIRBUS','A350-1000'::core.aircraft_model_type, 'CYHZ', 'UNDER MAINTENANCE'),
('C-E1A3', 'AIRBUS','A350-1000'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-E1A4', 'AIRBUS','A350-1000'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-E1A5', 'AIRBUS','A350-1000'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-E1A6', 'AIRBUS','A350-1000'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-F1A1', 'AIRBUS','A319NEO'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-F1A2', 'AIRBUS','A319NEO'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-F1A3', 'AIRBUS','A319NEO'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-F1A4', 'AIRBUS','A319NEO'::core.aircraft_model_type, 'CYHZ', 'UNDER MAINTENANCE'),
('C-F1A5', 'AIRBUS','A319NEO'::core.aircraft_model_type, 'CYHZ', 'FREE'),
('C-CXNA', 'CESSNA','208B GRAND CARAVAN'::core.aircraft_model_type, 'CYOW', 'FREE'),
('C-CXNB', 'CESSNA','208B GRAND CARAVAN'::core.aircraft_model_type, 'CYYZ', 'UNDER MAINTENANCE'),
('C-CXNC', 'CESSNA','208B GRAND CARAVAN'::core.aircraft_model_type, 'CYOW', 'FREE'),
('C-CXND', 'CESSNA','208B GRAND CARAVAN'::core.aircraft_model_type, 'CYUL', 'FREE'),
('C-CXNE', 'CESSNA','208B GRAND CARAVAN'::core.aircraft_model_type, 'CYUL', 'FREE'),
('C-D2A4', 'EMBRAER','E175'::core.aircraft_model_type, 'CYUL', 'FREE');


--------------------------------------------------------------------------------
-- Flights
--------------------------------------------------------------------------------


INSERT INTO core.flights (
    flight_number, 
    origin_icao, 
    destination_icao, 
    departure_time_scheduled, 
    arrival_time_scheduled,
    types_allowed,
    date_from,
    date_to,
    date_dows
    )
VALUES
-- Billy Bishop to Montreal-Trudeau
('SAL1000', 'CYTZ', 'CYUL', '00:00:00', '01:45:00', '{"A220-300", "Dash 8 Q400", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1002', 'CYTZ', 'CYUL', '02:00:00', '03:45:00', '{"A220-300", "Dash 8 Q400"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1004', 'CYTZ', 'CYUL', '04:00:00', '05:45:00', '{"A220-300", "Dash 8 Q400", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1008', 'CYTZ', 'CYUL', '06:00:00', '07:45:00', '{"A220-300", "Dash 8 Q400", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1010', 'CYTZ', 'CYUL', '08:00:00', '09:45:00', '{"A220-300", "Dash 8 Q400", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1020', 'CYTZ', 'CYUL', '22:00:00', '23:45:00', '{"A220-300", "Dash 8 Q400"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),

-- Montreal-Trudeau to Billy Bishop
('SAL1001', 'CYUL', 'CYTZ', '03:00:00', '04:45:00', '{"A220-300", "Dash 8 Q400"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),

-- Montreal to Halifax
('SAL1100', 'CYUL', 'CYHZ', '07:00:00', '10:00:00', '{"A220-300", "Dash 8 Q400", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, false, false, true, true, true]),
('SAL1102', 'CYUL', 'CYHZ', '11:00:00', '14:00:00', '{"A220-300", "Dash 8 Q400"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, false, false, true, true, true]),
('SAL1104', 'CYUL', 'CYHZ', '15:00:00', '18:00:00', '{"A220-300", "Dash 8 Q400"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, false, false, true, true, true]),
('SAL1106', 'CYUL', 'CYHZ', '18:00:00', '21:00:00', '{"A220-300", "Dash 8 Q400"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, false, false, true, true, true]),

-- Montreal to Newark
('SAL1200', 'CYUL', 'KEWR', '07:15:00', '10:15:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),
('SAL1202', 'CYUL', 'KEWR', '10:15:00', '13:15:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),
('SAL1204', 'CYUL', 'KEWR', '13:15:00', '16:15:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),
('SAL1206', 'CYUL', 'KEWR', '16:15:00', '19:15:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),
('SAL1208', 'CYUL', 'KEWR', '19:15:00', '22:15:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),

-- Newark to Montreal
('SAL1201', 'KEWR', 'CYUL', '08:05:00', '11:05:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),
('SAL1203', 'KEWR', 'CYUL', '11:05:00', '14:05:00', '{"A220-300", "B787-9", "A319NEO", "E195"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, false, false, false, true, true, true]),

-- Other
('SAL1300', 'CYUL', 'EKCH', '06:00:00', '12:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1301', 'EKCH', 'CYUL', '05:00:00', '11:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1302', 'CYUL', 'EKCH', '10:00:00', '16:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1303', 'EKCH', 'CYUL', '13:00:00', '19:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1304', 'CYUL', 'EKCH', '14:00:00', '20:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1305', 'EKCH', 'CYUL', '17:00:00', '23:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),

-- Ottawa to Amsterdam
('SAL1400', 'CYOW', 'EHAM', '04:00:00', '11:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1402', 'CYOW', 'EHAM', '07:00:00', '14:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),

-- Amsterdam to Ottawa
('SAL1401', 'EHAM', 'CYOW', '06:00:00', '13:00:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),

-- Montreal to Frankfurt am Main
('SAL1500', 'CYUL', 'EDDF', '04:10:00', '11:10:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]),
('SAL1502', 'CYUL', 'EDDF', '06:10:00', '13:10:00', '{"A350-1000", "B787-9"}'::core.aircraft_model_type[], '2025-06-6'::date, '2030-06-6'::date, ARRAY[true, true, true, true, true, true, true]);
