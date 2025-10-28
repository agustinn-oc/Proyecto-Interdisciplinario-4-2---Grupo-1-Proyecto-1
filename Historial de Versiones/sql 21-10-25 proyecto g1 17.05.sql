drop database if exists biblioteca;
create database biblioteca;
use biblioteca;

create table autores (
id_autor int auto_increment,
nombre_autor varchar (20),
apellido_autor varchar (20),
primary key(id_autor)
);
insert into autores
values (default, "J.K." , "Rowling");
insert into autores
values (default, "Ruben" , "Doblas");
insert into autores
values (default, "J. R. R. " , "Tolkien");
insert into autores
values (default, "Mario" , "Puzo");
insert into autores
values (default, "Tom" , "Clancy");


create table generos(
id_genero int auto_increment primary key,
nombre varchar (50),
descripcion varchar (2000)
);
insert into generos values (default, "Fantastico", "Relatos en que participan fenómenos sobrenaturales y extraordinarios, como la magia o la intervención de criaturas inexistentes.");
insert into generos values (default, "Humor", "Relatos que buscan provocar risa en los lectores a través de situaciones disparatadas o inesperadas, personajes ridículos o exagerados.");
insert into generos values (default, "Ciencia Ficción", "Es un género especulativo que relata acontecimientos posibles desarrollados en un marco imaginario, cuya verosimilitud se fundamenta narrativamente en los campos de las ciencias físicas, naturales y sociales.");
insert into generos values (default, "Criminal", "Narraciones que se centran en actos criminales y, especialmente, en la investigación, por parte de un detective aficionado o profesional, de un crimen, a menudo un asesinato.");
insert into generos values (default, "Ficción", "narrativas imaginarias que se centran en sucesos, personajes o lugares inventados por el autor, y se diferencian de la no ficción por su naturaleza ficticia." );


create table cargos(
id_cargo int not null auto_increment primary key,
nombre_cargo varchar (30),
sueldo_mensual int not null,
descripcion_cargo varchar (150)
);

create table turnos(
id_turno int not null auto_increment primary key,
nombre_turno enum("Mañana", "Tarde"),
horario_ingreso time,
horario_salida time
);

create table cargos_turnos(
id_cargoturno int not null auto_increment primary key,
id_cargo int,
id_turno int,
foreign key (id_cargo) references cargos(id_cargo),
foreign key (id_turno) references turnos(id_turno)
);

insert into cargos (id_cargo, nombre_cargo, sueldo_mensual, descripcion_cargo) values
(1, "Bibliotecario", 1000000, "Profesional encargado de gestionar y almacenar toda la información"),
(2, "Bibliotecario", 1000000, "Profesional encargado de gestionar y almacenar toda la información"),
(3, "Recepcionista", 850000, "Profesional que recibe, atiende y dirige a visitantes, clientes y personal externo"),
(4, "Recepcionista", 850000, "Profesional que recibe, atiende y dirige a visitantes, clientes y personal externo"),
(5, "Seguridad", 700000, "Profesional que protege personas, propiedades y activos, y cuyas funciones incluyen la prevención de delitos y la vigilancia"),
(6, "Seguridad", 700000, "Profesional que protege personas, propiedades y activos, y cuyas funciones incluyen la prevención de delitos y la vigilancia"),
(7, "Limpieza", 100000, "Profesional responsable de mantener la limpieza y el orden en diversas instalaciones"),
(8, "Limpieza", 100000, "Profesional responsable de mantener la limpieza y el orden en diversas instalaciones");

insert into turnos (id_turno, nombre_turno, horario_ingreso, horario_salida) values
(1, "Mañana", "07:45:00", "13:30:00"),
(2, "Tarde", "13:30:00", "22:00:00"),
(3, "Mañana", "07:45:00", "13:30:00"),
(4, "Tarde", "13:30:00", "22:00:00"),
(5, "Mañana", "07:45:00", "13:30:00"),
(6, "Tarde", "13:30:00", "22:00:00"),
(7, "Mañana", "07:45:00", "13:30:00"),
(8, "Tarde", "13:30:00", "22:00:00");

insert into cargos_turnos (id_cargoturno, id_cargo, id_turno) values
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5),
(6,6,6),
(7,7,7),
(8,8,8);

