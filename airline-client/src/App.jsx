import { useState } from 'react'
import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import TripViewMain from './components/tripview/TripViewMain';
import SearchViewMain from './components/searchview/SearchViewMain';
import Guide from './components/staticpages/Guide';


function App() {
  return (

    <Router>
      <Routes>
        <Route path="/" element={<SearchViewMain />} />
        <Route path="/tripinformation" element={<TripViewMain />} />
        <Route path="/projectdocs" element={<Guide />} />
        {/* <Route path="/dynamic/:id" element={<DynamicPage />} /> */}
      </Routes>
    </Router>
  )
}

export default App
