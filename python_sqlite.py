"""Script para trabajar con Sqlite desde python"""
# conectar/crear base de datos en python
import sqlite3

conn = sqlite3.connect("mi_database.db")

# trabajar con una base de datos desde la memoria
# conn=sqlite3.connect(':memory:')

# Crear un Tabla de base de datos
cursor = conn.cursor()  # creacion del Objeto cursor

# creacion de la tabla
cursor.execute(
    '''CREATE TABLE IF NOT EXISTS CUSTOMERS(
        ID INTEGER PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        email TEXT

    )'''
)

# Insertar registros en la tabla
# cursor.execute("INSERT INTO CUSTOMERS VALUES (1, 'Ivan', 'Zerpa', 'zerpaivan@gmail.com')")

# insertar multiple registros en una tabla.
many_customers = [
    (2, "Maria", "Perez", "perezm77@gmail.com"),
    (3, "Pedro", "Hernadez", "H_pedrp@outlook.com"),
    (4, "Ana", "Meza", "mezana@gmail.com"),
]
#  usar el metodo executemany para multiples registros
# cursor.executemany("INSERT INTO CUSTOMERS VALUES (?,?,?,?)", many_customers)

# ----------------------------------------------------------------------------
# Query a Fetchall
# cursor.execute("SELECT * FROM CUSTOMERS WHERE email LIKE '%gmail.com'")  # esta es la consulta

# fetchall transforma todos los registros la consulta en un array.
# print(cursor.fetchall())  # imprime los valores de la consulta (array)

# array de la primera fila de la tabla
# cursor.fetchone() 

# array de las filas indicadas
# cursor.fetchmany(3)

#------------------------------------------------------------------------------
# actualiza un registro
# UPDATE la_tabla SET la_columna = nuevo_valor WHERE condicion
# cursor.execute("UPDATE CUSTOMERS SET first_name = 'Tana' WHERE last_name = 'Meza'")
# -----------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Borrar un registro
# cursor.execute("DELETE FROM CUSTOMERS WHERE last_name = 'Perez'")
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#  ordenar una consulta
# cursor.execute("SELECT last_name, first_name FROM CUSTOMERS ORDER BY last_name DESC")
# rows = cursor.fetchall()
# for row in rows:
#     print(row)

# ------------------------------------------------------------------------------
# Restringir el numero de filas en una consulta LIMIT
# cursor.execute("SELECT * FROM CUSTOMERS LIMIT 2")
# rows = cursor.fetchall()
# for row in rows:
#     print(row)

# ------------------------------------------------------------------------------
# Borrar una tabla
# cursor.execute("DROP TABLE CUSTOMERS")
cursor.execute("""INSERT OR IGNORE INTO CUSTOMERS(first_name, last_name, email) VALUES
('Petra', 'Camuy', 'camuyP@tumail.com'),
('Tana', 'Leal', 'TanaL@fmail.com')
""")
cursor.execute("SELECT * FROM CUSTOMERS")
rows = cursor.fetchall()
for row in rows:
    print(row)
# ------------------------------------------------------------------------------
# Borrar una tabla


conn.commit()  # como un" push hacia la base de datos

# cerrar la coneccion
conn.close()
