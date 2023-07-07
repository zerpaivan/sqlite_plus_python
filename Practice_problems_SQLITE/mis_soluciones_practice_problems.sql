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
--  29
/*
SELECT 
Employees.EmployeeID,
Employees.LastName,
Orders.OrderID,
Products.ProductName,
'Order Details'.Quantity
FROM Orders

LEFT JOIN Employees
    ON Employees.EmployeeID = Orders.EmployeeID
LEFT JOIN 'Order Details'
    ON Orders.OrderID = 'Order Details'.OrderID
LEFT JOIN Products
ON 'Order Details'.ProductID = Products.ProductID
ORDER BY Orders.OrderID, Products.ProductID;
*/

-- 30
/*
SELECT Count(Orders.OrderID) AS count_orders, Customers.CustomerID FROM Customers
LEFT JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID
ORDER by count_orders;
*/

-- 31
-- SELECT DISTINCT(CustomerID) FROM Orders;
--SELECT DISTINCT(CustomerID) FROM Orders WHERE EmployeeID = 4;

/*
SELECT DISTINCT(Orders.CustomerID), prueba.CustomerID FROM Orders
LEFT JOIN (SELECT DISTINCT(CustomerID) FROM Orders WHERE EmployeeID = 4) AS Prueba
ON Orders.CustomerID = prueba.CustomerID
WHERE prueba.CustomerID IS NULL;
*/


-- investigar: subconsulta y expresión de tabla común (CTE)

-- Advanced Problems
-- 32
/*
SELECT 
    'Order Details'.OrderID, 
    ORDERS.CustomerID, 
    Customers.CompanyName, Orders.OrderDate, 
    SUM('Order Details'.UnitPrice * 'Order Details'.Quantity) as Subtotal
FROM 'Order Details'
LEFT JOIN Orders
    ON 'Order Details'.OrderID == Orders.OrderID
LEFT JOIN Customers
    ON Orders.CustomerID == Customers.CustomerID
WHERE Orders.OrderDate > '2015-12-31' AND Orders.OrderDate <= '2016-12-31'
GROUP BY 'Order Details'.OrderID
HAVING Subtotal > 10000;
*/

-- Otra forma de resolver el problema
/* 
SELECT OrderID, Subtotal 
FROM (
    SELECT *, SUM(UnitPrice * Quantity) as Subtotal
    FROM 'Order Details'
    GROUP BY OrderID
)
WHERE Subtotal > 10000;
*/

-- 33
-- variante del problema original donde se plantea que la condicion es que los clientes tengan compras totales > a 15000
-- aca se requiere que adicionamente el cliente tenga, por lo menos una orden de mas de 10000
/*
SELECT 
customers.CustomerID,
SUM('Order Details'.Quantity * 'Order Details'.UnitPrice) AS TotalByCustomer  
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID == Orders.CustomerID
LEFT JOIN 'Order Details'
ON Orders.OrderID == 'Order Details'.OrderID
GROUP BY Customers.CustomerID;
*/

-- Total por Customers

/*
SELECT sum('Order Details'.Quantity*'Order Details'.UnitPrice) AS TotalBycustomer FROM Customers
INNER JOIN Orders
ON Customers.CustomerID == Orders.CustomerID
INNER JOIN 'Order Details'
ON Orders.OrderID == 'Order Details'.OrderID
GROUP BY Customers.CustomerID;
*/


/*SELECT 
    'Order Details'.OrderID, 
    ORDERS.CustomerID, 
    Customers.CompanyName, Orders.OrderDate, 
    SUM('Order Details'.UnitPrice * 'Order Details'.Quantity) as TotalByOrder
FROM 'Order Details'
LEFT JOIN Orders
    ON 'Order Details'.OrderID == Orders.OrderID
LEFT JOIN Customers
    ON Orders.CustomerID == Customers.CustomerID
-- WHERE Orders.OrderDate > '2016-12-31' AND Orders.OrderDate <= '2018-12-31'
GROUP BY 'Order Details'.OrderID, Customers.CustomerID
HAVING (TotalByOrder > 5000) AND 
    ((SELECT sum('Order Details'.Quantity*'Order Details'.UnitPrice) AS TotalBycustomer FROM Customers
    INNER JOIN Orders
    ON Customers.CustomerID == Orders.CustomerID
    INNER JOIN 'Order Details'
    ON Orders.OrderID == 'Order Details'.OrderID
    GROUP BY Customers.CustomerID)) > 1000
ORDER BY Customers.CustomerID;
*/

-- 34
/*
SELECT 
    Customers.CustomerID, 
    Customers.CompanyName,
    SUM('Order Details'.UnitPrice * 'Order Details'.Quantity) AS TotalsWithoutDiscount,
    SUM('Order Details'.UnitPrice * 'Order Details'.Quantity *(1-'Order Details'.Discount)) AS TotalsWithDiscount
FROM Customers
INNER JOIN Orders
    ON Customers.CustomerID == Orders.CustomerID
INNER JOIN 'Order Details'
    ON Orders.OrderID = 'Order Details'.OrderID
WHERE Orders.OrderDate >= '2016-01-01' AND Orders.OrderDate < '2017-01-01'
GROUP BY Customers.CustomerID
HAVING TotalsWithDiscount > 10000
ORDER BY TotalsWithDiscount DESC;
*/

--35
/*
SELECT 
    EmployeeID,
    OrderID,
    OrderDate,
CASE
    WHEN strftime('%m-%d', OrderDate) == '02-29' THEN TRUE
    ELSE FALSE
END AS BISIESTO
FROM Orders
WHERE (   
    (NOT BISIESTO AND strftime('%m-%d', OrderDate) == '02-29') 
OR
    (strftime('%m-%d', OrderDate) IN ('01-31', '02-28', '03-31', '04-30', '05-31', '06-30', '07-31', '08-31', '09-30', '10-31', '11-30', '12-31'))
)
ORDER BY EmployeeID, OrderID
*/

