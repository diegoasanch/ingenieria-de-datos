-- 1. Listar las 10 habilidades que mas participaron en competencias del Entrenador XXX
DECLARE @EntrenadorID int = 1;
SELECT TOP 10 h.nombre, COUNT(*) AS numero_de_participaciones
FROM Habilidad h
JOIN HabilidadPokemon hp ON h.habilidad_id = hp.habilidad_id
JOIN Pokemon p ON hp.pokemon_id = p.pokemon_id
JOIN Equipo e ON p.equipo_id = e.equipo_id
JOIN Entrenador e2 ON e.lider_entrenador_id = e2.entrenador_id
WHERE e2.entrenador_id = @EntrenadorID
GROUP BY h.nombre
ORDER BY numero_de_participaciones DESC;


-- 2. Actualizar los participantes de un equipo si un integrante es descalificado
--
-- La estructura actual de la DB no registra si un entrenador integrante de un equipo
-- esta clasificado o no. Para soportarlo podemos agregar una columna `calificado`
-- de tipo `BIT` a la tabla `Entrenador` para llevar registro de la misma.
ALTER TABLE Entrenador ADD calificado BIT NOT NULL DEFAULT 0;
-- Y luego para modificar un integrante descalificado:
DECLARE @EntrenadorId int = 1;
UPDATE Entrenador SET calificado = 0 WHERE entrenador_id = @EntrenadorId;


-- 3. Mostrar por pantalla cuando finaliza una batalla y que equipo es el ganador
DECLARE @BatallaID int = 1;
SELECT 'La batalla ' + CAST(@BatallaID AS varchar) + ' ha finalizado. El equipo ganador es: ' + CAST(ganador_id AS varchar)
FROM Batalla
WHERE batalla_id = @BatallaID;


-- 4. Calcular el Líder mas ganador y mostrar cuantas batallas realizo
SELECT TOP 1 lider_entrenador_id, COUNT(*) AS numero_de_batallas
FROM Equipo e
JOIN Batalla b ON e.equipo_id = b.ganador_id
GROUP BY lider_entrenador_id
ORDER BY numero_de_batallas DESC;


-- 5. Cuantas medallas tiene el gimnasio XXX
DECLARE @GimnasioID int = 1;
SELECT COUNT(*) AS cantidad_de_medallas
FROM Medalla
WHERE gimnasio_id = @GimnasioID;


-- 6. Cuales son los tipos de daños que realiza la habilidad XXX
--
-- En la estructura actual de la DB cada Habilidad realiza un unico tipo de daño.
-- Una alternativa es conocer los tipos de daño de que puede realizar un Pokemon
DECLARE @PokemonId int = 1;
SELECT h.nombre
FROM Habilidad h
JOIN HabilidadPokemon hp ON h.habilidad_id = hp.habilidad_id
WHERE hp.pokemon_id = @PokemonId;


-- 7. Calcular el puntaje del entrenador XXX para las batallas XXX
--
-- Asumimos que cada batalla ganada le suma un punto a favor al entrenador
DECLARE @EntrenadorID int = 1;
DECLARE @Batallas TABLE (BatallaID int); -- Tabla temporal para almacenar IDs de batallas
INSERT INTO @Batallas (BatallaID) VALUES (1), (2), (3);

SELECT e.nombre, COUNT(*) AS puntaje_total
FROM Entrenador e
JOIN Equipo eq ON e.equipo_id = eq.equipo_id
JOIN Batalla b ON b.ganador_id = eq.equipo_id
JOIN @Batallas bt ON b.batalla_id = bt.BatallaID
WHERE e.entrenador_id = @EntrenadorID
GROUP BY e.nombre;


-- 8. Mostrar los 10 personajes mas utilizados y cuantas batallas ganó cada uno
--
-- Para saber que Pokemon participo en cada batalla debemos crear una nueva tabla `PokemonBatalla`
CREATE TABLE PokemonBatalla (
  PokemonBatallaID int NOT NULL PRIMARY KEY IDENTITY(1,1),
  pokemon_id int NOT NULL,
  batalla_id int NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES Pokemon(pokemon_id),
  FOREIGN KEY (batalla_id) REFERENCES Batalla(batalla_id)
);
-- Luego el query
SELECT TOP 10 p.nombre, COUNT(b.batalla_id) AS numero_de_victorias
FROM Pokemon p
JOIN PokemonBatalla pb ON p.pokemon_id = pb.pokemon_id
JOIN Batalla b ON pb.batalla_id = b.batalla_id AND b.ganador_id = (
  SELECT equipo_id FROM Equipo WHERE lider_entrenador_id = (
    SELECT entrenador_id FROM Entrenador WHERE equipo_id = p.equipo_id
  )
)
GROUP BY p.nombre
ORDER BY numero_de_victorias DESC;


