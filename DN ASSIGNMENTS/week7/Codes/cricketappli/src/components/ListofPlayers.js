import React from 'react';

const players = [
  { name: 'Virat Kohli', country: 'India' },
  { name: 'Steve Smith', country: 'Australia' },
  { name: 'Joe Root', country: 'England' },
  { name: 'Rohit Sharma', country: 'India' }
];

const ListOfPlayers = () => {
  return (
    <div>
      <h2>All Players</h2>
      <ul>
        {players.map((player, index) => (
          <li key={index}>{player.name} ({player.country})</li>
        ))}
      </ul>
    </div>
  );
};

export default ListOfPlayers;
