-- SCHEMA SETUP
DROP TABLE IF EXISTS AuditLog;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

CREATE TABLE AuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Action VARCHAR(100),
    ErrorMessage VARCHAR(4000),
    ActionDate DATETIME DEFAULT GETDATE()
);
GO

-- Insert Sample Department
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'HR'), (2, 'IT'), (3, 'Finance');
GO

-- PROCEDURE: AddEmployee with all validations and error handling
DROP PROCEDURE IF EXISTS AddEmployee;
GO
CREATE PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10, 2),
    @DepartmentID INT
AS
BEGIN
    IF @Salary < 0
    BEGIN
        RAISERROR('Negative salary not allowed.', 16, 1);
        RETURN;
    END
    ELSE IF @Salary < 1000
    BEGIN
        RAISERROR('Warning: salary is too low.', 10, 1);
    END

    IF @Salary <= 0
    BEGIN
        RAISERROR('Salary must be greater than zero.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID);
    END TRY
    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('Insert Employee', ERROR_MESSAGE());
        THROW;
    END CATCH
END;
GO

-- PROCEDURE: TransferEmployee with nested TRY...CATCH
DROP PROCEDURE IF EXISTS TransferEmployee;
GO
CREATE PROCEDURE TransferEmployee
    @EmployeeID INT,
    @NewDeptID INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @NewDeptID)
        BEGIN
            RAISERROR('Target department does not exist.', 16, 1);
        END

        BEGIN TRY
            UPDATE Employees
            SET DepartmentID = @NewDeptID
            WHERE EmployeeID = @EmployeeID;
        END TRY
        BEGIN CATCH
            INSERT INTO AuditLog (Action, ErrorMessage)
            VALUES ('Transfer Employee', ERROR_MESSAGE());
            THROW;
        END CATCH

    END TRY
    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('Outer Transfer Error', ERROR_MESSAGE());
        THROW;
    END CATCH
END;
GO

-- PROCEDURE: BatchInsertEmployees with transaction rollback and logging
DROP PROCEDURE IF EXISTS BatchInsertEmployees;
GO
CREATE PROCEDURE BatchInsertEmployees
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Employees VALUES (5, 'Alice', 'Ray', 'alice@example.com', 5000, 1);
        INSERT INTO Employees VALUES (6, 'Mark', 'Stone', 'mark@example.com', 0, 2);  -- triggers error
        INSERT INTO Employees VALUES (7, 'Leo', 'Ford', 'leo@example.com', 7000, 3);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('Batch Insert', ERROR_MESSAGE());
    END CATCH
END;
GO

-- EXEC AddEmployee 1, 'John', 'Doe', 'john@example.com', 0, 1;  -- Salary zero: should RAISERROR
-- EXEC AddEmployee 2, 'Jane', 'Smith', 'jane@example.com', 900, 1; -- Salary < 1000: warning
-- EXEC AddEmployee 3, 'Mike', 'Low', 'john@example.com', 5500, 1; -- Duplicate email triggers catch

-- EXEC TransferEmployee 1, 999;  -- Invalid dept triggers nested error logging

-- EXEC BatchInsertEmployees;  -- 2nd insert fails, rollback, logs error

-- SELECT * FROM AuditLog;
-- SELECT * FROM Employees;
