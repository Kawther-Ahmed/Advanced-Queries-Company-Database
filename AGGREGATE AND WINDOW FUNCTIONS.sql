-----------------------------------<< AGGREGATE AND WINDOW FUNCTIONS >>-----------------------------------
/*For each project, list the project name and 
the total hours per week (for all employees) spent on that project.*/
SELECT p.Pname, SUM(w.Hours) total_hours
FROM Project p
JOIN Works_for w
ON w.Pno = p.Pnumber
GROUP BY p.Pname


/*******************************************************/
/*Display the data of the department which has 
the smallest employee ID over all employees' ID.*/
SELECT TOP 1 d.*
FROM Employee e
JOIN Departments d
ON e.Dno = d.Dnum
ORDER BY e.SSN


/*******************************************************/
/*For each department, retrieve the department name and the maximum, 
minimum and average salary of its employees.*/
SELECT d.Dname, MAX(e.Salary) max_salay, MIN(e.Salary) min_salary, AVG(e.Salary) avg_salary
FROM Departments d
JOIN Employee e
ON e.Dno = d.Dnum
GROUP BY d.Dname


/*******************************************************/
/*For each department-- if its average salary is less than the average 
salary of all employees-- display its number, 
name and number of its employees.*/
SELECT d.Dnum, d.Dname,COUNT(e.SSN) dept_employees_num, AVG(e.Salary) dept_avg_salary
FROM Employee e
JOIN Departments d
ON e.Dno = d.Dnum
GROUP BY d.Dnum, d.Dname
HAVING AVG(e.Salary) < (
			SELECT AVG(Salary)
			FROM Employee)


/*******************************************************/
/*Try to get the max 2 salaries*/
SELECT TOP 2 Salary
FROM Employee
ORDER BY Salary DESC


/*******************************************************/
/*Find Highest two projects in working hours For each department*/
SELECT * 
FROM 
	(SELECT p.Dnum, p.Pname, 
		ROW_NUMBER() OVER(PARTITION BY p.Dnum ORDER BY SUM(w.Hours) DESC) AS highest_hours
		--,DENSE_RANK() OVER(PARTITION BY p.Dnum ORDER BY w.Hours DESC) AS DS
	FROM Project p
	JOIN Works_for w
	ON w.Pno = p.Pnumber
	GROUP BY p.Dnum, p.Pname) AS hours_table
WHERE highest_hours <=2



--without sum
SELECT * 
FROM 
	(SELECT p.Dnum, p.Pname, 
		ROW_NUMBER() OVER(PARTITION BY p.Dnum ORDER BY w.Hours DESC) AS highest_hours
		--,DENSE_RANK() OVER(PARTITION BY p.Dnum ORDER BY w.Hours DESC) AS DS
	FROM Project p
	JOIN Works_for w
	ON w.Pno = p.Pnumber) AS NEW
WHERE highest_hours <=2
--WHERE DS <=5

-----old try
SELECT p.Dnum, p.Pname, SUM(w.Hours) total_hours
FROM Project p
JOIN Works_for w
ON w.Pno = p.Pnumber
GROUP BY p.Dnum, p.Pname
ORDER BY p.Dnum