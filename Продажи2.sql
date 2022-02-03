/*Продажи2*/
/*1.Вывести товары, объем остатка (сколько места на складе занимает этот товар) которых на складе превышает значение заданное параметром.*/
DECLARE @V float
SET @V = 100
SELECT Good, QtyInStock * Volume as Volume_on_sclad
FROM Goods
WHERE QtyInStock * Volume > @V

/*2.Вывести города, в которых менее 5-ти покупателей.*/
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(Cust_id) < 5

/*3.Вывести все продажи (дата, ндок, товар, колво, цена) по покупателю, заданному параметром.*/
DECLARE @C float
SET @C = 1

SELECT T2.Cust_ID, T2.Data, T2.DocNum, T1.Good_id, T1.Price, T1.Qty
FROM Docs_data as T1 INNER JOIN Docs as T2 ON T1.DocNum = T2.DocNum
WHERE T2.Cust_ID = @C

/*4.Вывести уникальные наименования товаров, которые продавались в октябре 2021 года.*/
SELECT DISTINCT T3.Good
FROM Docs_data as T1 INNER JOIN Docs as T2 ON T1.DocNum = T2.DocNum INNER JOIN Goods as T3 ON T1.Good_id = T3.Good_id
WHERE MONTH(T2.Data) = 10 AND YEAR(T2.Data) = 2021

/*5.Вывести уникальные города, покупатели из которых покупали товар, заданный параметром.*/
DECLARE @T float
SET @T = 9

SELECT DISTINCT T4.City
FROM (SELECT T2.Cust_ID, T1.Good_id
FROM Docs_data as T1 INNER JOIN Docs as T2 ON T1.DocNum = T2.DocNum) AS T3 INNER JOIN Customers as T4 ON T3.Cust_ID = T4.Cust_id
WHERE T3.Good_id = @T

/*6.Вывести ФИО покупателя, купившего самый дорогой товар в октябре 2021. Самый дорогой товар – товар с самой большой продажной ценой*/
SELECT TOP 1 WITH TIES Customers.Customer
FROM Docs_data as Docs_d INNER JOIN Docs as Docs ON Docs_d.DocNum = Docs.DocNum INNER JOIN Customers as Customers
ON Docs.Cust_ID = Customers.Cust_id
WHERE MONTH(Docs.Data) = 10 AND YEAR(Docs.Data) = 2021
ORDER BY Docs_d.Price desc

/*7.Вывести суммарно проданный объем (сумма(объем*колво)) товара в октябре 2021*/
SELECT SUM(T3.Qty * T4.Volume) AS AllVolume
FROM 
	(SELECT T2.Cust_ID, T1.Good_id, T1.Qty
		FROM Docs_data as T1 
		INNER JOIN Docs as T2 
		ON T1.DocNum = T2.DocNum
		WHERE MONTH(T2.Data) = 10 AND YEAR(T2.Data) = 2021) 
	as T3 
	INNER JOIN Goods as T4 
	ON T3.Good_id = T4.Good_id

/*8.Выбрать город с максимальным оборотом по отпуску товара. Если их несколько, то выводить все.*/
/*Поняла условие в смысле максимальный оборот в целом по отпуску товаров в городах, а не по каждому отдельно*/
SELECT TOP 1 WITH TIES T4.City, SUM(T3.Price * T3.Qty) as Oborot
FROM
(SELECT T2.Cust_ID, T1.Good_id, T1.Price, T1.Qty
		FROM Docs_data as T1 
		INNER JOIN Docs as T2 
		ON T1.DocNum = T2.DocNum) as T3
	INNER JOIN Customers as T4
	ON T3.Cust_ID = T4.Cust_ID
GROUP BY T4.City
ORDER BY Oborot desc

/*9.По каждому покупателю вывести: суммарное колво, суммарную стоимость, суммарную массу и суммарный объем по купленному товару.
 Во втором варианте посчитать это только по товарам, в названии которых есть подстрока «монитор». (можно сделать двумя запросами)*/
 /*Опять же поняла как всё суммарное по всем товарам сразу, а не по каждому*/
SELECT T3.Cust_ID, SUM(T3.Qty) as Суммарное_колво, SUM(T3.Qty * T3.Price) as Суммарная_стоимость, SUM(T3.Qty * T4.Mass) as Суммарная_масса, SUM(T3.Qty * T4.Volume) as Суммарный_объём
FROM
(SELECT T2.Cust_ID, T1.Good_id, T1.Price, T1.Qty
		FROM Docs_data as T1 
		INNER JOIN Docs as T2 
		ON T1.DocNum = T2.DocNum) as T3
	INNER JOIN Goods as T4
	ON T3.Good_id = T4.Good_id
GROUP BY T3.Cust_ID

/*Вариант 2*/
SELECT T3.Cust_ID, SUM(T3.Qty) as Суммарное_колво, SUM(T3.Qty * T3.Price) as Суммарная_стоимость, SUM(T3.Qty * T4.Mass) as Суммарная_масса, SUM(T3.Qty * T4.Volume) as Суммарный_объём
FROM
(SELECT T2.Cust_ID, T1.Good_id, T1.Price, T1.Qty
		FROM Docs_data as T1 
		INNER JOIN Docs as T2 
		ON T1.DocNum = T2.DocNum) as T3
	INNER JOIN Goods as T4
	ON T3.Good_id = T4.Good_id
	WHERE T4.Good like '%монитор%'
GROUP BY T3.Cust_ID

/*10.Вывести документы, в которых суммарная стоимость товара в теле (документы_данные) не совпадает с суммарной стоимостью в заголовке (сумма в документах).*/
SELECT T1.DocNum
FROM (SELECT DocNum, SUM(Price * Qty) as Summ
		FROM Docs_data 
		GROUP BY DocNum) as T1
		INNER JOIN Docs as T2
		ON T1.DocNum = T2.DocNum
	WHERE T1.Summ != T2.Total
	GROUP BY T1.DocNum
		