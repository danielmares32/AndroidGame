-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2021 a las 19:05:08
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `android_gw_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `id_p` int(10) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `abreviacion` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`id_p`, `nombre`, `abreviacion`) VALUES
(1, 'mexico', 'mex');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partidas`
--

CREATE TABLE `partidas` (
  `id_game` int(10) NOT NULL,
  `id_usuario1` varchar(20) DEFAULT NULL,
  `id_usuario2` varchar(20) DEFAULT NULL,
  `id_usuario1_personaje` int(10) DEFAULT NULL,
  `id_usuario2_personaje` int(10) DEFAULT NULL,
  `id_usuario_ganador` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personajes`
--

CREATE TABLE `personajes` (
  `id` int(10) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `color_cabello` varchar(20) DEFAULT NULL,
  `color_piel` varchar(15) DEFAULT NULL,
  `tipo_de_cabello` varchar(20) DEFAULT NULL,
  `titulo_del_videojuego` varchar(30) DEFAULT NULL,
  `color_vestimenta` varchar(20) DEFAULT NULL,
  `imagen` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personajes`
--

INSERT INTO `personajes` (`id`, `nombre`, `color_cabello`, `color_piel`, `tipo_de_cabello`, `titulo_del_videojuego`, `color_vestimenta`, `imagen`) VALUES
(1, 'joker', 'negro', 'clara', 'grueso', 'persona 5', 'negro', 'joker_p5.png'),
(2, 'futaba', 'naranja', 'clara', 'lacio', 'persona 5', 'verde', 'futaba_p5.png'),
(3, 'haru', 'cafe', 'clara', 'ondulado', 'persona 5', 'rosa', 'haru_p5.jpg'),
(4, 'kasumi', 'rojo', 'clara', 'lacio', 'persona 5', 'negro', 'kasumi_p5.png'),
(5, 'a2', 'blanco', 'clara', 'lacio', 'nier automata', 'negro', 'a2_nier.png'),
(6, 'gwen', 'azul', 'clara', 'ondulado', 'league of legends', 'blanca', 'gwenLol.png'),
(7, 'dva', 'cafe', 'clara', 'grueso', 'overwatch', 'azul', 'Dva_overwatch.png'),
(8, 'cortana', 'negro', 'azul', 'lacio', 'halo', 'ninguno', 'cortana_halo.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int(10) NOT NULL,
  `pregunta` varchar(150) DEFAULT NULL,
  `categoria` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id_pregunta`, `pregunta`, `categoria`) VALUES
(1, '¿pertenece al juego de persona 5?', 'juego'),
(2, '¿pertenece al juego overwatch?', 'juego'),
(3, '¿pertenece al juego halo?', 'juego'),
(4, '¿pertenece al juego league of legends?', 'juego'),
(5, '¿pertenece al juego minecraft?', 'juego'),
(6, '¿pertenece al juego packman?', 'juego'),
(7, '¿pertenece al juego nier automata?', 'juego'),
(8, '¿pertenece al juego mario party?', 'juego'),
(9, '¿petenece al juego pokemon?', 'juego'),
(10, '¿pertenece al juego  call of duty?', 'juego'),
(11, '¿pertenece al juego god of war?', 'juego'),
(12, '¿pertenece al juego metroid?', 'juego'),
(13, '¿pertenece al juego star wars?', 'juego'),
(14, '¿pertenece al juego batman?', 'juego'),
(15, '¿pertenece al juego metal solid?', 'juego'),
(16, '¿pertenece al juego monster hunter?', 'juego'),
(17, '¿pertenece al juego chrono trigger?', 'juego'),
(18, '¿es hombre?', 'genero'),
(19, '¿es mujer?', 'genero'),
(20, '¿es de genero desconocido?', 'genero'),
(21, '¿es heroe?', 'papel'),
(22, '¿es villano?', 'papel'),
(23, '¿la primer letra del nombre esta entre A y G?', 'nombre_letra'),
(24, '¿la primer letra del nombre esta entre H y P?', 'nombre_letra'),
(25, '¿la primer letra del nombre esta entre Q y G?', 'nombre_letra'),
(26, '¿tiene el cabello negro?', 'cabello_color'),
(27, '¿tiene el cabello rojo?', 'cabello_color'),
(28, '¿tiene el cabello azul?', 'cabello_color'),
(29, '¿tiene el cabello cafe?', 'cabello_color'),
(30, '¿tiene el cabello naranja?', 'cabello_color'),
(31, '¿tiene el cabello blanco?', 'cabello_color'),
(32, '¿no tiene cabello?', 'cabello_color'),
(33, '¿tiene el cabello grueso?', 'cabello_tipo'),
(34, '¿tiene el cabello lacio?', 'cabello_tipo'),
(35, '¿tiene el cabello ondulado?', 'cabello_tipo'),
(36, '¿tiene nada de cabello?', 'cabello_tipo'),
(37, '¿tiene la piel clara?', 'piel'),
(38, '¿tiene la piel oscura?', 'piel'),
(39, '¿tiene la piel de color?', 'piel'),
(40, '¿se le ve la piel?', 'piel'),
(41, '¿viste de negro?', 'vestimenta'),
(42, '¿viste de verde?', 'vestimenta'),
(43, '¿viste de rosa?', 'vestimenta'),
(44, '¿viste de blanco?', 'vestimenta'),
(45, '¿viste de azul?', 'vestimenta'),
(46, '¿usa mascara?', 'vestimenta'),
(47, '¿usa gorra?', 'vestimenta'),
(48, '¿usa sombrero?', 'vestimenta'),
(49, '¿usa zapatos?', 'vestimenta'),
(50, '¿no viste nada?', 'vestimenta'),
(51, '¿es joker?', 'nombre'),
(52, '¿es futaba?', 'nombre'),
(53, '¿es haru?', 'nombre'),
(54, '¿es kasumi?', 'nombre'),
(55, '¿es a2?', 'nombre'),
(56, '¿es gwen?', 'nombre'),
(57, '¿es dva?', 'nombre'),
(58, '¿es cortana?', 'nombre'),
(59, '¿es ash?', 'nombre'),
(60, '¿es batman?', 'nombre'),
(61, '¿es simon riley?', 'nombre'),
(62, '¿es jinx?', 'nombre'),
(63, '¿es kratos?', 'nombre'),
(64, '¿es mario?', 'nombre'),
(65, '¿es jhon?', 'nombre'),
(66, '¿es packman?', 'nombre'),
(67, '¿es samus?', 'nombre'),
(68, '¿es steve?', 'nombre'),
(69, '¿es toad?', 'nombre'),
(70, '¿es vader?', 'nombre'),
(71, '¿es yoshi?', 'nombre'),
(72, '¿es hunter?', 'nombre'),
(73, '¿es hunter?', 'nombre'),
(74, '¿es big boss?', 'nombre'),
(75, '¿es crono?', 'nombre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntuaciones`
--

CREATE TABLE `puntuaciones` (
  `id_punt` int(10) NOT NULL,
  `total_partidas` int(10) DEFAULT NULL,
  `total_victorias` int(10) DEFAULT NULL,
  `total_derrotas` int(10) DEFAULT NULL,
  `total_puntos` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `puntuaciones`
--

INSERT INTO `puntuaciones` (`id_punt`, `total_partidas`, `total_victorias`, `total_derrotas`, `total_puntos`) VALUES
(2, 12, 5, 7, 345);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usu` varchar(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `id_pais` int(10) DEFAULT NULL,
  `id_puntuacion` int(10) DEFAULT NULL,
  `estado_conexion` varchar(2) DEFAULT NULL CHECK (`estado_conexion` in ('C','D')),
  `passwd` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usu`, `nombre`, `id_pais`, `id_puntuacion`, `estado_conexion`, `passwd`) VALUES
('1', 'enma', 1, 2, 'D', 'kuru');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_p`);

--
-- Indices de la tabla `partidas`
--
ALTER TABLE `partidas`
  ADD PRIMARY KEY (`id_game`),
  ADD KEY `FK_USU1_PART` (`id_usuario1`),
  ADD KEY `FK_USU2_PART` (`id_usuario2`),
  ADD KEY `FK_PER1_PART` (`id_usuario1_personaje`),
  ADD KEY `FK_PER2_PART` (`id_usuario2_personaje`);

--
-- Indices de la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id_pregunta`);

--
-- Indices de la tabla `puntuaciones`
--
ALTER TABLE `puntuaciones`
  ADD PRIMARY KEY (`id_punt`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usu`),
  ADD KEY `FK_USU_PAIS` (`id_pais`),
  ADD KEY `FK_USU_PUNT` (`id_puntuacion`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `partidas`
--
ALTER TABLE `partidas`
  ADD CONSTRAINT `FK_PER1_PART` FOREIGN KEY (`id_usuario1_personaje`) REFERENCES `personajes` (`id`),
  ADD CONSTRAINT `FK_PER2_PART` FOREIGN KEY (`id_usuario2_personaje`) REFERENCES `personajes` (`id`),
  ADD CONSTRAINT `FK_USU1_PART` FOREIGN KEY (`id_usuario1`) REFERENCES `usuarios` (`id_usu`),
  ADD CONSTRAINT `FK_USU2_PART` FOREIGN KEY (`id_usuario2`) REFERENCES `usuarios` (`id_usu`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FK_USU_PAIS` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_p`),
  ADD CONSTRAINT `FK_USU_PUNT` FOREIGN KEY (`id_puntuacion`) REFERENCES `puntuaciones` (`id_punt`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
