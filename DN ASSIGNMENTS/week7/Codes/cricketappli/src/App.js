import React, { useState } from 'react';
import ListOfPlayers from './components/ListofPlayers';
import IndianPlayers from './components/IndianPlayers';
import OddPlayers from './components/OddPlayers';

const App = () => {
  const [flag, setFlag] = useState(true);

  const toggleFlag = () => {
    setFlag(!flag);
  };

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial' }}>
      <h1>Cricket Players App</h1>
      <button onClick={toggleFlag}>
        Show {flag ? 'Odd Players' : 'Indian Players'}
      </button>

      <ListOfPlayers />

      {flag ? <IndianPlayers /> : <OddPlayers />}
    </div>
  );
};

export default App;
