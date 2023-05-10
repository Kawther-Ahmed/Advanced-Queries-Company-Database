-----------------------------------<< STORED PROCEDURES >>-----------------------------------
/*Create a stored procedure that will check for the number of employees in the project 100 
if they are more than 3 print a message to the user “'The number of employees in the project 100 is 3 or more'” 
if they are less display a message to the user “'The following employees work for the project p1'” 
in addition to the first name and last name of each one. [Company DB]*/

GO
ALTER PROC check_employees_number
AS
	DECLARE @employees_number int
	SELECT @employees_number = COUNT(e.SSN)
	FROM Employee e
	JOIN Works_for w
	ON w.ESSn = e.SSN
	WHERE w.Pno = 100

	IF @employees_number >= 3
		BEGIN
			SELECT 'The number of employees in the project 100 is 3 or more'
		END
	ELSE
		BEGIN
			SELECT 'The following employees work for the project p1'
			
			SELECT e.Fname +' '+ e.Lname full_name
			FROM Employee e
			JOIN Works_for w
			ON w.ESSn = e.SSN
			WHERE w.Pno = 100
		END
	
GO
check_employees_number


/*************************************************/
/*Create a stored procedure that will be used in case 
there is an old employee has left the project and a new one become instead of him. 
The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) 
and it will be used to update works_for table. [Company DB]*/

GO
CREATE PROC left_employee(@old_Emp_number int, @new_Emp_number int, @project_number int)
AS
	UPDATE works_for
	SET ESSn = @new_Emp_number
	WHERE 
		EXISTS(
			SELECT e.SSN
			FROM Employee e
			WHERE e.SSN = @new_Emp_number )
		AND ESSn = @old_Emp_number 
		AND Pno = @project_number

GO
left_employee 112233, 968574, 100


/*************************************************/