create table usuarios(
id_usuario int auto_increment primary key,
nombre_usuario varchar (30),
apellido_usuario varchar (40),
mail_usuario varchar(80),
telefono_usuario int (10),
direccion_usuario varchar (100),
dni_usuario int (8)
);
insert into usuarios(nombre_usuario, apellido_usuario, mail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values ("Agustin", "Zowmir", "agutinzow@gmail.com", 1175820756, "paysandu 5432", 30945821);
insert into usuarios(nombre_usuario, apellido_usuario, mail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Thiago", "Da Cruz", "gotiadacruz@gmail.com", 1126136892, "Espinosa 721", 39094874);
 insert into usuarios(nombre_usuario, apellido_usuario, mail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Brayan", "Cardenas", "brayancar@gmail.com", 1188234987, "Av. Gaona 3241", 47820194);
 insert into usuarios(nombre_usuario, apellido_usuario, mail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Gustavo","Cerati","cantorebien@gmail.com",1131254442,"Cucha Cucha 2001", 80149871);
 insert into usuarios(nombre_usuario, apellido_usuario, mail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Charly","Garcia","cantababien@gmail.com",1134125642,"Avenida Coronel Díaz 1905",76543801);
 
 
create table editoriales(
id_editorial int auto_increment primary key,
nombre_editorial varchar (50),
direccion varchar (50),
antiguedad date,
telefono int (10),
email varchar (50),
cantidad_empleados int (50)
);

create table empleados(
id_empleado int auto_increment primary key,
nombre_empleado varchar(50),
apellido_empleado varchar (50),
dni_empleado int (10),
email varchar (50),
id_cargo int,
foreign key (id_cargo) references cargos(id_cargo)
);

create table prestamos(
id_prestamo int auto_increment primary key,
id_empleado int,
id_usuario int,
estado_prestamo varchar(40),
fechayhora_devolucion datetime,
fechayhora_entrega datetime,
foreign key (id_empleado) references empleados(id_empleado),
foreign key (id_usuario) references usuarios(id_usuario)
);

insert into prestamos values (1, default, default, "Devuelto", "2010-10-22 10:43", "2010-10-10 15:00");
#insert into prestamos values (2, default, default, "No devuelto", "0000-00-00 00:00", "2010-08-12 14:47");
#insert into prestamos values (3, "Perdido, 00/00/0000, 10/07/2010 12:34");
#insert into prestamos values (4, "Devuelto, 20/03/2010 18:12, 10/01/2010 17:10");
#insert into prestamos values (5, "Devuelto, 30/07/2010 16:23, 28/06/2010 09:53");
#arreglar inserts despues

create table libros (
id_libro int auto_increment primary key,
isbn varchar(20), #aclaracion: es varchar porque supera el limite de los enteros (int)
titulo varchar(100),
num_pag int,
id_prestamo int,
id_genero int,
id_editorial int,
foreign key (id_prestamo) references prestamos(id_prestamo),
foreign key (id_genero) references generos(id_genero),
foreign key (id_editorial) references editoriales(id_editorial)
);

#hacer lo de la editorial depsues
#insert into libros values (default, "9788478886548", "Harry Potter y la Piedra Filosofal", 264, default, 1, "ingresar id editorial aca dsps");
#insert into libros values (default, "9789507300882", "El libro troll", 192, default, 2 , "ingresar id editorial aca dsps");
#insert into libros values (default, "9789505470662", "El Señor de los Anillos: El Retorno del Rey", 608, default, 3 , "ingresar id editorial aca dsps");
#insert into libros values (default, "9788425316654", "El Padrino", 608, default, 4, "ingresar id editorial aca dsps");
#insert into libros values (default, "9780140274059", "Rainbow Six", 740, default, 5, "ingresar id editorial aca dsps");

create table localidades(
 id_localidad int primary key,
 localidad_libro varchar(60) not null
);

create table ejemplares(
  id_ejemplar int auto_increment primary key,
  id_prestamo int null,
  id_libro int not null,
  id_localidad int,
 foreign key(id_prestamo) references prestamos(id_prestamo),
  foreign key(id_localidad) references localidades(id_localidad),
 foreign key(id_libro) references libros(id_libro)
);



#id localidad este la fk en ejemplares

#crear otra tabla localidades 1 a 1 con ejemplares
#INSERT INTO ejemplares VALUES (12324, 121, 1231);





#samir - arreglar las tablas de cargos !!!!! Hecho :D
#zowmir - hacer otra vez la tabla !!!! Hecho :D




























