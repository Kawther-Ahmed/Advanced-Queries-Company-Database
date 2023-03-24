/*1*/
SELECT d.dnum, d.dname, d.MGRSSN, e.Fname
FROM Departments d, Employee e
WHERE d.MGRSSN = e.SSN

/*2*/
SELECT d.dname, p.Pname
FROM Departments d, Project p
WHERE d.Dnum = p.Dnum

/*3*/
SELECT d.Dependent_name, d.Sex, d.Bdate, e.Fname
FROM Dependent d, Employee e
WHERE d.ESSN = e.SSN

/*4*/
SELECT p.Pnumber, p.Pname, p.Plocation 
FROM Project p
WHERE p.Plocation like '%Cairo%' or p.Plocation like '%Alex%'
/* or WHERE City = 'Cairo' OR City = 'Alex' */

/*5*/
SELECT *
FROM Project p
WHERE p.Pname like 'a%'

/*6*/
SELECT e.Fname
FROM Employee e
WHERE e.Dno = 30 and e.Salary between 1000 and 2000

/*7*/
SELECT e.Fname
FROM Employee e
JOIN works_for w
ON w.essn = e.ssn
JOIN Project p
ON w.Pno = p.Pnumber
WHERE e.Dno = 10 and w.Hours >= 10 and p.Pname = 'AL Rabwah'

/*8*/
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

/*9*/
SELECT e.Fname employee, p.Pname project
FROM Employee e
JOIN works_for w
ON w.essn = e.ssn
JOIN Project p
ON w.Pno = p.Pnumber
order by p.Pname

/*10*/
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

/*11*/
SELECT e.Fname, e.Lname, e.Address, e.Bdate, e.Salary, e.Sex, e.SSN
FROM Employee e, Departments d
WHERE e.ssn = d.MGRSSN

/* or
SELECT *
FROM Employee
WHERE SSN IN (SELECT MGRSSN FROM Departments)
*/

/*12*/
SELECT *
FROM Employee e
FULL OUTER JOIN Dependent de
ON e.SSN = de.ESSN

/* or
SELECT E., D.
FROM Employee E Full OUTER JOIN Dependent D
ON E.SSN = D.ESSN
*/


/***************************/
/*1*/
INSERT INTO Employee (Dno, SSN, Superssn, Salary) VALUES (30, 102672, 112233, 3000)
SELECT * FROM Employee

/*2*/
INSERT INTO Employee (Dno, SSN) VALUES (30, 102660)
SELECT * FROM Employee

/*3*/
UPDATE Employee
SET Salary = Salary + (Salary*20/100)
WHERE ssn = 102672

SELECT * FROM Employee

