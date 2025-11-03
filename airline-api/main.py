from flask import Flask, request, jsonify
import strawberry
from sqlalchemy.sql import text

# project imports
import db_setup
import schemas

app = Flask(__name__)

schema = strawberry.Schema(query=schemas.Query)


@app.route("/graphql/flights", methods=["GET"])
def get_flights():
    flight_number = request.args.get('flight_number')
    origin = request.args.get('origin')

    query_string = '{ getFlights(flightNumber: \"' + str(flight_number) + '\") { flightNumber originIcao destinationIcao }}'
    
    result = schema.execute_sync(query_string)
    
    return jsonify(result.data)


# GET http://127.0.0.1:8000/graphql/flights?flight_number=SAL1002


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)