#00.27 18-11-25
import mysql.connector
from mysql.connector import errorcode
import json

cursor = None
cnx = None

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

# PARTE DEL CODIGO DEL ARBOL BINARIO

# --- 1. Definición del Nodo ---
class Nodo:
   """
   Cada nodo del árbol almacena un valor y las referencias
   a sus hijos izquierdo y derecho.
   """
   def __init__(self, valor):
       self.valor = valor
       self.izquierda = None
       self.derecha = None
# --- 2. Definición del Árbol Binario de Búsqueda ---
class ArbolBinarioBusqueda:
   """
   Clase principal que gestiona el árbol, comenzando desde la raíz.
   """
   def __init__(self):
       self.raiz = None
   # --- Método público para insertar ---
   def insertar(self, valor):
       """
       Punto de entrada público para insertar un valor.
       Llama al método recursivo privado.
       """
       if self.raiz is None:
           self.raiz = Nodo(valor)
       else:
           self._insertar_recursivo(valor, self.raiz)
   # --- Método privado recursivo para insertar ---
   def _insertar_recursivo(self, valor, nodo_actual):
       """
       Implementa la lógica del ABB para encontrar dónde insertar el nuevo nodo.
       """
       if valor < nodo_actual.valor:
           # Ir a la izquierda
           if nodo_actual.izquierda is None:
               nodo_actual.izquierda = Nodo(valor)
           else:
               self._insertar_recursivo(valor, nodo_actual.izquierda)
       elif valor > nodo_actual.valor:
           # Ir a la derecha
           if nodo_actual.derecha is None:
               nodo_actual.derecha = Nodo(valor)
           else:
               self._insertar_recursivo(valor, nodo_actual.derecha)
       # Si valor == nodo_actual.valor, no hacemos nada (no se permiten duplicados)
       # (Esto puede cambiar según la implementación deseada)
   # --- Método público para buscar ---
   def buscar(self, valor):
       """
       Punto de entrada público para buscar un valor.
       Llama al método recursivo privado.
       """
       if self.raiz is None:
           return False
       else:
           return self._buscar_recursivo(valor, self.raiz)
   # --- Método privado recursivo para buscar ---
   def _buscar_recursivo(self, valor_buscado, nodo_actual):
       """
       Implementa la lógica de búsqueda del ABB.
       """
       # Caso base 1: No se encontró (llegamos a un nodo nulo)
       if nodo_actual is None:
           return False
       # Caso base 2: Se encontró
       if nodo_actual.valor == valor_buscado:
           return True
       # Caso recursivo: Decidir si ir a la izquierda o derecha
       if valor_buscado < nodo_actual.valor:
           return self._buscar_recursivo(valor_buscado, nodo_actual.izquierda)
       else:  # valor_buscado > nodo_actual.valor
           return self._buscar_recursivo(valor_buscado, nodo_actual.derecha)
abb = ArbolBinarioBusqueda()

def BuscarLibrosnombre(cursor):
    titulo = str(input("Ingrese su Busqueda: "))
    titulo = [titulo]
    cursor.execute( "SELECT titulo FROM libros where titulo = %s;", titulo)
    listatitulos = cursor.fetchall()
    lista = []
    for i in listatitulos:
        lista.append(i["titulo"])

    if listatitulos != []:
        cursor.execute("""
                           SELECT libros.id_libro, libros.titulo, libros.isbn, libros.num_pag, generos.nombre, editoriales.nombre_editorial, localidades.localidad_libro 
                           FROM libros inner join generos on generos.id_genero = libros.id_genero
                           inner join editoriales on editoriales.id_editorial = libros.id_editorial
                           inner join localidades on localidades.id_localidad = libros.id_localidad
                           where libros.titulo = %s""",titulo)
        lista = cursor.fetchall()
        for i in lista:
            print (i)
    else:
        print("No se encontró un libro llamado asi o esta mal escrita la busqueda")


ConectarBase()


