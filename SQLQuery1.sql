CREATE DATABASE Restourant

USE Restourant


CREATE TABLE Meals
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50),
	Price MONEY
)

CREATE TABLE Tables
(
	Id INT PRIMARY KEY IDENTITY,
	TablesNo NVARCHAR(50)
)


CREATE TABLE Orders
(
	Id INT PRIMARY KEY IDENTITY,
	MealId INT FOREIGN KEY REFERENCES Meals(Id),
	TableId INT FOREIGN KEY REFERENCES Tables(Id),
	DateTime DATETIME2
)



SELECT*FROM Meals

INSERT INTO Meals
VALUES
(N'Aş',4),
(N'Pomidor Yumurta',2),
(N'Bozbaş',7),
(N'Dönər',2),
(N'Toyuq',3)


SELECT*FROM Tables

INSERT INTO Tables
VALUES
('s2'),
('m3'),
('r4'),
('t6'),
('u3'),
('d2')



SELECT*FROM Orders

INSERT INTO Orders
VALUES
(1,4,'4-1-2024'),
(1,3,'2-18-2024'),
(2,6,'3-19-2024'),
(3,4,'2-23-2024'),
(2,3,'3-12-2024'),
(3,1,'3-7-2024'),
(5,6,'2-25-2024'),
(4,1,'2-20-2024')



--1, Bütün masa datalarını yanında o masaya edilmiş sifariş sayı ilə birlikdə select edən query--
select * , (Select COUNT(*) from Orders where Orders.TableId = Tables.Id) As OrdersCount from Tables


--2, Bütün yeməkləri o yeməyin sifariş sayı ilə select edən query--
select * , (Select COUNT(*) from Orders where Orders.MealId = Meals.Id) As OrdersCount from Meals


--3, Bütün sirafiş datalarını yanında yeməyin adı ilə select edən query--
SELECT o.*, M.Name FROM Orders O left JOIN Meals M ON O.MealId = M.Id


--4, Bütün sirafiş datalarını yanında yeməyin adı və masanın nömrəsi  ilə select edən query--
SELECT O.*, T.TablesNo FROM Orders O  JOIN Tables T ON O.MealId = T.Id

SELECT M.Name, T.TablesNo FROM Meals M full outer JOIN Tables T ON T.Id = M.Id

SELECT O.*, T.TablesNo FROM Orders O  JOIN Tables T ON O.MealId = T.Id


--5, Bütün masa datalarını yanında o masının sifarişlərinin ümumi məbləği ilə select edən query --
select * , (Select SUM(Orders.MealId) from Orders where Orders.TableId = Orders.Id) As Price from Orders


SELECT t.Id, t.TablesNo,COALESCE(SUM(o.MealId),0) AS Total
FROM tables t
LEFT JOIN orders o ON t.Id = o.TableId
GROUP BY t.Id, t.TablesNo;


--6, 1-idli masaya verilmis ilk sifarişlə son sifariş arasında neçə saat fərq olduğunu select edən query--
SELECT DATEDIFF(HOUR, MIN(Orders.DateTime), MAX(Orders.DateTime)) AS Saatferqi FROM Orders WHERE Orders.TableId = 1;


--7, ən son 30-dəqədən əvvəl verilmiş sifarişləri select edən query--
SELECT * FROM Orders WHERE DateTime < DATEADD(MINUTE, 30, GETDATE());




--8, heç sifariş verməmiş masaları select edən query--
SELECT T.Id, T.TablesNo FROM Tables T LEFT JOIN Orders O ON t.Id = O.TableId WHERE O.Id IS NULL;



--9, son 60 dəqiqədə heç sifariş verməmiş masaları select edən query--









