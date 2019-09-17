USE AdventureWorks2012;
GO

/*Select all departments which start with 'F' and end with 'e'*/
SELECT d.DepartmentID, d.Name 
FROM HumanResources.Department d
WHERE d.Name LIKE 'F%e';

/*Select average count of Vacation hours and average of Sick leave hours*/
SELECT AVG(e.VacationHours) 'AvgVacationHours', AVG(e.SickLeaveHours) 'AvgSickLeaveHours'
FROM HumanResources.Employee e;

/*Select employees older than 65 and their years worked*/
SELECT e.BusinessEntityID, e.JobTitle, e.Gender ,DATEDIFF(YEAR, e.HireDate, CURRENT_TIMESTAMP) 'YearsWorked' 
FROM HumanResources.Employee e
WHERE DATEDIFF(YEAR, e.BirthDate , CURRENT_TIMESTAMP) > 65;



