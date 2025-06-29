-- EXERCISE 1: Basic TRY...CATCH – Insert duplicate email triggers error and logs
BEGIN TRY
    -- First insert succeeds
    EXEC AddEmployee 101, 'Alice', 'Jones', 'alice@company.com', 5500, 1;

    -- Second insert with duplicate email triggers catch
    EXEC AddEmployee 102, 'Alan', 'Smith', 'alice@company.com', 6000, 1;
END TRY
BEGIN CATCH
    PRINT 'Test 1 Error: ' + ERROR_MESSAGE();
END CATCH
GO

-- EXERCISE 2: THROW – Ensures error is logged and thrown back to client
BEGIN TRY
    EXEC AddEmployee 103, 'Bob', 'Dylan', 'bob@company.com', 5500, 1;
    -- Reusing same email again to force THROW
    EXEC AddEmployee 104, 'Bobby', 'Ray', 'bob@company.com', 5800, 1;
END TRY
BEGIN CATCH
    PRINT 'Test 2 THROW Triggered: ' + ERROR_MESSAGE();
END CATCH
GO

-- EXERCISE 3: RAISERROR for Salary <= 0
BEGIN TRY
    EXEC AddEmployee 105, 'Charlie', 'Gray', 'charlie@company.com', 0, 1;
END TRY
BEGIN CATCH
    PRINT 'Test 3 Salary Validation: ' + ERROR_MESSAGE();
END CATCH
GO

-- EXERCISE 4: Nested TRY...CATCH – Transfer to invalid department
BEGIN TRY
    EXEC AddEmployee 106, 'David', 'Stone', 'david@company.com', 5500, 1;
    EXEC TransferEmployee 106, 999;  -- Invalid dept ID
END TRY
BEGIN CATCH
    PRINT 'Test 4 Nested Catch: ' + ERROR_MESSAGE();
END CATCH
GO

-- EXERCISE 5: Batch Insert – One bad insert triggers rollback
BEGIN TRY
    EXEC BatchInsertEmployees;
END TRY
BEGIN CATCH
    PRINT 'Test 5 Transaction Rolled Back: ' + ERROR_MESSAGE();
END CATCH
GO

-- EXERCISE 6: Severity Levels – Salary too low triggers warning, negative triggers error
BEGIN TRY
    -- Low salary: triggers warning
    EXEC AddEmployee 107, 'Ella', 'Young', 'ella@company.com', 900, 1;

    -- Negative salary: triggers error
    EXEC AddEmployee 108, 'Eve', 'Black', 'eve@company.com', -100, 1;
END TRY
BEGIN CATCH
    PRINT 'Test 6 Severity: ' + ERROR_MESSAGE();
END CATCH
GO

-- ✅ View Audit Logs and Employee Table After Testing
SELECT * FROM AuditLog ORDER BY ActionDate DESC;
SELECT * FROM Employees ORDER BY EmployeeID;
