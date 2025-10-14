drop database if exists biblioteca;
create database biblioteca;
use biblioteca;

create table autores (
id_autor int auto_increment,
nombre varchar (20),
apellido varchar (20),
primary key(id_autor)
);

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

insert into libros values (default, 9788478886548, "Harry Potter y la Piedra Filosofal", 264, default, "ingresar id genero aca dsps ", "ingresar id editorial aca dsps");
insert into libros values (default, 9789507300882, "El libro troll", 192, default, "ingresar id genero aca dsps ", "ingresar id editorial aca dsps");
insert into libros values (default, 9789505470662, "El Señor de los Anillos: El Retorno del Rey", 608, default, "ingresar id genero aca dsps ", "ingresar id editorial aca dsps");
insert into libros values (default, 9788425316654, "El Padrino", 608, default, "ingresar id genero aca dsps ", "ingresar id editorial aca dsps");
insert into libros values (default, 9780140274059, "Rainbow Six", 740, default, "ingresar id genero aca dsps ", "ingresar id editorial aca dsps");

create table usuarios(
id_usuario int auto_increment primary key,
nombre_usuario varchar (100),
apellido_usuario varchar (100),
gmail_usuario varchar(100),
telefono_usuario int (10),
direccion_usuario varchar (100),
dni_usuario int (8)
);

create table reportes(
id_reporte int auto_increment primary key,
fechayhora_devolucion datetime,
fechayhora_entrega datetime
);

create table editorial(
id_editorial int auto_increment primary key,
nombre_editorial varchar (50),
direccion varchar (50),
antiguedad date,
telefono varchar (11),
email varchar (50),
cantidad_empleados int (50)
);

create table generos(
id_generos int auto_increment primary key,
nombre varchar (50),
descripcion varchar (20000)
);
insert into generos values (default, "Fantastico", "Relatos en que participan fenómenos sobrenaturales y extraordinarios, como la magia o la intervención de criaturas inexistentes");
insert into generos values (default, "Fantastico", "Relatos en que participan fenómenos sobrenaturales y extraordinarios, como la magia o la intervención de criaturas inexistentes");
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



 