# PARTE DEL CODIGO QUE CONTIENE LAS FUNCIONES DEL MENU
def AniadirLibros(cursor):
    global abb
    titulo = str(input("Ingresar Titulo del Libro: "))
    isbn = int(input("Ingresar ISBN: "))
    num_pag = int(input("Ingresar Número de Páginas: "))


    #añadir localidad
    cursor.execute("Select * from localidades;")
    lista = cursor.fetchall()
    for i in lista:
        print (i)
    cursor.execute("Select id_localidad from localidades;")
    lista = cursor.fetchall()
    for l in lista:
        abb.insertar(int(l["id_localidad"]))
    id_localidad = int(input("Ingrese La ID de la localidad del libro: "))
    while True:
        if abb.buscar(id_localidad) == True:
            break
        else:
            id_localidad = int(input("VALOR INVALIDO - Ingrese la ID de la localidad del libro: "))

    #añadir genero
    cursor.execute("Select id_genero, nombre from generos;")
    lista = cursor.fetchall()
    for i in lista:
        print (i)

    #resetea el arbol binario
    abb = ArbolBinarioBusqueda()

    cursor.execute("Select id_genero from generos;")
    lista = cursor.fetchall()
    for l in lista:
        abb.insertar(int(l["id_genero"]))
    id_genero = int(input("Ingrese La ID del genero del libro: "))
    while True:
        if abb.buscar(id_genero) == True:
            break
        else:
            id_genero = int(input("VALOR INVALIDO - Ingrese la ID de la localidad del libro: "))


    # resetea el arbol binario
    abb = ArbolBinarioBusqueda()

    #añadir editorial
    cursor.execute("Select id_editorial, nombre_editorial from editoriales;")
    lista = cursor.fetchall()
    for i in lista:
        print(i)
    cursor.execute("Select id_editorial from editoriales;")
    lista = cursor.fetchall()
    for l in lista:
        abb.insertar(int(l["id_editorial"]))

    while True:
        respuesta = str(input("¿La editorial del libro se encuentra en la lista? [si / no]: "))
        respuesta.lower()
        if respuesta == "si":
            id_editorial = int(input("Ingrese La ID de la editorial del libro: "))
            while True:
                if abb.buscar(id_editorial) == True:

                    break
                elif abb.buscar(id_editorial) == False:
                    id_editorial = int(input("ID INVALIDA - Ingrese otra vez ID de la editorial del libro: "))
            break
            id_editorial = [id_editorial]
        elif respuesta == "no":
            nombre_editorial = str(input("Ingrese el nombre de la editorial del libro: "))
            nombre_editorial = [nombre_editorial]
            cursor.execute(
                "insert into editoriales (id_editorial, nombre_editorial) values(default, %s);",
                (nombre_editorial))
            cnx.commit()
            cursor.execute("Select max(id_editorial) from editoriales;")
            id_editorial = cursor.fetchone()
            id_editorial = id_editorial["max(id_editorial)"]
            print (id_editorial)
            break
        else:
            print ("RESPUESTA INVALIDA - VUELVA A INTENTAR")

    cursor.execute("insert into libros (titulo, isbn, num_pag, id_localidad, id_genero, id_editorial) values(%s, %s, %s, %s, %s, %s);",
                   (titulo, isbn, num_pag, id_localidad, id_genero, id_editorial))
    cnx.commit()
    listacompleta = []
    cursor.execute("""
                   SELECT libros.titulo,
                          libros.isbn,
                          libros.num_pag,
                          generos.nombre,
                          editoriales.nombre_editorial,
                          localidades.localidad_libro
                   FROM libros
                            inner join generos on generos.id_genero = libros.id_genero
                            inner join editoriales on editoriales.id_editorial = libros.id_editorial
                            inner join localidades on localidades.id_localidad = libros.id_localidad
                   """)
    listacompleta = cursor.fetchall()
    for i in listacompleta:
        print (i)


def BuscarLibrosID(cursor):
    cursor.execute("SELECT id_libro FROM libros")
    librosdict = cursor.fetchall()
    libros = []
    for i in librosdict:
        libros.append(i["id_libro"])
    #print(libros)
    for l in libros:
        abb.insertar(l)
    idingresada = int(input("Ingrese la id que quiere buscar: "))
    if abb.buscar(idingresada) == True:
        id = [idingresada]
        cursor.execute("""
                       SELECT libros.titulo, libros.isbn, libros.num_pag, generos.nombre, editoriales.nombre_editorial, localidades.localidad_libro 
                       FROM libros inner join generos on generos.id_genero = libros.id_genero
                       inner join editoriales on editoriales.id_editorial = libros.id_editorial
                       inner join localidades on localidades.id_localidad = libros.id_localidad
                       where libros.id_libro = %s
                           """, id)
        print(cursor.fetchall())
    elif abb.buscar(idingresada) == False:
        print("No se encontro ningun libro con la ID ingresada")

