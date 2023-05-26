import sqlite3
conn = sqlite3.Connection('rexon_metals.db')
cursor = conn.cursor()
cursor.execute(
                ''' SELECT NAME, STATE, CUSTOMER_ORDER.ORDER_ID
                    FROM CUSTOMER 
                    INNER JOIN CUSTOMER_ORDER 
                        ON CUSTOMER.CUSTOMER_ID = CUSTOMER_ORDER.CUSTOMER_ID
                '''
)
temp_head = cursor.description 
head=tuple(map(lambda x: (x[0],),temp_head))

for h in head:
    print(h, end='')
else:
    print()
rows=cursor.fetchall()
for row in rows:
    print(row)
