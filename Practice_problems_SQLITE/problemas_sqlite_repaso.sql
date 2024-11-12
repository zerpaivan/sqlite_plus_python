-- SQLite
-- Introductory Problems
/* 1.
SELECT * FROM Shippers
*/
--2
SELECT  row_number() OVER() AS NI, categoryName, Description from Categories

--3
SELECT FirstName, LastName, HireDate from Employees
WHERE Title LIKE 'Sales Representative'

--4
SELECT FirstName, LastName, HireDate from Employees
WHERE Title like 'Sales Representative' AND Country LIKE 'USA'

--5 
SELECT OrderID, OrderDate FROM Orders
WHERE EmployeeID = 5

--6
SELECT SupplierID, ContactName, ContactTitle FROM Suppliers
WHERE ContactTitle NOT LIKE "Marketing Manager"

--7
SELECT ProductID, ProductName FROM Products
WHERE ProductName LIKE '%queso%'

--8
SELECT OrderID, CustomerID, ShipCountry  FROM Orders
WHERE ShipCountry LIKE 'France' OR ShipCountry LIKE 'Belgium'

--9
SELECT OrderID, CustomerID, ShipCountry FROM Orders
WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

--10
SELECT FirstName, LastName, Title, BirthDate FROM Employees
ORDER BY BirthDate ASC

--11
SELECT FirstName, LastName Title, STRFTIME('%d/%m/%Y', BirthDate) AS BirthDate_N FROM Employees
ORDER BY BirthDate

--12
SELECT FirstName, LastName, FirstName || ' ' || LastName AS FullName FROM Employees
--13
SELECT OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity AS TotalPrice FROM "Order Details"
ORDER BY OrderID, ProductID

--14 
SELECT count(CustomerID) FROM Customers

--15
/* SELECT OrderID, OrderDate AS FirstOrder FROM Orders
order by OrderDate
LIMIT 1*/
SELECT MIN(OrderDate) FROM Orders

--16
SELECT DISTINCT Country from Customers
WHERE Country IS NOT NULL
ORDER BY  Country

--17
SELECT ContactTitle, COUNT(ContactTitle) AS NumberOfCT FROM Customers
GROUP BY ContactTitle

--18
SELECT 
    Products.ProductID,
    Products.ProductName,
    Suppliers.CompanyName
FROM Suppliers
INNER JOIN Products
    ON Suppliers.SupplierID = Products.SupplierID

--19
SELECT OrderID, Date(OrderDate), Shippers.CompanyName AS "Ship by" FROM Orders
INNER JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
WHERE OrderID >= 10300
ORDER BY OrderID

/* Problemas Intermedios */

--20
SELECT Categories.CategoryName, COUNT(products.CategoryID) AS ProductsByCategory FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryID
Order By ProductsByCategory DESC

--21
SELECT city, Country, count(CustomerID) AS TotalCustomer FROM Customers
GROUP BY Country, City
ORDER BY TotalCustomer DESC

--22
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel FROM Products
WHERE ReorderLevel > UnitsInStock
ORDER BY ProductID

--23
SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
FROM Products
WHERE UnitsInStock + UnitsOnOrder < ReorderLevel AND Discontinued == 0

--24
SELECT CustomerID, CompanyName, Region,
CASE
    WHEN Region IS NOT NULL THEN 1
    ELSE 0
END AS FLAG
FROM Customers
ORDER BY FLAG DESC, Region
-- ####
SELECT CustomerID, CompanyName, Region from Customers
order by Region is NULL, Region

--25
SELECT ShipCountry, AVG(Freight) AS AVGfreight from Orders
GROUP by ShipCountry
ORDER BY AVGfreight DESC
LIMIT 3

--26
SELECT ShipCountry, AVG(Freight) as AVGfreight, STRFTIME('%Y', OrderDate) as Year from Orders
WHERE Year  == '2017'
GROUP BY ShipCountry
ORDER BY AVGfreight DESC
LIMIT 4

--27
SELECT ShipCountry,
AVG(Freight) as AVGfreight,
STRFTIME('%Y', OrderDate) as Year 
FROM Orders
WHERE ShipCountry LIKE 'France' and STRFTIME('%Y', OrderDate) == '2017'

-- 28
SELECT
    ShipCountry,
    AVG(Freight) AS AVGfreight
FROM Orders
WHERE 
    OrderDate 
    BETWEEN (SELECT date( max(OrderDate), '-12 month') FROM Orders) 
    AND (SELECT MAX(OrderDate) FROM orders)
