create database prodw3;

use prodw3;

create table usuario
(   
    id int(7) not null auto_increment,
    nombre varchar(30) not null,
    nickname varchar(30) not null unique,
    password varchar(40) not null,
    cellphone int(8) not null unique,
    email varchar(50) not null unique,
    primary key(id)
);

create table producto
(
    id int(7) not null auto_increment,
    url_img varchar(170) not null,
    nombre varchar(20) not null unique,
    precio_unitario int(7) not null,
    cantidad int(7) not null,
    descripcion varchar(30) not null,
    primary key(id)
);


create table shoppingList
(
    id int(7) not null,
    nro_pedido int(4) not null,
    nombre varchar(20) not null unique,
    precio_unitario int(7) not null,
    cantidad_requerida int(7) not null,
    sub_total int(8) not null,
    primary key (id)
);


create table precio_dollar
(
    id int(7) not null auto_increment,
    nombre varchar(20),
    precio_dolar varchar(10),  
    fecha_info varchar(50),
    primary key(id)
);