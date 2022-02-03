/*�������2*/
/*1.������� ������, ����� ������� (������� ����� �� ������ �������� ���� �����) ������� �� ������ ��������� �������� �������� ����������.*/
DECLARE @V float
SET @V = 100
SELECT Good, QtyInStock * Volume as Volume_on_sclad
FROM Goods
WHERE QtyInStock * Volume > @V

/*2.������� ������, � ������� ����� 5-�� �����������.*/
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(Cust_id) < 5

/*3.������� ��� ������� (����, ����, �����, �����, ����) �� ����������, ��������� ����������.*/
DECLARE @C float
SET @C = 1

SELECT T2.Cust_ID, T2.Data, T2.DocNum, T1.Good_id, T1.Price, T1.Qty
FROM Docs_data as T1 INNER JOIN Docs as T2 ON T1.DocNum = T2.DocNum
WHERE T2.Cust_ID = @C

/*4.������� ���������� ������������ �������, ������� ����������� � ������� 2021 ����.*/
SELECT DISTINCT T3.Good
FROM Docs_data as T1 INNER JOIN Docs as T2 ON T1.DocNum = T2.DocNum INNER JOIN Goods as T3 ON T1.Good_id = T3.Good_id
WHERE MONTH(T2.Data) = 10 AND YEAR(T2.Data) = 2021

/*5.������� ���������� ������, ���������� �� ������� �������� �����, �������� ����������.*/
DECLARE @T float
SET @T = 9

SELECT DISTINCT T4.City
FROM (SELECT T2.Cust_ID, T1.Good_id
FROM Docs_data as T1 INNER JOIN Docs as T2 ON T1.DocNum = T2.DocNum) AS T3 INNER JOIN Customers as T4 ON T3.Cust_ID = T4.Cust_id
WHERE T3.Good_id = @T

/*6.������� ��� ����������, ��������� ����� ������� ����� � ������� 2021. ����� ������� ����� � ����� � ����� ������� ��������� �����*/
SELECT TOP 1 WITH TIES Customers.Customer
FROM Docs_data as Docs_d INNER JOIN Docs as Docs ON Docs_d.DocNum = Docs.DocNum INNER JOIN Customers as Customers
ON Docs.Cust_ID = Customers.Cust_id
WHERE MONTH(Docs.Data) = 10 AND YEAR(Docs.Data) = 2021
ORDER BY Docs_d.Price desc

/*7.������� �������� ��������� ����� (�����(�����*�����)) ������ � ������� 2021*/
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

/*8.������� ����� � ������������ �������� �� ������� ������. ���� �� ���������, �� �������� ���.*/
/*������ ������� � ������ ������������ ������ � ����� �� ������� ������� � �������, � �� �� ������� ��������*/
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

/*9.�� ������� ���������� �������: ��������� �����, ��������� ���������, ��������� ����� � ��������� ����� �� ���������� ������.
 �� ������ �������� ��������� ��� ������ �� �������, � �������� ������� ���� ��������� ��������. (����� ������� ����� ���������)*/
 /*����� �� ������ ��� �� ��������� �� ���� ������� �����, � �� �� �������*/
SELECT T3.Cust_ID, SUM(T3.Qty) as ���������_�����, SUM(T3.Qty * T3.Price) as ���������_���������, SUM(T3.Qty * T4.Mass) as ���������_�����, SUM(T3.Qty * T4.Volume) as ���������_�����
FROM
(SELECT T2.Cust_ID, T1.Good_id, T1.Price, T1.Qty
		FROM Docs_data as T1 
		INNER JOIN Docs as T2 
		ON T1.DocNum = T2.DocNum) as T3
	INNER JOIN Goods as T4
	ON T3.Good_id = T4.Good_id
GROUP BY T3.Cust_ID

/*������� 2*/
SELECT T3.Cust_ID, SUM(T3.Qty) as ���������_�����, SUM(T3.Qty * T3.Price) as ���������_���������, SUM(T3.Qty * T4.Mass) as ���������_�����, SUM(T3.Qty * T4.Volume) as ���������_�����
FROM
(SELECT T2.Cust_ID, T1.Good_id, T1.Price, T1.Qty
		FROM Docs_data as T1 
		INNER JOIN Docs as T2 
		ON T1.DocNum = T2.DocNum) as T3
	INNER JOIN Goods as T4
	ON T3.Good_id = T4.Good_id
	WHERE T4.Good like '%�������%'
GROUP BY T3.Cust_ID

/*10.������� ���������, � ������� ��������� ��������� ������ � ���� (���������_������) �� ��������� � ��������� ���������� � ��������� (����� � ����������).*/
SELECT T1.DocNum
FROM (SELECT DocNum, SUM(Price * Qty) as Summ
		FROM Docs_data 
		GROUP BY DocNum) as T1
		INNER JOIN Docs as T2
		ON T1.DocNum = T2.DocNum
	WHERE T1.Summ != T2.Total
	GROUP BY T1.DocNum
		