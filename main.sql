SELECT *
--Seleccionar todos los elementos

--Luego de SELECT podemos solicitar una ejecución específica

COUNT(id)
--Cuenta la cantidad de elementos

SUM(quantity)
--Realiza la operación de suma deseada

AVG(age)
--Obtiene el promedio (average)

MIN(date)
--Obtiene el número menor de la tabla

MAX(date)
--Obtiene el número mayor de la tabla

IF(500 < 1000, 'YES', 'NO');
--Condicional, siempre que se cumpla da una respuesta

CASE
  WHEN quantity > 30 THEN 'Over 30'
  WHEN quantity = 30 THEN 'Equal 30'
  ELSE 'Under 30'
END AS QuantityText
--Similar a switch en JS. Especifia condiciones de cumplimiento para cada caso

-------------

-- From representa el origen de la tabla que será la fuente de datos a consultar
SELECT *
FROM tabla_diaria

-- Para la consulta a la tabla le podemos asignar un alias
FROM tabla_diaria AS td

-- JOIN es un complemento para FROM. Obtener los datos de una tabla relacionados con la primera

FROM tabla_diaria AS td
  JOIN tabla_mensual AS tabla_mensual


-- ON en este ejemplo nos indica desde que llave se hará la consulta
FROM tabla_diaria AS td
  JOIN tabla_mensual AS tabla_mensual
  ON td.pk = tm.fk
-- Primary Key de td - Foreign Key de tm

-- FROM puede tomar información de diferentes bases de datos. Por ejemplo
SELECT *
FROM dblink('
dbname=somedb
port=5432 host=someserver
user=someuser
password=somepwd')
AS blockgroups
-- Ejecuta la sentencia y la regresa como una tabla local

-------------------

-- JOIN en base a los diagramas de Venn (círculos que se conectan)

LEFT JOIN
-- Toma todos los elementos de la tabla A, sin importar aquellos que coincidan o tengan un equivalente con la tabla B

RIGHT JOIN
-- Toma todos los elementos de la tabla B, sin importar aquellos que coincidan o tengan un equivalente con la tabla A

EXCLUSIVE LEFT JOIN
-- Trae todos los elementos de la tabla A, pero se asegura de no traer aquellos que coincidan o tengan un equivalente con la tabla B

EXCLUSIVE RIGHT JOIN
-- Trae todos los elementos de la tabla B, pero se asegura de no traer aquellos que coincidan o tengan un equivalente con la tabla A

FULL OUTER JOIN
-- Trae todos los elementos de ambas tablas y los opera entre sí

EXCLUSIVE FULL OUTER JOIN 
-- Trae todos los elementos de ambas tablas, excepto los que coinciden o tienen alguna relación entre sí

INNER JOIN
-- Es el "JOIN" por defecto. Trae solo los elementos que tienen relación con ambas tablas 

------------

WHERE
-- Es el equivalente de selección en SQL (representado con la letra Sigma del alfabeto griego)
SELECT *
FROM tabla_diaria
WHERE id = 1;

SELECT *
FROM tabla_diaria
WHERE cantidad > 10;

SELECT *
FROM tabla_diaria
WHERE cantidad < 100;

-- Con WHERE podemos definir un rango utilizando BETWEEN y AND
SELECT *
FROM tabla_diaria
WHERE cantidad BETWEEN 10
  AND 100;

-- Con WHERE también podemos definir casos especiales en las que se deben cumplir ambas condiciones utilizando AND (&&); o que al menos se cumpla una de las dos con la sentencia OR (||)
SELECT * 
FROM users
WHERE nombre = 'Israel'
  AND (
    lastname = 'Vasquez'
    OR 
    lastname = "Lopez"
  );


-- La sentencia LIKE busca opciones que se asemejen
SELECT * 
FROM users
WHERE nombre LIKE 'Is%'
-- Por ejemplo, nombres que comiencen con "Is"

SELECT * 
FROM users
WHERE nombre NOT LIKE 'Is%'
-- NOT LIKE es la negación de la misma. Va a traer los datos que no tengan similitud


--IS NULL solicita de aquellas tablas los datos que se encuentren nulos. Importante; no es válido = NULL
SELECT * 
FROM users
WHERE nombre IS NULL

-- O podemos negar la nulidad para que traiga los datos que no están vacíos
SELECT * 
FROM users
WHERE nombre IS NOT NULL

-- La sentencia IN nos sirve para agrupar varios datos que queremos traer en una sola solicitud
SELECT * 
FROM users
WHERE nombre IN ('Laura', 'Ezequiel', 'Luis')

-----------

-- ORDER BY nos permite indicar un criterio de ordenamiento

SELECT * 
FROM users
ORDER BY fecha ASC
-- Ordenamiento ascendente, de menor a mayor

SELECT * 
FROM users
ORDER BY fecha DESC
-- Ordenamiento descendente, de mayor a menor

-----------

-- GROUP BY es la sentencia SQL para la agregación y el agrupamiento de datos
SELECT * 
FROM tabla_diaria
GROUP BY marca, modelo;


-- La sentencia LIMIT nos permite precisamente limitar la cantidad de datos que se van a recibir
SELECT * 
FROM tabla_diaria
LIMIT 1500;


-- SELECT es un tipo de consulta que se puede anidar en "SUB QUERY" (entre paréntesis)
SELECT *
FROM   (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM tabla
) 
WHERE row_id = 5
;

-- DISTINCT trae el dato solo una vez

--CONCAT es la sentencia que nos permite concatenar dos valores diferentes indepentientemente de donde los vayamos a traer
SELECT CONCAT(a.nombre, ' ', a.apellido)



/* ALGUNOS COMANDOS */

SELECT *
FROM   tabla
FETCH FIRST 1 ROWS ONLY;

SELECT *
FROM   tabla
LIMIT 1;
-- En ambos casos se obtiene el primer elemento de la lista


SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM tabla
) AS with_row_num
WHERE row_id IN(1,5,10,20,50,71);
-- Trae una lista específica de elementos

