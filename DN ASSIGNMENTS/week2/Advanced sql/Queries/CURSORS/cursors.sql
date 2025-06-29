-- DROP old tables if needed
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

-- Insert sample Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');
GO

-- Insert sample Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 1, 5000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2019-03-22'),
(3, 'Bob', 'Johnson', 3, 5500.00, '2021-07-30');
GO

-- Exercise 1: Basic Cursor to Print All Employee Details
DECLARE @EmployeeID INT, @FirstName VARCHAR(50), @LastName VARCHAR(50), 
        @DepartmentID INT, @Salary DECIMAL(10,2), @JoinDate DATE;

DECLARE emp_cursor CURSOR FOR
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate FROM Employees;

OPEN emp_cursor;

FETCH NEXT FROM emp_cursor INTO @EmployeeID, @FirstName, @LastName, @DepartmentID, @Salary, @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'ID: ' + CAST(@EmployeeID AS VARCHAR) + ', Name: ' + @FirstName + ' ' + @LastName +
          ', DeptID: ' + CAST(@DepartmentID AS VARCHAR) + ', Salary: ' + CAST(@Salary AS VARCHAR) +
          ', JoinDate: ' + CAST(@JoinDate AS VARCHAR);
    
    FETCH NEXT FROM emp_cursor INTO @EmployeeID, @FirstName, @LastName, @DepartmentID, @Salary, @JoinDate;
END;

CLOSE emp_cursor;
DEALLOCATE emp_cursor;
GO

-- Exercise 2: Types of Cursors

-- 1. Static Cursor
DECLARE static_cursor CURSOR STATIC FOR
SELECT * FROM Employees;
OPEN static_cursor;
CLOSE static_cursor;
DEALLOCATE static_cursor;
GO

-- 2. Dynamic Cursor
DECLARE dynamic_cursor CURSOR DYNAMIC FOR
SELECT * FROM Employees;
OPEN dynamic_cursor;
CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;
GO

-- 3. Forward-Only Cursor
DECLARE forward_cursor CURSOR FORWARD_ONLY FOR
SELECT * FROM Employees;
OPEN forward_cursor;
CLOSE forward_cursor;
DEALLOCATE forward_cursor;
GO

-- 4. Keyset-Driven Cursor
DECLARE keyset_cursor CURSOR KEYSET FOR
SELECT * FROM Employees;
OPEN keyset_cursor;
CLOSE keyset_cursor;
DEALLOCATE keyset_cursor;
GO
