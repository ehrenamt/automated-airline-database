import { useState } from 'react';
import styles from '../../css/SearchViewMain.module.css'
import Hnav from '../Hnav';
import SearchInput from './SearchInput'

function SearchViewMain() {

    const [formData, setFormData] = useState({
        origin: '',
        destination: '',
        date: '',
        passengers: 1
    });

    const [responseData, setResponseData] = useState(null);

    const handleInputChange = (event) => {
        const { key, value } = event.target;
        setFormData((prevState) => ({
            ...prevState,
            [key]: value,
        }));

        console.log(formData)
    };

    return (
        <>
            <div className={styles.searchViewObject}>
                <Hnav></Hnav>
                <div className={styles.searchViewHeaderGroup}>
                    <h1>Flying to Europe or Asia for the holidays?</h1>
                    <h2>With the largest fleet and flight network in the world, Sequel Airlines will take you there!</h2>
                </div>
                <SearchInput onInputChange={handleInputChange}></SearchInput>
            </div>
        </>
    )
}

export default SearchViewMain;