GROUP BY ShipCountry
ORDER BY AVGfreight DESC
LIMIT 3

--29
SELECT 
    Orders.OrderID,
    Employees.EmployeeID,
    Employees.LastName,
    Products.ProductName,
    "Order Details".Quantity
FROM Orders
INNER JOIN Employees
    ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN "Order Details"
    ON Orders.OrderID = "Order Details".OrderID
INNER JOIN Products
    ON "Order Details".ProductID = Products.ProductID

-- 30
SELECT Orders.OrderID, Customers.CustomerID FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL

--31
SELECT Customers.CustomerID, T1.OrderID FROM Customers
LEFT JOIN 
    (SELECT OrderID, CustomerID, EmployeeID FROM Orders
    WHERE EmployeeID ==  4) AS T1
ON Customers.CustomerID = T1.CustomerID
WHERE T1.OrderID IS NULL

--******************************************
-- Advanced Problems
--********************************************

-- 32
SELECT 
    "Order Details".OrderID,
    Orders.CustomerID,
    customers.CompanyName,
    Orders.OrderDate,
    SUM(UnitPrice * Quantity) as Total
FROM "Order Details"
INNER JOIN Orders
    ON "Order Details".OrderID = Orders.OrderID
INNER JOIN Customers
    ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '2018-01-01' AND '2018-31-12'
GROUP BY Orders.OrderID
HAVING total >= 10000

-- 33
WITH
    Orders10K AS (
        SELECT
            "Order Details".OrderID,
            Orders.CustomerID,
            Orders.OrderDate,
            SUM(UnitPrice *Quantity) AS Total_1
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        GROUP BY orders.OrderID
        HAVING total_1 > 10000
    ),

    Orders15K AS (
        SELECT 
            Orders.CustomerID,
            SUM(UnitPrice * Quantity) as Total_2
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        WHERE Orders.OrderDate BETWEEN '2018-01-01' AND '2018-31-12'
        GROUP BY Orders.OrderID, Orders.CustomerID
        HAVING Total_2 > 15000
    )
SELECT Orders10K.CustomerID, Orders10K.TOTAL_1, Orders15K.total_2 FROM Orders10K
INNER JOIN Orders15K
    ON Orders10K.CustomerID = Orders15K.CustomerID 

--34
WITH
    Orders10K AS (
        SELECT
            "Order Details".OrderID,
            Orders.CustomerID,
            Orders.OrderDate,
            SUM(UnitPrice * Quantity * (1-Discount)) AS Total_1
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        GROUP BY orders.OrderID
        HAVING total_1 > 10000
    ),

    Orders15K AS (
        SELECT 
            Orders.CustomerID,
            SUM(UnitPrice * Quantity * (1-Discount)) as Total_2
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        WHERE Orders.OrderDate BETWEEN '2018-01-01' AND '2018-31-12'
        GROUP BY Orders.OrderID, Orders.CustomerID
        HAVING Total_2 > 15000
    )
SELECT Orders10K.CustomerID, Orders10K.TOTAL_1, Orders15K.total_2 FROM Orders10K
INNER JOIN Orders15K
    ON Orders10K.CustomerID = Orders15K.CustomerID 

-- 35
SELECT OrderID, EmployeeID, OrderDate FROM  Orders
WHERE 
    (strftime('%m', OrderDate) IN ('01','03','05','07','08','10','12') AND strftime('%d', OrderDate) == '31')
OR
    (strftime('%m', OrderDate) IN ('04','06','09','11') AND strftime('%d', OrderDate) == '30')
OR
    (strftime('%m', OrderDate) == '02' AND strftime('%d', OrderDate) IN ('28', '29'))

ORDER BY EmployeeID, OrderID

-- 36
SELECT Orders.OrderID, count("Order Details".OrderID) AS TotalOrderDetails FROM Orders
INNER JOIN "Order Details"
ON Orders.OrderID = "Order Details".OrderID
GROUP BY Orders.OrderID
ORDER BY TotalOrderDetails DESC
LIMIT 10

-- 37
SELECT * FROM Orders
ORDER BY RANDOM()
LIMIT ROUND(0.02 * (SELECT COUNT(*) FROM ORDERS))

-- 38

SELECT
    COUNT("Order Details".OrderID) AS n_Orders,
    "Order Details".OrderID
FROM "Order Details"
INNER JOIN Orders
    ON "Order Details".OrderID = Orders.OrderID
