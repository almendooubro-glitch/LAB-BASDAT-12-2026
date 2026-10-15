set search_path to classicmodels, public;

-- Soal 1
SELECT
    customerNumber,
    SUM(amount) AS total_pembayaran,
    COUNT(DISTINCT checkNumber) AS jumlah_transaksi,
    MAX(amount) AS pembayaran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4
   AND AVG(amount) > 20000
ORDER BY customerNumber;

-- Soal 2
SELECT
    customerNumber,
    SUM(amount) AS total_pembayaran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_pembayaran DESC;

-- Soal 3
SELECT productline, 
COUNT(productcode) AS jumlah_ragam_produk, 
ROUND(AVG(msrp), 2) AS rata_rata_harga_jual_ritel, STRING_AGG (productname, ' , ') AS daftar_nama_produk 
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

-- Soal 4
SELECT reportsto AS nomor_identifikasi_unik FROM employees where reportsto is not null
EXCEPT 
SELECT employeenumber FROM employees
WHERE jobtitle ILIKE '%VP%' OR jobtitle ILIKE '%President%';

-- Soal 5
SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;


-- Soal 6
SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_dipesan,
    SUM(quantityOrdered * priceEach) AS total_pendapatan_kotor,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_jual,
    MAX(priceEach) - MIN(priceEach) AS rentang_volatilitas_harga
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY total_pendapatan_kotor DESC;


-- Soal 7
SELECT customernumber FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customernumber FROM orders
WHERE status = 'Cancelled' OR status = 'On Hold'
EXCEPT 
SELECT customernumber FROM payments
GROUP BY customernumber
HAVING SUM (amount) > 100000;



-- Study Case
-- Soal 1
SELECT customerNumber, SUM(amount) AS total_pembayaran, AVG(amount) AS rata_rata_pembayaran, COUNT(*) AS jumlah_transaksi
FROM payments
GROUP BY customerNumber
HAVING AVG(amount) > 3000
ORDER BY total_pembayaran DESC;

-- Soal 2
SELECT
 customerNumber,
    customerName,
    country,
    creditLimit
FROM customers
WHERE country IN ('USA', 'UK')
    AND creditLimit > 50000
ORDER BY creditLimit DESC;