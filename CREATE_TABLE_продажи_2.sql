CREATE DATABASE MDZ3 -- ������� ���� ��� ����, ������� ��� ��������
GO

USE MDZ3 -- ���� �������� ��� ���� ��� ��������, �� ����� ���� ��������
GO

-- �������� ������ (��������� ������ ���� �����). ��� ������� ������� �������� � ����� ��. 
/*
	���� ������� �� ������������ � ������ ��������, �� �������� ������ �� ������ ����, ������� �� ������ �������� �� ������ Object Explorer (��� ������������ ������ ��������)
*/
CREATE TABLE Docs (DocNum int primary key, Data datetime, Cust_ID int, Total float)
CREATE TABLE Docs_data (DocNum int, Good_id int, Price float, Qty int, primary key(DocNum, Good_id))
CREATE TABLE Goods (Good_id int primary key, Good nvarchar(50), Price float, QtyInStock int, Volume float, Mass float)
CREATE TABLE Customers (Cust_id int primary key, Customer nvarchar(50), City nvarchar(50))

-- ������� ������ (��������� ������ ���� �����)
-- ��� ������ ��������� ������� �� ������, ���� � ��� �� ����� ������ ������. �� ������� ������ �������������� ����� ���������� ����� (� ����� ���� ������� � �������� ��� �������)
INSERT INTO Docs VALUES (1,'20210901 15:00:00',1,186)
INSERT INTO Docs VALUES (2,'20210913 18:00:00',2,955)
INSERT INTO Docs VALUES (3,'20210915 10:00:00',10,10660)
INSERT INTO Docs VALUES (4,'20210915 12:30:00',8,500)
INSERT INTO Docs VALUES (5,'20210923 14:00:00',6,1365)
INSERT INTO Docs VALUES (6,'20210925 12:00:00',4,3571)
INSERT INTO Docs VALUES (7,'20210926 13:15:00',5,772)
INSERT INTO Docs VALUES (8,'20210929 12:50:00',2,80)
INSERT INTO Docs VALUES (9,'20211001 10:30:00',3,467)
INSERT INTO Docs VALUES (10,'20211005 14:30:00',7,204)
INSERT INTO Docs VALUES (11,'20211006 18:30:00',9,808)
INSERT INTO Docs VALUES (12,'20211010 11:30:00',1,470)
INSERT INTO Docs VALUES (13,'20211015 12:30:00',3,6377)
INSERT INTO Docs VALUES (14,'20211016 16:30:00',6,10830)
INSERT INTO Docs VALUES (15,'20211020 10:30:00',8,2351)


INSERT INTO Docs_data VALUES (1,1,147,1)
INSERT INTO Docs_data VALUES (1,2,13,3)
INSERT INTO Docs_data VALUES (2,3,191,5)
INSERT INTO Docs_data VALUES (3,4,891,2)
INSERT INTO Docs_data VALUES (3,5,1609,4)
INSERT INTO Docs_data VALUES (3,6,407,6)
INSERT INTO Docs_data VALUES (4,7,10,1)
INSERT INTO Docs_data VALUES (4,8,483,1)
INSERT INTO Docs_data VALUES (5,9,94,1)
INSERT INTO Docs_data VALUES (5,10,169,3)
INSERT INTO Docs_data VALUES (5,1,135,4)
INSERT INTO Docs_data VALUES (5,2,32,7)
INSERT INTO Docs_data VALUES (6,3,197,1)
INSERT INTO Docs_data VALUES (6,4,894,2)
INSERT INTO Docs_data VALUES (6,5,1586,1)
INSERT INTO Docs_data VALUES (7,6,386,2)
INSERT INTO Docs_data VALUES (8,7,28,3)
INSERT INTO Docs_data VALUES (9,8,467,1)
INSERT INTO Docs_data VALUES (10,9,102,2)
INSERT INTO Docs_data VALUES (11,10,160,4)
INSERT INTO Docs_data VALUES (11,1,168,1)
INSERT INTO Docs_data VALUES (12,2,30,3)
INSERT INTO Docs_data VALUES (12,3,190,2)
INSERT INTO Docs_data VALUES (13,4,911,7)
INSERT INTO Docs_data VALUES (14,5,1587,6)
INSERT INTO Docs_data VALUES (14,6,416,3)
INSERT INTO Docs_data VALUES (14,7,15,4)
INSERT INTO Docs_data VALUES (15,8,451,5)
INSERT INTO Docs_data VALUES (15,9,96,1)

INSERT INTO Goods VALUES (1,'������� Samsung 17 �����',150,5,19.8,3.35)
INSERT INTO Goods VALUES (2,'����� A4Tech 5 ������ �������',20,50,3.083282475,0.575)
INSERT INTO Goods VALUES (3,'������� HP ��������',200,2,61.4321,9)
INSERT INTO Goods VALUES (4,'��������� ���� S5000',900,1,4.65,1.45)
INSERT INTO Goods VALUES (5,'������� Lenovo',1600,3,21.02479335,3.2)
INSERT INTO Goods VALUES (6,'������� Philips 27 ������',400,7,87.528,7.74)
INSERT INTO Goods VALUES (7,'���������� Logitech �����',10,20,2.013244779,0.454)
INSERT INTO Goods VALUES (8,'�������� HTC �������',470,8,2.1638547,0.685)
INSERT INTO Goods VALUES (9,'��������� Intel',100,6,0.00703125,0.027)
INSERT INTO Goods VALUES (10,'����������� ����� Gigabyte',150,7,3.54228615,0.681)

INSERT INTO Customers VALUES (1,'��� ����������','������')
INSERT INTO Customers VALUES (2,'��� ��������������� �������','�����������')
INSERT INTO Customers VALUES (3,'��� ���������� ��� ����','�����������')
INSERT INTO Customers VALUES (4,'�� �������� �������� ��������','������')
INSERT INTO Customers VALUES (5,'��� ������� � ������ ���','����')
INSERT INTO Customers VALUES (6,'��� ��������� ����������','������������')
INSERT INTO Customers VALUES (7,'��� ���� ������','�����-���������')
INSERT INTO Customers VALUES (8,'��� ���������� ��� ���������','������������')
INSERT INTO Customers VALUES (9,'��� ������','�����')
INSERT INTO Customers VALUES (10,'��� ������� ������','�����-���������')


/*
	� ���������� ���������� ������� � ��� ������ �������� �� MDZ3 � 4-�� ���������, � ������ ������� ������ ��������� ��������� ����� ������.
	
	��������� ��� T-SQL, ���� � ��� ������ ����, �� �������� ����������� �������������� �����������.
	� ��� �����, ���� �������� ����������� ��� ������� � ��� �� ������������ � �������� ����, �� �� �����������, ��� �� ����� �����������.
*/