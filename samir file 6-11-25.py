
import mysql.connector

from mysql.connector import errorcode

cursor = None
cnx = None

#HACER TODO EL CODIGO EN FUNCIONES :(

while True: 
    print ("=== Opciones ===")
    print ("1 - Añadir Libros")
    print ("2 - Eliminar Libros")
    print ("3 - Buscar Libros")
    print ("4 - Reporte de la base de datos")
    menu = int(input("> Ingrese su opcion: "))
    if menu >= 1 and menu <= 4:
        break
    else:
        print ("OPCION INVALIDA -- VUELVA A INTENTAR") 

def AniadirLibros(cursor, titulo, isbn, num_pag):
    cursor.execute("insert into libros (titulo, isbn, num_pag) values(%s, %s, %s);",
                   (titulo, isbn, num_pag))
    cnx.commit()
    listacompleta = []
    cursor.execute("Select * from libros;")
    listacompleta = cursor.fetchall()
    for i in listacompleta:
        print (i)

    #return cursor.lastrowid

def EliminarLibrosPorTitulo(cursor, titulo):
    sql = "SELECT id, titulo, isbn, num_pag FROM libros WHERE titulo = %s;"
    cursor.execute(sql, (titulo,))
    libros = cursor.fetchall()

    if len(libros) == 0:
        print("No se encontró ningún libro con ese título.")
        return

    print("Libros encontrados:")
    for libro in libros:
        print("ID:", libro["id"], "| Título:", libro["titulo"], "| ISBN:", libro["isbn"], "| Páginas:", libro["num_pag"])

    if len(libros) > 1:
        id_valido = False
        while not id_valido:
            try:
                id_elegido = int(input("Ingrese el ID del libro que desea eliminar: "))
                for l in libros:
                    if l["id"] == id_elegido:
                        id_valido = True
                        break
                if not id_valido:
                    print("El ID ingresado no coincide con los mostrados, intente de nuevo.")
            except:
                print("Debe ingresar un número válido.")
    else:
        id_elegido = libros[0]["id"]
        print("Se eliminará el único libro encontrado con ese título (ID:", id_elegido, ")")

    sql_delete = "DELETE FROM libros WHERE id = %s;"
    cursor.execute(sql_delete, (id_elegido,))
    cnx.commit()
    print("Libro eliminado correctamente.")

    # lista actualizafa
    cursor.execute("SELECT * FROM libros;")
    todos = cursor.fetchall()
    print("Lista actualizada de libros:")
    for t in todos:
        print(t)



def ConectarBase():
    global cnx, cursor

    try:
        cnx = mysql.connector.connect(user="root", password="", host="Localhost", database="biblioteca")
        cursor = cnx.cursor(dictionary=True)
        print('Conexión establecida')
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print('Usuario o contraseña incorrectos!')
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print('La base de datos no existe!')
        else:
            print(err)

def ConsultaSelect():
    Consulta = "SELECT * FROM clientes;"
    cursor.execute(Consulta)
    return cursor.fetchall()
#ACA HACE LAS COSAS SAMIR

def InsertarLibros(nombre,dni,correo,saldo):
    sql = "INSERT INTO clientes (nombre, dni, correo, saldo)VALUES( %s, %s, %s, %s)"
    cursor.execute(sql,(nombre,dni,correo,saldo))
    cnx.commit()
    return cursor.lastrowid

ConectarBase()



if menu == 1:
    titulo = str(input("Ingresar Titulo del Libro: "))
    isbn = int(input("Ingresar ISBN: "))
    num_pag = int(input("Ingresar Número de Páginas: "))
    AniadirLibros(cursor, titulo, isbn, num_pag)
elif menu == 2:
    titulo = input("Ingresar Titulo del Libro: ")
    EliminarLibrosPorTitulo(cursor, titulo)