-- 9. Cuántos Gimnasios tienen más de XXX medallas del tipo XXX
DECLARE @NumeroMedallas int = 1;
DECLARE @TipoMedalla varchar(255) = 'Trueno';
SELECT COUNT(DISTINCT g.gimnasio_id) AS cantidad_gimnasios
FROM Gimnasio g
JOIN Medalla m ON g.gimnasio_id = m.gimnasio_id
JOIN ObtencionMedalla om ON m.medalla_id = om.obtencion_medalla_id
WHERE m.nombre = @TipoMedalla
GROUP BY g.gimnasio_id
HAVING COUNT(m.medalla_id) > @NumeroMedallas;


-- 10. Cuando la salud de un personaje está por debajo de XXX mostrar una alerta por pantalla
DECLARE @SaludUmbral int = 10;
SELECT 'Alerta: El personaje ' + p.nombre + ' tiene salud baja: ' + CAST(p.salud AS varchar)
FROM Pokemon p
WHERE p.salud < @SaludUmbral;


-- 11. Mostrar los gimnasios de la ciudad XXX y cuántas medallas y de qué tipo tiene cada uno
DECLARE @CiudadID int = 1;
SELECT g.nombre AS nombre_gimnasio, m.nombre AS tipo_medalla, COUNT(m.medalla_id) AS cantidad_medallas
FROM Gimnasio g
JOIN Medalla m ON g.gimnasio_id = m.gimnasio_id
WHERE g.ciudad_id = @CiudadID
GROUP BY g.nombre, m.nombre;


-- 12. Mostrar las batallas del entrenador XXX en el periodo XXX
DECLARE @EntrenadorID int = 1;
DECLARE @FechaInicio datetime = '2020-04-20';
DECLARE @FechaFin datetime = '2023-11-22';
SELECT b.*
FROM Batalla b
JOIN Equipo e ON b.ganador_id = e.equipo_id OR b.perdedor_id = e.equipo_id
JOIN Entrenador e2 ON e.lider_entrenador_id = e2.entrenador_id
WHERE e2.entrenador_id = @EntrenadorID
AND b.fecha BETWEEN @FechaInicio AND @FechaFin;


-- 13. Cambiar la potencia XXX de la habilidad XXX cuando el personaje que tiene dicha habilidad gane 10 batallas
DECLARE @NuevaPotencia int = 50;
DECLARE @HabilidadID int = 1;
UPDATE Habilidad
SET potencia = @NuevaPotencia
WHERE habilidad_id = @HabilidadID
AND (
  SELECT COUNT(*) FROM Batalla b
  JOIN HabilidadPokemon hp ON hp.habilidad_id = @HabilidadID
  JOIN PokemonBatalla pb ON pb.pokemon_id = hp.pokemon_id
  WHERE b.ganador_id IN (
    SELECT equipo_id FROM Pokemon WHERE pokemon_id = pb.pokemon_id
  ) AND pb.batalla_id = b.batalla_id
) >= 10;


-- 14. Mostrar los entrenadores con mayor cantidad de puntaje en el período XXXX
DECLARE @FechaInicio datetime = '2020-04-20';
DECLARE @FechaFin datetime = '2023-11-22';
SELECT e.nombre, SUM(CASE WHEN b.ganador_id = e.equipo_id THEN 1 ELSE 0 END) AS puntaje_total
FROM Entrenador e
JOIN Equipo eq ON e.equipo_id = eq.equipo_id
JOIN Batalla b ON b.ganador_id = eq.equipo_id AND b.fecha BETWEEN @FechaInicio AND @FechaFin
GROUP BY e.nombre
ORDER BY puntaje_total DESC;


-- 15. Mostrar los 10 Pokémon con mayor aumento de nivel en el período XXX
--
-- La estructura actual de la DB no registra los aumentos de nivel de cada pokemon, para ello
-- debemos crear una nueva tabla CambioNivel que registre cada transicion de nivel y su fecha
CREATE TABLE CambioNivel (
  CambioNivelID int NOT NULL PRIMARY KEY IDENTITY(1,1),
  pokemon_id int NOT NULL,
  nivel_anterior int NOT NULL,
  nuevo_nivel int NOT NULL,
  fecha_cambio datetime NOT NULL,
  FOREIGN KEY (pokemon_id) REFERENCES Pokemon(pokemon_id)
);
-- Y la query
DECLARE @FechaInicio datetime = '2020-04-20';
DECLARE @FechaFin datetime = '2023-11-22';
SELECT TOP 10 p.nombre, (MAX(cn.nuevo_nivel) - MIN(cn.nivel_anterior)) AS aumento_de_nivel
FROM Pokemon p
JOIN CambioNivel cn ON p.pokemon_id = cn.pokemon_id
WHERE cn.fecha_cambio BETWEEN @FechaInicio AND @FechaFin
GROUP BY p.nombre
ORDER BY aumento_de_nivel DESC;


