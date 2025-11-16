import { useState } from 'react'
import './App.css'
import './components/tripview/TripViewMain'
import TripViewMain from './components/tripview/TripViewMain'

import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <TripViewMain></TripViewMain>
    </>
  )
}

export default App
