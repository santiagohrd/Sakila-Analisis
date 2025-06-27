# 🧪 Exploración Inicial de la Base de Datos: Sakila

## 📅 Fecha de inicio: 2025-04-29  

---

## 🗺️ Estructura general

- Total de tablas: 16
- Principales relaciones:
  - `rental` → `customer`, `inventory`
  - `payment` → `rental`, `customer`
  - `film` → `category`, `actor`, `inventory`
  - `store` → `staff`, `inventory`

---

## 🔍 Revisión por tabla

### 1. Tabla: `actor`

- 🔢 Total de registros: 200
- 🧱 Columnas: `actor_id`, `first_name`, `last_name`, `last_update`
- 📌 Observaciones:
  - Sin valores nulos.
  - Hay dos actrices llamadas 'SUSAN DAVIS' (Validar si es la misma)

---

### 2. Tabla: `address`
- 🔢 Total de registros: 603
- 🧱 Columnas: `address_id`, `address`, `address2`, `district`, `city_id`, `postal_code`, `phone`, `location`, `last_update`
- 📌 Observaciones:
  - `address2` tiene 4 valores nulos
  - La columna `location` indica puntos de cordenadas:
            -`st_astext(columna)` permite ver los puntos de cordenadas
            - `SELECT ST_X(location) AS lat, ST_Y(location) AS lon FROM address;` para ver las cordenadas por columna
  - No hay valores repetidos en columnas claves como address, district, phone

---

### 3. Tabla: `category`
- 🔢 Total de registros: 16
- 🧱 Columnas: `category_id`, `name`, `last_update`
- 📌 Observaciones:
  - No hay valores repetidos en columnas claves como name
  
---

### 4. Tabla: `city`
- 🔢 Total de registros: 600
- 🧱 Columnas: `city_id`, `city`, `country_id`, `last_update`
- 📌 Observaciones:
  - No hay valores repetidos en columnas claves como city
 
---

### 5. Tabla: `country`
- 🔢 Total de registros: 109
- 🧱 Columnas: `country_id`, `country`, `last_update`
- 📌 Observaciones:
  - No hay valores repetidos en columnas claves como country 
  
---

### 6. Tabla: `customer`
- 🔢 Total de registros: 599
- 🧱 Columnas: `customer_id`, `store_id`, `first_name`, `last_name`, `email`, `address_id`, `active`, `create_date`, `last_update`, `creation_date`
- 📌 Observaciones:
  - No hay valores repetidos en columnas claves como city, email
  - No hay valores nulos en columnas claves
  - Usuarios registrados desde el Enero/2020 a Diciembre/2025
  - 584 clientes activos, 15 inactivos
  
  ---

### 7. Tabla: `film`
- 🔢 Total de registros: 1000
- 🧱 Columnas: `film_id`, `title`, `description`, `release_year`, `language_id`, `original_language_id`, `rental_duration`, `rental_rate`, `length`, `replacement_cost`, `rating`, `special_features`, `last_update`, `released_year`
- 📌 Observaciones:
  - No hay valores repetidos en columnas claves
  - No hay valores duplicados en columnas claves
  - `rental_duration` mínimo de días de renta de una películo es 3, el máximo 7
  - Los precios de renta van desde 0,99 a 4,99. No se observa outliers
  - Duración de las películas van desde 46 a 185 minutos
 
 ---

### 8. Tabla: `inventory`
- 🔢 Total de registros: 4581
- 🧱 Columnas: `inventory_id`, `film_id`, `store_id`, `last_update`
- 📌 Observaciones:
  - Hay inventario en las dos tiendas
  - La max cantidad en inventario son 8, min 2
  - Todas las películas cuentan con inventario
  
 ---
 
### 9. Tabla: `language`
- 🔢 Total de registros: 6
- 🧱 Columnas: `language_id`, `name`, `last_update`
- 📌 Observaciones:
  - Los idiomas guardados: English, Italian, Japanese, Mandarin, French, German
  
 ---
  
### 10. Tabla: `payment `
- 🔢 Total de registros: 16044
- 🧱 Columnas: `payment_id`, `customer_id`, `staff_id`, `rental_id`, `amount`, `payment_date`, `last_update`
- 📌 Observaciones:
  - Sin valores nulos
  - 24 casos donde el pago fue 0
  - 3154 casos donde el cliente pagó antes de rentar la película
  
 ---  
  
### 10. Tabla: `rental`
- 🔢 Total de registros: 16044
- 🧱 Columnas: `rental_id`, `rental_date`, `inventory_id`, `customer_id`, `staff_id`, `return_date`, `last_update`
- 📌 Observaciones:
  - Sin valores nulos
  - 24 casos donde el pago fue 0
  - 3154 casos donde el cliente pagó antes de rentar la película
  
 ---
