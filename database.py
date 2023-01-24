import sqlite3

CREATE_BEANS_TABLE = """ CREATE TABLE IF NOT EXISTS beans (id INTEGER PRIMARY KEY, name_bean TEXT, method TEXT, rating INTEGER);"""
INSERT_BEANS = "INSERT INTO beans (name_bean, method, rating) VALUES (?,?,?); "
GET_ALL_BEANS = "SELECT * FROM beans;"
GET_BEANS_BY_NAME = "SELECT * FROM beans WHERE name_bean = ?;"
GET_BEST_PREPARATION_FOR_BEAN = """
SELECT * FROM beans
WHERE name_bean = ?
ORDER BY rating DESC
LIMIT 1;"""

# conecta con la base de datos
def connect():
    return sqlite3.connect("data.db")


#  funcion para crear una table
# conecta, crea la tabla y cierra la coneccion
def create_tables(connection):
    with connection:
        connection.execute(CREATE_BEANS_TABLE)


def add_beans(connection, name_bean, method, rating):
    with connection:
        connection.execute(INSERT_BEANS, (name_bean, method, rating))


def get_all_beans(connection):
    with connection:
        return connection.execute(GET_ALL_BEANS).fetchall()


def get_beans_by_name(connection, name_bean):
    with connection:
        return connection.execute(GET_BEANS_BY_NAME, (name_bean,)).fetchall()

def get_preparation_for_bean(connection, name_bean):
    with connection:
        return connection.execute(GET_BEST_PREPARATION_FOR_BEAN, (name_bean,)).fetchone()