
import mysql.connector

from mysql.connector import errorcode

cursor = None
cnx = None

#HACER TODO EL CODIGO EN FUNCIONES :(

while True: 
    print ("Opciones:")
    print ("1- Añadir Libros")
    print ("2- Eliminar Libros")
    print ("3- Buscar Libros")
    print ("4- Reporte de la base de datos")
    menu = int(input("Ingrese su opcion: "))
    if menu >= 1 and menu <= 4:
        break
    else:
        print ("OPCION INVALIDA -- VUELVA A INTENTAR") 


#if menu == 1:




#elif menu == 2:



#elif menu == 3:




#elif menu == 4:

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



#parte no terminada agus ortiz:
def BuscarLibros():
    sql = "select * from libros" \
          "where "
    cursor.execute(sql, (nombre, dni, correo, saldo))
    cnx.commit()
    return cursor.lastrowid
ConectarBase()

