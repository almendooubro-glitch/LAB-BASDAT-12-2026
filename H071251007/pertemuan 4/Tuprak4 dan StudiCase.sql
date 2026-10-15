SET search_path TO classicmodels, public;

--AGGREGATE FUNCTION
-- count
SELECT COUNT(*) as total_pesanan FROM orders;
SELECT COUNT(DISTINCT country) as jumlah_negara FROM customers;

-- sum
SELECT SUM(quantityordered * priceeach) as total_pendapatan FROM orderdetails;

--avg
SELECT ROUND(AVG(buyprice), 2) as laba_bersih FROM products;

--min max
SELECT MIN(amount) as terkecil,
	MAX(amount) as terbesar
FROM payments; --kalau teks, itu mengurutkan dari abjad a(terkecil)-z(terbesar)
	
SELECT MIN(customername) as terkecil,
	MAX(customername) as terbesar
FROM customers; --kalau teks, itu mengurutkan dari abjad a(terkecil)-z(terbesar)

--string_agg
SELECT STRING_AGG(DISTINCT productline, ', ' ORDER BY productline) AS daftar_produk
FROM productlines;

SELECT COUNT(*) AS total_item_terjual,
	SUM(quantityOrdered * priceEach) AS total_pendapatan, 
	ROUND(AVG(priceEach), 2) AS rata_rata_harga_jual, 
	MIN(priceEach) AS harga_jual_termurah, MAX(priceEach) AS harga_jual_tertinggi
FROM orderdetails;

--GROUP BY 	
SELECT productCode AS "Kode Produk", COUNT (productCode) AS "Banyak Produk"
FROM orderdetails
GROUP BY productCode
ORDER BY COUNT (productCode) ASC
LIMIT 5;

SELECT DISTINCT productcode FROM orderdetails;

SELECT country, city, COUNT(*) AS jumlah_pelanggan
FROM customers
GROUP BY country, city
ORDER BY jumlah_pelanggan DESC;

--having
SELECT customernumber, SUM(amount) AS total_pendapatan
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 10000
ORDER BY total_pendapatan DESC;

--where having
SELECT customernumber, SUM(amount) AS total_pendapatan
FROM payments
WHERE amount > 10000
GROUP BY customernumber
HAVING SUM(amount) > 10000
ORDER BY total_pendapatan DESC;

--SET OPERATIONS
--union: operasi yang digunakan untuk menggabungkan dua atau lebih query menjadi satu hasil akhir, yg sama hanya tampil 1 kali
SELECT customernumber as "ID", customername as "nama"
FROM customers
UNION
SELECT employeenumber, CONCAT(firstname, ' ', lastname)
FROM employees;

SELECT 'Produk' AS kategori, COUNT(*) AS total
FROM products
UNION ALL
SELECT 'Pesanan' AS kategori, COUNT (*) FROM orders;

SELECT customerNumber, customerName, country 
FROM customers
WHERE country = 'USA' AND creditLimit > 1000 
UNION
SELECT customerNumber, customerName, country 
FROM customers
WHERE country = 'UK' AND creditLimit > 1000;

SELECT customerNumber, customerName, country 
FROM customers
WHERE country = 'USA' AND creditLimit > 1000 
UNION
SELECT customerNumber, customerName, country 
FROM customers
WHERE country = 'UK' AND creditLimit > 1000
ORDER BY customernumber DESC;

--intersect, yg sama diambil
SELECT customernumber FROM customers
INTERSECT
SELECT customernumber FROM payments;

SELECT customernumber FROM customers
WHERE contactfirstname LIKE 'A%'
INTERSECT
SELECT customernumber FROM payments;

-- except, yg sm skip 
SELECT customernumber FROM customers
EXCEPT
SELECT customernumber FROM orders;

SELECT customernumber FROM orders
WHERE orderdate >= '2003-01-01' --ada disini
EXCEPT
SELECT customernumber FROM payments
WHERE amount > 5000; -- tapi tidk ada disini

SELECT customernumber FROM customers
WHERE contactfirstname LIKE 'B%'
EXCEPT
SELECT customernumber FROM payments;

-- STUDICASE PRAKTIKUM
SELECT MIN(amount) as terkecil,
	MAX(amount) as terbesar,
	SUM(amount) as total_pembayaran
FROM payments;

SELECT customernumber, SUM(amount) as total_pembayaran, 
	ROUND(AVG(amount), 2) as rata_rata_pembayaran, COUNT(customernumber) as jumlah_transaksi
FROM payments
GROUP BY customernumber
HAVING SUM(rata_rata_pembayaran) > 10000;




-- TUGAS PRAKTIKUM 4
--No.1
SELECT 
	customerNumber AS nomor_pelanggan, 
	SUM(amount) AS total_akumulasi,
	COUNT(checknumber) AS frekuensi_transaksi,
	MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(checkNumber) > 4 AND ROUND(AVG(amount), 3) > 20000;

--No.2
SELECT
	customerNumber AS nomor_pelanggan,
	SUM(amount) AS total_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

--No.3
SELECT 
	productLine AS kategori_barang,
	COUNT(productCode) AS jumlah_ragam_produk,
	ROUND(AVG(msrp), 2) AS rata_harga_ritel,
	STRING_AGG(productName, ', ' ORDER BY productName) AS daftar_produk
FROM products
GROUP BY productLine
HAVING COUNT(productCode) > 10;

SELECT productLine FROM products;

--No.4
SELECT reportsto FROM employees
EXCEPT
SELECT employeenumber
FROM employees
WHERE jobtitle LIKE '%VP%' OR jobtitle LIKE '%President%';

--No.5
SELECT 
    productCode AS kode_identifikasi_barang,
    SUM(quantityOrdered) AS total_unit_terjual,
    ROUND(AVG(priceEach), 2) AS rata_harga_riil
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

--No.6
SELECT
	productCode AS kode_identifikasi_barang,
	SUM(quantityOrdered) AS total_barang_terpesan,
	SUM(quantityOrdered * priceEach) AS pendapatan_kotor,
	ROUND(AVG(priceEach), 2) AS rata_harga_ril_satuan_barang,
	(MAX(priceEach) - MIN(priceEach)) AS rentang_volatilitas_harga
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY pendapatan_kotor DESC;

--No.7
SELECT customernumber 
FROM customers 
WHERE creditlimit > 80000
    
INTERSECT
SELECT customernumber 
FROM orders 
WHERE status IN ('Cancelled', 'On Hold');

EXCEPT
SELECT customernumber
FROM payments 
GROUP BY customernumber 
HAVING SUM(amount) > 100000;



-- STUDI CASE ASISTENSI
--no.1
SELECT 
	customerNumber,
	SUM(amount) AS total_pembayaran,
	ROUND(AVG(amount), 2) AS rata_rata_pembayaran,
	COUNT(amount) AS jumlah_transaksi
FROM payments
GROUP BY customerNumber
HAVING AVG(amount) > 3000
ORDER BY total_pembayaran DESC;

--no.2
SELECT
	customerNumber,
	customerName,
	country,
	creditLimit
FROM customers
WHERE country IN ('USA') AND creditLimit > 50000
UNION
SELECT
	customerNumber,
	customerName,
	country,
	creditLimit
FROM customers
WHERE country IN ('UK') AND creditLimit > 50000
ORDER BY creditLimit DESC;