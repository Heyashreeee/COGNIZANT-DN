import React from 'react';
import './App.css';
import CalculateScore from './components/CalculateScore';

function App() {
  return (
    <div className="App">
      <CalculateScore 
        Name="Sita" 
        School="Kendriya Vidyalaya" 
        total={289} 
        goal={3}
      />
    </div>
  );
}

export default App;
