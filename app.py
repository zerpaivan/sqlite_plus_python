import database

MENU_PROMPT = """\n
--Coffee Bean App--
Please choose one of these options:
1) Add a new bean.
2) See all beans.
3) Find a bean by name.
4) See whith preparation method is best for a bean.
5) Exit.\n
"""

def menu():
    connection = database.connect()
    database.create_tables(connection)
    
    user_input = input(MENU_PROMPT)
    while user_input != "5":
        if user_input == '1':
            name = input('Enter the name: ')
            method = input('Enter the method: ')
            rating = int(input('Enter the rating (0-100)'))

            database.add_beans(connection, name, method, rating)
        elif user_input == '2':
            beans = database.get_all_beans(connection)

            for bean in beans:
                print(f"{bean[1]} - ({bean[2]}) - {bean[3]}/100")
        elif user_input == '3':
            name = input("Enter bean name to find: ")
            beans = database.get_beans_by_name(connection, name)
            for bean in beans:
                print(f"{bean[1]} - ({bean[2]}) - {bean[3]}/100")
        elif user_input == '4':
            name = input("Enter bean name to find: ")
            best_method = database.get_preparation_for_bean(connection, name)
            print(f"The best preparation method for {name} is: {best_method[2]}")
        else:
            print("Input Invalido, intente de nuevo")
        
        user_input = input(MENU_PROMPT)

menu()