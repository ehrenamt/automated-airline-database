import { Link } from 'react-router-dom';
import styles from '../css/Hnav.module.css';

function Hnav() {
    return (
        <>
            <div class={styles.hnavObject}>
                <div class={styles.hnavWrapper}>
                    <nav class={styles.hnav}>
                        <li class={styles.hnavLiObject}>
                            <Link to="/" class={styles.hnavLiItemObject}>Home</Link>
                            <Link to="/about" class={styles.hnavLiItemObject}>About</Link>
                            <Link to="/tripinformation" class={styles.hnavLiItemObject}>Live Trips</Link>
                            <Link to="/contact" class={styles.hnavLiItemObject}>Contact</Link>
                            <Link to="/projectdocs" class={styles.hnavLiItemObject}>Guide</Link>
                        </li>
                    </nav>
                </div>
            </div>
        </>
    )
}

export default Hnav;