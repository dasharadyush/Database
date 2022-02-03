/*1.Cуммарное колво пассажиров и колво выживших, доля выживших*/
SELECT SUM(Survived), COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic

/*2.По каждому классу билета суммарное колво пассажиров и колво выживших, доля выживших*/
SELECT Pclass, SUM(Survived) as Survived, COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic 
GROUP BY Pclass
ORDER BY Pclass

/*3.По каждому классу билета и полу пассажира суммарное колво пассажиров, колво выживших и долю выживших.*/
SELECT Pclass, Sex, SUM(Survived) as Survived, COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic 
GROUP BY Pclass, Sex
ORDER BY Pclass

/*4.По каждому порту отправления колво пассажиров, колво выживших и долю выживших*/
SELECT Embarked, SUM(Survived) as Survived, COUNT(PassengerId) as Passengers, 
ROUND(CAST(SUM(Survived) as float)/CAST(COUNT(PassengerId) as float), 2) as 'Proportion of survivors'
FROM Titanic 
GROUP BY Embarked
ORDER BY Embarked

/*5.Порт отправления с наибольшим колвом пассажиров*/
SELECT TOP 1 with ties Embarked
FROM Titanic
GROUP BY Embarked
ORDER BY COUNT(PassengerId) desc

/*6.Cредний возраст пассажиров и средний возраст выживших в группировке по классу билета и полу*/
/*Пустые значения Age проимпортировались как NULL, а значит среднее значение считается верно*/
/*Я так понимаю, через Left join среднее если никто не выжил не потеряется, как сделать именно этот запрос короче, не придумала*/
SELECT T1.Pclass, T1.Sex, T2.Средний_выживших, T1.Средний
FROM
(SELECT ROUND(AVG(Age), 2) as Средний, Pclass, Sex
FROM Titanic 
GROUP BY Pclass, Sex) as T1
LEFT JOIN
(SELECT ROUND(AVG(Age), 2) as Средний_выживших, Pclass, Sex
FROM Titanic 
WHERE Survived = 1
GROUP BY Pclass, Sex) as T2 ON T1.Pclass = T2.Pclass AND T1.Sex = T2.Sex
ORDER BY T1.Pclass

/*7.Первые 10 строк по убыванию стоимости билета.*/
/*Нет, запросом ниже убедилась, что тариф написан за билет, а билет по таблице может быть на несколько человек*/
SELECT TOP 10 with ties *
FROM Titanic
ORDER BY Fare desc

/*8.Есть ли билеты, для которых цена в разных строках отличается?*/
/*Да, такие билеты есть, этот запрос выводит билеты, у которых в разных строках различная цена*/
SELECT Ticket
FROM Titanic
GROUP BY Ticket
HAVING COUNT(DISTINCT Fare) > 1
/*Для порта отправления*/
SELECT Ticket 
FROM Titanic
GROUP BY Ticket
HAVING COUNT(DISTINCT Embarked) > 1

/*9.Для каждого номера билета, класса, цены и порта отправления колво пассажиров, колво выживших пассажиров.*/
/*Выводит NULL в случае если нет выживших*/
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

/*10.Билеты, для которых колво пассажиров более 1 и все пассажиры выжили*/
SELECT Ticket
FROM Titanic
GROUP BY Ticket
HAVING COUNT(PassengerId) > 1 AND COUNT(PassengerId) = SUM(Survived)

/*11.Запрос, который посчитает вероятность выжить, если Вас зовут Elizabeth, 
если Вас зовут Mary (достаточно посчитать, что такая подстрока должна входить в имя пассажира)*/
DECLARE @c float, @b float, @m float, @p float
SET @c = (SELECT COUNT(PassengerId) FROM Titanic WHERE Name like '%Mary%')
SET @b = (SELECT SUM(Survived) FROM Titanic WHERE Name like '%Mary%')
SET @p = (SELECT COUNT(PassengerId) FROM Titanic WHERE Name like '%Elizabeth%')
SET @m = (SELECT SUM(Survived) FROM Titanic WHERE Name like '%Elizabeth%')


SELECT ROUND( @b/@c, 2) as Вероятность, 'Mary' as Name
UNION
SELECT ROUND( @m/@p, 2) as Вероятность, 'Elizabeth' as Name

