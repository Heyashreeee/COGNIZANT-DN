import React from 'react';

const players = [
  { name: 'Virat Kohli', country: 'India' },
  { name: 'Steve Smith', country: 'Australia' },
  { name: 'Joe Root', country: 'England' },
  { name: 'Rohit Sharma', country: 'India' }
];

const OddPlayers = () => {
  const oddPlayers = players.filter((_, index) => index % 2 === 1);

  return (
    <div>
      <h2>Odd Index Players</h2>
      <ul>
        {oddPlayers.map((player, index) => (
          <li key={index}>{player.name}</li>
        ))}
      </ul>
    </div>
  );
};

export default OddPlayers;
