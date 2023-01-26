import Practice_problems
My_solutions = Practice_problems.PracticeProblems()

myquery_1 = "SELECT * FROM Shippers"
myquery_2 = "SELECT CategoryName, Description FROM Categories"
myquery_3 = "SELECT FirstName, LastName, HireDate FROM Employees WHERE Title = 'Sales Representative'"
myquery_4 = "SELECT FirstName, LastName, HireDate FROM Employees WHERE Title = 'Sales Representative' AND Region = 'North America'"
myquery_5 = "SELECT OrderId FROM Orders WHERE EmployeeId = 5"

My_solutions.show_query(myquery_5) 