import repaso

myquery_1 =  'SELECT * FROM Shippers'
myquery_2 =  'SELECT CategoryName, Description FROM Categories'

myquery_3 =  ''' SELECT FirstName, LastName, HireDate FROM Employees
                 WHERE Title LIKE '%Representative%' '''

myquery_4 =  ''' SELECT FirstName, LastName, HireDate FROM Employees
                 WHERE Title LIKE '%Representative%' AND Country LIKE 'USA' '''

myquery_5 = 'SELECT * FROM Employees'

myquery_10 = ''' SELECT FirstName, LastName, Title, BirthDate FROM Employees
ORDER BY BirthDate ASC'''

myquery_26 = ''' SELECT ShipCountry, 
STRFTIME('%Y', OrderDate) as year
FROM Orders
where year = '2016' '''

myquery_10320 = '''UPDATE Orders SET ShippedDate == '2016-10-17'
WHERE EmployeeID == 5 AND ShippedDate > RequiredDate'''

repaso.read_query(myquery_10320) # cargar la query
repaso.show_query() # mostrar la query
repaso.conn.close()