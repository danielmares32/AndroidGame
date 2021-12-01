-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 01, 2021 at 12:42 PM
-- Server version: 8.0.27-0ubuntu0.20.04.1
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `guess_who`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_puntuacion_derrota` (IN `id_puntuacion` VARCHAR(20))  BEGIN

UPDATE puntuaciones SET puntuaciones.total_partidas=puntuaciones.total_partidas+1,
puntuaciones.total_derrotas=puntuaciones.total_derrotas+1
WHERE puntuaciones.id_punt=id_puntuacion;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_puntuacion_victoria` (IN `id_puntuacion` VARCHAR(20))  BEGIN

UPDATE puntuaciones SET puntuaciones.total_partidas=puntuaciones.total_partidas+1,
puntuaciones.total_victorias=puntuaciones.total_victorias+1,
puntuaciones.total_puntos=puntuaciones.total_puntos+100
WHERE puntuaciones.id_punt=id_puntuacion;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignacion_personaje` ()  BEGIN
SELECT ROUND((RAND() * (24 - 1)) + 1) AS personaje_asignado;
END$$

--
-- Functions
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

CREATE DEFINER=`root`@`localhost` FUNCTION `asignacion_personaje` (`id_partida` INT(10), `id_jugador` VARCHAR(20)) RETURNS INT BEGIN

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
 UPDATE partidas SET partidas.id_usuario2_personaje=var_id_personaje WHERE partidas.id_game=id_partida;
END IF;
IF(id_jugador=id_p2)
THEN
 UPDATE partidas SET partidas.id_usuario1_personaje=var_id_personaje WHERE partidas.id_game=id_partida;
END IF;

RETURN var_id_personaje;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `paises`
--

CREATE TABLE `paises` (
  `id_p` int NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `abreviacion` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `paises`
--

INSERT INTO `paises` (`id_p`, `nombre`, `abreviacion`) VALUES
(1, 'mexico', 'mex');

-- --------------------------------------------------------

--
-- Table structure for table `partidas`
--

CREATE TABLE `partidas` (
  `id_game` int NOT NULL,
  `id_usuario1` varchar(20) DEFAULT NULL,
  `id_usuario2` varchar(20) DEFAULT NULL,
  `id_usuario1_personaje` int DEFAULT NULL,
  `id_usuario2_personaje` int DEFAULT NULL,
  `id_usuario_ganador` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `partidas`
--

INSERT INTO `partidas` (`id_game`, `id_usuario1`, `id_usuario2`, `id_usuario1_personaje`, `id_usuario2_personaje`, `id_usuario_ganador`) VALUES
(1, 'dany1', 'mario1', 9, 11, '0'),
(2, 'dany1', 'Mario1', 19, 12, '0'),
(3, 'Mario1', 'dany1', 11, 21, '0'),
(4, 'dany1', 'Mario1', 11, 1, '0'),
(5, 'dany1', 'Mario1', 4, 3, NULL),
(6, 'dany1', 'Mario1', 19, 21, '0');

-- --------------------------------------------------------

--
-- Table structure for table `personajes`
--

CREATE TABLE `personajes` (
  `id` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `personajes`
--

INSERT INTO `personajes` (`id`, `nombre`, `nombre_letra`, `color_cabello`, `color_piel`, `tipo_de_cabello`, `titulo_del_videojuego`, `color_vestimenta`, `genero`, `rol`, `accesorio`, `imagen`) VALUES
(1, 'joker', 'H y P', 'negro', 'clara', 'grueso', 'persona 5', 'negro', 'masculino', 'heroe', 'ninguno', 'joker_p5.png'),
(2, 'futaba', 'A y G', 'naranja', 'clara', 'lacio', 'persona 5', 'verde', 'femenino', 'heroe', 'ninguno', 'futaba_p5.png'),
(3, 'haru', 'H y P', 'cafe', 'clara', 'ondulado', 'persona 5', 'rosa', 'femenino', 'heroe', 'ninguno', 'haru_p5.jpg'),
(4, 'kasumi', 'H y P', 'rojo', 'clara', 'lacio', 'persona 5', 'negro', 'femenino', 'heroe', 'ninguno', 'kasumi_p5.png'),
(5, 'a2', 'A y G', 'blanco', 'clara', 'lacio', 'nier automata', 'negro', 'femenino', 'heroe', 'ninguno', 'a2_nier.png'),
(6, 'gwen', 'A y G', 'azul', 'clara', 'ondulado', 'league of legends', 'blanca', 'femenino', 'heroe', 'ninguno', 'gwenLol.png'),
(7, 'dva', 'A y G', 'cafe', 'clara', 'grueso', 'overwatch', 'azul', 'femenino', 'heroe', 'ninguno', 'Dva_overwatch.png'),
(8, 'cortana', 'A y G', 'negro', 'color', 'lacio', 'halo', 'ninguno', 'femenino', 'villano', 'ninguno', 'cortana_halo.png'),
(9, 'ash ketchum', 'A y K', 'negro', 'oscura', 'despeinado', 'pokemon', 'azul', 'masculino', 'heroe', 'gorra', NULL),
(10, 'snake', 'Q y Z', 'cafe', 'clara', 'lacio', 'metal gear solid', 'verde', 'masculino', 'heroe', 'parche', NULL),
(11, 'chrono', 'A y G', 'rojo', 'clara', 'despeinado', 'chrono trigger', 'azul', 'masculino', 'heroe ', 'espada', NULL),
(12, 'hunter', 'H y P', 'negro', 'clara', 'mohawk', 'monster hunter', 'negro', 'masculino', 'heroe', 'espada', NULL),
(13, 'powder', 'H y P', 'azul', 'clara', 'trenzas', 'league of legends', 'morada', 'femenino', 'villano', 'armas', NULL),
(14, 'ghost', 'A y G', 'desconocido', 'desconocido', 'desconocido', 'call of duty', 'gris', 'masculino', 'heroe', 'armas', NULL),
(15, 'kratos', 'H y P', 'cafe', 'clara', 'desconocido', 'god of war', 'cafe', 'masculino', 'heroe', 'hacha', NULL),
(16, 'samus', 'Q y Z', 'amarillo', 'clara', 'desconocido', 'metroid', 'dorada', 'femenino', 'heroe', 'arma', NULL),
(17, 'mario', 'H y P', 'castano', 'clara', 'desconocido', 'mario party', 'azul', 'masculino', 'heroe', 'gorra', NULL),
(18, 'toad', 'Q y Z', 'rojo', 'clara', 'desconocido', 'mario party', 'blanca', 'masculino', 'heroe', 'gorra', NULL),
(19, 'yoshi', 'Q y Z', 'verde', 'verde', 'lacio', 'mario party', 'ninguno', 'masculino', 'heroe', 'ninguno', NULL),
(20, 'masterchief', 'H y P', 'desconocido', 'desconocido', 'desconocido', 'halo', 'verde', 'masculino', 'heroe', 'armas', NULL),
(21, 'steve', 'Q y Z', 'cafe', 'clara', 'grueso', 'minecraft', 'blanca', 'masculino', 'heroe', 'ninguno', NULL),
(22, 'vader', 'Q y Z', 'desconocido', 'desconocido', 'desconocido', 'starwars', 'negra', 'masculino', 'villano', 'armas', NULL),
(23, 'pacman', 'H y P', 'ninguno', 'amarilla', 'ninguno', 'pacman', 'ninguno', 'masculino', 'heroe', 'ninguno', NULL),
(24, 'batman', 'A y G', 'desconocido', 'clara', 'desconocido', 'batman', 'negra', 'masculino', 'heroe', 'ninguno', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int NOT NULL,
  `pregunta` varchar(150) DEFAULT NULL,
  `categoria` varchar(30) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `preguntas`
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
(18, '¿es hombre?', 'genero', 'masculino'),
(19, '¿es mujer?', 'genero', 'femenino'),
(20, '¿es de genero desconocido?', 'genero', 'desconocido'),
(21, '¿es heroe?', 'rol', 'heroe'),
(22, '¿es villano?', 'rol', 'villano'),
(23, '¿la primer letra del nombre esta entre A y G?', 'nombre_letra', 'A y G'),
(24, '¿la primer letra del nombre esta entre H y P?', 'nombre_letra', 'H y P'),
(25, '¿la primer letra del nombre esta entre Q y G?', 'nombre_letra', 'Q y Z'),
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
(61, '¿es ghost?', 'nombre', 'ghost'),
(62, '¿es powder?', 'nombre', 'powder'),
(63, '¿es kratos?', 'nombre', 'kratos'),
(64, '¿es mario?', 'nombre', 'mario'),
(65, '¿es jhon?', 'nombre', 'jhon'),
(66, '¿es pacman?', 'nombre', 'pacman'),
(67, '¿es samus?', 'nombre', 'samus'),
(68, '¿es steve?', 'nombre', 'steve'),
(69, '¿es toad?', 'nombre', 'toad'),
(70, '¿es vader?', 'nombre', 'vader'),
(71, '¿es yoshi?', 'nombre', 'yoshi'),
(72, '¿es hunter?', 'nombre', 'hunter'),
(74, '¿es snake?', 'nombre', 'snake'),
(75, '¿es chrono?', 'nombre', 'chrono');

-- --------------------------------------------------------

--
-- Table structure for table `puntuaciones`
--

CREATE TABLE `puntuaciones` (
  `id_punt` varchar(20) NOT NULL,
  `total_partidas` int DEFAULT NULL,
  `total_victorias` int DEFAULT NULL,
  `total_derrotas` int DEFAULT NULL,
  `total_puntos` int DEFAULT NULL,
  `Prop_V_D` float(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `puntuaciones`
--

INSERT INTO `puntuaciones` (`id_punt`, `total_partidas`, `total_victorias`, `total_derrotas`, `total_puntos`, `Prop_V_D`) VALUES
('0', 0, 0, 0, 0, 0.00000),
('2', 12, 5, 7, 345, 0.00000),
('7', 14, 7, 7, 700, 0.00000),
('8', 2, 0, 2, 0, 0.00000),
('dany1', 5, 3, 2, 300, 1.50000),
('enma1', 0, 0, 0, 0, 0.00000),
('jose1', 0, 0, 0, 0, 0.00000),
('mario1', 4, 1, 3, 100, 0.33333);

--
-- Triggers `puntuaciones`
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
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usu` varchar(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `id_pais` int DEFAULT NULL,
  `id_puntuacion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `estado_conexion` varchar(2) DEFAULT NULL,
  `passwd` varchar(30) NOT NULL
) ;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id_usu`, `nombre`, `id_pais`, `id_puntuacion`, `estado_conexion`, `passwd`) VALUES
('dany1', 'Daniel', 1, 'dany1', 'D', 'hola'),
('enma1', 'Enmanuel', 1, 'enma1', 'D', 'hola'),
('jose1', 'Jose', 1, 'jose1', 'D', 'hola'),
('mario1', 'Mario', 1, 'mario1', 'D', 'hola');

