USE AdventureWorks2012;
GO

/*Вывести на экран список отделов, названия которых начинаются на букву ‘F’ и заканчиваются на букву ‘е’.*/
SELECT d.DepartmentID, d.Name 
FROM HumanResources.Department d
WHERE d.Name LIKE 'F%e';

/*Вывести на экран среднее количество часов отпуска и среднее количество больничных часов у сотрудников. 
Назовите столбцы с результатами ‘AvgVacationHours’ и ‘AvgSickLeaveHours’ для отпусков и больничных соответственно.*/
SELECT AVG(e.VacationHours) 'AvgVacationHours', AVG(e.SickLeaveHours) 'AvgSickLeaveHours'
FROM HumanResources.Employee e;

/*Вывести на экран сотрудников, которым больше 65-ти лет на настоящий момент. Вывести также количество лет, 
прошедших с момента трудоустройства, в столбце с именем ‘YearsWorked’.*/
SELECT e.BusinessEntityID, e.JobTitle, e.Gender ,DATEDIFF(YEAR, e.HireDate, CURRENT_TIMESTAMP) 'YearsWorked' 
FROM HumanResources.Employee e
WHERE DATEDIFF(YEAR, e.BirthDate , CURRENT_TIMESTAMP) > 65;
