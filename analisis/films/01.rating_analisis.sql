-- Participación por rating, y promedio de rental_rate. duration, replacementCost
SELECT
	CASE
		WHEN rating = 'G' THEN 'General audience'
		WHEN rating = 'PG' THEN 'Parental Guidance' 
		WHEN rating = 'R' THEN 'Restricted'
		WHEN rating = 'NC-17' THEN 'No One 17 and Under Admitted'
		WHEN rating = 'PG-13' THEN 'Parents Strongly Cautioned)'
		ELSE 'Without rating' 
	END AS rating_category,
	COUNT(*) AS count_of_movies,
	ROUND(AVG(rental_rate), 2) AS avg_rental,
	ROUND(AVG(length), 1) AS avg_duration,
	ROUND(AVG(replacement_cost), 2) AS avg_replacement_cost,
	ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percent_total
FROM film
GROUP BY 1 ORDER BY count_of_movies DESC;

--
SELECT f.title

FROM payment AS p
INNER JOIN rental AS r
	ON r.rental_id = p.rental_id
INNER JOIN inventory AS i
	ON i.inventory_id = r.inventory_id
INNER JOIN film AS f
	ON f.film_id = i.film_id;