--
-- Triggers `usuarios`
--
DELIMITER $$
CREATE TRIGGER `User_Trigger1` BEFORE INSERT ON `usuarios` FOR EACH ROW BEGIN

/*NEW.id_puntuacion=NEW.id_usu;*/
INSERT into puntuaciones
VALUES (NEW.id_usu,0,0,0,0,0.0);


SET NEW.id_puntuacion=NEW.id_usu;

END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_p`);

--
-- Indexes for table `partidas`
--
ALTER TABLE `partidas`
  ADD PRIMARY KEY (`id_game`),
  ADD KEY `FK_USU1_PART` (`id_usuario1`),
  ADD KEY `FK_USU2_PART` (`id_usuario2`),
  ADD KEY `FK_PER1_PART` (`id_usuario1_personaje`),
  ADD KEY `FK_PER2_PART` (`id_usuario2_personaje`);

--
-- Indexes for table `personajes`
--
ALTER TABLE `personajes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id_pregunta`);

--
-- Indexes for table `puntuaciones`
--
ALTER TABLE `puntuaciones`
  ADD PRIMARY KEY (`id_punt`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usu`),
  ADD KEY `FK_USU_PAIS` (`id_pais`),
  ADD KEY `id_puntuacion` (`id_puntuacion`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `partidas`
--
ALTER TABLE `partidas`
  MODIFY `id_game` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `partidas`
--
ALTER TABLE `partidas`
  ADD CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`id_usuario1`) REFERENCES `usuarios` (`id_usu`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `partidas_ibfk_2` FOREIGN KEY (`id_usuario2`) REFERENCES `usuarios` (`id_usu`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `partidas_ibfk_3` FOREIGN KEY (`id_usuario1_personaje`) REFERENCES `personajes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `partidas_ibfk_4` FOREIGN KEY (`id_usuario2_personaje`) REFERENCES `personajes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_p`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_puntuacion`) REFERENCES `puntuaciones` (`id_punt`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
