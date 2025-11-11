
import mysql.connector

from mysql.connector import errorcode

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


def BuscarLibrosnombre(cursor, titulo):
    titulo = [titulo]
    cursor.execute("""
                       SELECT libros.titulo, libros.isbn, libros.num_pag, generos.nombre, editoriales.nombre_editorial, localidades.localidad_libro 
                       FROM libros inner join generos on generos.id_genero = libros.id_genero
                       inner join editoriales on editoriales.id_editorial = libros.id_editorial
                       inner join localidades on localidades.id_localidad = libros.id_localidad
                       where libros.titulo = %s""",titulo)
    return cursor.fetchall()
ConectarBase()

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

#wkkb


#elif menu == 2:



#elif menu == 4:

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
# Insertamos valores

#valores = [50, 30, 70, 20, 40, 60, 80]
#for v in valores:
   #abb.insertar(v)


# El árbol resultante se vería así:
#         50
#       /    \
#     30      70
#    /  \    /  \
#  20    40 60    80


# Buscamos valores
#print(f"¿Está el 40 en el árbol? {abb.buscar(40)}")  # True


def BuscarLibrosID(cursor):
    cursor.execute("SELECT id_libro FROM libros")
    librosdict = cursor.fetchall()
    libros = []
    for i in librosdict:
        libros.append(i["id_libro"])
    print(libros)
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
    print(libros)
    for l in libros:
        abb.insertar(l)
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
    print(libros)
    for l in libros:
        abb.insertar(l)

    idingresada = int(input("Ingrese la id que quiere buscar: "))
    if abb.buscar(idingresada) == True:
        confirmar = input("r u fucking sure dummy? [ si / no ]")
        if confirmar.lower == "si":
            id = [idingresada]
            #REEEMPLAZAR CON CODIGO PAR ABORARR MIERDA
    elif abb.buscar(idingresada) == False:
            print("No se encontro ningun libro con la ID ingresada")





if menu == 3:
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
        titulo = str(input("Ingrese su Busqueda: "))
        if (BuscarLibrosnombre(cursor, str(titulo))) != []:
            print (BuscarLibrosnombre(cursor, str(titulo)))
        else:
            print("No se encontró un libro llamado asi o esta mal escrita la busqueda")
    elif opt == 1:
        BuscarLibrosID(cursor)
    elif opt == 2:
        BuscarLibrosISBN(cursor)