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

-- Cantidad de peliculas alquiladas por categoria por cliente
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Customer,
       COUNT(CASE WHEN ct.name = 'Action' THEN 'Alquilado' ELSE NULL END) AS Action,
       COUNT(CASE WHEN ct.name = 'Animation' THEN 'Alquilado' ELSE NULL END) AS Animation,
       COUNT(CASE WHEN ct.name = 'Children' THEN 'Alquilado' ELSE NULL END) AS Children,
       COUNT(CASE WHEN ct.name = 'Classics' THEN 'Alquilado' ELSE NULL END) AS Classics,
       COUNT(CASE WHEN ct.name = 'Comedy' THEN 'Alquilado' ELSE NULL END) AS Comedy,
       COUNT(CASE WHEN ct.name = 'Documentary' THEN 'Alquilado' ELSE NULL END) AS Documentary,
       COUNT(CASE WHEN ct.name = 'Drama' THEN 'Alquilado' ELSE NULL END) AS Drama,
       COUNT(CASE WHEN ct.name = 'Family' THEN 'Alquilado' ELSE NULL END) AS Family,
       COUNT(CASE WHEN ct.name = 'Foreign' THEN 'Alquilado' ELSE NULL END) AS 'Foreign',
       COUNT(CASE WHEN ct.name = 'Games' THEN 'Alquilado' ELSE NULL END) AS Games,
       COUNT(CASE WHEN ct.name = 'Horror' THEN 'Alquilado' ELSE NULL END) AS Horror,
       COUNT(CASE WHEN ct.name = 'Music' THEN 'Alquilado' ELSE NULL END) AS Music,
       COUNT(CASE WHEN ct.name = 'New' THEN 'Alquilado' ELSE NULL END) AS 'New',
       COUNT(CASE WHEN ct.name = 'Sci-Fi' THEN 'Alquilado' ELSE NULL END) AS 'Sci-Fi',
       COUNT(CASE WHEN ct.name = 'Sports' THEN 'Alquilado' ELSE NULL END) AS Sports,
       COUNT(CASE WHEN ct.name = 'Travel' THEN 'Alquilado' ELSE NULL END) AS Travel
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category ct ON ct.category_id = fc.category_id
GROUP BY c.customer_id
;

-- clientes que han alquilado todas las películas de una categoría determinada
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Customer, COUNT(f.title) AS 'Conteo_Total'
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category ct ON ct.category_id = fc.category_id
WHERE ct.name like '%Comedy%'
GROUP BY c.customer_id
HAVING COUNT(DISTINCT f.film_id) = (
    SELECT COUNT(f.film_id)
    FROM film f
    INNER JOIN film_category fc ON f.film_id = .film_id
    INNER JOIN category ct ON ct.category_id = fc.category_id
    WHERE ct.name = 'Comedy'
);

-- Validación de la cantidad máxima alquilada por cliente por categoría
SELECT CONCAT(c.first_name, ' ', c.last_name) AS Customer, COUNT(f.title) AS 'Conteo_Total'
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category ct ON ct.category_id = fc.category_id
WHERE ct.name like '%Action%'
GROUP BY c.customer_id
ORDER BY COUNT(f.title) Desc
limit 10;

-- películas que nunca han sido alquiladas 
SELECT f.film_id, f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

-- Peliculas que han sido alquiladas mas de 5 veces en un solo día
SELECT f.film_id, f.title, r.rental_date, COUNT(r.rental_id) AS total_rentals
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, r.rental_date
HAVING COUNT(r.rental_id) >5
ORDER BY r.rental_date;

-- clientes que alquilaron una película en el mismo día en que se registraron
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, r.rental_date, c.create_date
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
WHERE DATE(c.create_date) = DATE(r.rental_date);