def BuscarLibrosISBN(cursor):
    cursor.execute("SELECT isbn FROM libros order by isbn asc")
    librosdict = cursor.fetchall()
    libros = []
    for i in librosdict:
        libros.append(i["isbn"])
    #print(libros)
    for l in libros:
        abb.insertar(int(l))
    isbningresado = int(input("Ingrese el numero de isbn del libro que quiere buscar: "))
    if abb.buscar(int(isbningresado)) == True:
        isbningresado = [isbningresado]
        cursor.execute("""
                       SELECT libros.titulo, libros.isbn, libros.num_pag, generos.nombre, editoriales.nombre_editorial, localidades.localidad_libro 
                       FROM libros inner join generos on generos.id_genero = libros.id_genero
                       inner join editoriales on editoriales.id_editorial = libros.id_editorial
                       inner join localidades on localidades.id_localidad = libros.id_localidad
                       where libros.isbn = %s
                           """, isbningresado)
        print(cursor.fetchall())
    elif abb.buscar(isbningresado) == False:
        print("No se encontro ningun libro con el ISBN ingresado")



def borrarporid(cursor):
    #LOOP PARA AGREGAR TODAS LAS IDs  A LA LISTA "libros"
    cursor.execute("SELECT id_libro FROM libros")
    librosdict = cursor.fetchall()
    libros = []
    for i in librosdict:
        libros.append(i["id_libro"])
    #print(libros)
    for l in libros:
        abb.insertar(l)

    idingresada = int(input("Ingrese la id que quiere buscar: "))
    if abb.buscar(idingresada) == False:
        print("El id que ingresaste no existe")
    elif abb.buscar(idingresada) == True:
        idingresada = [idingresada]
        cursor.execute("SELECT * FROM libros where id_libro = %s",idingresada)
        print(cursor.fetchone())
        print ("¿Estas Seguro que quieres Eliminar el Libro?")
        confirmar = str(input("Respuesta [ Si / No ]: "))
        if confirmar == "si":
                cursor.execute("DELETE FROM prestamos WHERE id_libro = %s;", idingresada)
                cnx.commit()
                cursor.execute("DELETE FROM libros_autores WHERE id_libro = %s;", idingresada )
                cnx.commit()
                cursor.execute("DELETE FROM libros WHERE id_libro = %s;", idingresada)
                cnx.commit()

                print("Lista actualizada de libros:")
                cursor.execute("""
                       SELECT libros.titulo, libros.isbn, libros.num_pag, generos.nombre, editoriales.nombre_editorial, localidades.localidad_libro 
                       FROM libros inner join generos on generos.id_genero = libros.id_genero
                       inner join editoriales on editoriales.id_editorial = libros.id_editorial
                       inner join localidades on localidades.id_localidad = libros.id_localidad
                           """)
                todos = cursor.fetchall()
                for t in todos:
                    print(t)
        elif confirmar == "no":
            print("Cerrando Programa...")

def EliminarLibrosPorTitulo(cursor):
    titulo = str(input("Ingresar Titulo del Libro: "))
    titulo = [titulo]
    cursor.execute("SELECT id_libro FROM libros WHERE titulo = %s;", titulo)
    librosdict = cursor.fetchall()
    libros = []
    for i in librosdict:
        libros.append(i["id_libro"])
    print(libros)
    for l in libros:
        abb.insertar(l)


    if libros != []:
        idingresada = int(input("Ingrese la id del libro ingresado que quiere borrar: "))
        if abb.buscar(idingresada) == False:
            print("El id que ingresaste no existe")
        elif abb.buscar(idingresada) == True:
            print("¿Estas Seguro que quieres Eliminar el Libro?")
            confirmar = str(input("Respuesta (si / no): "))
            if confirmar == "si":
                id = [idingresada]
                cursor.execute("DELETE FROM prestamos WHERE id_libro = %s;", id, )
                cnx.commit()
                cursor.execute("DELETE FROM libros_autores WHERE id_libro = %s;", id, )
                cnx.commit()
                cursor.execute("DELETE FROM libros WHERE id_libro = %s;", id, )
                cnx.commit()

                print("Lista actualizada de libros:")
                cursor.execute("""
                               SELECT libros.id_libro, libros.titulo, libros.isbn, libros.num_pag, generos.nombre, editoriales.nombre_editorial, localidades.localidad_libro 
                               FROM libros inner join generos on generos.id_genero = libros.id_genero
                               inner join editoriales on editoriales.id_editorial = libros.id_editorial
                               inner join localidades on localidades.id_localidad = libros.id_localidad
                                   """)
                todos = cursor.fetchall()
                for t in todos:
                    print(t)
            elif confirmar == "no":
                print("Cerrando Programa...")
    else:
        print ("Ningun libro con ese nombre fue encontrado en la base de datos")

