SET search_path TO classicmodels, public;

-- no1
SELECT customernumber, SUM (amount) AS dana_riil, COUNT(DISTINCT amount) AS jumlah_frekuensi, MAX(amount) FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4 AND AVG(amount) > 20000;

--no2
SELECT customernumber, SUM(amount) AS totalkeseluruhan FROM payments
GROUP BY customernumber
HAVING SUM (amount) > 80000
ORDER BY totalkeseluruhan DESC;

--no3
SELECT productline, COUNT(productcode) AS jumlah_ragam_produk, ROUND(AVG(msrp), 2) AS rata_rata_harga_jual_ritel, STRING_AGG (productname, ' , ') AS daftar_nama_produk FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

-- no4
SELECT reportsto AS nomor_identifikasi_unik FROM employees
EXCEPT 
SELECT employeenumber FROM employees
WHERE jobtitle ILIKE '%VP%' OR jobtitle ILIKE '%President%';

SELECT * FROM employees;
-- no5
SELECT productcode, SUM(quantityordered) AS total_akumulasi_unit, ROUND (AVG(priceeach), 2) FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered)  > 50
ORDER BY total_akumulasi_unit DESC;

-- no6
SELECT productcode AS kode_identifikasi_barang, SUM(quantityordered) AS total_keseluruhan_unit, SUM (quantityordered * priceeach) AS pendapatan_kotor, ROUND (AVG (priceeach), 2) AS rata_rata_harga_riil, (MAX(priceeach) - MIN(priceeach)) AS rentang_volatilitas_harga_jual FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM (quantityordered * priceeach) > 50000
ORDER BY pendapatan_kotor DESC;

-- no7
SELECT customernumber FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customernumber FROM orders
WHERE status = 'Cancelled' OR status = 'On Hold'
EXCEPT 
SELECT customernumber FROM payments
GROUP BY customernumber
HAVING SUM (amount) > 100000;

-- cs
SELECT customernumber, SUM(amount) AS total_pembayaran, ROUND (AVG(amount), 2) AS rata_rata_pembayaran, COUNT(amount) AS jumlah_transaksi FROM payments
GROUP BY customernumber
HAVING AVG(amount) > 3000
ORDER BY SUM(amount) DESC;


-- SELECT customernumber, customername,, creditlimit FROM customers
-- WHERE creditlimit > 50000 
-- UNION 
SELECT 
	customernumber, 
	customername, 
	country, 
	creditlimit 
FROM customers
WHERE 
	creditlimit > 50000 
	AND country IN ('UK')
UNION
SELECT 
	customernumber, 
	customername, 
	country, 
	creditlimit 
FROM customers
WHERE 
	creditlimit > 50000 
	AND country IN ('USA')
ORDER BY creditlimit DESC;