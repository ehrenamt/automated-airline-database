import { useState } from 'react'
import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
// import './components/searchview/SearchViewMain'
// import './components/tripview/TripViewMain'
import TripViewMain from './components/tripview/TripViewMain'
import SearchViewMain from './components/searchview/SearchViewMain'

function App() {
  return (

    <Router>
      <Routes>
        <Route path="/" element={<SearchViewMain />} />
        <Route path="/tripinformation" element={<TripViewMain />} />
        {/* <Route path="/dynamic/:id" element={<DynamicPage />} /> */}
      </Routes>
    </Router>
    // <>
    //   <TripViewMain></TripViewMain>
    // </>
  )
}

export default App
