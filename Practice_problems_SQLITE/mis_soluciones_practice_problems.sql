-- SQLite
-- SELECT * FROM Shippers
-- SELECT CategoryName, Description FROM Categories

-- SELECT FirstName, LastName, HireDate FROM Employees
-- WHERE Title LIKE '%Representative%'

-- 4
-- SELECT FirstName, LastName, HireDate FROM Employees
-- WHERE Title LIKE '%Representative%' AND Country LIKE 'USA'

-- 5
-- SELECT OrderID, OrderDate FROM Orders
-- WHERE EmployeeID == 5

-- 6
-- SELECT SupplierID, ContactName, ContactTitle FROM Suppliers
-- WHERE ContactTitle NOT LIKE 'Marketing Manager'

-- 7
-- SELECT ProductID, ProductName FROM Products
-- WHERE ProductName LIKE '%queso%'

-- 8 
-- SELECT OrderID, customerid, ShipCountry FROM  Orders
-- where ShipCountry LIKE 'France' OR ShipCountry LIKE 'Belgium'

-- 9
-- SELECT OrderID, CustomerID, ShipCountry FROM Orders
-- WHERE ShipCountry IN ('Brazil','Mexico','Argentina','Venezuela')

-- 10
-- SELECT FirstName, LastName, Title, BirthDate FROM Employees
-- ORDER BY BirthDate ASC

-- 11
-- SELECT FirstName, LastName, STRFTIME('%d/%m/%Y', BirthDate) AS BirthDate FROM Employees
-- ORDER BY BirthDate

-- 12
-- SELECT FirstName, LastName, FirstName || ' ' || LastName AS FullName FROM Employees

-- 13
-- SELECT OrderID, ProductID,  UnitPrice, quantity, UnitPrice * Quantity AS TotalPrice FROM 'Order Details'
-- ORDER BY OrderID, ProductID

-- 14
-- SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers FROM Customers

-- 15
-- SELECT OrderDate AS FirstOrder FROM Orders
-- ORDER BY OrderDate LIMIT 1

-- 16
-- SELECT DISTINCT(Country) FROM Customers
-- ORDER BY Country

-- 17
-- SELECT ContactTitle, count(ContactTitle) as Numbers_CT FROM Customers
-- GROUP BY ContactTitle

-- 18
/*
SELECT 
Products.ProductID, 
Products.ProductName,
Suppliers.CompanyName
FROM Products
INNER JOIN Suppliers
ON Products.SupplierID == Suppliers.SupplierID
ORDER BY ProductID
*/

--19
/*
SELECT 
Orders.OrderID,
Orders.OrderDate,
Shippers.CompanyName
FROM Orders
INNER JOIN Shippers
ON Orders.ShipVia == Shippers.ShipperID
WHERE Orders.OrderID <= 10300
ORDER BY Orders.OrderID
*/

-- 20
/*
SELECT Categories.CategoryName , count(Products.CategoryID) AS TotalProducts  FROM Products
INNER JOIN Categories
ON Products.CategoryID == Categories.CategoryID
GROUP BY Products.CategoryID
order by TotalProducts DESC
*/

-- 21
/*
SELECT City, Country, count(CustomerID) AS TotalCustomers FROM Customers
WHERE City IS NOT NULL
GROUP by Country, City
ORDER BY Country
*/

--22
/*
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel FROM Products
WHERE UnitsInStock < ReorderLevel
ORDER BY ProductID
*/

-- 23
/*
SELECT ProductID, 
ProductName AS ProductsToReordering, 
UnitsInStock, 
UnitsOnOrder, 
ReorderLevel, 
Discontinued
FROM Products
WHERE 
UnitsInStock + UnitsOnOrder <= ReorderLevel AND NOT Discontinued
*/

-- 24
/* SELECT CustomerID, 
CompanyName, 
Region,
CASE
WHEN Region IS NULL THEN 1
ELSE
0
END AS SENTINEL
FROM Customers
ORDER BY SENTINEL, Region ASC
*/


-- 25
/*
SELECT ShipCountry, ROUND(AVG(Freight), 2) AS AVG_freight FROM Orders
GROUP by ShipCountry
ORDER BY AVG_freight DESC
LIMIT 3
*/
-- 26
/*
SELECT ShipCountry, ROUND(AVG(Freight),2) AS AVG_freight, strftime('%Y', OrderDate) AS YEAR FROM Orders
WHERE YEAR <= '2016'
GROUP BY ShipCountry
*/


--27 
/*
SELECT ShipCountry,
AVG(Freight)AS AverageFreight,
OrderDate
FROM Orders
WHERE  strftime('%Y', OrderDate) >= '2016'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3
*/
-- 28
/*
SELECT 
ShipCountry, 
OrderDate,
AVG(Freight) 
FROM Orders
where OrderDate > (SELECT date(max(OrderDate), '-1 year') FROM Orders)
GROUP BY ShipCountry
ORDER BY OrderDate
*/

-- investigar: subconsulta y expresión de tabla común (CTE)