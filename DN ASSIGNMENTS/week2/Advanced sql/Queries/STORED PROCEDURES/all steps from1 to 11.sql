-- SP 1: Get Employees by Department
DROP PROCEDURE IF EXISTS sp_GetEmployeesByDepartment;
GO
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, DepartmentID
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- SP 2: Modify to Include Salary
ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- SP 3: Delete (You may skip this to avoid losing it again)
-- DROP PROCEDURE IF EXISTS sp_GetEmployeesByDepartment;
-- GO

-- SP 4: Execution (moved to last so procedure exists before calling)
-- Will run at the very end
-- EXEC sp_GetEmployeesByDepartment 2;

-- SP 5: Count Employees in Department
DROP PROCEDURE IF EXISTS sp_CountEmployeesInDepartment;
GO
CREATE PROCEDURE sp_CountEmployeesInDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT COUNT(*) AS TotalEmployees
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- SP 6: Output Total Salary
DROP PROCEDURE IF EXISTS sp_TotalSalaryByDepartment;
GO
CREATE PROCEDURE sp_TotalSalaryByDepartment
    @DepartmentID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- SP 7: Update Salary
DROP PROCEDURE IF EXISTS sp_UpdateEmployeeSalary;
GO
CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
GO

-- SP 8: Give Bonus
DROP PROCEDURE IF EXISTS sp_GiveBonus;
GO
CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + @BonusAmount
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- SP 9: Transaction Update
DROP PROCEDURE IF EXISTS sp_Tr_
