# Reference

## Types

### manufacturer_type

<b>Description:</b>
An enumerated type that stores the names of aicraft manufacturers. Available in the ```core``` schema.

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
An enumerated type that stores the names of aicraft models from the different manufacturers listed in the ```manufacturer_type```. Available in the ```core``` schema.

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
