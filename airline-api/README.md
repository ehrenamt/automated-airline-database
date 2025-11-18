# Flask / GraphQL API

This application uses a Flask API for simple querying, which it then translates into a GraphQL query, addition an additional layer of abstraction from the database and allowing flexibility in modifying queries.

## Build

### Production Server
To run the production server without Docker, activate the virtual environment.
```
.venv/Scripts/Activate
```

Set up the virtual environment by installing the packages spceified in ```requirements.txt```.
```
pip install -r requirements.txt
```

Run the main file with Python.
```
python main.py
```

### Docker Build

From the parent directory, use docker compose to build the entire app
```
docker compose up
```
