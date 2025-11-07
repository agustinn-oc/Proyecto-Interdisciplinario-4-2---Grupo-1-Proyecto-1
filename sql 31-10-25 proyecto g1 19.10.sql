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

insert into cargos (nombre_cargo, sueldo_mensual, descripcion_cargo) values
("Bibliotecario", 1000000, "Profesional encargado de gestionar y almacenar toda la información"),
("Bibliotecario", 1000000, "Profesional encargado de gestionar y almacenar toda la información"),
("Recepcionista", 850000, "Profesional que recibe, atiende y dirige a visitantes, clientes y personal externo"),
("Recepcionista", 850000, "Profesional que recibe, atiende y dirige a visitantes, clientes y personal externo"),
("Seguridad", 700000, "Profesional que protege personas, propiedades y activos, y cuyas funciones incluyen la prevención de delitos y la vigilancia"),
("Seguridad", 700000, "Profesional que protege personas, propiedades y activos, y cuyas funciones incluyen la prevención de delitos y la vigilancia"),
("Limpieza", 100000, "Profesional responsable de mantener la limpieza y el orden en diversas instalaciones"),
("Limpieza", 100000, "Profesional responsable de mantener la limpieza y el orden en diversas instalaciones");

insert into turnos (nombre_turno, horario_ingreso, horario_salida) values
("Mañana", "07:45:00", "13:30:00"),
("Tarde", "13:30:00", "22:00:00"),
("Mañana", "07:45:00", "13:30:00"),
("Tarde", "13:30:00", "22:00:00"),
("Mañana", "07:45:00", "13:30:00"),
("Tarde", "13:30:00", "22:00:00"),
("Mañana", "07:45:00", "13:30:00"),
("Tarde", "13:30:00", "22:00:00");

insert into cargos_turnos (id_cargo, id_turno) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8);

create table usuarios(
id_usuario int auto_increment primary key,
nombre_usuario varchar (30),
apellido_usuario varchar (40),
mail_usuario varchar(80),
telefono_usuario int,
direccion_usuario varchar (100),
dni_usuario int
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
telefono int,
email varchar (50),
cantidad_empleados int
);

insert into editoriales values(default, "Salamandra", "Travessera de Gràcia 47-49", "1989-10-06", 932151199, "prensa@salamandra.es", 419);
insert into editoriales values(default, "Temas De Hoy", "P.º de Recoletos, 4, 4º", "1987-06-23", 914230318, "temasdehoy@temasdehoy.com", 389);
insert into editoriales values(default, "Minotauro", "Av. Diagonal, 662-664, Barcelona", "1955-07-13", 934928000, "proyectosminotauro@planeta.es", 435);
insert into editoriales values(default, "Grijalbo", "Avenida Belgrano, Arenales 1256, C1061", "1957-03-22", 1143837181, "grijalboeditorial@grijalbo.com", 445);
insert into editoriales values(default, "Berkley Publishing Group", "Humberto Primo 555", "1955-06-24", 1152354400, "berkleypublicity@penguinrandomhouse.com.", 467);


create table empleados(
id_empleado int primary key auto_increment,
nombre_empleado varchar(50),
apellido_empleado varchar (50),
dni_empleado int,
email varchar (50),
id_cargo int,
foreign key (id_cargo) references cargos(id_cargo)
);

insert into empleados values (default, "Samir", "Rivera", 123456789, "riverasamir@gmail.com", 1);
insert into empleados values (default, "Agustin", "Ortiz", 213456789, "ortizagustin@gmail.com", 1);
insert into empleados values (default, "Agustin", "Zowmir", 123456789, "zowmiragustin@gmail.com", 2);
insert into empleados values (default, "Agustin", "Lerman", 123456789, "lermanagustin@gmail.com", 3);
insert into empleados values (default, "Thiago", "Da Cruz", 123456789, "dacruzthiago@gmail.com", 3);

create table localidades(
 id_localidad int primary key auto_increment,
 localidad_libro varchar(60) not null
);

insert into localidades values (default, "Biblioteca 1 (Pared izquierda)");
insert into localidades values (default, "Biblioteca 2 (Pared Derecha)");
insert into localidades values (default, "Biblioteca 3 (Pared Central)");
insert into localidades values (default, "Biblioteca 3 (Izquierda central)");
insert into localidades values (default, "Biblioteca 3 (Derecha central)");

