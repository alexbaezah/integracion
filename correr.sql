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





INSERT INTO `precio_dollar` (`id`, `nombre`, `precio_dolar`, `fecha_info`) VALUES
(1, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(2, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(3, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(4, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(5, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(6, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(7, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000'),
(8, 'USD', '809.301', 'Sun, 28 May 2023 00:00:02 +0000');

-- --------------------------------------------------------


--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `url_img`, `nombre`, `precio_unitario`, `cantidad`, `descripcion`) VALUES
(8, 'https://www.malaga8.com/modules/dbblog/views/img/post/para-que-sirve-el-tremolo-de-una-guitarra-electrica.jpg', 'guitarra electrica', 300000, 2, 'guitarra electrica'),
(9, 'https://www.musicnexo.com/blog/wp-content/uploads/2016/02/Guitarra-acustica-MusicNexo-2.jpg', 'guitarra acustica', 100000, 5, 'guitarra acutica'),
(10, 'https://p4.wallpaperbetter.com/wallpaper/191/937/157/bass-bass-guitar-black-electric-bass-wallpaper-preview.jpg', 'bajo 4 cuerda', 200000, 3, 'bajo 4 cuerdas'),
(11, 'https://cdn.shopify.com/s/files/1/2235/9983/files/BAJO_iInstrumento_960x.jpg?v=1614356418', 'bajo 5 cuerdas', 500000, 7, 'bajo 5 cuerdas'),
(12, 'https://thumbs.dreamstime.com/b/piano-de-cola-b-w-111730374.jpg', 'piano media cola', 800000, 9, 'piano media cola'),
(13, 'https://www.shutterstock.com/image-vector/black-classic-piano-illustration-over-260nw-2293096033.jpg', 'piano de cola entera', 700000, 1, 'piano de cola entera'),
(14, 'https://img.freepik.com/fotos-premium/bateria-profesional-rock-black-luz-volumetrica-sobre-fondo-negro-representacion-3d_476612-9866.jpg', 'bateria tama', 500000, 3, 'bateria tama'),
(15, 'https://i.pinimg.com/originals/49/f5/01/49f501b40df7055fd8cab751c7f297a9.jpg', 'bateria pearl', 900000, 5, 'bateria pearl'),
(16, 'https://masterampli.com/wp-content/webpc-passthru.php?src=https://masterampli.com/wp-content/uploads/2020/10/amplificadores-marshall.jpg&nocache=1', 'amplificador marshal', 300000, 4, 'amplificador marshall'),
(17, 'https://st2.depositphotos.com/17539056/47811/i/600/depositphotos_478116628-stock-photo-milton-keynes-great-britain-may.jpg', 'caja marshall', 350000, 6, 'caja marshall'),
(18, 'https://e1.pxfuel.com/desktop-wallpaper/531/324/desktop-wallpaper-headphones-sennheiser-25-sennheiser.jpg', 'hd 25 ', 200000, 9, 'hd 25'),
(19, 'https://http2.mlstatic.com/D_NQ_NP_805274-MLA28023241993_082018-O.webp', 'focusritte 2i2 ', 160000, 3, 'interfaz de audio '),
(20, 'https://img.freepik.com/fotos-premium/microfono-profesional-estudio-grabacion_116317-2439.jpg?w=2000', 'microfono profesiona', 600000, 1, 'microfono de studio'),
(21, 'https://images8.alphacoders.com/688/thumb-1920-688882.jpg', 'mixer piooner', 500000, 7, 'mixer piooner');

-- --------------------------------------------------------


-- --------------------------------------------------------


--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `nickname`, `password`, `cellphone`, `email`) VALUES
(1, 'mathias ', 'admin', 'admin', 123, 'maravaal1312@gmail.com'),
(3, 'srx', 'sr x', '1234', 123456, 'srx@gmail.com'),
(5, 'koko', 'kokoha', '1234', 123654, 'koko@gmail.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `precio_dollar`
--
ALTER TABLE `precio_dollar`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `shoppinglist`
--
ALTER TABLE `shoppinglist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nickname` (`nickname`),
  ADD UNIQUE KEY `cellphone` (`cellphone`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `precio_dollar`
--
ALTER TABLE `precio_dollar`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;