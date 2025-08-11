// src/TrainersMock.js
import Trainer from './Trainer';

const trainers = [
  new Trainer(1, 'John Doe', 'john@example.com', '1234567890', 'Java', ['Spring', 'Hibernate']),
  new Trainer(2, 'Jane Smith', 'jane@example.com', '9876543210', 'Python', ['Django', 'Flask']),
  new Trainer(3, 'Alice Johnson', 'alice@example.com', '1112223333', 'JavaScript', ['React', 'Node.js']),
];

export default trainers;
