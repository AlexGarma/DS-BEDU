
CREATE DATABASE IF NOT EXISTS bedu_test;
-- DROP DATABASE IF EXISTS bedu_test;

USE bedu_test;

CREATE TABLE IF NOT EXISTS users (
	id INT PRIMARY KEY,
    gender CHAR(1),
    age VARCHAR(7),
    occupation VARCHAR(21),
    zip_code VARCHAR(20)
);

-- RETO 1

-- Definir los campos y tipos de datos para la tabla movies haciendo uso de los archivos movies.dat y README.

-- Crear la tabla movies (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos).
CREATE TABLE IF NOT EXISTS movies (
	id INT PRIMARY KEY,
    title VARCHAR(50),
    genres VARCHAR(100)
);
-- Definir los campos y tipos de datos para la tabla ratings haciendo uso de los archivos ratings.dat y README.

-- Crear la tabla ratings (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos)
CREATE TABLE IF NOT EXISTS ratings (
	user_id INT,
    movie_id INT,
    rating INT,
    timestamp BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

-- Reto 2
SELECT *
FROM movies
LIMIT 10;

SELECT *
FROM ratings
LIMIT 10;






