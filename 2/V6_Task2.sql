USE AdventureWorks2012;
GO






















/*a) �������� ������� dbo.Person � ����� �� ���������� ��� Person.Person,
����� ����� xml, uniqueidentifier, �� ������� �������, ����������� � ��������;*/
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


/*b) ��������� ���������� ALTER TABLE, �������� ��� ������� dbo.Person 
��������� ��������� ���� �� ����� BusinessEntityID � PersonType*/
ALTER TABLE dbo.Person
ADD CONSTRAINT PK_Person PRIMARY KEY (BusinessEntityID, PersonType);


/*c) ��������� ���������� ALTER TABLE, �������� ��� ������� dbo.Person ����������� ��� 
���� PersonType, ����� ��������� ��� ����� ���� ������ ���������� �� ������ �GC�,�SP�,�EM�,�IN�,�VC�,�SC�;*/
ALTER TABLE dbo.Person
ADD CONSTRAINT CheckType CHECK (PersonType IN ('GC','SP','EM','IN','VC','SC'));


/*d) ��������� ���������� ALTER TABLE, �������� ��� ������� dbo.Person ����������� 
DEFAULT ��� ���� Title, ������� �������� �� ��������� �n/a�;*/
ALTER TABLE dbo.Person
ADD CONSTRAINT DF_Person_Title DEFAULT 'n/a' FOR Title;


/*e) ��������� ������� dbo.Person ������� �� Person.Person ������ ��� ��� ���, ��� ������� ��� 
�������� � ������� ContactType ��������� ��� �Owner�. ���� Title ��������� ���������� �� ���������;*/
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


/*f) �������� ����������� ���� Title, ��������� ������ ���� �� 4-�� ��������, 
����� ��������� ��������� null �������� ��� ����� ����.*/
ALTER TABLE dbo.Person
ALTER COLUMN Title NVARCHAR(4) NOT NULL;