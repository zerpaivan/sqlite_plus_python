# este es un repaso de los problemas del libro sql practice problems

import sqlite3
# establecer coneccion con la base de datos 
conn = sqlite3.connect('Practice_problems_SQLITE\\northwind.db')
#  creacion del cursor
cursor = conn.cursor()


def read_query(myquery):
    cursor.execute(myquery)

def show_query():
    rows = cursor.fetchall()
    n_rows = len(rows)  # numero de filas
    len_fields = list(map(lambda x: [len(str(n)) for n in x], rows)) # longitud de cada uno de los registros

    # numero de columnas de la tabla
    n_col = len(rows[0])
    # se ordena la longitug de los registros por columna
    len_col = [[row[i] for row in len_fields] for i in range(n_col)] 

    # determinar el ancho de cada columna
    width_col = list(map(lambda x: max(x), len_col))
    print(width_col, sum(width_col))


    # para determinar el ancho optimo de la columna que enumera las filas
    width_id_num = len(str(n_rows))

    # ancho de la tabla
    width_table = sum(width_col) + width_id_num + n_col + 1
    
    # bcles para la creacion de la tabla con sus lineas separadoras
    for n, row in enumerate(rows):
        # print("\n{}".format(width_table * '_'))

        print("{:>{width_col}}".format(n, width_col= width_id_num ), end='|')
        
        for i, field in enumerate(row):
            if field is not None:
                print("{:^{width_col}}".format(field, width_col=width_col[i]), end='|')
            else:
                print("{:^{width_col}}".format('None', width_col=width_col[i]), end='|')

        print()
        # print("\n{}".format(width_table * '¯'), end='')



   
    # bucles para agrupar/organizar las longitudes de los registros
    # new_list = []
    # for m, col in enumerate(len_fields[0]):
    #     sub_list = []
    #     for n, row in enumerate(len_fields):
    #         sub_list.append(len_fields[n][m])
    #     new_list.append(sub_list)


    # print('x\n', new_list)

if __name__== '__main__':
    myquery = 'SELECT * FROM Products LIMIT 5'
    read_query(myquery)
    show_query()


    cursor.close()
    conn.close()
