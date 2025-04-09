-- Exporation of actor table
SELECT * FROM actor limit 10;

SELECT COUNT(*) FROM actor;

WITH null_counts AS (
    SELECT 
        'actor_id' AS column_name, COUNT(*) - COUNT(actor_id) AS null_values FROM actor
    UNION ALL
    SELECT 
        'first_name', COUNT(*) - COUNT(first_name) FROM actor
    UNION ALL
    SELECT 
        'last_name', COUNT(*) - COUNT(last_name) FROM actor
    UNION ALL
    SELECT 
        'last_update', COUNT(*) - COUNT(last_update) FROM actor
)
SELECT * FROM null_counts;

-- Exporation of address table
desc address;
select * from address limit 10;

select count(*) from address;

WITH null_counts AS (
    SELECT 
        'address' AS column_name, 
        SUM(CASE WHEN address IS NULL THEN 1 ELSE 0 END) AS null_values 
    FROM address
    UNION ALL
    SELECT 
        'district', 
        SUM(CASE WHEN district IS NULL THEN 1 ELSE 0 END) 
    FROM address
    UNION ALL
    SELECT 
        'postal_code', 
        SUM(CASE WHEN postal_code IS NULL THEN 1 ELSE 0 END) 
    FROM address
    UNION ALL
    SELECT 
        'phone', 
        SUM(CASE WHEN phone IS NULL THEN 1 ELSE 0 END) 
    FROM address
    UNION ALL
    SELECT 
		'location',
        SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END)
	FROM address
)
SELECT * FROM null_counts;

SELECT COUNT(*)
FROM address
WHERE phone IS NULL OR phone = '';

SELECT phone, COUNT(phone) AS count
FROM address
GROUP BY phone
ORDER BY COUNT(phone) desc;

-- Exporation of category table
DESC category;
SELECT COUNT(*) FROM category;

SELECT name, COUNT(name) AS count FROM category 
group by name
order by COUNT(name) DESC;