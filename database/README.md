# Sequel Airlines Database

The airline database is a PostgreSQL database that makes use of PLpgSQL functions to automate adding new data, updating current data, and archiving old data.

## Description

This database stores information on flights, aircraft, and trips. It distinguishes flights and trips by defining flights as recurring, scheduled trips, whereas trips are flights associated at a particular time and day using a particular aircraft.

These tables and views are normalized and separated into schemas. These schemas are only accessible by certain users. This means users are unable to perform operations on data objects, or they are unable to view information at all, depending on the schema. For example, the ```readonly_user``` can only read tables from the core schema. Any other type of SQL statement is not allowed.

This combination of user permissions on schemas allows the Flask API to connect to the database as different users based on the type of query. This reduces the permissions to only the necessary permissions for that query type, minimizing the potential attack surface for harmful queries.

In addition, the logic of automatically updating and archiving rows are handled automatically using scheduled ```pg_cron``` tasks. No backend or API is needed to communicate with the database for automated and scheduled tasks; the database can operate entirely independently.

## Build and Installation

The Docker image is built as specified in [Dockerfile.db](Dockerfile.db). Note that no ports are exposed, so it is only directly accessible via an interactive terminal or via the Docker bridge network. For this reason, the API also features an admin interface to easily view sensitive data.

```.sql``` files are numbered in the manner ```1-description```, ```2-description```, and more to enforce the order in which these files are executed. In the Dockerfile, these are moved into the ```/docker-entrypoint-initdb.d``` directory. The PostgreSQL image, upon building the container, will execute these in alphanumerical order. The numbering of these files clearly indicates the order in which these files will be executed during the build process.

### Build

From the parent directory, use docker compose to build the entire app
```
docker compose up
```

## Documentation

Detailed documentation is accessible in the ```/documentation``` subdirectory.