SELECT *
FROM tabla
WHERE id IN (
	SELECT id
	FROM tabla
	WHERE row_id = 30
)
--Con el sub query podemos crear una condición para que traiga una cantidad específica de elementos que cumplan con esa condición

--DATE_PART es una forma de extraer la parte de una fecha, tal como el año, el mes o el día.
SELECT DATE_PART('YEAR', fecha_) AS year_inc,
DATE_PART('MONTH', fecha_) AS month_inc,
DATE_PART('DAY', fecha_) AS day_inc
FROM tabla;

-- O incluso horas, miutos y segundos

SELECT DATE_PART('HOUR', fecha_) AS hour_inc,
DATE_PART('MINUTE', fecha_) AS minute_inc,
DATE_PART('SECOND', fecha_) AS second_inc,
FROM tabla;
-- Al utilizar AS se crea una nueva columna en la tabla con la información extraida

-- EXTRACT obtiene un dato específico, por ejemplo de una fecha
SELECT *
FROM tabla
WHERE (EXTRACT(YEAR FROM fecha_)) = 2018
-- Es una alternativa para DATE_PART

--CAST en SQL determina la forma como deseamos que se trate ese tipo de dato por ejemplo:
::text
::timestamp

SELECT (tabla.*)::text, COUNT(*)
FROM tabla
GROUP BY tabla.*
-- En este ejemplo se extraen todos los elementos de cada columna y se retornan en una sola columna separados por comas


-- Self JOIN. Unir elementos de la misma tabla
SELECT a.nombre,
		t.nombre,
FROM tabla AS a
	INNER JOIN tabla AS t ON a.columna_id = t.id


  /* ALGUNAS FUNCIONES */

--lpad() agrega una cantidad de padding a la izquierda
SELECT rpad('*', id, '*'), carrera_id
FROM tabla
WHERE id < 10
--rpad() agrega una cantidad de padding a la derecha

--generate_series() genera automáticamente un determinado rango
SELECT *
FROM generate_series(1,10)

--generate_series puede operar con un tercér parámetro, por ejemplo para ir en orden descendente
SELECT *
FROM generate_series(10,1,-2)
-- el tercer parámetro es lla forma en la que ira descendiendo el generador


--current_date es una función que devuelve la fecha actual
--current_time devuelve hora y zona horaria

/* EXPRESIONES REGULARES */

SELECT email
FROM platzi.alumnos
WHERE email ~*'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}';

SELECT email
FROM platzi.alumnos
WHERE email ~*'[A-Z0-9._%+-]+@google[A-Z0-9.-]+\.[A-Z]{2,4}';

/* UN POCO OSBRE BASES DE DATOS */

