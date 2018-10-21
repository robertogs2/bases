USE BASESTEC;
GO

CREATE VIEW [Employee info]
AS

SELECT      Park.Name AS [Park name],
			Person.Name AS [Employee name], 
			Person.LastName AS [Employee lastname],
			Person.PhoneNumber AS [Employee phone number], 
			Profession.Name AS [Employee profession]

FROM		Park
INNER JOIN	Employee		ON	Park.idPark = Employee.fk_idPark
INNER JOIN	Person		ON	Employee.fk_idPerson = Person.idPerson
INNER JOIN	Profession	ON	Employee.fk_idProfession = Profession.idProfession