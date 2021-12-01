-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-12-2021 a las 18:33:13
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `guess_who`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `asignacion_personaje` ()  BEGIN
SELECT ROUND((RAND() * (24 - 1)) + 1) AS personaje_asignado;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_accesorio` (`id_personaje` INT(10), `par_accesorio` VARCHAR(20)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_accesorio VARCHAR(25) DEFAULT 'who';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.accesorio INTO var_accesorio  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_accesorio = par_accesorio)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_color_cabello` (`id_personaje` INT(10), `par_c_cabello` VARCHAR(30)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_cabello VARCHAR(20) DEFAULT 'desconocido';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.color_cabello INTO var_cabello  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_cabello = par_c_cabello)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_color_piel` (`id_personaje` INT(10), `par_c_piel` VARCHAR(15)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_cPiel VARCHAR(15) DEFAULT 'who';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.color_piel INTO var_cPiel  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_cPiel = par_c_piel)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_color_vestimenta` (`id_personaje` INT(10), `par_cVestimenta` VARCHAR(20)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_cVestimenta VARCHAR(20) DEFAULT 'who';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.color_vestimenta INTO var_cVestimenta  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_cVestimenta = par_cVestimenta)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_genero` (`id_personaje` INT(10), `par_genero` VARCHAR(20)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_genero VARCHAR(20) DEFAULT 'desconocido';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.genero INTO var_genero  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_genero = par_genero)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_letra_nombre` (`id_personaje` INT(10), `par_letras` VARCHAR(20)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_letra VARCHAR(20) DEFAULT 'A y G';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.nombre_letra INTO var_letra  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_letra = par_letras)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_nombre` (`id_personaje` INT(10), `par_nombre` VARCHAR(30)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_nombre VARCHAR(30) DEFAULT 'who';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.nombre INTO var_nombre  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_nombre = par_nombre)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_personaje` (`id_jugador` VARCHAR(20), `id_partida` INT(10), `personaje_nom` VARCHAR(30)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

DECLARE var_personaje varchar(20) DEFAULT '';
DECLARE var_respuesta varchar(30) DEFAULT 'no';
DECLARE var_p1 varchar(20) DEFAULT '';
DECLARE var_p2 varchar(20) DEFAULT '';

SELECT partidas.id_usuario1,partidas.id_usuario2
INTO var_p1,var_p2
FROM partidas
WHERE partidas.id_game=id_partida;

IF(id_jugador=var_p1)
THEN
SELECT personajes.nombre INTO var_personaje
FROM personajes,partidas,usuarios
WHERE usuarios.id_usu=partidas.id_usuario1
and personajes.id=partidas.id_usuario1_personaje
and usuarios.id_usu=id_jugador and partidas.id_game=id_partida;

	IF(personaje_nom=var_personaje)
    THEN
    UPDATE partidas SET partidas.id_usuario_ganador=var_p2 where partidas.id_game=id_partida;
    SET var_respuesta='si';
    END IF;
END IF;

IF(id_jugador=var_p2)
THEN
SELECT personajes.nombre INTO var_personaje
FROM personajes,partidas,usuarios
WHERE usuarios.id_usu=partidas.id_usuario2
and personajes.id=partidas.id_usuario2_personaje
and usuarios.id_usu=id_jugador and partidas.id_game=id_partida;
	IF(personaje_nom=var_personaje)
    THEN
    UPDATE partidas SET partidas.id_usuario_ganador=var_p1 where partidas.id_game=id_partida;
	SET var_respuesta='si';
    END IF;
END IF;

RETURN var_respuesta;


END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_rol` (`id_personaje` INT(10), `par_rol` VARCHAR(20)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_rol VARCHAR(20) DEFAULT 'who';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.rol INTO var_rol  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_rol = par_rol)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_tipo_cabello` (`id_personaje` INT(10), `par_t_cabello` VARCHAR(20)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_tCabello VARCHAR(20) DEFAULT 'who';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.tipo_de_cabello INTO var_tCabello  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_tCabello = par_t_cabello)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `adivinar_videojuego` (`id_personaje` INT(10), `par_juego` VARCHAR(30)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN

  DECLARE var_juego VARCHAR(30) DEFAULT 'xd';
  DECLARE var_res VARCHAR(30) DEFAULT 'no';

  SELECT personajes.titulo_del_videojuego INTO var_juego  FROM personajes WHERE personajes.id = id_personaje;
    
    IF(var_juego = par_juego)
    THEN
    SET var_res='si';
    END IF;

  RETURN var_res;
  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `asignacion_personaje` (`id_partida` INT(10), `id_jugador` VARCHAR(20)) RETURNS INT(10) BEGIN

DECLARE var_id_personaje INT(10) DEFAULT 1;
DECLARE id_p1 VARCHAR(20) DEFAULT '';
DECLARE id_p2 VARCHAR(20) DEFAULT '';

SELECT ROUND((RAND() * (24 - 1)) + 1), partidas.id_usuario1,partidas.id_usuario2
INTO
var_id_personaje,
id_p1,
id_p2
FROM partidas
WHERE partidas.id_game=id_partida;


IF(id_jugador=id_p1)
THEN
 UPDATE partidas SET partidas.id_usuario1_personaje=var_id_personaje WHERE partidas.id_game=id_partida;
END IF;
IF(id_jugador=id_p2)
THEN
 UPDATE partidas SET partidas.id_usuario2_personaje=var_id_personaje WHERE partidas.id_game=id_partida;
END IF;

RETURN var_id_personaje;

END$$

DELIMITER ;

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

--
-- Volcado de datos para la tabla `partidas`
--

INSERT INTO `partidas` (`id_game`, `id_usuario1`, `id_usuario2`, `id_usuario1_personaje`, `id_usuario2_personaje`, `id_usuario_ganador`) VALUES
(0, 'User', 'User', NULL, NULL, NULL);

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
(8, 'cortana', 'A y G', 'negro', 'color', 'lacio', 'halo', 'ninguno', 'mujer', 'villano', 'ninguno', 'cortana_halo.png'),
(9, 'Ash Ketchum', 'A y K', 'Negro', 'Morena', 'Despeinado', 'Pokemon', 'Azul', 'Masculino', 'Heroe', 'Gorra', NULL),
(10, 'Snake', 'S', 'Café', 'Clara', 'Lacio', 'Metal Gear Solid', 'Verde', 'Masculino', 'Heroe', 'Parche', NULL),
(11, 'Chrono', 'C', 'Rojo', 'Clara', 'Despeinado', 'Chrono Trigger', 'Azul', 'Masculino', 'Heroe ', 'Espada', NULL),
(12, 'Hunter', 'H', 'Negro', 'Clara', 'Mohawk', 'Monster Hunter', 'Negra', 'Masculino', 'Heroe', 'Espada', NULL),
(13, 'Powder', 'P', 'Azul', 'Clara', 'Trenzas', 'League of Legends', 'Morada', 'Femenino', 'Villano', 'Armas', NULL),
(14, 'Ghost', 'G', 'Desconocido', 'Desconocido', 'Desconocido', 'Call of Duty', 'Gris', 'Masculino', 'Heroe', 'Armas', NULL),
(15, 'Kratos', 'K', 'Café', 'Clara', 'Desconocido', 'God Of War', 'Café', 'Masculino', 'Heroe', 'Hacha', NULL),
(16, 'Samus Aran', 'S y A', 'Desconocido', 'Desconocido', 'Desconocido', 'Metroid', 'Dorada', 'Desconocido', 'Heroe', 'Arma', NULL);

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
  `id_punt` varchar(10) NOT NULL,
  `total_partidas` int(10) DEFAULT NULL,
  `total_victorias` int(10) DEFAULT NULL,
  `total_derrotas` int(10) DEFAULT NULL,
  `total_puntos` int(10) DEFAULT NULL,
  `Prop_V_D` float(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `puntuaciones`
--

INSERT INTO `puntuaciones` (`id_punt`, `total_partidas`, `total_victorias`, `total_derrotas`, `total_puntos`, `Prop_V_D`) VALUES
('2', 12, 5, 7, 345, 0.00000),
('5', 60, 50, 10, 500, 5.00000),
('7', 0, 0, 0, 0, 0.00000);

--
-- Disparadores `puntuaciones`
--
DELIMITER $$
CREATE TRIGGER `Calcular V_D` BEFORE UPDATE ON `puntuaciones` FOR EACH ROW IF NEW.total_derrotas!=0
THEN
set NEW.Prop_V_D=NEW.total_victorias/NEW.total_derrotas;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usu` varchar(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `id_pais` int(10) DEFAULT NULL,
  `id_puntuacion` varchar(10) DEFAULT NULL,
  `estado_conexion` varchar(2) DEFAULT NULL CHECK (`estado_conexion` in ('C','D')),
  `passwd` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usu`, `nombre`, `id_pais`, `id_puntuacion`, `estado_conexion`, `passwd`) VALUES
('1', 'enma', 1, '2', 'D', 'kuru'),
('3', 'MArio', 1, NULL, NULL, 'JOJO'),
('5', 'Gustavo', 1, '5', 'D', 'GUS'),
('USer', 'User', 1, NULL, 'D', 'PASS');

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `User_Trigger1` BEFORE INSERT ON `usuarios` FOR EACH ROW BEGIN

/*NEW.id_puntuacion=NEW.id_usu;*/
INSERT into puntuaciones
VALUES (NEW.id_usu,0,0,0,0);


SET NEW.id_puntuacion=NEW.id_usu;

END
$$
DELIMITER ;

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
  ADD KEY `id_puntuacion` (`id_puntuacion`) USING BTREE;

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
  ADD CONSTRAINT `FK_USU_PUNTU` FOREIGN KEY (`id_puntuacion`) REFERENCES `puntuaciones` (`id_punt`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
