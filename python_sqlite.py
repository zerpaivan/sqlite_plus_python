'''Script para trabajar con Sqlite desde python'''
# conectar/crear base de datos en python
import sqlite3
conn = sqlite3.connect('mi_database.db')

# trabajar con una base de datos desde la memoria
# conn=sqlite3.connect('mi_database.db')

# Crear un Tabla de base de datos
cursor = conn.cursor() # creacion del Objeto cursor

# creacion de la tabla
# cursor.execute(
#     '''CREATE TABLE CUSTOMERS(
#         first_name TEXT,
#         last_name TEXT,
#         email TEXT

#     )'''
# )

# Insertar registros en la tabla
# cursor.execute("INSERT INTO CUSTOMERS VALUES ('Ivan', 'Zerpa', 'zerpaivan@gmail.com')")

# insertar multiple registros en una tabla.
many_customers = [
    ('Maria', 'Perez', 'perezm77@gmail.com'),
    ('Pedro', 'Hernadez', 'H_pedrp@outlook.com'),
    ('Ana','Meza','mezana@gmail.com')
    ]

# cursor.executemany("INSERT INTO CUSTOMERS VALUES (?,?,?)", many_customers)

#----------------------------------------------------------------------------
# Query a Fetchall
cursor.execute("SELECT * FROM CUSTOMERS") # esta es la consulta
print(cursor.fetchall()) # imprime los valores de la consulta

conn.commit() # como un" push hacia la base de datos

# cerrar la coneccion
conn.close()
