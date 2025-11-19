import styles from '../../css/SearchInput.module.css'

function SearchInput(onInputChange) {
    return (
        <>
            <div className={styles.searchInputObject}>
                <h3 className={styles.searchViewHeader}>Use our flexible search features below!</h3>
                <div className={styles.searchFormWrapper}>
                    {/* <form onSubmit={onFormSubmit}></form> */}
                    <form className={styles.searchForm}>
                        <div className={styles.searchFormVerticalGroup}>
                            <p className={styles.inputLabel}>From</p>
                            <input 
                            className={styles.inputTag} type="text" id="fname" name="search-input-origin-airport"
                            onChange={onInputChange}
                            />
                        </div>
                        <div className={styles.searchFormVerticalGroup}>
                            <p className={styles.inputLabel}>To</p>
                            <input className={styles.inputTag} type="text" id="fname" name="search-input-origin-airport" onChange={onInputChange}></input>
                        </div>
                        <div className={styles.searchFormVerticalGroup}>
                            <p className={styles.inputLabel}>Date</p>
                            <input className={styles.inputTag} type="date" onChange={onInputChange}></input>
                        </div>
                        <div className={styles.searchFormVerticalGroup}>
                            <p className={styles.inputLabel}>Passengers</p>
                            <input className={styles.inputTag} type="number" min="1" required onChange={onInputChange}></input>
                        </div>
                        <input className={styles.submitButton} type="submit" value="Submit"></input>
                    </form>
                </div>
            </div>
        </>
    )
}

export default SearchInput;