WHERE "Order Details".Quantity >= 60
GROUP BY "Order Details".OrderID,  "Order Details".Quantity
HAVING n_Orders > 1

-- 39
WITH
    CTE AS (
        Select
        OrderID
        From "Order Details"
        Where Quantity >= 60
        Group By OrderID, Quantity
        Having Count(*) > 1
    )
SELECT * FROM "Order Details"
WHERE OrderID IN (SELECT * FROM CTE)

-- 40
SELECT * FROM "Order Details"
INNER JOIN (
    SELECT
        OrderID
    FROM "Order Details"
    WHERE Quantity >= 60
    GROUP BY OrderID, Quantity
    HAVING count(*) > 1
) AS PRUEBA
ON "Order Details".OrderID = PRUEBA.OrderID

-- 41
SELECT OrderID, CustomerID, RequiredDate, ShippedDate FROM Orders
WHERE ShippedDate > RequiredDate

-- 42
SELECT Orders.EmployeeID,FirstName, LastName, count(*) as OrdersLate FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
WHERE ShippedDate > RequiredDate
GROUP BY Orders.EmployeeID
ORDER BY OrdersLate DESC

--43
WITH
    Table1 AS (
        SELECT EmployeeID, count(OrderID) AS TotalOrders FROM Orders
        GROUP BY EmployeeID
    ),

    Table2 AS (
        SELECT Orders.EmployeeID,FirstName, LastName, count(*) as OrdersLate FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        WHERE ShippedDate > RequiredDate
        GROUP BY Orders.EmployeeID
        ORDER BY OrdersLate DESC
    )

SELECT table2.EmployeeID, table2.LastName, Table1.TotalOrders, table2.OrdersLate FROM Table2
INNER JOIN table1
ON table1.EmployeeID = table2.EmployeeID

-- 44
WITH
    Table1 AS (
        SELECT Orders.EmployeeID, FirstName, LastName, count(OrderID) AS TotalOrders FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        GROUP BY Orders.EmployeeID
    ),

    Table2 AS (
        SELECT Orders.EmployeeID,FirstName, LastName, count(*) as OrdersLate FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        WHERE ShippedDate > RequiredDate
        GROUP BY Orders.EmployeeID
        ORDER BY OrdersLate DESC
    )

SELECT table1.EmployeeID, table1.LastName, Table1.TotalOrders, table2.OrdersLate FROM Table1
LEFT JOIN table2
ON table1.EmployeeID = table2.EmployeeID

--45
WITH
    Table1 AS (
        SELECT Orders.EmployeeID, FirstName, LastName, count(OrderID) AS TotalOrders FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        GROUP BY Orders.EmployeeID
    ),

    Table2 AS (
        SELECT Orders.EmployeeID,FirstName, LastName, count(*) as OrdersLate FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        WHERE ShippedDate > RequiredDate
        GROUP BY Orders.EmployeeID
        ORDER BY OrdersLate DESC
    )

SELECT table1.EmployeeID, table1.LastName, Table1.TotalOrders, COALESCE(table2.OrdersLate,0) AS Orderslate FROM Table1
LEFT JOIN table2
ON table1.EmployeeID = table2.EmployeeID

-- 46 Y 47
WITH
    Table1 AS (
        SELECT Orders.EmployeeID, FirstName, LastName, count(OrderID) AS TotalOrders FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        GROUP BY Orders.EmployeeID
    ),

    Table2 AS (
        SELECT Orders.EmployeeID,FirstName, LastName, count(*) as OrdersLate FROM Orders
        INNER JOIN Employees
        ON Orders.EmployeeID = Employees.EmployeeID
        WHERE ShippedDate > RequiredDate
        GROUP BY Orders.EmployeeID
        ORDER BY OrdersLate DESC
    )

SELECT
    table1.EmployeeID,
    table1.LastName, 
    Table1.TotalOrders,
    COALESCE(table2.OrdersLate,0) AS Orderslate,
    ROUND(Orderslate/(1.0*Table1.TotalOrders), 2)  AS PercentLateOrders 
FROM Table1
LEFT JOIN table2
ON table1.EmployeeID = table2.EmployeeID

