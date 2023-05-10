-----------------------------------<< FUNCTIONS >>-----------------------------------
/*Create a function that takes project number and display all employees in this project*/
GO
CREATE FUNCTION get_project_employees(@number int)
RETURNS TABLE
AS
RETURN (
	SELECT e.Fname +' ' + e.Lname Full_Name
	FROM Employee e
	JOIN Works_for w
	ON w.ESSn = e.SSN
	WHERE w.Pno = @number
)
GO
SELECT * FROM get_project_employees(400)


/*************************************************/
/*write a Query that computes the increment in salary that arises if 
the salary of employees increased by any value.*/
DECLARE @old_salary int 
SELECT @old_salary = Salary
FROM Employee
WHERE SSN = 112233

UPDATE Employee 
SET Salary = 1300
WHERE SSN = 112233

SELECT salary new_salary, @old_salary old_salary, (((salary - @old_salary)*100) / salary) AS increment
FROM Employee
WHERE SSN = 112233


/*************************************************/
/*write a Query that computes the increment in salary that arises if 
the salary of employees increased by any value.*/
GO
CREATE FUNCTION get_increment (@id int, @new_salary int)
RETURNS int
AS
BEGIN
	DECLARE @old_salary int 
	SELECT @old_salary = Salary
		FROM Employee
		WHERE SSN = @id
	UPDATE Employee 
		SET Salary = @new_salary
		WHERE SSN = @id
	DECLARE @increment int
	SELECT @increment = salary - @old_salary
		FROM Employee
		WHERE SSN = @id
	RETURN @increment
END
GO

SELECT * FROM [dbo].get_increment(112233, 4000)