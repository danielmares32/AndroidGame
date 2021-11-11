-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-11-2021 a las 16:02:44
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int(10) NOT NULL,
  `pregunta` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
