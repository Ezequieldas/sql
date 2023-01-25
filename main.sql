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