-- 16. Armar ranking de los 3 mejores entrenadores y que se actualice automáticamente luego de cada batalla
--
-- Creamos un stored procedure que arma el ranking con la ultima data de las batallas realizadas, cada vez
-- que una nueva batalla haya sido agregada esta stored procedure la usara para armar el raking
CREATE PROCEDURE sp_GetTop3Entrenadores
AS
BEGIN
  SELECT TOP 3 e.entrenador_id, e.nombre, COUNT(*) AS numero_de_victorias
  FROM Entrenador e
  JOIN Equipo eq ON e.equipo_id = eq.equipo_id
  JOIN Batalla b ON b.ganador_id = eq.equipo_id
  GROUP BY e.entrenador_id, e.nombre
  ORDER BY numero_de_victorias DESC;
END;
-- Para ejecutar el procedure usamos
EXEC sp_GetTop3Entrenadores;


-- 17. Mostrar cuál es el promedio de batallas ganadas del entrenador XXX en el período XXX
--
-- En este contexto un promedio de batallas ganadas no tiene mucho sentido ya que cada victoria
-- suma un unico punto y estamos hablando de un entrenador y rango de tiempo, definidos.
-- Una metrica que podemos calcular es la cantidad total de victorias en dicho periodo
DECLARE @EntrenadorID int = 1;
DECLARE @FechaInicio datetime = '2020-04-20';
DECLARE @FechaFin datetime = '2023-11-22';

SELECT e.nombre, COUNT(*) AS total_victorias
FROM Entrenador e
JOIN Equipo eq ON e.equipo_id = eq.equipo_id
JOIN Batalla b ON b.ganador_id = eq.equipo_id
WHERE e.entrenador_id = @EntrenadorID AND b.fecha BETWEEN @FechaInicio AND @FechaFin
GROUP BY e.nombre;


-- 18. Listar las 10 habilidades que tienen mayor probabilidad de acierto y cuántas veces fueron efectivas en una batalla
--
-- Para saber cuando una habilidad fue efectiva en batalla debemos crear una nueva tabla HabilidadPokemonBatalla
-- que registre cuando la habilidad de un pokemon fue usada en batalla y si fue efectiva o no
CREATE TABLE HabilidadPokemonBatalla (
  HabilidadPokemonBatallaID int NOT NULL PRIMARY KEY IDENTITY(1,1),
  habilidad_pokemon_id int NOT NULL,
  batalla_id int NOT NULL,
  fue_efectiva BIT NOT NULL,
  FOREIGN KEY (habilidad_pokemon_id) REFERENCES HabilidadPokemon(habilidad_pokemon_id),
  FOREIGN KEY (batalla_id) REFERENCES Batalla(batalla_id)
);
-- query
SELECT TOP 10 h.nombre, h.precision_de_acierto, COUNT(hpb.habilidad_pokemon_id) AS veces_efectivas
FROM Habilidad h
JOIN HabilidadPokemon hp ON h.habilidad_id = hp.habilidad_id
JOIN HabilidadPokemonBatalla hpb ON hp.habilidad_pokemon_id = hpb.habilidad_pokemon_id AND hpb.fue_efectiva = 1
GROUP BY h.nombre, h.precision_de_acierto
ORDER BY h.precision_de_acierto DESC, veces_efectivas DESC;



-- 19. Mostrar los 5 líderes con menos victoria de la ciudad XXX
DECLARE @CiudadID int = 1;
SELECT TOP 5 e.nombre, COUNT(b.batalla_id) AS numero_de_victorias
FROM Entrenador e
JOIN Equipo eq ON e.entrenador_id = eq.lider_entrenador_id
JOIN Batalla b ON eq.equipo_id = b.ganador_id
JOIN Gimnasio g ON eq.gimnasio_id = g.gimnasio_id
WHERE g.ciudad_id = @CiudadID
GROUP BY e.nombre
ORDER BY numero_de_victorias ASC;


-- 20. Cuántos personajes hay de la especie XXX que hayan ganado más de XXX batallas
DECLARE @Especie varchar(255) = 'Pikachu'
DECLARE @NumeroDeVictorias int = 10;
SELECT COUNT(DISTINCT p.pokemon_id) AS cantidad_personajes
FROM Pokemon p
JOIN Equipo eq ON p.equipo_id = eq.equipo_id
JOIN Batalla b ON eq.equipo_id = b.ganador_id
WHERE p.especie = @Especie
GROUP BY p.especie
HAVING COUNT(b.batalla_id) > @NumeroDeVictorias;
