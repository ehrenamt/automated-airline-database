"""
main.py

Entrypoint for a Flask-GraphQL API application.
"""

# third-party packages
from flask import Flask, request, jsonify
import strawberry

# project imports
# import src.database.schemas as schemas
from src.database import schemas

app = Flask(__name__)

schema = strawberry.Schema(query=schemas.Query)


@app.route("/userapi/flights", methods=["GET"])
def get_flights_default():
    """
    Default route for flight search.
    Supports flexible querying, can return flights without specifying exact parameters.
    """

    flight_number = request.args.get('flight_number')
    origin = request.args.get('origin')

    query_string = '{ getFlights'
    query_string_end = ' { flightNumber originIcao destinationIcao }}'

    filters = {"flightNumber": flight_number, "originIcao": origin}
    any_filters = False

    filter_query_string = ""

    # Add filters to the GraphQL if they have been specified in the API URL
    for _, (key, value) in enumerate(filters.items()):
        if value is not None:

            if any_filters:
                filter_query_string += ", "

            filter_query_string += f'{key}: "{value}"'

            any_filters = True

    # Add necessary parentheses if any_filters is triggered
    if any_filters :
        query_string = query_string + "(" + filter_query_string + ")"

    query_string += query_string_end

    result = schema.execute_sync(query_string)

    return jsonify(result.data), 200


@app.route("/userapi/trips", methods=["GET"])
def get_trips():

    query_string = '{ getTrips '
    query_string += '{'
    query_string += 'flightNumber departureTimeScheduled '
    query_string += 'arrivalTimeScheduled aircraft tripStatus'
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    return jsonify(result.data), 200


@app.route("/dbadmin/archivedtrips", methods=["GET"])
def get_archived_trips():

    query_string = '{ getArchivedTrips '
    query_string += '{'
    query_string += 'flightNumber departureTimeScheduled '
    query_string += 'arrivalTimeScheduled aircraft tripStatus'
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    return jsonify(result.data), 200


@app.route("/dbadmin/aircraft", methods=["GET"])
def get_aircraft():

    query_string = '{ getAircraft '
    query_string += '{'
    query_string += 'registration manufacturer '
    query_string += 'model status'
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    return jsonify(result.data), 200


if __name__ == "__main__":
    # for the development server
    app.run(host="0.0.0.0", port=8000)
