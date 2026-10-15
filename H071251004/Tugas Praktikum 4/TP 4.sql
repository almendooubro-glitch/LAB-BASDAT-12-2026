SET search_path TO classicmodels, public;

-- Soal 1
SELECT customerNumber,
	SUM(amount) AS "Total Setoran",
	COUNT(DISTINCT checkNumber) AS "Jumlah Transaksi",
	MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4 AND AVG(amount) > 20000;

-- Soal 2
SELECT customerNumber, SUM(amount) AS "Total Setoran"
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY "Total Setoran" DESC;

-- Soal 3
SELECT productLine,
	COUNT(DISTINCT productCode) AS "Jumlah Produk",
	ROUND(AVG(msrp), 2) AS "Rata-rata Msrp",
	STRING_AGG(productName, ', ' ORDER BY productName) AS "Daftar Produk"
FROM products
GROUP BY productLine
HAVING COUNT(DISTINCT productCode) > 10;

-- Soal 4
SELECT reportsTo AS employeeNumber FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

-- Soal 5
SELECT productCode, 
	SUM(quantityOrdered) AS "Total Unit Terjual",
	ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Jual"
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY "Total Unit Terjual" DESC;

-- Soal 6
SELECT productCode,
	SUM(quantityOrdered) AS "Total Unit",
	SUM(quantityOrdered * priceEach) AS "Pendapatan Kotor",
	ROUND(AVG(priceEach), 2) AS "Rata-rata Harga",
	MAX(priceEach) - MIN(priceEach) AS "Rentang Volatilitas"
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY "Pendapatan Kotor" DESC;

-- Soal 7
SELECT customerNumber FROM customers
WHERE creditLimit > 80000
INTERSECT
SELECT customerNumber FROM orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber FROM payments
GROUP BY customerNumber
HAVING SUM(amount) >= 100000;

-- Study Case 1
SELECT customerNumber, 
	SUM(amount) AS "Total Pembayaran",
	ROUND(AVG(amount), 2) AS "Rata-rata Pembayaran",
	COUNT(checkNumber) AS "Jumlah Transaksi"
FROM payments
GROUP BY customerNumber
HAVING ROUND(AVG(amount), 2) > 3000
ORDER BY "Total Pembayaran" DESC;

-- Study Case 2
SELECT customerNumber, customerName, country, creditLimit
FROM customers
WHERE country = 'USA' AND creditLimit > 50000
UNION
SELECT customerNumber, customerName, country, creditLimit
FROM customers
WHERE country = 'UK' AND creditLimit > 50000
ORDER BY creditLimit DESC;
