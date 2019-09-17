USE AdventureWorks2012;
GO


















/*Select the earliest employee start date in each department*/
SELECT d.Name, MIN(e.HireDate) 'StartDate'
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.Department d ON d.DepartmentID = ed.DepartmentID
GROUP BY d.Name;

/*Select all employees with job title 'Stocker' and their ShiftIndex*/
SELECT e.BusinessEntityID, e.JobTitle, s.ShiftID 'ShiftName'
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.Shift s ON s.ShiftID = ed.ShiftID
WHERE e.JobTitle = 'Stocker';


/* Select all employees with current department and replace 'and' on '&' in JobTitle */
SELECT e.BusinessEntityID, REPLACE(e.JobTitle, 'and', '&') 'Job Title', d.Name 'DepName'
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.Department d ON d.DepartmentID = ed.DepartmentID
WHERE ed.EndDate IS NULL;