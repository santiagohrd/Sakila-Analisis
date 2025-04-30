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
