DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10, 2),
    JoinDate DATE
);
INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO Employees VALUES
(101, 'Amit', 'Shah', 1, 50000, '2021-01-15'),
(102, 'Riya', 'Das', 2, 62000, '2020-07-22'),
(103, 'Vikram', 'Rao', 3, 58000, '2019-03-01');

