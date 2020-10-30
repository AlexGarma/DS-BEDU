 -- Reto 1
-- Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
USE tienda;
-- ¿Qué artículos incluyen la palabra Pasta en su nombre?
SELECT * 
FROM articulo
WHERE nombre LIKE '%Pasta%';
-- ¿Qué artículos incluyen la palabra Cannelloni en su nombre?
SELECT * 
FROM articulo
WHERE nombre LIKE '%Cannelloni%';
-- ¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT *
FROM articulo
WHERE nombre LIKE '% - %';
-- ¿Qué puestos incluyen la palabra Designer?
SELECT * 
FROM puesto
WHERE nombre LIKE '%Designer%';
-- ¿Qué puestos incluyen la palabra Developer?
SELECT * 
FROM puesto
WHERE nombre LIKE '%Developer%';

-- Reto 2

-- ¿Cuál es el promedio de salario de los puestos?
SELECT nombre, avg(salario) AS promedio
FROM puesto;
-- ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
SELECT count(*) AS conteo
FROM articulo
WHERE nombre LIKE '%Pasta%';
-- ¿Cuál es el salario mínimo y máximo?
SELECT min(salario) AS min ,max(salario) AS max
FROM puesto;
-- ¿Cuál es la suma del salario de los últimos cinco puestos agregados?**
SELECT sum(salario) AS suma
FROM puesto
WHERE id_puesto > 995;

-- Reto 3 

-- ¿Cuántos registros hay por cada uno de los puestos?
SELECT nombre,count(*) AS registros
FROM puesto
GROUP BY nombre;
-- ¿Cuánto dinero se paga en total por puesto?
SELECT nombre,sum(salario) AS total
FROM puesto
GROUP BY nombre;
-- ¿Cuál es el número total de ventas por vendedor?
SELECT id_empleado,count(*) AS total_ventas
FROM venta
GROUP BY id_empleado;
-- ¿Cuál es el número total de ventas por artículo?
SELECT id_articulo, count(*) AS total_ventas
FROM venta
GROUP BY id_articulo;

-- Ejercicios
USE classicmodels;
-- Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con a.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'a%';
-- Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre termina con on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE '%on';
-- Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE '%on%';
-- Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen tres letras e inician con T y finalizan con m.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'T_m';
-- Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName NOT LIKE 'B%';
-- Dentro de la tabla products, obten el código de producto y nombre de los productos cuyo código incluye la cadena _20. **
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%_20%';
-- Dentro de la tabla orderdetails, obten el total de cada orden.
SELECT orderNumber, SUM(quantityOrdered*priceEach) AS total
FROM orderdetails
GROUP BY orderNumber;
-- Dentro de la tabla orders obten el número de órdenes por año.
SELECT YEAR(orderDate) AS ano, COUNT(*) AS ordenes
FROM orders
GROUP BY YEAR(orderDate);
-- Obten el apellido y nombre de los empleados cuya oficina está ubicada en USA.

-- Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.

-- Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.

-- Obten el nombre de aquellos clientes que no han hecho ninguna orden.

-- Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.

-- Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
