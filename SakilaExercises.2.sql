-- actores que no han aparecido en ninguna película.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor
FROM actor a
WHERE actor_id NOT IN (SELECT actor_id
		FROM film_actor);

-- películas que tienen más de una hora y media de duración
SELECT title, length
FROM film
WHERE length > time_to_sec('1:30:00') / 60;

-- categorias alquiladas por los clientes
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Customer, ct.name AS Category
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category ct ON ct.category_id = fc.category_id
WHERE c.customer_id = 1 -- Ejem para hallar el conteo
ORDER BY ct.category_id;

-- cantidad de peliculas alquiladas por categoria por cliente
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Customer, ct.name AS Category, COUNT(ct.name) AS Times_rented
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category ct ON ct.category_id = fc.category_id
group by c.customer_id, ct.name
;

-- PENDING
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Customer,
       MAX(CASE WHEN ct.name = 'Action' THEN 'Alquilado' ELSE 'No alquilado' END) AS Action,
       MAX(CASE WHEN ct.name = 'Animation' THEN 'Alquilado' ELSE 'No alquilado' END) AS Animation,
       MAX(CASE WHEN ct.name = 'Children' THEN 'Alquilado' ELSE 'No alquilado' END) AS Children,
       MAX(CASE WHEN ct.name = 'Classics' THEN 'Alquilado' ELSE 'No alquilado' END) AS Classics,
       MAX(CASE WHEN ct.name = 'Comedy' THEN 'Alquilado' ELSE 'No alquilado' END) AS Comedy,
       MAX(CASE WHEN ct.name = 'Documentary' THEN 'Alquilado' ELSE 'No alquilado' END) AS Documentary,
       MAX(CASE WHEN ct.name = 'Drama' THEN 'Alquilado' ELSE 'No alquilado' END) AS Drama,
       MAX(CASE WHEN ct.name = 'Family' THEN 'Alquilado' ELSE 'No alquilado' END) AS Family,
       MAX(CASE WHEN ct.name = 'Foreign' THEN 'Alquilado' ELSE 'No alquilado' END) AS 'Foreign',
       MAX(CASE WHEN ct.name = 'Games' THEN 'Alquilado' ELSE 'No alquilado' END) AS Games,
       MAX(CASE WHEN ct.name = 'Horror' THEN 'Alquilado' ELSE 'No alquilado' END) AS Horror,
       MAX(CASE WHEN ct.name = 'Music' THEN 'Alquilado' ELSE 'No alquilado' END) AS Music
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category ct ON ct.category_id = fc.category_id
WHERE c.first_name like '%JANE%'
GROUP BY c.customer_id
;

-- películas que han sido alquiladas más de 5 veces en un solo día


/*
Obtener una lista de los .
Obtener una lista de las películas que han sido alquiladas más de 5 veces en un solo día.
Obtener una lista de los clientes que alquilaron una película en el mismo día en que se registraron como clientes.
Obtener una lista de las películas que nunca han sido alquiladas en un mes determinado.
Obtener una lista de los clientes que alquilaron al menos 10 películas en un mes determinado.
Obtener una lista de las películas que han sido alquiladas por el mismo cliente más de una vez en un día determinado.
Obtener una lista de los actores que aparecen en las películas más populares (es decir, las que se alquilaron más veces).
Obtener una lista de las categorías de películas que han sido alquiladas más veces en un mes determinado.
Obtener una lista de los clientes que han alquilado todas las películas de un actor determinado.
Obtener una lista de los clientes que alquilaron una película en su fecha de cumpleaños.
Obtener una lista de las películas que nunca han sido alquiladas por un cliente que ha alquilado al menos 10 películas en total.*/