/*
BASES DE DATOS DISTRIBUIDAS: 
Son una colección de múltiples bases de datos separadas físicamente que se comunican mediante una red informática.

VENTAJAS:

-desarrollo modular.
-incrementa la confiabilidad.
-mejora el rendimiento.
-mayor disponibilidad.
-rapidez de respuesta.

DESVENTAJAS:

-Manejo de seguridad.
-complejidad de procesamiento.
-Integridad de datos más compleja.
-Costo.

TIPOS:

Homogéneas: mismo tipo de BD, manejador y sistema operativo. (aunque esté distribuida).
Heterogénea: puede que varíen alguna de los anteriores características.
-OS
-Sistema de bases de datos.
-Modelo de datos.

ARQUITECTURAS:

-** cliente- servidor**: donde hay una BD principal y tiene varias BD que sirven como clientes o como esclavas que tratarán de obtener datos de la principal, a la que normalmente se hacen las escrituras.

Par a par (peer 2 peer): donde todos los puntos en la red de bd son iguales y se hablan como iguales sin tener que responder a una sola entidad.
multi manejador de bases de datos.
ESTRATEGIA DE DISEÑO:

top down: es cuando planeas muy bien la BD y la vas configurando de arriba hacia abajo de acuerdo a tus necesidades.
bottom up: ya existe esa BD y tratas de construir encima.

ALMACENAMIENTO DISTRIBUIDO:

-Fragmentación: qué datos van en dónde.

fragmentación horizontal: (sharding) partir la tabla que estás utilizando en diferentes pedazos horizontales.

fragmentación vertical: cuando parto por columnas.

fragmentación mixta: cuando tienes algunas columnas y algunos datos en un lugar y algunas columnas y algunas tuplas en otro lugar.

-Replicación: tienes los mismos datos en todas ala BBDD no importa donde estén.

-replicación completa: cuando toda al BD está en varias versiones a lo largo del globo, toda la información está igualita en todas las instancias de BD.
-replicación parcial: cuando algunos datos están replicados y compartidos en varias zonas geográficas
-sin replicación: no estás replicando nada de los datos, cada uno está completamente separa y no tienen que estarse hablando para sincronizar datos entre ellas.

DISTRIBUCIÓN DE DATOS:

-Distribución: cómo va a pasar la data entre una BD y otra. Tiene que ver mucho con networking, tiempos, latencia, etc. Pueden ser:

Centralizada: cuando la distribuyes des un punto central a todas las demás
Particionada: está partida en cada una de las diversas zonas geográficas y se comparten información entre ellas.
Replicada: tener la misma información en todas y entre ellas se hablan para siempre tener la misma versión.

*/

/* WINDOW FUNCTION */

-- Obtener el número de tupla sin un orden en particular --
SELECT ROW_NUMBER() OVER() AS row_id, *
FROM tabla;

-- Obtener el número de tupla cuando ordenamos por fecha de incorporacion --
SELECT ROW_NUMBER() OVER(ORDER BY fecha_incorporacion) AS row_id, *
FROM tabla;

-- Obtener el valor de un atributo de la primera tupla del window frame actual (global por default) --
SELECT FIRST_VALUE(colegiatura) OVER() AS row_id, *
FROM tabla;

-- Obtener el valor de un atributo de la primera tupla del window frame actual --
-- La colegiatura de la persona que se inscribió primero por carrera --
SELECT FIRST_VALUE(colegiatura) OVER(PARTITION BY carrera_id ORDER BY fecha_incorporacion) AS row_id, *
FROM tabla;

-- Obtener el valor de un atributo de la ultima tupla del window frame actual --
-- La colegiatura de la persona que se inscribió al final por carrera --
SELECT LAST_VALUE(colegiatura) OVER(PARTITION BY carrera_id ORDER BY fecha_incorporacion) AS row_id, *
FROM tabla;

-- Obtener el valor de un atributo de la tupla numero n = 3 del window frame actual --
-- La colegiatura de la persona que se inscribió en lugar 3 por carrera --
SELECT nth_value(colegiatura, 3) OVER(PARTITION BY carrera_id ORDER BY fecha_incorporacion) AS row_id, *
FROM tabla;

-- Rank Simple: Por cada elemento cuenta 1 generando espacios en el rank --
SELECT 	*,
		RANK() OVER (PARTITION BY carrera_id ORDER BY colegiatura DESC) AS brand_rank
FROM	tabla
ORDER BY carrera_id, brand_rank;

-- Rank Simple: Por cada grupo de lementos iguales cuenta 1 generando rank "denso" --
SELECT 	*,
		DENSE_RANK() OVER (PARTITION BY carrera_id ORDER BY colegiatura DESC) AS brand_rank
FROM	tabla
ORDER BY carrera_id, brand_rank;

-- Percent Rank: Genera una distribución percentual siguiendo la fórmula (rank - 1) / (total rows - 1) --
SELECT 	*,
		PERCENT_RANK() OVER (PARTITION BY carrera_id ORDER BY colegiatura ASC) AS brand_rank
FROM	tabla
ORDER BY carrera_id, brand_rank;


-- ROW_NUMBER(): nos da el numero de la tupla que estamos utilizando en ese momento.

-- OVER([PARTITION BY column] [ORDER BY column DIR]): nos deja Particionar y Ordenar la window function.

-- PARTITION BY(column/s): es un group by para la window function, se coloca dentro de OVER.

-- FIRST_VALUE(column): devuelve el primer valor de una serie de datos.

-- LAST_VALUE(column): Devuelve el ultimo valor de una serie de datos.

-- NTH_VALUE(column, row_number): Recibe la columna y el numero de row que queremos devolver de una serie de datos

-- RANK(): nos dice el lugar que ocupa de acuerdo a el orden de cada tupla, deja gaps entre los valores.

-- DENSE_RANK(): Es un rango mas denso que trata de eliminar los gaps que nos deja RANK.

-- PERCENT_RANK(): Categoriza de acuerdo a lugar que ocupa igual que los anteriores pero por porcentajes.


