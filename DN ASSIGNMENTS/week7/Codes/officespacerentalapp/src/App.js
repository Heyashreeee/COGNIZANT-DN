import React from 'react';

function OfficeSpaceCard() {
  const office = {
    name: 'Office Hub',
    rent: 58000,
    address: 'Bangalore',
  };

  const rentStyle = {
    color: office.rent < 60000 ? 'red' : 'green',
  };

  return (
    <div>
      <h1>Office Space Rental</h1>
      <img
        src="https://plus.unsplash.com/premium_photo-1670315264879-59cc6b15db5f?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        alt="Office Space"
        width="500"
      />
      <h2>{office.name}</h2>
      <p style={rentStyle}>Rent: ₹{office.rent}</p>
      <p>Address: {office.address}</p>
    </div>
  );
}

export default OfficeSpaceCard;