def CrearReporte(cursor,tituloreporte,listareporte):
    with open(tituloreporte, 'w', encoding='utf-8') as archivo:
        json.dump(listareporte, archivo, indent=4, ensure_ascii=False)
    print(f"¡Reporte creado con éxito!")

def LibrosMasPrestados():
    cursor.execute("""
                   select libros.titulo, count(libros.id_libro) as "Cantidad de prestamos"
                   from libros
                            inner join prestamos on prestamos.id_libro = libros.id_libro
                   group by libros.titulo
                   order by count(libros.id_libro) desc limit 5;
                   """)
    listareporte = cursor.fetchall()
    tituloreporte = "Reporte - Libros mas prestados.json"
    CrearReporte(cursor, tituloreporte, listareporte)

def LibrosConMenorDisponibilidad():
    cursor.execute("""
                   select libros.titulo, count(libros.id_libro) as "Cantidad de libros"
                   from libros
                            inner join prestamos on prestamos.id_libro = libros.id_libro
                   where prestamos.id_libro is null
                      or prestamos.estado_prestamo = "Devuelto"
                   group by libros.titulo
                   order by count(libros.id_libro) asc;

                   """)
    listareporte2 = cursor.fetchall()
    tituloreporte2 = "Reporte - Libros con baja disponibilidad.json"
    CrearReporte(cursor, tituloreporte2, listareporte2)

def LibrosAlumnosPrestamosVencidos():
    cursor.execute("""
                   select libros.id_libro,
                          libros.titulo,
                          libros.isbn,
                          usuarios.id_usuario,
                          usuarios.nombre_usuario,
                          usuarios.mail_usuario
                   from libros
                            inner join prestamos on prestamos.id_libro = libros.id_libro
                            inner join usuarios on usuarios.id_usuario = prestamos.id_usuario
                   where estado_prestamo = "No devuelto"
                      or estado_prestamo = "Perdido";
                    """)
    listareporte3 = cursor.fetchall()
    tituloreporte3 = "Reporte - Libros y Alumnos con prestamos vencidos.json"
    CrearReporte(cursor, tituloreporte3, listareporte3)

while True:
    print ("--Sistema Gestor de Libreria--")
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

if menu == 1:
    AniadirLibros(cursor)
elif menu == 2:
    while True:
        print("Eliminar por:")
        print("1- Id del libro, 2- Nombre del libro")
        opt = int(input("Seleccion: "))
        if (opt >= 1 and opt <= 2):
            break
        else:
            print("VALOR ERRONEO : VOLVER A INTENTAR")
    if opt == 1:
        borrarporid(cursor)
    elif opt == 2:
        EliminarLibrosPorTitulo(cursor)
elif menu == 3:
    while True:
        print("Buscar por:")
        print("1- Id del libro, 2- ISBN del libro")
        print("3- Nombre")
        opt = int(input("Seleccion: "))
        if (opt >=1 and opt <= 3):
            break
        else:
            print ("VALOR ERRONEO : VOLVER A INTENTAR")
    if opt == 3:
        BuscarLibrosnombre(cursor)
    elif opt == 1:
        BuscarLibrosID(cursor)
    elif opt == 2:
        BuscarLibrosISBN(cursor)
elif menu == 4:
    while True:
        print("¿Que reporte quiere ver?:")
        print("1- Mostrar los libros mas prestados")
        print("2- Mostrar los libros con menor disponibilidad")
        print("3- Mostrar los libros y alumnos con prestamos vencidos")
        opcion = int(input("Seleccion: "))
        if (opcion >=1 and opcion <=3):
            break
        else:
            print("Valor incorrecto : vuelva a intentarlo")
    if opcion == 1:
        LibrosMasPrestados()
    elif opcion == 2:
        LibrosConMenorDisponibilidad()
    elif opcion == 3:
        LibrosAlumnosPrestamosVencidos()


#Funciones de ejemplo para el usuario:

def ConsultaSelect():
    Consulta = "SELECT * FROM clientes;"
    cursor.execute(Consulta)
    return cursor.fetchall()

def InsertarLibros(nombre,dni,correo,saldo):
    sql = "INSERT INTO clientes (nombre, dni, correo, saldo)VALUES( %s, %s, %s, %s)"
    cursor.execute(sql,(nombre,dni,correo,saldo))
    cnx.commit()
    return cursor.lastrowid









