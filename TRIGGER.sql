-----------------------------------<< TRIGGERS >>-----------------------------------
/*Create an Audit table, This table will be used to audit the update trials 
on the Hours column, Example: If a user updated the Hours column then the project number, 
the user name that made that update, the date of the modification 
and the value of the old and the new Hours will be inserted into the Audit table*/

CREATE TABLE Audit_table(
	ProjectNo int,
	UserName varchar(max),
	ModifiedDate date,
	Hours_Old int,
	Hours_New int
)
GO
ALTER TRIGGER update_hours
ON [dbo].[Works_for]
AFTER UPDATE
AS
	IF UPDATE(Hours)
		BEGIN
			DECLARE @ProjectNo int, @Hours_Old int, @Hours_New int
			SELECT @ProjectNo = pno, @Hours_New = Hours FROM inserted
			SELECT @Hours_Old = Hours FROM deleted

			INSERT INTO Audit_table VALUES(@ProjectNo, SUSER_NAME(), GETDATE(), @Hours_Old, @Hours_New)
			SELECT * FROM Audit_table
		END
GO
UPDATE Works_for 
SET Hours = 30
WHERE Pno = 100


/*************************************************/
/*Create a trigger that prevents users from altering any table in Company DB.*/
GO
USE Company_SD
GO
CREATE TRIGGER prevent_alter_company
ON DATABASE
FOR ALTER_TABLE
AS
	ROLLBACK
	SELECT 'You can’t alter this database'
	
ALTER TABLE Employee ADD Age INT;

/*************************************************/