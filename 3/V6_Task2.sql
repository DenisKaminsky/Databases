USE AdventureWorks2012;
GO

/*a) выполните код, созданный во втором задании второй лабораторной работы. 
Добавьте в таблицу dbo.Person поля TotalGroupSales MONEY и SalesYTD MONEY.
Также создайте в таблице вычисляемое поле RoundSales, округляющее значение в поле SalesYTD до целого числа.*/
ALTER TABLE dbo.Person
ADD TotalGroupSales MONEY, SalesYTD MONEY, RoundSales AS (ROUND(SalesYTD, 0));

/*b) создайте временную таблицу #Person, с первичным ключом по полю BusinessEntityID. 
Временная таблица должна включать все поля таблицы dbo.Person за исключением поля RoundSales.*/
CREATE TABLE dbo.#Person (
	BusinessEntityID INT NOT NULL,
	PersonType NCHAR(2) NOT NULL,
	NameStyle BIT NOT NULL,
	Title NVARCHAR(4) NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50) NULL,
	LastName NVARCHAR(50) NOT NULL,
	Suffix NVARCHAR(10) NULL,
	EmailPromotion INT NOT NULL,
	ModifiedDate DATETIME NOT NULL,
	TotalGroupSales MONEY,
	SalesYTD MONEY
	PRIMARY KEY(BusinessEntityID)
);

/*c) заполните временную таблицу данными из dbo.Person. Поле SalesYTD заполните 
значениями из таблицы Sales.SalesTerritory. Посчитайте общую сумму продаж (SalesYTD) 
для каждой группы территорий (Group) в таблице Sales.SalesTerritory и заполните этими значениями поле 
TotalGroupSales. Подсчет суммы продаж осуществите в Common Table Expression (CTE).*/
WITH EMP AS (SELECT
	p.BusinessEntityID, 
	p.PersonType, 
	p.NameStyle,
	p.Title,
	p.FirstName, 
	p.MiddleName, 
	p.LastName , 
	p.Suffix,
	p.EmailPromotion, 
	p.ModifiedDate,
	SUM(st.SalesYTD) AS TotalGroupSales
FROM dbo.Person p
INNER JOIN Person.BusinessEntityAddress bea ON bea.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address a ON a.AddressID = bea.AddressID
INNER JOIN Person.StateProvince sp ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN Sales.SalesTerritory st ON st.CountryRegionCode = sp.CountryRegionCode
GROUP BY
	p.BusinessEntityID, 
	p.PersonType, 
	p.NameStyle,
	p.Title,
	p.FirstName, 
	p.MiddleName, 
	p.LastName , 
	p.Suffix,
	p.EmailPromotion, 
	p.ModifiedDate ;)

SELECT
	p.BusinessEntityID, 
	p.PersonType, 
	p.NameStyle,
	p.Title,
	p.FirstName, 
	p.MiddleName, 
	p.LastName , 
	p.Suffix,
	p.EmailPromotion, 
	p.ModifiedDate
FROM dbo.Person p
/*INNER JOIN Person.BusinessEntityAddress bea ON bea.BusinessEntityID = p.BusinessEntityID*/
/*INNER JOIN Person.Address a ON a.AddressID = bea.AddressID
INNER JOIN Person.StateProvince sp ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN Person.CountryRegion cr ON cr.CountryRegionCode = sp.CountryRegionCode
INNER JOIN Sales.SalesTerritory st ON st.CountryRegionCode = cr.CountryRegionCode*/
GROUP BY
	p.BusinessEntityID, 
	p.PersonType, 
	p.NameStyle,
	p.Title,
	p.FirstName, 
	p.MiddleName, 
	p.LastName , 
	p.Suffix,
	p.EmailPromotion, 
	p.ModifiedDate

/*d) удалите из таблицы dbo.Person строки, где EmailPromotion = 2*/
DELETE FROM dbo.Person WHERE EmailPromotion = 2;

/*e) напишите Merge выражение, использующее dbo.Person как target,
а временную таблицу как source. Для связи target и source используйте BusinessEntityID. 
Обновите поля TotalGroupSales и SalesYTD, если запись присутствует в source и target. 
Если строка присутствует во временной таблице, но не существует в target, добавьте строку 
в dbo.Person. Если в dbo.Person присутствует такая строка, которой не существует
во временной таблице, удалите строку из dbo.Person.*/