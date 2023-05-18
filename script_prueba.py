import sqlite3
conn = sqlite3.connect('mi_database.db')
cur = conn.cursor()
cur.execute('SELECT * FROM CUSTOMERS')
cabeza = cur.description
filas = cur.fetchall()
print(cabeza)
print(filas)