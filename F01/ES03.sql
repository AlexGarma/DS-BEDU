-- Para estas consultas usa RIGHT JOIN
USE classicmodels;
-- Obten el código de producto, nombre de producto y descripción de todos los productos.
SELECT productCode, productName, productDescription
FROM products;
-- Obten el número de orden, estado y costo total de cada orden.
SELECT o.orderNumber, status, SUM(quantityOrdered*priceEach) AS total
FROM orders AS o
RIGHT JOIN orderdetails AS od
USING(orderNumber)
GROUP BY orderNumber;
-- Obten el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza que muestre los detalles de cada orden.
SELECT orderNumber, orderDate, orderLineNumber, productName, quantityOrdered, priceEach
FROM orders AS o
RIGHT JOIN orderdetails AS od
USING(orderNumber)
RIGHT JOIN products AS p
USING(productCode);
-- Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SELECT orderNumber, productName, MSRP, priceEach
FROM orders
RIGHT JOIN orderdetails
USING(orderNumber)
RIGHT JOIN products
USING(productCode);

-- Para estas consultas usa LEFT JOIN

-- Obtén el número de cliente, nombre de cliente, número de orden y estado de cada cliente.
SELECT customerNumber, customerName, orderNumber, state 
FROM customers 
LEFT JOIN orders
USING(customerNumber);
-- Obtén los clientes que no tienen una orden asociada.
SELECT customerNumber, customerName
FROM customers AS c
LEFT JOIN orders AS o 
USING(customerNumber)
WHERE orderNumber IS NULL;
-- Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT lastName, firstName, customerName, checkNumber, amount
FROM employees AS e
LEFT JOIN customers AS c
	ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p
	USING(customerNumber); 
    
-- Para estas consultas usa RIGHT JOIN

-- Repite los ejercicios 5 a 7 usando RIGHT JOIN.
-- Obtén el número de cliente, nombre de cliente, número de orden y estado de cada cliente.
SELECT customerNumber, customerName, orderNumber, state 
FROM orders
RIGHT JOIN customers
USING(customerNumber);
-- Obtén los clientes que no tienen una orden asociada.
SELECT customerNumber, customerName
FROM orders AS o
RIGHT JOIN customers AS c
USING(customerNumber)
WHERE orderNumber IS NULL;
-- Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT lastName, firstName, customerName, checkNumber, amount
FROM payments AS p
RIGHT JOIN customers AS c
	USING(customerNumber)
RIGHT JOIN  employees AS e
	ON e.employeeNumber = c.salesRepEmployeeNumber; 

-- Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
CREATE VIEW clientes_asociados AS (
SELECT lastName, firstName, customerName, checkNumber, amount
FROM payments AS p
RIGHT JOIN customers AS c
	USING(customerNumber)
RIGHT JOIN  employees AS e
	ON e.employeeNumber = c.salesRepEmployeeNumber); 

CREATE VIEW clientes_sin_orden AS (
SELECT customerNumber, customerName
FROM orders AS o
RIGHT JOIN customers AS c
USING(customerNumber)
WHERE orderNumber IS NULL) ;

CREATE VIEW estado_cliente AS (
SELECT customerNumber, customerName, orderNumber, state 
FROM orders
RIGHT JOIN customers
USING(customerNumber));