-- películas que tienen más de una hora y media de duración
SELECT title, length
FROM film
WHERE length > time_to_sec('1:30:00') / 60;
