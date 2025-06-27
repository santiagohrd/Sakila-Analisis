# 🧪 Exploración de Datos – Proyecto de Limpieza y Validación

Este proyecto se enfoca en la **exploración inicial de la base de datos**. El objetivo principal fue identificar inconsistencias, valores nulos, atípicos y validar que los datos cumplan con los formatos esperados antes de pasar a análisis más profundos o modelado.

---

## ✅ Habilidades y conceptos aplicados

### 🔍 Validación de tipos de datos

- **Expresiones regulares (`REGEXP`)**: Utilizadas para verificar que los valores de ciertas columnas correspondan al tipo esperado, como números o fechas con formato `YYYY-MM-DD HH:MM:SS`.
- **`STR_TO_DATE()`**: Para validar que las fechas y timestamps sean realmente parseables, evitando errores en columnas que aparentan ser válidas.

### 🧠 Detección de valores nulos y anomalías

- **Uso de `CASE WHEN`**: Para revisar la existencia de valores `NULL` o en blanco en cada columna de forma flexible y personalizada.
- **Descriptivos estadísticos (media, mediana, desviación estándar, etc.)**: Aplicados a columnas numéricas para identificar **valores atípicos** (outliers) y posibles errores de ingreso de datos.

### 🗺️ Validación de coordenadas geográficas

- Aprendí a usar las funciones espaciales **`ST_X()` y `ST_Y()`** para extraer y validar coordenadas de columnas tipo `GEOMETRY`, asegurando que se encuentren dentro de los rangos geográficos válidos.

### 🏷️ Categorización de datos

- Uso de la función **`CASE`** para crear nuevas categorías a partir de valores existentes, o para clasificar registros según rangos (por ejemplo, edades, rangos salariales, zonas geográficas).

### 📆 Validación de fechas

- Verificación de que las fechas estén **dentro de los rangos esperados**.
- Detección de fechas fuera de rango, erróneas o mal formateadas, usando combinaciones de `STR_TO_DATE`, `BETWEEN`, y `CASE`.

### 🔄 Validación cruzada entre tablas

- Realicé comparaciones entre columnas relacionadas de diferentes tablas (por ejemplo, `payment_date` vs `rental_date`) para detectar inconsistencias lógicas como **pagos realizados antes del alquiler**, lo cual reveló problemas potenciales en la calidad y secuencia de los datos, o posibles agendamientos en la renta.

### 📊 Análisis temporal de creación de registros

- Agrupé y analicé fechas por **año y mes** para entender la distribución temporal de registros, como los clientes (`creation_date`). Esto permitió detectar posibles patrones de estacionalidad, errores en fechas o períodos sin actividad.

### 💸 Validación de reglas de negocio (pagos)

- Verifiqué que los valores de pago (`amount`) fueran válidos, destacando aquellos que eran **cero o negativos**, lo cual puede indicar errores operativos o en la fuente de datos. Esto va más allá del tipo de dato y asegura que los valores tengan sentido comercial.

### 🔢 Validación de tipos numéricos en campos de texto

- Utilicé expresiones regulares (`REGEXP`) para confirmar que valores numéricos almacenados como texto en realidad **cumplen con el formato esperado**, ayudando a identificar entradas incorrectas, como letras o símbolos mezclados.

---

## 🚧 Desafíos y consideraciones adicionales

Durante este proceso de exploración y preparación de datos, enfrenté varios retos técnicos y de lógica de negocio:

### 🧠 Uso de funciones avanzadas en SQL

- El uso de **funciones de ventana**, como `ROW_NUMBER() OVER(PARTITION BY ...)`, representó un reto inicial, especialmente al momento de detectar duplicados sin eliminar información valiosa.
- También trabajé con **funciones de agregación con `OVER()`** para calcular totales acumulados por año o categoría, lo cual implicó estructurar correctamente la partición y el orden.

### 🔍 Validación con expresiones regulares

- La validación de columnas con posibles datos incorrectos mediante **`REGEXP`** fue compleja al inicio, pero resultó esencial para comprobar que campos como montos o correos estuvieran bien formateados.

---

## 🛠️ Modificaciones a los datos para enriquecer el análisis

Dado que los datos originales de la base de datos Sakila contenían valores por defecto o fechas poco realistas (por ejemplo, todas las fechas del 2006), realicé ajustes controlados para simular un conjunto de datos más realista y útil para análisis:

- 🗓️ **Clientes**: Añadí una nueva columna `creation_date` con fechas aleatorias entre 2020 y 2025 para representar el momento en que se registraron.
- 🎬 **Películas**: Añadí una columna `released_year` con valores aleatorios entre 2000 y 2020 para simular variedad en los estrenos.
- 🎟️ **Alquileres (`rental`)**: Ajusté la fecha de renta para que esté basada en la fecha de creación del cliente, sumando un intervalo aleatorio.
- 💰 **Pagos (`payment`)**:
  - En la mayoría de casos, la fecha de pago fue modificada para ocurrir minutos después del alquiler.
  - En el 20% de los registros, el pago fue ajustado para simular una precompra, es decir, ocurrió **antes** del alquiler.
- 📦 **Devoluciones (`return_date`)**: Se generaron fechas de entrega aleatorias entre 1 y 30 días después de la fecha de renta.

Estas modificaciones me permitieron aplicar validaciones de calidad temporal más realistas y detectar errores intencionales para fines de aprendizaje.


## 💡 Reflexión

Este paso me permitió entender a fondo la estructura, calidad y desafíos presentes en los datos brutos. La validación con expresiones regulares, el uso de funciones espaciales y la estadística descriptiva fueron herramientas clave para garantizar que los datos estén listos para ser analizados con confianza.








