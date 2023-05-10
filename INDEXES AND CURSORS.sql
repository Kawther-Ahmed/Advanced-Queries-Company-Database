-----------------------------------<< INDEXES AND CURSORS >>-----------------------------------
/*In Company_SD in employee table Check if Gender='M' add 'Mr Befor Employee name    
else if Gender='F' add Mrs Befor Employee name  then display all names  
use cursor for update*/
DECLARE c2 CURSOR
FOR
	SELECT Gender
	FROM Employee
FOR UPDATE
DECLARE @gender VARCHAR(20)
OPEN c2
FETCH c2 INTO @gender
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@gender = 'M')
			BEGIN
				UPDATE Employee
				SET Fname = 'Mr' + ' ' + Fname
				WHERE CURRENT OF c2
			END
		ELSE IF (@gender = 'F')
			BEGIN
				UPDATE Employee
				SET Fname = 'Mrs' + ' ' + Fname
				WHERE CURRENT OF c2
			END

		FETCH c2 INTO @gender
	END
SELECT * FROM Employee
CLOSE c2
DEALLOCATE c2


/*******************************************************/
CREATE UNIQUE NONCLUSTERED INDEX in2
ON [dbo].[Departments](MGRSSN)
