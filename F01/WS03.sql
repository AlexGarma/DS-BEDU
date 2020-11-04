-- Retos

USE tienda;
-- Reto 1 

-- Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
-- ¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
SELECT nombre, apellido_paterno
FROM empleado
WHERE id_puesto  IN
	(SELECT id_puesto 
    FROM puesto
    WHERE salario < 1e4);
-- ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
SELECT id_empleado, MAX(ventas) AS max, MIN(ventas) AS min
FROM
	(SELECT clave, id_empleado, COUNT(*) AS ventas
    FROM venta
    GROUP BY clave, id_empleado) AS sc
GROUP BY id_empleado;
-- ¿Cuáles claves de venta incluyen artículos cuyos precios son mayores a $5,000?
SELECT clave
FROM venta
WHERE id_articulo 
IN
	(SELECT id_articulo
    FROM articulo
    WHERE precio > 5e3);

-- Reto 2 
-- ¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT clave, id_venta, nombre, apellido_paterno
FROM venta 
JOIN empleado 
USING(id_empleado)
ORDER BY clave;
-- ¿Cuál es el nombre de los artículos que se han vendido?
SELECT clave, nombre
FROM venta
JOIN articulo
USING(id_articulo)
ORDER BY clave;
-- ¿Cuál es el total de cada venta?
SELECT clave, SUM(precio) AS total
FROM venta
JOIN articulo
USING(id_articulo)
GROUP BY clave ;
