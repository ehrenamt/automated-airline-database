"""
main.py

Entrypoint for a Flask-GraphQL API application.
"""

# third-party packages
from dotenv import load_dotenv
from flask import Flask, request, jsonify, make_response
from flask_cors import CORS, cross_origin
import strawberry

# project imports
from src.database import schemas

app = Flask(__name__)

load_dotenv()

CORS(app)

schema = strawberry.Schema(query=schemas.Query)


@app.route("/userapi/flights", methods=["GET"])
@cross_origin()
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

    response = make_response(jsonify(result.data))

    response.headers.add('Access-Control-Allow-Origin', '*')

    return response, 200


@app.route("/userapi/trips", methods=["GET"])
# @cross_origin()
def get_trips():

    query_string = '{ getTrips '
    query_string += '{'
    query_string += 'flightNumber departureTimeScheduled '
    query_string += 'arrivalTimeScheduled aircraft tripStatus'
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    response = make_response(jsonify(result.data))

    response.headers.add('Access-Control-Allow-Origin', '*')

    return response, 200


@app.route("/userapi/tripinformation", methods=["GET"])
def get_trip_information():

    query_string = '{ getTripInformation '
    query_string += '{'
    query_string += 'flightNumber aircraftModel '
    query_string += 'originAirport destinationAirport '
    query_string += 'departureTimeScheduled arrivalTimeScheduled status '
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    response = make_response(jsonify(result.data))

    response.headers.add('Access-Control-Allow-Origin', '*')

    return response, 200


@app.route("/dbadmin/archivedtrips", methods=["GET"])
@cross_origin()
def get_archived_trips():

    query_string = '{ getArchivedTrips '
    query_string += '{'
    query_string += 'flightNumber departureTimeScheduled '
    query_string += 'arrivalTimeScheduled aircraft tripStatus'
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    response = make_response(jsonify(result.data))

    response.headers.add('Access-Control-Allow-Origin', '*')

    return response, 200


@app.route("/dbadmin/aircraft", methods=["GET"])
@cross_origin()
def get_aircraft():

    query_string = '{ getAircraft '
    query_string += '{'
    query_string += 'registration manufacturer '
    query_string += 'model status'
    query_string += '}'
    query_string += '}'

    result = schema.execute_sync(query_string)

    response = make_response(jsonify(result.data))

    response.headers.add('Access-Control-Allow-Origin', '*')

    return response, 200


if __name__ == "__main__":
    # for the development server
    app.run(host="0.0.0.0", port=8000)
