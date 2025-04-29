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

DESC category;
DESC city;
DESC country;
DESC customer; -- create_date
DESC film; -- release_year
DESC film_actor;
DESC film_category;
DESC film_text;
DESC inventory;
DESC language;
DESC payment; -- payment_date
DESC rental; -- rental_date, return_date
DESC staff;
DESC store;