-- actores que no han aparecido en ninguna película.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor
FROM actor a
WHERE actor_id NOT IN (SELECT actor_id
		FROM film_actor);
        
-- actores que aparecen en las películas más rentadas
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name, COUNT(r.rental_id) AS rental_count
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY a.actor_id, actor_name
ORDER BY rental_count DESC;


        
