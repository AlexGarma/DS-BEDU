-- Ejercicios:

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
SELECT lastName, firstName
FROM employees
WHERE officeCode IN 
	(SELECT officeCode 
    FROM offices 
    WHERE country = 'USA');
-- Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
SELECT customerNumber, checkNumber, amount
FROM payments
ORDER BY amount DESC
LIMIT 1;
-- Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.

-- Obten el nombre de aquellos clientes que no han hecho ninguna orden.

-- Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.

-- Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.