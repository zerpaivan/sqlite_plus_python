import sqlite3
conn = sqlite3.connect('Practice_problems_SQLITE\\northwind.db')


class PracticeProblems():
    def __init__(self):
        self.conn = sqlite3.connect('Practice_problems_SQLITE\\northwind.db')
        self.cur = self.conn.cursor()
    
    # metodo para mostrar el nombre de las columnas.
    def __data_description(self, my_query:str):
        data = self.cur.execute(my_query)
        # Capturar el nombre de las columnas con despcription
        temp_rows = self.cur.description
        print(temp_rows, temp_rows[0][0])
        head_rows = tuple(map(lambda x: (x[0],), temp_rows))
        # print('head_rows', head_rows)
        return head_rows


    def read_query(self,my_query: str):
        # self.__data_description(my_query)
        self.cur.execute(my_query)
        rows = self.cur.fetchall()
        return rows
        # conn.commit()
        # -----------------------------------------------------------------------
    
    # metodo para determinar el campo o registro con la longitud mas grande
    #  con el fin de determinar el mejor ancho de columna para la tabla a mostrar
    def column_width(self, rows):
        len_fields = [list(map(lambda x: len(str(x)), row)) for row in rows]
        max_field = max(map(lambda x: max(x), len_fields))
        # print(len_fields, max_field)
        #  retorna una tupla de la forma ((N1,),(N2,),...(Nn,))
        return max_field

    # metodo para mostrar las query en la terminal en una tabla ordenada
    def show_query(self,my_query):
        head = self.__data_description(my_query)
        rows = self.read_query(my_query)
        cw_head = self.column_width(head)
        cw_rows = self.column_width(rows)
        # print('cw_head: ', cw_head, 'cw_rows', cw_rows)
        if cw_head >= cw_rows:
            c_width = cw_head
        else:
            c_width = cw_rows

        # mostrar la cabezera de la tabla
        # for field_name in head:
        #     print(f'{field_name:^{c_width}}', end=" | ")
        # else:
        #     print()
        
        for  h_row in head:
            for h_field in h_row:
                print(f'{h_field:^{c_width}}', end=" | ")
        else:
            print()
        # mostrar los registros de la tabla
        for row in rows:
            for field in row:
                print(f'{field:^{c_width}}', end=" | ")
            else:
                print()


if __name__ == "__main__":
    myquery_1 = "SELECT * FROM Shippers"
    MySolutions = PracticeProblems()
    MySolutions.show_query(myquery_1)

    
    



