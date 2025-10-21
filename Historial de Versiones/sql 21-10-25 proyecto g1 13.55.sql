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
id_generos int auto_increment primary key,
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
nombre_turno varchar(10),
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

#insert into cargos (id_cargo, nombre_cargo, horario_ingreso, horario_salida, sueldo_mensual, descripcion_cargo) values
#(1, "Bibliotecario Turno Mañana", "07:45", "13:30", 1000000, ""),
#2, "Bibliotecario Turno Tarde", "13:30", "22:00", 1000000, ""),
#(3, "Recepcionista Turno Mañana", "07:45", "13:30", 850000, ""),
#(4, "Recepcionista Turno Tarde", "13:30", "22:00", 850000, ""),
#(5, "Seguridad Turno Mañana", "07:45", "13:30", 700000, ""),
#(6, "Seguridad Turno Tarde", "13:30", "22:00", 700000, ""),
#(7, "Limpieza Turno Mañana", "07:45", "13:30", 100000, ""),
#(8, "Limpieza Turno Tarde", "13:30", "22:00", 100000, "");


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
foreign key (id_usuario) references usuario(id_usuario)
);

insert into prestamos values ("devuelto, 22/10/2010 10:43, 10/10/2010 15:00");
insert into prestamos values ("no devuelto, 00/00/0000, 12/08/2010 14:47");
insert into prestamos values ("perdido, 00/00/0000, 10/07/2010 12:34");
insert into prestamos values ("devuelto, 20/03/2010 18:12, 10/01/2010 17:10");
insert into prestamos values ("devuelto, 30/07/2010 16:23, 28/06/2010 09:53");

create table libros (
id_libros int auto_increment primary key,
isbn int (20),
titulo varchar(100),
num_pag int,
id_prestamo int,
id_genero int,
id_editorial int,
foreign key (id_prestamo) references prestamos(id_prestamo),
foreign key (id_genero) references generos(id_genero),
foreign key (id_editorial) references editoriales(id_editorial)
);

insert into libros values (default, 9788478886548, "Harry Potter y la Piedra Filosofal", 264, default, 1, "ingresar id editorial aca dsps");
insert into libros values (default, 9789507300882, "El libro troll", 192, default, 2 , "ingresar id editorial aca dsps");
insert into libros values (default, 9789505470662, "El Señor de los Anillos: El Retorno del Rey", 608, default, 3 , "ingresar id editorial aca dsps");
insert into libros values (default, 9788425316654, "El Padrino", 608, default, 4, "ingresar id editorial aca dsps");
insert into libros values (default, 9780140274059, "Rainbow Six", 740, default, 5, "ingresar id editorial aca dsps");

create table ejemplares(
id_ejemplar int auto_increment,
localidad varchar(30),
ficha int(15),
primary key(id_ejemplar),
foreign key(id_prestamo) references prestamos(id_prestamo),
foreign key(id_libro) references libros(id_libro)
);

INSERT INTO ejemplares VALUES
(12313, "Chubut 1283", 12742871);


create table usuarios(
id_usuario int auto_increment primary key,
nombre_usuario varchar (30),
apellido_usuario varchar (40),
mail_usuario varchar(80),
telefono_usuario int (10),
direccion_usuario varchar (100),
dni_usuario int (8)
);
insert into usuarios(nombre_usuario, apellido_usuario, gmail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values ("Agustin, Zowmir, agutinzow@gmail.com, 1175820756, paysandu 5432, 30945821");
insert into usuarios(nombre_usuario, apellido_usuario, gmail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Thiago", "Da Cruz", "gotiadacruz@gmail.com", 1126136892, "Espinosa 721", 39094874);
 insert into usuarios(nombre_usuario, apellido_usuario, gmail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Brayan", "Cardenas", "brayancar@gmail.com", 1188234987, "Av. Gaona 3241", 47820194);
 insert into usuarios(nombre_usuario, apellido_usuario, gmail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
values
 ("Gustavo","Cerati","cantorebien@gmail.com",1131254442,"Cucha Cucha 2001", 80149871);
 insert into usuarios(nombre_usuario, apellido_usuario, gmail_usuario, telefono_usuario, direccion_usuario, dni_usuario) 
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


#samir - arreglar las tablas de cargos
#zowmir - hacer otra vez la tabla





























