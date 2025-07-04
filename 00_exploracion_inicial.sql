USE sakila;

-- Actor Table
DESC actor; 
SELECT COUNT(*) AS num_records
FROM actor;

SELECT CONCAT(first_name, " ", last_name) AS actorName, 
	COUNT(*) as num_actors 
FROM actor
GROUP BY actorName
HAVING num_actors > 1;

SELECT 
	SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS nulls_col1,
	SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS nulls_col2
FROM actor;

-- Address Table
DESC address;
SELECT COUNT(*) AS num_records
FROM address;

SELECT 
	SUM(CASE WHEN address IS NULL THEN 1 ELSE 0 END) AS nulls_address,
	SUM(CASE WHEN address2 IS NULL THEN 1 ELSE 0 END) AS nulls_address2,
    SUM(CASE WHEN district IS NULL THEN 1 ELSE 0 END) AS nulls_district,
    SUM(CASE WHEN postal_code IS NULL THEN 1 ELSE 0 END) AS nulls_postal,
    SUM(CASE WHEN phone IS NULL THEN 1 ELSE 0 END) AS nulls_phone,
    SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS nulls_location
FROM address;

SELECT address, COUNT(address) AS address_count,
		phone, COUNT(phone) AS phone_count
FROM address
GROUP BY address, phone
HAVING address_count > 1;

SELECT st_astext(location) FROM address;

SELECT ST_X(location) AS lat, ST_Y(location) AS lon
FROM address;

SELECT COUNT(DISTINCT district) AS count_districts
FROM address;

SELECT DISTINCT district
FROM address
ORDER BY district;

-- Category table
DESC category;
SELECT COUNT(name) AS category_count FROM category;

SELECT DISTINCT name FROM category;

SELECT name FROM category
WHERE name IS NULL;

-- City Table
DESC city;
SELECT COUNT(city) AS city_count
FROM city;

SELECT DISTINCT city FROM city;

SELECT city FROM city
WHERE city IS NULL;

-- Country Table
DESC country;
SELECT COUNT(country) as country_count FROM country;

SELECT DISTINCT country FROM country;

SELECT country FROM country
WHERE country IS NULL;

-- Customer table
DESC customer; -- create_date
SELECT COUNT(*) AS customer_count
FROM customer;

SELECT COUNT(DISTINCT email) AS unique_email FROM customer;

SELECT email, COUNT(*) AS duplicate_email
FROM customer
GROUP BY 1
HAVING email_count > 1;

SELECT
	SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS null_firstName,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS null_lastName,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS null_email,
    SUM(CASE WHEN active IS NULL THEN 1 ELSE 0 END) AS null_active,
    SUM(CASE WHEN creation_date IS NULL THEN 1 ELSE 0 END) AS null_creationDate
FROM customer;

SELECT active, COUNT(active) AS amount
FROM customer
GROUP BY 1;

SELECT YEAR(creation_date) AS annual, 
	DATE_FORMAT(creation_date, "%b") AS monthly, 
    COUNT(*) as month_amount
FROM customer
GROUP BY 1, MONTH(creation_date), 2
ORDER BY annual, MONTH(creation_date);

SELECT 
  YEAR(creation_date) AS anio,
  MONTH(creation_date) AS mes,
  COUNT(*) AS cantidad_mensual,
  SUM(COUNT(*)) OVER (PARTITION BY YEAR(creation_date)) AS total_anual,
  ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY YEAR(creation_date)), 2) AS pct_customers_anio
FROM customer
GROUP BY YEAR(creation_date), MONTH(creation_date)
ORDER BY anio, mes;

DESC film; -- release_year
SELECT COUNT(*) FROM film;

SELECT
	SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS null_description,
    SUM(CASE WHEN rental_duration IS NULL THEN 1 ELSE 0 END) AS null_duration,
    SUM(CASE WHEN rental_rate IS NULL THEN 1 ELSE 0 END) AS null_rate,
    SUM(CASE WHEN length IS NULL THEN 1 ELSE 0 END) AS null_length,
    SUM(CASE WHEN replacement_cost IS NULL THEN 1 ELSE 0 END) AS null_replacement,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN special_features IS NULL THEN 1 ELSE 0 END) AS null_features,
    SUM(CASE WHEN released_year IS NULL THEN 1 ELSE 0 END) AS null_released
FROM film;

SELECT title, COUNT(DISTINCT title) AS conteo 
FROM film 
GROUP BY 1 
HAVING conteo > 1;

SELECT MIN(rental_duration) AS minimo, MAX(rental_duration) AS maximo
FROM film;

