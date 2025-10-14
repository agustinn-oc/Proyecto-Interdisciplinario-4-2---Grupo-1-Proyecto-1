drop database if exists biblioteca;
create database biblioteca;
use biblioteca;

create table autores (
id_autor int auto_increment,
nombre varchar (20),
apellido varchar (20),
primary key(id_autor)
);
insert into autores
values ("J.K." , "Rowling");
insert into autores
values ("Ruben" , "Doblas");
insert into autores
values ("J. R. R. " , "Tolkien");
insert into autores
values ("Mario" , "Puzo");
insert into autores
values ("Tom" , "Clan");


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

create table usuarios(
id_usuario int auto_increment primary key,
nombre_usuario varchar (30),
apellido_usuario varchar (40),
mail_usuario varchar(80),
telefono_usuario int (10),
direccion_usuario varchar (100),
dni_usuario int (8)
);

create table prestamos(
id_prestamo int auto_increment primary key,
id_empleado int auto_increment primary key,
id_usuarios int auto_increment primary key,
estado_prestamo varchar(40),
fechayhora_devolucion datetime,
fechayhora_entrega datetime,
foreign key (id_empleado) references empleados(id_empleado),
foreign key (id_usuario) references usuario(id_usuario)
);

insert into prestamos values ("devuelto, 22/10/2010 10:43, 10/10/2010 15:00"),
("no devuelto, 00/00/0000, 12/08/2010 14:47"),
("perdido, 00/00/0000, 10/07/2010 12:34"),
("devuelto, 20/03/2010 18:12, 10/01/2010 17:10"),
("devuelto, 30/07/2010 16:23, 28/06/2010 09:53");

create table editoriales(
id_editorial int auto_increment primary key,
nombre_editorial varchar (50),
direccion varchar (50),
antiguedad date,
telefono varchar (11),
email varchar (50),
cantidad_empleados int (50)
);


create table empleados(
id_empleado int auto_increment primary key,
nombre_empleado varchar(50),
apellido varchar (50),
cargo varchar(50),
dni_empleado int (10),
sueldo float (50),
email varchar (50),
horario_trabajo time
);

