import React, { useState } from "react";
import "./App.css";

function App() {
  const [count, setCount] = useState(0);
  const [amount, setAmount] = useState("");
  const [currency, setCurrency] = useState("");

  // Multiple handler for increment button
  const handleIncrement = () => {
    setCount(prev => prev + 1);
    sayHello();
  };

  const handleDecrement = () => {
    setCount(prev => prev - 1);
  };

  const sayHello = () => {
    alert("Hello! Member1");
  };

  const sayMessage = (msg) => {
    alert(msg);
  };

  const handleClick = (e) => {
    // Synthetic event in React
    alert("I was clicked");
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (currency === "Euro") {
      const result = parseFloat(amount) * 80;
      alert(`Converting to ${currency} Amount is ${result}`);
    } else {
      alert("Please enter valid currency");
    }
  };

  return (
    <div className="App">
      <p>{count}</p>
      <button onClick={handleIncrement}>Increment</button>
      <button onClick={handleDecrement}>Decrement</button>
      <br /><br />
      <button onClick={() => sayMessage("welcome")}>Say welcome</button>
      <br /><br />
      <button onClick={handleClick}>Click on me</button>

      <h1 style={{ color: "green" }}>Currency Convertor!!!</h1>

      <form onSubmit={handleSubmit}>
        <label>
          Amount:
          <input
            type="text"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
          />
        </label>
        <br />
        <label>
          Currency:
          <input
            type="text"
            value={currency}
            onChange={(e) => setCurrency(e.target.value)}
          />
        </label>
        <br />
        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default App;
