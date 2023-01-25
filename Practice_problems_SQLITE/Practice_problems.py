import sqlite3
conn = sqlite3.connect('Practice_problems_SQLITE\\northwind.db')

cursor = conn.cursor()
cursor.execute("SELECT Photo FROM EMPLOYEES WHERE EmployeeID =  1")
rows = cursor.fetchall()
# for row in rows:
#     print(row)
# conn.close()
# cur.execute('SELECT * FROM Shippers')

