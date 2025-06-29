-- Reset Schema
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10,2),
    JoinDate DATE
);
GO

-- Sample Data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');
GO

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 1, 5000.00, '2022-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2021-03-22'),
(3, 'Michael', 'Johnson', 3, 7000.00, '2020-07-30'),
(4, 'Emily', 'Davis', 4, 5500.00, '2019-11-05');
GO

-- Exercise 1: AFTER Trigger to Log Salary Changes
DROP TABLE IF EXISTS EmployeeChanges;
GO
CREATE TABLE EmployeeChanges (
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

DROP TRIGGER IF EXISTS trg_AfterSalaryUpdate;
GO
CREATE TRIGGER trg_AfterSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeChanges (EmployeeID, OldSalary, NewSalary)
    SELECT 
        d.EmployeeID, 
        d.Salary AS OldSalary, 
        i.Salary AS NewSalary
    FROM deleted d
    JOIN inserted i ON d.EmployeeID = i.EmployeeID
    WHERE d.Salary <> i.Salary;
END;
GO

-- Exercise 2: INSTEAD OF DELETE Trigger
DROP TRIGGER IF EXISTS trg_PreventDelete;
GO
CREATE TRIGGER trg_PreventDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Deletion not allowed on Employees table.', 16, 1);
END;
GO

-- Exercise 3: LOGON Trigger (2–3 AM restriction)
DROP TRIGGER IF EXISTS tr_LogonTimeRestrict ON ALL SERVER;
GO
CREATE TRIGGER tr_LogonTimeRestrict
ON ALL SERVER
FOR LOGON
AS
BEGIN
    IF DATEPART(HOUR, GETDATE()) BETWEEN 2 AND 2
    BEGIN
        ROLLBACK;
        PRINT 'Logins are disabled between 2 AM and 3 AM for maintenance.';
    END
END;
GO

-- Exercise 4: Modify a Trigger — Done manually in SSMS (GUI)

-- Exercise 5: Delete Triggers (run when needed)
-- DROP TRIGGER IF EXISTS trg_AfterSalaryUpdate;
-- DROP TRIGGER IF EXISTS trg_PreventDelete;
-- DROP TRIGGER IF EXISTS tr_LogonTimeRestrict ON ALL SERVER;

-- Exercise 6: Trigger to Update Computed Column
ALTER TABLE Employees ADD AnnualSalary DECIMAL(12,2);
GO

DROP TRIGGER IF EXISTS trg_UpdateAnnualSalary;
GO
CREATE TRIGGER trg_UpdateAnnualSalary
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE e
    SET AnnualSalary = e.Salary * 12
    FROM Employees e
    INNER JOIN inserted i ON e.EmployeeID = i.EmployeeID;
END;
GO

-- Test update that triggers both logs and computed update
UPDATE Employees
SET Salary = 8000
WHERE EmployeeID = 3;
GO

-- Check results
SELECT * FROM Employees;
SELECT * FROM EmployeeChanges;
GO
