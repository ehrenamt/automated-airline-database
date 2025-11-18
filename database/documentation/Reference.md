# Reference

## Types

### manufacturer_type

<b>Description:</b>
An enumerated type that stores the names of aircraft manufacturers. Available in the ```core``` schema.

<b>Location:</b> ```2-schema.sql```

<b>Definition:</b>

```
CREATE TYPE core.manufacturer_type AS ENUM (
    'AIRBUS',
    'BOEING',
    'BOMBARDIER',
    'CESSNA',
    'DOUGLAS CORPORATION',
    'EMBRAER',
    'MCDONNELL DOUGLAS'
);
```


### aircraft_model_type

<b>Description:</b>
An enumerated type that stores the names of aircraft models from the different manufacturers listed in the ```manufacturer_type```. Available in the ```core``` schema.

<b>Location:</b> ```2-schema.sql```

<b>Definition:</b>

```
CREATE TYPE core.aircraft_model_type AS ENUM (
    'A220-100',
    'A220-300',
    'A319NEO',
    'A350-1000',
    'B787-9',
    'Dash 8 Q400',
    'E175',
    'E195',
    '208B GRAND CARAVAN'
);
```


### aircraft_status_type

<b>Description:</b>
An enumerated type that represents the status of fleet aircraft in the aircraft entity table. Available in the ```core``` schema.

<b>Location:</b> ```2-schema.sql```

<b>Definition:</b>

```
CREATE TYPE core.aircraft_status_type AS ENUM (
    'IN SERVICE',
    'UNDER MAINTENANCE',
    'FREE'
);
```


### trip_status_type

<b>Description:</b>
An enumerated type that represents the status of trips in the trip table and the trip details view. Available in the ```core``` schema.

<b>Location:</b> ```2-schema.sql```

<b>Definition:</b>

```
CREATE TYPE core.trip_status_type AS ENUM (
    'SCHEDULED',
    'DELAYED',
    'IN FLIGHT',
    'LANDED',
    'CANCELED'
);
```


## Tables & Entities

### Airports

```
CREATE TABLE core.airports (
    icao CHAR(4) PRIMARY KEY,
    iata CHAR(3) UNIQUE NOT NULL,
    full_airport_name TEXT UNIQUE NOT NULL,
    airport_display_name TEXT UNIQUE NOT NULL,
    country TEXT NOT NULL,
    city TEXT,
    timezone TEXT NOT NULL
);
```