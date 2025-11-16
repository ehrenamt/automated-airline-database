import React, { useState, useEffect } from 'react';

function TripViewMain() {

    const apiUrlTripEndpoint = import.meta.env.GRAPHQL_API_URL_TRIP_ENDPOINT;
    
    const [trips, setTrips] = useState([]);
    const [error, setError] = useState(null);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
    const fetchTrips = async () => {
        try {
        const response = await fetch('http://airline-graphql-api:8000/userapi/trips');
        if (!response.ok) {
            throw new Error('Response returned not ok.');
        }

        const jsonData = await response.json();

        setTrips(jsonData.getTrips);

        } catch (error) {
            setError(error);
        } finally {
            setIsLoading(false);
        }
    };

    fetchTrips();
    }, []);

    // Placeholder, we have some other ideas for loading values
    if (isLoading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;


    // const getTripDict = data["getTrips"];

    console.log(trips)
    return (
        <>
            <h1>Live Trip Information</h1>
            <p>Table</p>
        </>
    )
}

export default TripViewMain