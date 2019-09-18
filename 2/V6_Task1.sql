USE AdventureWorks2012;
GO

/*Вывести на экран самую раннюю дату начала работы сотрудника в каждом отделе. Дату вывести для каждого отдела.*/
SELECT d.Name, MIN(e.HireDate) 'StartDate'
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.Department d ON d.DepartmentID = ed.DepartmentID
GROUP BY d.Name;

/*Вывести на экран название смены сотрудников, работающих на позиции ‘Stocker’. 
Замените названия смен цифрами (Day — 1; Evening — 2; Night — 3).*/
SELECT e.BusinessEntityID, e.JobTitle, s.ShiftID 'ShiftName'
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.Shift s ON s.ShiftID = ed.ShiftID
WHERE e.JobTitle = 'Stocker';


/*Вывести на экран информацию обо всех сотрудниках, с указанием отдела, в котором они работают в настоящий момент.
В названии позиции каждого сотрудника заменить слово ‘and’ знаком & (амперсанд). */
SELECT e.BusinessEntityID, REPLACE(e.JobTitle, 'and', '&') 'Job Title', d.Name 'DepName'
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.Department d ON d.DepartmentID = ed.DepartmentID
WHERE ed.EndDate IS NULL;