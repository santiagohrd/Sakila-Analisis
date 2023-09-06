-- actores que no han aparecido en ninguna película.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor
FROM actor a
WHERE actor_id NOT IN (SELECT actor_id
		FROM film_actor);
        