create table libros (
id_libro int auto_increment primary key,
isbn varchar(20), #aclaracion: es varchar porque supera el limite de los enteros (int)
titulo varchar(100),
num_pag int,
id_genero int,
id_editorial int,
id_localidad int,
foreign key (id_genero) references generos(id_genero),
foreign key (id_editorial) references editoriales(id_editorial),
foreign key (id_localidad) references localidades(id_localidad)
);


insert into libros values (default, "9788478886548", "Harry Potter y la Piedra Filosofal", 264, 1, 1, 1);
insert into libros values (default, "9789507300882", "El libro troll", 192, 2, 2 , 2);
insert into libros values (default, "9789505470662", "El Señor de los Anillos: El Retorno del Rey", 608, 3, 3 , 3);
insert into libros values (default, "9788425316654", "El Padrino", 608, 4, 4, 4);
insert into libros values (default, "9780140274059", "Rainbow Six", 740, 5, 5, 5);

create table libros_autores (
id_libroautor int primary key auto_increment,
id_libro int,
id_autor int,
foreign key (id_libro) references libros(id_libro),
foreign key (id_autor) references autores(id_autor)
);

insert into libros_autores values (default, 1,1);
insert into libros_autores values (default, 2,2);
insert into libros_autores values (default, 3,3);
insert into libros_autores values (default, 4,4);
insert into libros_autores values (default, 5,5);


create table prestamos(
id_prestamo int auto_increment primary key,
id_usuario int,
id_empleado int,
id_libro int,
estado_prestamo varchar(40),
fechayhora_devolucion datetime,
fechayhora_entrega datetime,
foreign key (id_usuario) references usuarios(id_usuario),
foreign key (id_empleado) references empleados(id_empleado),
foreign key (id_libro) references libros(id_libro)
);

insert into prestamos values (default, 1, 1, 1, "Devuelto", "2010-10-22 10:43", "2010-10-10 15:00");
insert into prestamos values (default, 2, 2, 2, "No devuelto", null, "2010-08-12 14:47");
insert into prestamos values (default, 3, 3, 3, "Perdido", null, "2010-07-10 12:34");
insert into prestamos values (default, 4, 4, 4, "Devuelto", "2010-03-20 18:12", "2010-01-10 17:10");
insert into prestamos values (default, 5, 5, 5, "Devuelto", "2010-07-30 16:23", "2010-06-28 09:53");

#consultas basicas:

#muestra ultimo prestamo hecho
select * from prestamos
order by fechayhora_devolucion desc
limit 1;

#muestra todos los usuarios
select * from usuarios;

#muestra el ultimo empleado contratado
select * from empleados
order by id_empleado desc;

#muestra todos los libros existentes en la base de datos
select * from libros;

#muestra la cantidad de libros que hay en la base de datos
select count(id_libro) as "Cantidad total de libros" from libros;

#consultas complejas:

#ultimo prestamo hecho
select * from autores
where id_autor = (select max(id_autor) from autores);

#muestra el ultimo prestamo realizado por fecha
select * from prestamos
where fechayhora_devolucion = (select max(fechayhora_devolucion) from prestamos);

#muestra cuantos prestamos fueron realizados por usuario
select usuarios.id_usuario, usuarios.nombre_usuario, usuarios.apellido_usuario, count(id_prestamo) from usuarios
inner join prestamos on prestamos.id_usuario = usuarios.id_usuario
group by (prestamos.id_usuario);

#muestra los libros que pidio cada usuario
select usuarios.id_usuario, usuarios.nombre_usuario, usuarios.apellido_usuario, prestamos.id_prestamo, libros.titulo from usuarios
inner join prestamos on prestamos.id_usuario = usuarios.id_usuario
inner join libros on libros.id_libro = prestamos.id_libro;

#muestra cuantos libros de cada genero hay
select generos.nombre, count(libros.id_libro) from libros
inner join generos on generos.id_genero = libros.id_genero
group by (libros.id_genero);


select libros.id_libro,
libros.titulo, 
libros.isbn,
usuarios.id_usuario,
usuarios.nombre_usuario, 
usuarios.mail_usuario
from libros
inner join prestamos on prestamos.id_libro = libros.id_libro
inner join usuarios on usuarios.id_usuario = prestamos.id_usuario
where estado_prestamo = "No devuelto" or estado_prestamo = "Perdido";

