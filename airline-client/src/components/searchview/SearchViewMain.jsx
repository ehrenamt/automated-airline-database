import styles from '../../css/SearchViewMain.module.css'
import Hnav from '../Hnav';
import SearchInput from './SearchInput'

function SearchViewMain() {
    return (
        <>
            <div class={styles.searchViewObject}>
                <Hnav></Hnav>
                <h2>Flying to Europe or Asia for the holidays?</h2>
                <h2>With the largest fleet and flight network in the world, Sequel Airlines will take you there!</h2>
                <SearchInput></SearchInput>
            </div>
        </>
    )
}

export default SearchViewMain;