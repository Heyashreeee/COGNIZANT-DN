import React from 'react';
import '../Stylesheets/mystyle.css';

function CalculateScore(props) {
  const percentage = ((props.total / 300) * 100).toFixed(2);
  return (
    <div className="container">
      <h2>Student Score Calculator</h2>
      <p><strong>Name:</strong> {props.Name}</p>
      <p><strong>School:</strong> {props.School}</p>
      <p><strong>Total Marks:</strong> {props.total}</p>
      <p><strong>Goal (Max):</strong> {props.goal}</p>
      <h3>Score: {percentage}%</h3>
    </div>
  );
}

export default CalculateScore;