SELECT MIN(rental_rate), MAX(rental_rate), AVG(rental_rate) 
FROM film;

SELECT 
	CASE
	WHEN rental_rate < 2 THEN "less_2"
    WHEN rental_rate BETWEEN 1.99 AND 4 THEN "between_2_and_4"
    ELSE "more_4"
    END AS prices,
    COUNT(rental_rate)
FROM film
GROUP BY 1
ORDER BY
		CASE prices
			WHEN 'less_2' THEN 1
			WHEN 'between_2_and_4' THEN 2
			WHEN 'more_4' THEN 3
		  END;
          
SELECT MIN(length) AS min_length, MAX(length) AS max_length, AVG(length), STDDEV(length)
FROM film;

SELECT 
	CASE  
    WHEN length <= 60 THEN "<60"
    WHEN length BETWEEN 60 AND 90 THEN "60-90"
    WHEN length BETWEEN 89 AND 120 THEN "90-120"
    WHEN length BETWEEN 119 AND 120 THEN "120-150"
    ELSE ">150" END AS duration,
    COUNT(*) AS num_films
FROM film
GROUP BY 1
ORDER BY
		CASE duration
        WHEN "<60" THEN 1
        WHEN "60-90" THEN 2
        WHEN "90-120" THEN 3
        WHEN "120-150" THEN 4
        WHEN ">150" THEN 5
        END;
        
DESC inventory;

SELECT COUNT(*) as qnt
FROM inventory
GROUP BY "qnt"
HAVING qnt IS NOT NULL;

SELECT DISTINCT(f.title),
	CASE
		WHEN i.store_id = 1 THEN "Main store"
        ELSE "Sucursal" END AS Store
FROM inventory AS i
LEFT JOIN film as f
ON i.film_id = f.film_id;

SELECT i.store_id, COUNT(*) AS qnt
FROM inventory AS i
LEFT JOIN film as f
ON i.film_id = f.film_id
GROUP BY "qnt", i.store_id;

SELECT f.title, COUNT(*) AS qnt
FROM inventory AS i
LEFT JOIN film as f
ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY qnt asc;

DESC language;
SELECT COUNT(*) FROM language;

SELECT name FROM language;

DESC payment; -- payment_date
SELECT * FROM payment LIMIT 5;

SELECT MIN(amount), MAX(amount), COUNT(*) AS total_payments, COUNT(DISTINCT customer_id) AS unique_clients
FROM payment;

SELECT
	SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN staff_id IS NULL THEN 1 ELSE 0 END) AS null_staff_id,
    SUM(CASE WHEN rental_id IS NULL THEN 1 ELSE 0 END) AS null_rental_id,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN payment_date IS NULL THEN 1 ELSE 0 END) AS null_payment_date
FROM payment;

SELECT * FROM payment WHERE amount <= 0;

SELECT amount, COUNT(*) FROM payment GROUP BY amount ORDER BY COUNT(*) DESC;


SELECT CASE WHEN amount REGEXP '^[0-9]+$' THEN 'numero' ELSE 'No es número' END
FROM payment;

SELECT staff_id, COUNT(*) AS pagos, SUM(amount) AS total
FROM payment
GROUP BY staff_id;

SELECT count(*) AS cantidad, datediff(payment_date, rental_date) AS time_diff
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
WHERE p.payment_date < r.rental_date
GROUP BY 2
ORDER BY 2;

SELECT COUNT(datediff(payment_date, rental_date)) AS time_diff
FROM payment AS p
JOIN rental AS r
	ON p.rental_id = r.rental_id
WHERE payment_date < rental_date;

DESC rental; -- rental_date, return_date

SELECT * FROM rental LIMIT 5;

SELECT COUNT(*) FROM rental;
SELECT 
	SUM(CASE WHEN rental_date IS NULL THEN 1 ELSE 0 END) AS null_rental_id,
    SUM(CASE WHEN inventory_id IS NULL THEN 1 ELSE 0 END) AS null_inventory_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN return_date IS NULL THEN 1 ELSE 0 END) AS null_return_date,
    SUM(CASE WHEN staff_id IS NULL THEN 1 ELSE 0 END) AS null_staff_id
FROM rental;

SELECT COUNT(rental_id)
FROM rental
WHERE return_date < rental_date;

SELECT *
FROM rental
WHERE STR_TO_DATE(rental_date, '%Y-%m-%d %H:%i:%s') IS NULL
      AND rental_date IS NOT NULL
		OR STR_TO_DATE(return_date, '%Y-%m-%d %H:%i:%s') IS NULL
      AND return_date IS NOT NULL;