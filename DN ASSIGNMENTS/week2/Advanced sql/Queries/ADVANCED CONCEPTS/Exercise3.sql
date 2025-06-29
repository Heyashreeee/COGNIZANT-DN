-- Recursive CTE: Calendar from 2025-01-01 to 2025-01-31
DROP TABLE IF EXISTS StagingProducts;
WITH Calendar AS (
    SELECT CAST('2025-01-01' AS DATE) AS DateVal
    UNION ALL
    SELECT DATEADD(DAY, 1, DateVal)
    FROM Calendar
    WHERE DateVal < '2025-01-31'
)
SELECT * FROM Calendar
OPTION (MAXRECURSION 1000);

-- Create StagingProducts
CREATE TABLE StagingProducts (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Insert into StagingProducts
INSERT INTO StagingProducts VALUES
(1, 'Laptop', 'Electronics', 1250.00),
(5, 'Smartwatch', 'Electronics', 300.00);

-- MERGE to update or insert
MERGE Products AS Target
USING StagingProducts AS Source
ON Target.ProductID = Source.ProductID
WHEN MATCHED THEN
    UPDATE SET ProductName = Source.ProductName,
               Category = Source.Category,
               Price = Source.Price
WHEN NOT MATCHED THEN
    INSERT (ProductID, ProductName, Category, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Category, Source.Price);
