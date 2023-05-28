-- lista de actores y el título de la película en la que han actuado
SELECT concat(first_name, ' ', last_name) AS Actor, film.title
FROM actor 
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

-- título de las películas y sus respectivas categorías
SELECT film.title, category.name AS Category
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON category.category_id = film_category.category_id;

-- lista de todas las categorías y las películas asociadas a cada una
SELECT category.name Category, film.title
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film
ON film.film_id = film_category.film_id;

-- actores que han actuado en películas de la categoría "Comedy"
SELECT DISTINCT(CONCAT(first_name, ' ', last_name)) as Actor
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE(
SELECT category_id
FROM category
WHERE category.name LIKE 'Comedy');

-- actores y la cantidad de películas en las que han actuado, ordenados por la cantidad de películas de forma descendente
SELECT CONCAT(actor.first_name, ' ',actor.last_name) AS 'Actor', COUNT(film_id) AS Movies
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
group by film_actor.actor_id
ORDER BY Movies DESC;

-- lista de películas y la cantidad de actores que han participado en cada una, mostrando solo las películas con más de 5 actores
SELECT title, COUNT(film_actor.actor_id) AS Actors
FROM film
INNER JOIN film_actor
ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id
HAVING Actors > 5;

-- 7 categorías de películas que no tienen ninguna película asociada
SELECT name
FROM category
WHERE category_id NOT IN (SELECT category_id
		FROM film_category);

-- 8 nombres de los actores que han trabajado juntos en al menos una película, ordenados alfabéticamente
SELECT CONCAT(a.first_name, ' ', a.last_name)
FROM actor a
INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id
;

SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS Actor1, CONCAT(a2.first_name, ' ', a2.last_name) AS Actor2
FROM film_actor fa1
INNER JOIN film_actor fa2 
	ON fa1.film_id = fa2.film_id
INNER JOIN actor a1 
	ON fa1.actor_id = a1.actor_id
INNER JOIN actor a2 
	ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id <> a2.actor_id
ORDER BY Actor1, Actor2;

-- 9 películas que no han sido asignadas a ninguna categoría
SELECT title
FROM film f
WHERE f.film_id NOT IN (SELECT film_id
		FROM film_category);