-- 36
/*
SELECT Orders.OrderID, Count('Order Details'.OrderID) AS TotalOrderDetails FROM Orders
INNER JOIN 'Order Details'
ON Orders.OrderID = 'Order Details'.OrderID
GROUP BY Orders.OrderID
ORDER BY TotalOrderDetails DESC
LIMIT 10
*/

-- 37
/*
SELECT OrderID FROM Orders
ORDER BY RANDOM()
LIMIT (SELECT ROUND(0.02 * COUNT(OrderID),0) FROM Orders)
*/
/*
SELECT
DISTINCT(Products.ProductID),
Orders.OrderID, 
Orders.EmployeeID,
Employees.FirstName,
'Order Details'.Quantity
from Products
INNER JOIN 'Order Details'
ON Products.ProductID == 'Order Details'.ProductID
INNER JOIN Orders
ON Orders.OrderID == 'Order Details'.OrderID
INNER JOIN Employees
ON Orders.EmployeeID == Employees.EmployeeID
WHERE 'Order Details'.Quantity >= 60 AND Employees.EmployeeID == 3
ORDER BY 'Order Details'.ProductID;
*/

-- 38
-- respuesta larga.
/*
SELECT 
    'Order Details'.OrderID,
    COUNT('Order Details'.OrderID) AS N,
    Products.ProductID,
    Orders.EmployeeID,
    Employees.FirstName,
    'Order Details'.Quantity
FROM 'Order Details' 
INNER JOIN Products
    ON Products.ProductID == 'Order Details'.ProductID
INNER JOIN Orders
    ON Orders.OrderID == 'Order Details'.OrderID
INNER JOIN Employees
    ON Orders.EmployeeID == Employees.EmployeeID
WHERE 'Order Details'.Quantity >= 60
GROUP BY  'Order Details'.OrderID, 'Order Details'.Quantity
HAVING N > 1
ORDER BY 'Order Details'.OrderID;
*/

-- repuesta corta:
/*Select
OrderID
From 'OrderDetails'
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1;
*/
--Nota: No estoy convencido de la respuesta ya que el error
-- lo cometio la empleada Janet y este deberia ser un criterio 
-- para la query. En la solucion planteada por el libro no
-- toman en cuenta esto

--39
/*
WITH Previa AS (
Select
    OrderID
From 'Order Details'
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
)

SELECT * FROM 'Order Details'
where OrderID IN Previa
*/

-- 40
/*
Select
'Order Details'.OrderID,
ProductID,
UnitPrice,
Quantity,
Discount
From 'Order Details'
Join 
(
    Select 
        OrderID
        From 'Order Details'
        Where Quantity >= 60
        Group By OrderID, Quantity
        Having Count(*) > 1
) AS T_Orders
on T_Orders.OrderID = 'Order Details'.OrderID
Order by 'Order Details'.OrderID, 'Order Details'.ProductID;
*/

--41
/*
SELECT OrderID, OrderDate, RequiredDate, ShippedDate FROM Orders
WHERE RequiredDate < ShippedDate;
*/
-- 42
/*
SELECT 
Orders.EmployeeID,
Employees.FirstName || ' ' || Employees.LastName AS EmployeeID,
COUNT(Orders.EmployeeID) AS TotalLateOrders
FROM Orders
INNER JOIN
Employees
ON Orders.EmployeeID == Employees.EmployeeID
WHERE  Orders.ShippedDate > Orders.RequiredDate
GROUP BY Orders.EmployeeID
ORDER BY TotalLateOrders DESC
*/

--43
/*
WITH
    OrdersByEmployee AS (
        SELECT 
            COUNT(OrderID) AS AllOrders, 
            EmployeeID 
            FROM Orders
            GROUP BY EmployeeID
    )

SELECT 
    Orders.EmployeeID,
    Employees.FirstName || ' ' || Employees.LastName AS Employee,
    OrdersByEmployee.AllOrders,
    COUNT(Orders.EmployeeID) AS TotalLateOrders
FROM Orders

INNER JOIN Employees
    ON Orders.EmployeeID == Employees.EmployeeID

INNER JOIN OrdersByEmployee
    ON Orders.EmployeeID == OrdersByEmployee.EmployeeID

WHERE  Orders.ShippedDate > Orders.RequiredDate
GROUP BY Orders.EmployeeID
ORDER BY OrdersByEmployee.AllOrders DESC;
*/

--44

-- la columna TotalLateOrders no presenta valores nulos para la
-- la condicion Orders.ShippedDate > Orders.RequiredDate
-- por lo tanto la respuedta difiere con la original
/*
WITH
    OrdersByEmployee AS (
        SELECT 
            COUNT(OrderID) AS AllOrders, 
            EmployeeID 
            FROM Orders
            GROUP BY EmployeeID
    )

SELECT 
    Orders.EmployeeID,
    Employees.FirstName || ' ' || Employees.LastName AS Employee,
    OrdersByEmployee.AllOrders,
    COUNT(Orders.EmployeeID) AS TotalLateOrders
FROM Employees

INNER JOIN Orders
    ON Orders.EmployeeID == Employees.EmployeeID

INNER JOIN OrdersByEmployee
    ON Orders.EmployeeID == OrdersByEmployee.EmployeeID

WHERE  Orders.ShippedDate > Orders.RequiredDate
GROUP BY Orders.EmployeeID
ORDER BY Orders.EmployeeID;
*/
SELECT OrderID, EmployeeID, RequiredDate, ShippedDate FROM Orders
WHERE EmployeeID == 5 AND ShippedDate > RequiredDate