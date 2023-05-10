-----------------------------------<< VIEWS >>-----------------------------------
/*Create a view that will display the project name and the number of employees works on it.*/
GO
CREATE VIEW project_view
AS
	SELECT pro.Pname Project_name, COUNT(emp.SSN) Employees_Number
	FROM Project pro
	JOIN Works_for wofor
	ON wofor.Pno = pro.Pnumber
	JOIN Employee emp
	ON wofor.ESSn = emp.SSN
	GROUP BY pro.Pname
GO
SELECT * FROM project_view


/*************************************************/
/*Create a view named “v_D30” that will display employee number, project number, 
hours of the projects in department 30.*/
GO
CREATE VIEW v_D30
AS
	SELECT EMP.SSN Employee_Number, pro.Pnumber Project_Number, wofor.Hours
	FROM Employee emp
	JOIN Departments dept
	ON emp.Dno = dept.Dnum
	JOIN Works_for wofor
	ON wofor.ESSn = emp.SSN
	JOIN Project pro
	ON wofor.Pno = pro.Pnumber
	WHERE dept.Dnum = 30
GO
SELECT * FROM v_D30


/*************************************************/
/*Create a view named “v_count“ that will display the project name and the number of hours for each one. */
GO
CREATE VIEW v_count
AS
	SELECT pro.Pname Project_Name, SUM(wofor.Hours) Hours
	FROM Project pro
	JOIN Works_for wofor
	ON wofor.Pno = pro.Pnumber
	GROUP BY pro.Pname
GO
SELECT * FROM v_count


/*************************************************/
/*Create a view named ”v_project_500” that will display the emp no. 
for the project 500, use the previously created view  “v_D30”*/
GO
CREATE VIEW v_project_500
AS
	SELECT v_D30.Employee_Number
	FROM v_D30
	WHERE v_D30.Project_Number = 500
GO
SELECT * FROM v_project_500


/*************************************************/
/*Delete the views “v_D30” and “v_count”*/
DROP VIEW v_D30
DROP VIEW v_count


/*************************************************/
/*Make a rule that makes sure the value is less than 1000 then bind it on the Salary in Employee table.*/
GO
CREATE RULE less_than_1000
AS @variable<1000
GO
sp_bindrule less_than_1000, 'Employee.Salary'

INSERT INTO Employee (SSN, Salary) VALUES (2050, 500)
SELECT * FROM Employee


/*************************************************/
/*Create a new user data type named loc with the following Criteria:
•	nchar(2)
•	default: NY 
•	create a rule for this Datatype :values in (NY,DS,KW)) and associate it to the location column*/
CREATE TYPE loc FROM NCHAR(2);
GO
CREATE RULE values_from 
AS @list IN ('NY','DS','KW')
GO
sp_bindrule values_from, loc
GO
CREATE DEFAULT d 
AS 'NY'
GO
sp_bindefault d, loc


/*************************************************/
/*Create a New table Named newStudent, and use the new user define data type on it you just have made and*/
CREATE TABLE newStudent(
	location loc,
	name varchar(50)
)

INSERT INTO newStudent(name, location) VALUES('Ali', 'gg')
INSERT INTO newStudent(name, location) VALUES('Ali', 'KW')