-- 48 y  49
WITH
    Table_1 AS (
        SELECT
            Orders.CustomerID,
            Customers.CompanyName,
            SUM(UnitPrice *Quantity) AS Total
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        INNER JOIN Customers
            ON Customers.CustomerID = Orders.CustomerID
        WHERE strftime('%Y', OrderDate) == '2018'
        GROUP BY Customers.CustomerID
)
SELECT *,
CASE
    WHEN Total < 1000 THEN 'Low'
    WHEN Total < 5000 THEN 'Medium'
    WHEN Total < 10000 THEN 'High'
    ELSE 'Very High'
END AS CustomerGroup
FROM Table_1

-- 50
WITH


    Table_1 AS (
        SELECT
            Orders.CustomerID,
            Customers.CompanyName,
            SUM(UnitPrice *Quantity) AS Total
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        INNER JOIN Customers
            ON Customers.CustomerID = Orders.CustomerID
        WHERE strftime('%Y', OrderDate) == '2018'
        GROUP BY Customers.CustomerID
    ),
    
    Table_2 AS (
        SELECT *,
        CASE
            WHEN Total < 1000 THEN 'Low'
            WHEN Total < 5000 THEN 'Medium'
            WHEN Total < 10000 THEN 'High'
            ELSE 'Very High'
        END AS CustomerGroup
        FROM Table_1
    ),

    Table_3 AS(
        SELECT customerGroup, count(CustomerID) as TotalInGroup FROM Table_2
        GROUP BY CustomerGroup
    )

SELECT
customerGroup,
totalInGroup,
(1.0 * totalInGroup / (SELECT SUM(TotalInGroup) FROM Table_3)) AS Percentage
FROM Table_3

-- 51
/*CREATE TABLE IF NOT EXISTS CustomerGroupThreshold(
TotalRef  INTEGER,
CustomerGroup TEXT
)
INSERT INTO CustomerGroupThreshold (TotalRef, CustomerGroup)
VALUES
(1000, 'Low'), (5000, 'Medium'),(10000, 'High')*/

WITH
    Table_1 AS (
        SELECT
            Orders.CustomerID,
            Customers.CompanyName,
            SUM(UnitPrice *Quantity) AS Total
        FROM "Order Details"
        INNER JOIN Orders
            ON "Order Details".OrderID = Orders.OrderID
        INNER JOIN Customers
            ON Customers.CustomerID = Orders.CustomerID
        WHERE strftime('%Y', OrderDate) == '2018'
        GROUP BY Customers.CustomerID
    )

SELECT * FROM Table_1
CROSS JOIN CustomerGroupThreshold
WHERE Total > TotalRef

--52
SELECT Customers.Country FROM Customers
WHERE Customers.Country IS NOT NULL
UNION 
SELECT Suppliers.Country FROM Suppliers
WHERE Suppliers.Country IS NOT NULL

-- 53 
WITH 
    Country_list AS (
        SELECT Customers.Country FROM Customers
        WHERE Customers.Country IS NOT NULL
        UNION 
        SELECT Suppliers.Country FROM Suppliers
        WHERE Suppliers.Country IS NOT NULL
    )
SELECT
    DISTINCT
    Country_list.Country ,
    Suppliers.Country AS SupplierCountry,
    Customers.Country AS CustomerCountry
FROM Country_list
LEFT JOIN Customers
    ON Country_list.Country = Customers.Country
LEFT JOIN Suppliers
    ON Country_list.Country = Suppliers.Country

-- 54
WITH 
    Country_list AS (
        SELECT Customers.Country FROM Customers
        WHERE Customers.Country IS NOT NULL
        UNION 
        SELECT Suppliers.Country FROM Suppliers
        WHERE Suppliers.Country IS NOT NULL
    ),

    TotalSuppliers_Table AS(
        SELECT
            Country,
            count(Country) AS TotalSuppliers 
            FROM Suppliers
            GROUP BY country
    ),

    TotalCustomers_Table AS (
        SELECT
            Country,
            count(Country) AS TotalCustomers 
            FROM Customers
            GROUP BY country
    )

SELECT Country_list.Country, COALESCE(TotalSuppliers, 0) AS TotalSuppliers, COALESCE(TotalCustomers, 0) AS TotalCustomers FROM Country_list
LEFT JOIN TotalSuppliers_Table
    ON Country_list.Country = TotalSuppliers_Table.Country
LEFT JOIN TotalCustomers_Table
    ON Country_list.Country = TotalCustomers_Table.Country

-- 55

SELECT ROW_NUMBER() OVER(ORDER BY ShipCountry) AS row_num, ShipCountry, CustomerID, OrderID, min(OrderDate)  FROM Orders
GROUP by ShipCountry

-- 56
 
 

