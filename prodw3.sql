-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2023 a las 01:39:35
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prodw3`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precio_dollar`
--

CREATE TABLE `precio_dollar` (
  `id` int(7) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `precio_dolar` varchar(10) DEFAULT NULL,
  `fecha_info` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `precio_dollar`
--

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
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(7) NOT NULL,
  `url_img` varchar(170) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `precio_unitario` int(7) NOT NULL,
  `cantidad` int(7) NOT NULL,
  `descripcion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Estructura de tabla para la tabla `shoppinglist`
--

CREATE TABLE `shoppinglist` (
  `id` int(7) NOT NULL,
  `nro_pedido` int(4) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `precio_unitario` int(7) NOT NULL,
  `cantidad_requerida` int(7) NOT NULL,
  `sub_total` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(7) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `nickname` varchar(30) NOT NULL,
  `password` varchar(40) NOT NULL,
  `cellphone` int(8) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
