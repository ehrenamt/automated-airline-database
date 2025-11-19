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

    const intervalId = setInterval(fetchTrips, 5000);

    return () => clearInterval(intervalId);
    }, []);

    // Placeholder, we have some other ideas for loading values
    if (isLoading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    const getStatusColor = (status) => {
        switch (status) {
            case 'LANDED':
                return { color: 'rgb(130, 255, 153)' };
            case 'CANCELED':
                return { color: 'rgba(255, 101, 101, 1)' };
            case 'DELAYED':
                return { color: 'rgba(255, 101, 101, 1)' };
            default:
                return { color: 'rgb(255, 178, 62)' };
        }
    };

    console.log(trips)

    // document.title = "Trip Information";

    return (
        <>  
            <div className={styles.darkoverlay}></div>
            <div className={styles.overlay}></div>
            <div className={styles.tableViewObject}>
                <h1 className={styles.tableHeaderTitle}>Live Trip Information - Arrivals and Departures</h1>
                <div className={styles.columnHeader}>
                    <p className={styles.columnHeaderItemNarrowObject}>Flight #</p>
                    <p className={styles.columnHeaderItemLongObject}>From</p>
                    <p className={styles.columnHeaderItemLongObject}>To</p>
                    <p className={styles.columnHeaderItemStandardObject}>Aircraft</p>
                    <p className={styles.columnHeaderItemNarrowObject}>Departure</p>
                    <p className={styles.columnHeaderItemNarrowObject}>Arrival</p>
                    <p className={styles.columnHeaderItemNarrowObject}>Status</p>
                </div>
                <div className={styles.columnHeader}>
                    <p className={styles.columnHeaderItemNarrowObject}>Vol #</p>
                    <p className={styles.columnHeaderItemLongObject}>De</p>
                    <p className={styles.columnHeaderItemLongObject}>à</p>
                    <p className={styles.columnHeaderItemStandardObject}>Avion</p>
                    <p className={styles.columnHeaderItemNarrowObject}>Départ</p>
                    <p className={styles.columnHeaderItemNarrowObject}>Arrivée</p>
                    <p className={styles.columnHeaderItemNarrowObject}>état</p>
                </div>
                <ul>
                {trips.map(trip => (
                    <li className={styles.tripRow} key={trip.flightNumber}>
                        <p className={styles.tripRowNarrowField}>{trip.flightNumber}</p>
                        <p className={styles.tripRowLongField}>{trip.originAirport}</p>
                        <p className={styles.tripRowLongField}>{trip.destinationAirport}</p>
                        <p className={styles.tripRowStandardField} data-aircraft={`Aircraft: ${trip.aircraftModel}, Flight Number: ${trip.flightNumber}`}>{trip.aircraftModel}</p>
                        <p className={styles.tripRowNarrowField}>{trip.departureTimeScheduled}</p>
                        <p className={styles.tripRowNarrowField}>{trip.arrivalTimeScheduled}</p>
                        <p className={styles.tripRowNarrowField} style={getStatusColor(trip.status)}>{trip.status}</p>
                    </li>
                ))}
                </ul>
            </div>
        </>
    )
}

export default TripViewMain;