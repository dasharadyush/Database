/*1.C�������� ����� ���������� � ����� ��������, ���� ��������*/
SELECT SUM(Survived), COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic

/*2.�� ������� ������ ������ ��������� ����� ���������� � ����� ��������, ���� ��������*/
SELECT Pclass, SUM(Survived) as Survived, COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic 
GROUP BY Pclass
ORDER BY Pclass

/*3.�� ������� ������ ������ � ���� ��������� ��������� ����� ����������, ����� �������� � ���� ��������.*/
SELECT Pclass, Sex, SUM(Survived) as Survived, COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic 
GROUP BY Pclass, Sex
ORDER BY Pclass

/*4.�� ������� ����� ����������� ����� ����������, ����� �������� � ���� ��������*/
SELECT Embarked, SUM(Survived) as Survived, COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic 
GROUP BY Embarked
ORDER BY Embarked

/*5.���� ����������� � ���������� ������ ����������*/
SELECT TOP 1 with ties Embarked
FROM Titanic
GROUP BY Embarked
ORDER BY COUNT(PassengerId) desc

/*6.C������ ������� ���������� � ������� ������� �������� � ����������� �� ������ ������ � ����*/
/*������ �������� Age ������������������ ��� NULL, � ������ ������� �������� ��������� �����*/
/*� ��� �������, ����� Left join ������� ���� ����� �� ����� �� ����������, ��� ������� ������ ���� ������ ������, �� ���������*/
SELECT T1.Pclass, T1.Sex, T2.�������_��������, T1.�������
FROM
(SELECT ROUND(AVG(Age), 2) as �������, Pclass, Sex
FROM Titanic 
GROUP BY Pclass, Sex) as T1
LEFT JOIN
(SELECT ROUND(AVG(Age), 2) as �������_��������, Pclass, Sex
FROM Titanic 
WHERE Survived = 1
GROUP BY Pclass, Sex) as T2 ON T1.Pclass = T2.Pclass AND T1.Sex = T2.Sex
ORDER BY T1.Pclass

/*7.������ 10 ����� �� �������� ��������� ������.*/
/*���, �������� ���� ���������, ��� ����� ������� �� �����, � ����� �� ������� ����� ���� �� ��������� �������*/
SELECT TOP 10 with ties *
FROM Titanic
ORDER BY Fare desc

/*8.���� �� ������, ��� ������� ���� � ������ ������� ����������?*/
/*��, ����� ������ ����, ���� ������ ������� ������, � ������� � ������ ������� ��������� ����*/
SELECT Ticket
FROM Titanic
GROUP BY Ticket
HAVING COUNT(DISTINCT Fare) > 1
/*��� ����� �����������*/
SELECT Ticket 
FROM Titanic
GROUP BY Ticket
HAVING COUNT(DISTINCT Embarked) > 1

/*9.��� ������� ������ ������, ������, ���� � ����� ����������� ����� ����������, ����� �������� ����������.*/
/*������� NULL � ������ ���� ��� ��������*/
SELECT T1.Ticket, T1.Pclass, T1.Fare, T1.embarked, T1.Passengers, T2.Survived 
FROM (SELECT COUNT(PassengerId) as Passengers, Ticket, Pclass, Fare, Embarked
FROM Titanic 
GROUP BY Ticket, Pclass, Fare, Embarked) as T1
LEFT JOIN
(SELECT COUNT(Survived) as Survived, Ticket, Pclass, Fare, Embarked
FROM Titanic 
WHERE Survived = 1
GROUP BY Ticket, Pclass, Fare, Embarked) as T2 ON T1.Ticket = T2.Ticket AND 
T1.Pclass = T2.Pclass AND T1.Fare = T2.Fare AND T1.Embarked = T2.Embarked

/*10.������, ��� ������� ����� ���������� ����� 1 � ��� ��������� ������*/
SELECT Ticket
FROM Titanic
GROUP BY Ticket
HAVING COUNT(PassengerId) > 1 AND COUNT(PassengerId) = SUM(Survived)

/*11.������, ������� ��������� ����������� ������, ���� ��� ����� Elizabeth, 
���� ��� ����� Mary (���������� ���������, ��� ����� ��������� ������ ������� � ��� ���������)*/
DECLARE @c float, @b float, @m float, @p float
SET @c = (SELECT COUNT(PassengerId) FROM Titanic WHERE Name like '%Mary%')
SET @b = (SELECT SUM(Survived) FROM Titanic WHERE Name like '%Mary%')
SET @p = (SELECT COUNT(PassengerId) FROM Titanic WHERE Name like '%Elizabeth%')
SET @m = (SELECT SUM(Survived) FROM Titanic WHERE Name like '%Elizabeth%')


SELECT ROUND( @b/@c, 2) as �����������, 'Mary' as Name
UNION
SELECT ROUND( @m/@p, 2) as �����������, 'Elizabeth' as Name

