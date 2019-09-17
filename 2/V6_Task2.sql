USE AdventureWorks2012;
GO






















/*a) создайте таблицу dbo.Person с такой же структурой как Person.Person,
кроме полей xml, uniqueidentifier, не включа€ индексы, ограничени€ и триггеры;*/
CREATE TABLE dbo.Person (
	BusinessEntityID INT NOT NULL,
	PersonType NCHAR(2) NOT NULL,
	NameStyle BIT NOT NULL,
	Title NVARCHAR(8) NULL,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50) NULL,
	LastName NVARCHAR(50) NOT NULL,
	Suffix NVARCHAR(10) NULL,
	EmailPromotion INT NOT NULL,
	ModifiedDate DATETIME NOT NULL
)


/*b) использу€ инструкцию ALTER TABLE, создайте дл€ таблицы dbo.Person 
составной первичный ключ из полей BusinessEntityID и PersonType*/
ALTER TABLE dbo.Person
ADD CONSTRAINT PK_Person PRIMARY KEY (BusinessEntityID, PersonType);


/*c) использу€ инструкцию ALTER TABLE, создайте дл€ таблицы dbo.Person ограничение дл€ 
пол€ PersonType, чтобы заполнить его можно было только значени€ми из списка СGCТ,ТSPТ,ТEMТ,ТINТ,ТVCТ,ТSCТ;*/
ALTER TABLE dbo.Person
ADD CONSTRAINT CheckType CHECK (PersonType IN ('GC','SP','EM','IN','VC','SC'));


/*d) использу€ инструкцию ALTER TABLE, создайте дл€ таблицы dbo.Person ограничение 
DEFAULT дл€ пол€ Title, задайте значение по умолчанию Сn/aТ;*/
ALTER TABLE dbo.Person
ADD CONSTRAINT DF_Person_Title DEFAULT 'n/a' FOR Title;


/*e) заполните таблицу dbo.Person данными из Person.Person только дл€ тех лиц, дл€ которых тип 
контакта в таблице ContactType определен как СOwnerТ. ѕоле Title заполните значени€ми по умолчанию;*/
INSERT INTO dbo.Person (
	BusinessEntityID, 
	PersonType, 
	NameStyle, 
	FirstName, 
	MiddleName, 
	LastName , 
	Suffix,
	EmailPromotion, 
	ModifiedDate)
SELECT 
	p.BusinessEntityID,
	p.PersonType,
    p.NameStyle,
	p.FirstName,
	p.MiddleName,
	p.LastName,
	p.Suffix,
	p.EmailPromotion,
	p.ModifiedDate
FROM Person.Person p
INNER JOIN Person.BusinessEntityContact bc ON bc.PersonID = p.BusinessEntityID
INNER JOIN Person.ContactType c ON c.ContactTypeID = bc.ContactTypeID
WHERE c.Name = 'Owner';


/*f) измените размерность пол€ Title, уменьшите размер пол€ до 4-ти символов, 
также запретите добавл€ть null значени€ дл€ этого пол€.*/
ALTER TABLE dbo.Person
ALTER COLUMN Title NVARCHAR(4) NOT NULL;