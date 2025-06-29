-- Step 1: Aggregate sales by Product and Month
SELECT p.ProductName, MONTH(o.OrderDate) AS SalesMonth, SUM(od.Quantity) AS TotalQty
INTO #SalesData
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName, MONTH(o.OrderDate);

-- Step 2: PIVOT
SELECT *
FROM (
    SELECT ProductName, SalesMonth, TotalQty FROM #SalesData
) AS src
PIVOT (
    SUM(TotalQty) FOR SalesMonth IN ([1], [2], [3], [4])
) AS PivotedTable;

-- Step 3: UNPIVOT
SELECT ProductName, SalesMonth, TotalQty
FROM (
    SELECT ProductName, [1], [2], [3], [4]
    FROM (
        SELECT ProductName, SalesMonth, TotalQty FROM #SalesData
    ) AS src
    PIVOT (
        SUM(TotalQty) FOR SalesMonth IN ([1], [2], [3], [4])
    ) AS p
) AS u
UNPIVOT (
    TotalQty FOR SalesMonth IN ([1], [2], [3], [4])
) AS Final;

DROP TABLE #SalesData;
