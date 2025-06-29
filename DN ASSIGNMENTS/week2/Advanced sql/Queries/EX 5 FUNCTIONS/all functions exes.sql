-- Drop existing tables if needed
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10,2),
    JoinDate DATE
);
GO

-- Insert Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');
GO

-- Insert Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 1, 5000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2019-03-22'),
(3, 'Bob', 'Johnson', 3, 5500.00, '2021-07-01');
GO

-- Exercise 1: Scalar Function - Annual Salary
CREATE FUNCTION fn_CalculateAnnualSalary (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 12;
END;
GO

-- Exercise 2: Table-Valued Function - Employees by Department
CREATE FUNCTION fn_GetEmployeesByDepartment (@DeptID INT)
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
    FROM Employees
    WHERE DepartmentID = @DeptID
);
GO

-- Exercise 3: Scalar Function - 10% Bonus
CREATE FUNCTION fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

-- Exercise 4: Modify Bonus Function to 15%
ALTER FUNCTION fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

-- Exercise 5: Drop Bonus Function
DROP FUNCTION IF EXISTS fn_CalculateBonus;
GO

-- Recreate for later exercises
CREATE FUNCTION fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

-- Exercise 6: Execute Annual Salary Function
SELECT EmployeeID, FirstName, dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

-- Exercise 7: Annual Salary for EmployeeID = 1
SELECT dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees
WHERE EmployeeID = 1;
GO

-- Exercise 8: Employees from Finance Department
SELECT * FROM dbo.fn_GetEmployeesByDepartment(3);
GO

-- Exercise 9: Nested Function - Total Compensation
CREATE FUNCTION fn_CalculateTotalCompensation (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2)
    SET @Total = dbo.fn_CalculateAnnualSalary(@Salary) + dbo.fn_CalculateBonus(@Salary)
    RETURN @Total
END;
GO

-- Exercise 10: Modify Nested Function to Use Updated Bonus
ALTER FUNCTION fn_CalculateTotalCompensation (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2)
    SET @Total = dbo.fn_CalculateAnnualSalary(@Salary) + dbo.fn_CalculateBonus(@Salary)
    RETURN @Total
END;
GO

-- Final test of nested function
SELECT EmployeeID, FirstName, dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO
