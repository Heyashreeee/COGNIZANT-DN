-- Using ROW_NUMBER to get top 3 most expensive products per category
SELECT *
FROM (
    SELECT ProductName, Category, Price,
           ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
    FROM Products
) AS Ranked
WHERE RowNum <= 3;

-- Using RANK: This allows ties (same price = same rank)
SELECT *
FROM (
    SELECT ProductName, Category, Price,
           RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS RankNum
    FROM Products
) AS Ranked
WHERE RankNum <= 3;

-- Using DENSE_RANK: Like RANK but doesn't skip rank numbers after ties
SELECT *
FROM (
    SELECT ProductName, Category, Price,
           DENSE_RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS DenseRankNum
    FROM Products
) AS Ranked
WHERE DenseRankNum <= 3;
