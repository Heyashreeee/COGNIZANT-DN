import React from 'react';

const players = [
  { name: 'Virat Kohli', country: 'India' },
  { name: 'Steve Smith', country: 'Australia' },
  { name: 'Joe Root', country: 'England' },
  { name: 'Rohit Sharma', country: 'India' }
];

const IndianPlayers = () => {
  const indianOnly = players.filter(player => player.country === 'India');

  return (
    <div>
      <h2>Indian Players</h2>
      <ul>
        {indianOnly.map((player, index) => (
          <li key={index}>{player.name}</li>
        ))}
      </ul>
    </div>
  );
};

export default IndianPlayers;
