CREATE DATABASE netflix;

USE netflix;

CREATE TABLE movies(
idMovies int auto_increment primary key not null,
title varchar(45) not null,
genre varchar(45) not null,
image varchar(1000) not null,
category varchar(45) not null,
year int 
);

CREATE TABLE users(
idUser int auto_increment primary key not null,
user varchar(45) not null,
password varchar(45) not null,
name varchar(45) not null,
email varchar(45) not null,
plan_details varchar(45) not null
);



CREATE TABLE actors(
idActor int auto_increment primary key not null,
name varchar(45) not null,
lastname varchar(45) not null,
country varchar(45) not null,
birthday date
);

INSERT INTO actors (name, lastname, country, birthday)
VALUES ('Tom', 'Hanks', 'Estados Unidos', '1956-07-09'),
('Roberto', 'Benigni', 'Italia', '1952-10-27'),
('John', 'Travolta', 'Estados Unidos', '1954-02-18');

INSERT INTO movies (title, genre, image, category, year)
VALUES 
('Pulp Fiction', 'Crimen', 'https://pics.filmaffinity.com/pulp_fiction-210382116-large.jpg', 'Top 10', 1994),
('La Vita è Bella', 'Comedia', 'https://pics.filmaffinity.com/la_vita_e_bella-646167341-mmed.jpg', 'Top 10', 1996),
('Forrest Gump', 'Comedia', 'https://pics.filmaffinity.com/forrest_gump-212765827-mmed.jpg', 'Top 10', 1994);

INSERT INTO users (user, password, name, email, plan_details)
VALUES
('laura_dev', 'laura', 'Laura', 'laura@gmail.com', 'Standard'),
('maria_dev', 'maria', 'Maria', 'maria@gmail.com', 'Standard'),
('ester_dev', 'ester', 'Ester', 'ester@gmail.com', 'Standard');

SELECT * FROM actors;
SELECT * FROM users;
SELECT * FROM movies;

SELECT title, genre FROM movies WHERE year>1990;
SELECT * FROM movies WHERE category='Top 10';

UPDATE movies SET year=1997 WHERE idMovies=2;

SELECT * FROM actors;

SELECT * FROM actors WHERE birthday BETWEEN '1950-01-01' and '1960-12-31';

DELETE FROM users WHERE idUser BETWEEN 1 and 3;

SELECT name, lastname FROM actors WHERE country = 'Estados Unidos';

SELECT * FROM users WHERE plan_details = 'Standard';

DELETE FROM users WHERE name LIKE 'M%' AND idUser > 0;
DELETE FROM users WHERE idUser=2;

CREATE TABLE users_has_movies(
fk_users INT,
fk_movies INT,
CONSTRAINT fk_users FOREIGN KEY (fk_users) REFERENCES users(idUser),
CONSTRAINT fk_movies FOREIGN KEY (fk_movies) REFERENCES movies(idMovies),
PRIMARY KEY (fk_users, fk_movies)
);

INSERT INTO users_has_movies(fk_users, fk_movies)
VALUES
(4,1),
(4,2),
(5,2);

CREATE TABLE actors_has_movies(
fk_actors INT,
FOREIGN KEY (fk_actors) REFERENCES actors(idActor),
fk_movies INT,
FOREIGN KEY (fk_movies) REFERENCES movies(idMovies),
PRIMARY KEY (fk_actors, fk_movies)
);

-- Cuantas peliculas favoritas tiene cada usuario
SELECT COUNT(fk_movies) AS peliculas_favoritas, users.name AS usuario
FROM users_has_movies
INNER JOIN users
ON users.idUser = users_has_movies.fk_users
GROUP BY fk_users;

-- Usuario con mayor cantidad de películas favoritas
SELECT users.name, COUNT(fk_movies) AS peliculas_favoritas, users.name AS usuario
FROM users_has_movies
INNER JOIN users
ON users.idUser = users_has_movies.fk_users
GROUP BY fk_users





















