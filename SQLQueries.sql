---------------------------------------<< SELECT >>---------------------------------------
/*Display the Department id, name and id and the name of its manager.*/
SELECT d.dnum, d.dname, d.MGRSSN, e.Fname
FROM Departments d, Employee e
WHERE d.MGRSSN = e.SSN


/***************************************************/
/*Display the name of the departments and the name of the projects under its control.*/
SELECT d.dname, p.Pname
FROM Departments d, Project p
WHERE d.Dnum = p.Dnum


/***************************************************/
/*Display the full data about all the dependence 
associated with the name of the employee they depend on him/her.*/
SELECT d.Dependent_name, d.Sex, d.Bdate, e.Fname
FROM Dependent d, Employee e
WHERE d.ESSN = e.SSN


/***************************************************/
/*Display the Id, name and location of the projects in Cairo or Alex city.*/
SELECT p.Pnumber, p.Pname, p.Plocation 
FROM Project p
WHERE p.Plocation like '%Cairo%' or p.Plocation like '%Alex%'
/* or WHERE City = 'Cairo' OR City = 'Alex' */


/***************************************************/
/*Display the Projects full data of the projects with a name starts with "a" letter.*/
SELECT *
FROM Project p
WHERE p.Pname like 'a%'


/***************************************************/
/*display all the employees in department 30 whose salary from 1000 to 2000 LE monthly*/
SELECT e.Fname
FROM Employee e
WHERE e.Dno = 30 and e.Salary between 1000 and 2000


/***************************************************/
/*Retrieve the names of all employees in department 10 who works more than 
or equal10 hours per week on "AL Rabwah" project.*/
SELECT e.Fname
FROM Employee e
JOIN works_for w
ON w.essn = e.ssn
JOIN Project p
ON w.Pno = p.Pnumber
WHERE e.Dno = 10 and w.Hours >= 10 and p.Pname = 'AL Rabwah'


/***************************************************/
/*Find the names of the employees who directly supervised with Kamel Mohamed.*/
SELECT e.Fname, s.Fname
FROM Employee e 
JOIN Employee s
ON e.Superssn = s.SSN
WHERE s.Fname = 'Kamel' AND s.Lname = 'Mohamed'
/* or 
SELECT Fname, Lname
From Employee 
WHERE SSN IN (SELECT Superssn FROM Employee WHERE Fname = 'Kamel' AND Lname = 'Mohamed')
*/


/***************************************************/
/*Retrieve the names of all employees and the names of the projects they are working on, 
sorted by the project name.*/
SELECT e.Fname employee, p.Pname project
FROM Employee e
JOIN works_for w
ON w.essn = e.ssn
JOIN Project p
ON w.Pno = p.Pnumber
order by p.Pname


/***************************************************/
/*For each project located in Cairo City , find the project number, 
the controlling department name ,the department manager last name ,address and birthdate.*/
SELECT p.Pnumber, p.Pname project, d.Dname, e.Lname, e.Address, e.Bdate
FROM Project p
JOIN works_for w
ON w.Pno = p.Pnumber
JOIN Employee e
ON w.essn = e.ssn
JOIN Departments d
ON e.SSN = d.MGRSSN
WHERE p.City = 'Cairo'

/* or
SELECT P.Pnumber, P.Dnum, E.Lname, E.Address, E.Bdate
FROM Departments D INNER JOIN Project P 
ON D.Dnum = P.Dnum
INNER JOIN Employee E 
ON E.SSN = D.MGRSSN
WHERE P.City = 'Cairo'
*/


/***************************************************/
/*Display All Data of the mangers*/
SELECT e.Fname, e.Lname, e.Address, e.Bdate, e.Salary, e.Sex, e.SSN
FROM Employee e, Departments d
WHERE e.ssn = d.MGRSSN

/* or
SELECT *
FROM Employee
WHERE SSN IN (SELECT MGRSSN FROM Departments)
*/


/***************************************************/
/*Display All Employees data and the data of their dependents even if they have no dependents*/
SELECT *
FROM Employee e
FULL OUTER JOIN Dependent de
ON e.SSN = de.ESSN

/* or
SELECT E., D.
FROM Employee E Full OUTER JOIN Dependent D
ON E.SSN = D.ESSN
*/


---------------------------------------<< DML >>---------------------------------------
/*Insert your personal data to the employee table as a new employee 
in department number 30, SSN = 102672, Superssn = 112233, salary=3000.*/
INSERT INTO Employee (Dno, SSN, Superssn, Salary) VALUES (30, 102672, 112233, 3000)
SELECT * FROM Employee

/*Insert another employee with personal data your friend as new employee in department number 30, 
SSN = 102660, but don’t enter any value for salary or manager number to him.*/
INSERT INTO Employee (Dno, SSN) VALUES (30, 102660)
SELECT * FROM Employee

/*Upgrade your salary by 20 % of its last value.*/
UPDATE Employee
SET Salary = Salary + (Salary*20/100)
WHERE ssn = 102672

SELECT * FROM Employee

