CREATE VIEW vw_EmployeeFullName AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    FirstName + ' ' + LastName AS FullName
FROM Employees;
