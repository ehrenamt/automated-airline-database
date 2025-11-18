import styles from '../../css/SearchInput.module.css'

function SearchInput() {
    return (
        <>
            {/* search object */}
            <div class={styles.searchViewObject}>
                <h3>Use our flexible search features below!</h3>
                <div class={styles.searchFormWrapper}>
                    <p>From</p>
                    <input type="text" id="fname" name="search-input-origin-airport"></input>
                    <p>To</p>
                    <input type="text" id="fname" name="search-input-origin-airport"></input>
                    <p>Date</p>
                    <input type="date"></input>
                    <p>Passengers</p>
                    <input type="number" min="1" required></input>
                    <input type="submit" value="Submit"></input>
                </div>
            </div>
        </>
    )
}

export default SearchInput;
