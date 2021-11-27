-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-11-2021 a las 00:24:51
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
  `nombre_letra` varchar(20) DEFAULT NULL,
  `color_cabello` varchar(20) DEFAULT NULL,
  `color_piel` varchar(15) DEFAULT NULL,
  `tipo_de_cabello` varchar(20) DEFAULT NULL,
  `titulo_del_videojuego` varchar(30) DEFAULT NULL,
  `color_vestimenta` varchar(20) DEFAULT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `rol` varchar(20) DEFAULT NULL,
  `accesorio` varchar(25) DEFAULT NULL,
  `imagen` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personajes`
--

INSERT INTO `personajes` (`id`, `nombre`, `nombre_letra`, `color_cabello`, `color_piel`, `tipo_de_cabello`, `titulo_del_videojuego`, `color_vestimenta`, `genero`, `rol`, `accesorio`, `imagen`) VALUES
(1, 'joker', 'H y P', 'negro', 'clara', 'grueso', 'persona 5', 'negro', 'hombre', 'heroe', 'ninguno', 'joker_p5.png'),
(2, 'futaba', 'A y G', 'naranja', 'clara', 'lacio', 'persona 5', 'verde', 'mujer', 'heroe', 'ninguno', 'futaba_p5.png'),
(3, 'haru', 'H y P', 'cafe', 'clara', 'ondulado', 'persona 5', 'rosa', 'mujer', 'heroe', 'ninguno', 'haru_p5.jpg'),
(4, 'kasumi', 'H y P', 'rojo', 'clara', 'lacio', 'persona 5', 'negro', 'mujer', 'heroe', 'ninguno', 'kasumi_p5.png'),
(5, 'a2', 'A y G', 'blanco', 'clara', 'lacio', 'nier automata', 'negro', 'mujer', 'heroe', 'ninguno', 'a2_nier.png'),
(6, 'gwen', 'A y G', 'azul', 'clara', 'ondulado', 'league of legends', 'blanca', 'mujer', 'heroe', 'ninguno', 'gwenLol.png'),
(7, 'dva', 'A y G', 'cafe', 'clara', 'grueso', 'overwatch', 'azul', 'mujer', 'heroe', 'ninguno', 'Dva_overwatch.png'),
(8, 'cortana', 'A y G', 'negro', 'color', 'lacio', 'halo', 'ninguno', 'mujer', 'villano', 'ninguno', 'cortana_halo.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int(10) NOT NULL,
  `pregunta` varchar(150) DEFAULT NULL,
  `categoria` varchar(30) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id_pregunta`, `pregunta`, `categoria`, `descripcion`) VALUES
