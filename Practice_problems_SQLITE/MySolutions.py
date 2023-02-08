import Practice_problems
My_solutions = Practice_problems.PracticeProblems()

myquery_1 = "SELECT * FROM Shippers"
myquery_2 = "SELECT CategoryName, Description FROM Categories"
myquery_3 = "SELECT FirstName, LastName, HireDate FROM Employees WHERE Title = 'Sales Representative'"
myquery_4 = "SELECT FirstName, LastName, HireDate FROM Employees WHERE Title = 'Sales Representative' AND Region = 'North America'"
myquery_5 = "SELECT OrderId, OrderDate FROM Orders WHERE EmployeeId = 5"
myquery_6 = "SELECT SupplierID, ContactName, ContactTitle FROM Suppliers WHERE NOT ContactTitle = 'Marketing Manager'"
myquery_7 = "SELECT ProductID, ProductName FROM Products WHERE lower(ProductName) LIKE '%queso%'"
myquery_8 = "SELECT OrderID, CustomerID, ShipCountry FROM Orders WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium' LIMIT 10"
myquery_9 = "SELECT OrderID, CustomerID, ShipCountry FROM Orders WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela') ORDER BY ShipCountry"
myquery_10 = "SELECT firstName, LastName, Title,  BirthDate FROM Employees ORDER BY BirthDate ASC"
myquery_11 = "SELECT firstName, LastName, Title,  STRFTIME('%d/%m/%Y', BirthDate) AS BirthDate_ FROM Employees ORDER BY BirthDate ASC"
myquery_12 = "SELECT FirstName, LastName, (FirstName || ' ' || LastName) AS FullName FROM Employees"
# myquery_t = "SELECT STRFTIME('%d/%m/%Y', BirthDate)  FROM Employees"
myquery_13 = "SELECT OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity AS TotalPrice FROM 'Order Details' ORDER BY OrderID, ProductID"
myquery_14 = "SELECT COUNT(DISTINCT CompanyName) FROM CUSTOMERS"
myquery_15 = "SELECT OrderID, OrderDate FROM Orders ORDER BY OrderDate ASC LIMIT 1"
myquery_15v2 = "SELECT MIN(OrderDate) AS First_order FROM Orders "
myquery_16 = "SELECT Country FROM Customers GROUP BY Country ORDER BY Country"
myquery_17 = "SELECT ContactTitle, COUNT(ContactTitle) AS NCT FROM Customers GROUP BY ContactTitle"
myquery_18 = """SELECT Products.ProductID, ProductName, CompanyName FROM Products INNER JOIN Suppliers ON Suppliers.SupplierID = Products.SupplierID"""
My_solutions.show_query(myquery_18)
# ShippedDate