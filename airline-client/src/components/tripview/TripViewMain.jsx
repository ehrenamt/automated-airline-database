import React, { useState, useEffect } from 'react';
import styles from '../../css/TripView.module.css'

function TripViewMain() {

    const apiUrlTripEndpoint = import.meta.env.GRAPHQL_API_URL_TRIP_ENDPOINT;
    
    const [trips, setTrips] = useState([]);
    const [error, setError] = useState(null);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
    const fetchTrips = async () => {
        try {
        const response = await fetch('http://127.0.0.1:8000/userapi/tripinformation');
        if (!response.ok) {
            throw new Error('Response returned not ok.');
        }

        const jsonData = await response.json();

        setTrips(jsonData.getTripInformation);

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

    const getStatusColor = (status) => {
        switch (status) {
            case 'LANDED':
                return { color: 'rgb(130, 255, 153)' };
            default:
                return { color: 'rgb(255, 178, 62)' };
        }
    };

    console.log(trips)
    return (
        <>  
            <div class={styles.darkoverlay}></div>
            <div class={styles.overlay}></div>
            <div class={styles.tableViewObject}>
                <h1 class={styles.tableHeaderTitle}>Live Trip Information - Arrivals and Departures</h1>
                <div class={styles.columnHeader}>
                    <p class={styles.columnHeaderItemNarrowObject}>Flight #</p>
                    <p class={styles.columnHeaderItemLongObject}>From</p>
                    <p class={styles.columnHeaderItemLongObject}>To</p>
                    <p class={styles.columnHeaderItemStandardObject}>Aircraft</p>
                    <p class={styles.columnHeaderItemNarrowObject}>Departure</p>
                    <p class={styles.columnHeaderItemNarrowObject}>Arrival</p>
                    <p class={styles.columnHeaderItemNarrowObject}>Status</p>
                </div>
                <div class={styles.columnHeader}>
                    <p class={styles.columnHeaderItemNarrowObject}>Vol #</p>
                    <p class={styles.columnHeaderItemLongObject}>De</p>
                    <p class={styles.columnHeaderItemLongObject}>à</p>
                    <p class={styles.columnHeaderItemStandardObject}>Avion</p>
                    <p class={styles.columnHeaderItemNarrowObject}>Départ</p>
                    <p class={styles.columnHeaderItemNarrowObject}>Arrivée</p>
                    <p class={styles.columnHeaderItemNarrowObject}>état</p>
                </div>
                <ul>
                {trips.map(trip => (
                    <li class={styles.tripRow} key={trip.flightNumber}>
                        <p class={styles.tripRowNarrowField}>{trip.flightNumber}</p>
                        <p class={styles.tripRowLongField}>{trip.originAirport}</p>
                        <p class={styles.tripRowLongField}>{trip.destinationAirport}</p>
                        <p class={styles.tripRowStandardField} data-aircraft={`Aircraft: ${trip.aircraftModel}, Flight Number: ${trip.flightNumber}`}>{trip.aircraftModel}</p>
                        <p class={styles.tripRowNarrowField}>{trip.departureTimeScheduled}</p>
                        <p class={styles.tripRowNarrowField}>{trip.arrivalTimeScheduled}</p>
                        <p class={styles.tripRowNarrowField} style={getStatusColor(trip.status)}>{trip.status}</p>
                    </li>
                ))}
                </ul>
            </div>
        </>
    )
}

export default TripViewMain;