(1, '¿pertenece al juego de persona 5?', 'titulo_del_videojuego', 'persona 5'),
(2, '¿pertenece al juego overwatch?', 'titulo_del_videojuego', 'overwatch'),
(3, '¿pertenece al juego halo?', 'titulo_del_videojuego', 'halo'),
(4, '¿pertenece al juego league of legends?', 'titulo_del_videojuego', 'league of legends'),
(5, '¿pertenece al juego minecraft?', 'titulo_del_videojuego', 'minecraft'),
(6, '¿pertenece al juego packman?', 'titulo_del_videojuego', 'packman'),
(7, '¿pertenece al juego nier automata?', 'titulo_del_videojuego', 'nier automata'),
(8, '¿pertenece al juego mario party?', 'titulo_del_videojuego', 'mario party'),
(9, '¿petenece al juego pokemon?', 'titulo_del_videojuego', 'pokemon'),
(10, '¿pertenece al juego  call of duty?', 'titulo_del_videojuego', 'call of duty'),
(11, '¿pertenece al juego god of war?', 'titulo_del_videojuego', 'god of war'),
(12, '¿pertenece al juego metroid?', 'titulo_del_videojuego', 'metroid'),
(13, '¿pertenece al juego star wars?', 'titulo_del_videojuego', 'star wars'),
(14, '¿pertenece al juego batman?', 'titulo_del_videojuego', 'batman'),
(15, '¿pertenece al juego metal solid?', 'titulo_del_videojuego', 'metal gear solid'),
(16, '¿pertenece al juego monster hunter?', 'titulo_del_videojuego', 'monster hunter'),
(17, '¿pertenece al juego chrono trigger?', 'titulo_del_videojuego', 'chrono trigger'),
(18, '¿es hombre?', 'genero', 'hombre'),
(19, '¿es mujer?', 'genero', 'mujer'),
(20, '¿es de genero desconocido?', 'genero', 'desconocido'),
(21, '¿es heroe?', 'rol', 'heroe'),
(22, '¿es villano?', 'rol', 'villano'),
(23, '¿la primer letra del nombre esta entre A y G?', 'nombre_letra', 'A y G'),
(24, '¿la primer letra del nombre esta entre H y P?', 'nombre_letra', 'H y P'),
(25, '¿la primer letra del nombre esta entre Q y G?', 'nombre_letra', 'Q y G'),
(26, '¿tiene el cabello negro?', 'color_cabello', 'negro'),
(27, '¿tiene el cabello rojo?', 'color_cabello', 'rojo'),
(28, '¿tiene el cabello azul?', 'color_cabello', 'azul'),
(29, '¿tiene el cabello cafe?', 'color_cabello', 'cafe'),
(30, '¿tiene el cabello naranja?', 'color_cabello', 'naranja'),
(31, '¿tiene el cabello blanco?', 'color_cabello', 'blanco'),
(32, '¿no tiene cabello?', 'color_cabello', 'nada'),
(33, '¿tiene el cabello grueso?', 'tipo_de_cabello', 'grueso'),
(34, '¿tiene el cabello lacio?', 'tipo_de_cabello', 'lacio'),
(35, '¿tiene el cabello ondulado?', 'tipo_de_cabello', 'ondulado'),
(36, '¿tiene nada de cabello?', 'tipo_de_cabello', 'nada'),
(37, '¿tiene la piel clara?', 'color_piel', 'clara'),
(38, '¿tiene la piel oscura?', 'color_piel', 'oscura'),
(39, '¿tiene la piel de color?', 'color_piel', 'color'),
(40, '¿se le ve la piel?', 'color_piel', 'desconocido'),
(41, '¿viste de negro?', 'color_vestimenta', 'negro'),
(42, '¿viste de verde?', 'color_vestimenta', 'verde'),
(43, '¿viste de rosa?', 'color_vestimenta', 'rosa'),
(44, '¿viste de blanco?', 'color_vestimenta', 'blanco'),
(45, '¿viste de azul?', 'color_vestimenta', 'azul'),
(46, '¿usa mascara?', 'accesorio', 'mascara'),
(47, '¿usa gorra?', 'accesorio', 'gorra'),
(48, '¿usa sombrero?', 'accesorio', 'sombrero'),
(49, '¿usa zapatos?', 'accesorio', 'zapatos'),
(50, '¿no viste nada?', 'color_vestimenta', 'ninguno'),
(51, '¿es joker?', 'nombre', 'joker'),
(52, '¿es futaba?', 'nombre', 'futaba'),
(53, '¿es haru?', 'nombre', 'haru'),
(54, '¿es kasumi?', 'nombre', 'kasumi'),
(55, '¿es a2?', 'nombre', 'a2'),
(56, '¿es gwen?', 'nombre', 'gwen'),
(57, '¿es dva?', 'nombre', 'dva'),
(58, '¿es cortana?', 'nombre', 'cortana'),
(59, '¿es ash?', 'nombre', 'ash'),
(60, '¿es batman?', 'nombre', 'batman'),
(61, '¿es simon riley?', 'nombre', 'simon riley'),
(62, '¿es jinx?', 'nombre', 'jinx'),
(63, '¿es kratos?', 'nombre', 'kratos'),
(64, '¿es mario?', 'nombre', 'mario'),
(65, '¿es jhon?', 'nombre', 'jhon'),
(66, '¿es packman?', 'nombre', 'packman'),
(67, '¿es samus?', 'nombre', 'samus'),
(68, '¿es steve?', 'nombre', 'steve'),
(69, '¿es toad?', 'nombre', 'toad'),
(70, '¿es vader?', 'nombre', 'vader'),
(71, '¿es yoshi?', 'nombre', 'yoshi'),
(72, '¿es hunter?', 'nombre', 'hunter'),
(74, '¿es big boss?', 'nombre', 'big boss'),
(75, '¿es crono?', 'nombre', 'crono');

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
