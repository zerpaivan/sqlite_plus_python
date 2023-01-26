import sqlite3

conn = sqlite3.connect('mi_database.db')
columna = 'first_name, last_name'
cursor = conn.execute(f'SELECT {columna} FROM CUSTOMERS')
print(cursor.fetchall())