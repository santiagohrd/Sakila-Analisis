-- Actualizar la fecha de creación de la cuenta del usuario
ALTER TABLE customer ADD COLUMN creation_date DATE;

update customer
set creation_date = date_add('2020-01-01',
    INTERVAL FLOOR(RAND() * (DATEDIFF('2025-12-31', '2020-01-01') + 1)) DAY)
where year(create_date) = "2006";

-- Actualizar el año de lanzamiento de las películas
alter table film
add column released_year YEAR;																																																																																		

update film
set released_year = floor(2000 + (rand() * 21));

-- Actualizar fecha de rental considerando fecha de registro de cada cliente
update rental r
join customer c
	ON r.customer_id = r.customer_id																								
SET r.rental_date = DATE_ADD(
	DATE_ADD(
		c.creation_date,
        INTERVAL FLOOR(
			RAND() * (DATEDIFF('2024-12-31', c.creation_date) + 1)
		) DAY
	),
    INTERVAL FLOOR(RAND() * 86400) SECOND
)
WHERE c.creation_date <= '2024-12-31';

-- Actualiza la fecha de pago para que coincida en el intervalo del rental
UPDATE payment p
JOIN rental r ON p.rental_id = r.rental_id
SET p.payment_date = DATE_ADD(
    r.rental_date,
    INTERVAL FLOOR(1 + (RAND() * 59)) MINUTE
);

 -- Toma unos datos random para simular que pagaron antes
UPDATE payment p
JOIN rental r ON p.rental_id = r.rental_id
SET p.payment_date = DATE_SUB(
    r.rental_date,
    INTERVAL FLOOR(1 + RAND() * 5) DAY
)
WHERE RAND() < 0.2;  -- 20% de los registros

-- Actualiza la fecha de entrega dada la fecha de rentado
UPDATE rental
SET return_date = DATE_ADD(
	rental_Date,
    INTERVAL FLOOR(1 + (RAND() * 30)) day
	);