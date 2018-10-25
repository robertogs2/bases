-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS getAllProfessions;

-- Sets the behavior when null values are found
-- if: WHERE columnName = NULL, no rows are returned.
-- Even if de condition is true and if:
-- WHERE columnName <> NULL, no rows are returned even 
-- if the condition is true in some rows.
SET ANSI_NULLS ON
GO

-- Allows the use of  double quotation marks to represent 
-- identifiers and single quotation to represent literals
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Creates a local cursor and iterates over 
-- all the inserted profesions in the db
-- =============================================
CREATE PROCEDURE getAllProfessions 
	-- Parameters
AS
BEGIN

	DECLARE @ProfessionName AS VARCHAR(25) 
	--Works like a ptr, local scope means is available only in this SQL statement
	DECLARE profName CURSOR LOCAL	
		FOR 
		SELECT Profession.Name 
		FROM Profession 
	-- Gets the data from the cursor, is like a dereference of a ptr, *x
	OPEN profName
	-- gets the next value and inserts it into the variable
	FETCH NEXT FROM profName INTO @ProfessionName	
	WHILE @@fetch_status = 0
	BEGIN
		PRINT @ProfessionName
		FETCH NEXT FROM profName INTO @ProfessionName
	END
	-- Removes the cursor
	CLOSE profName
	DEALLOCATE profName
	
END
GO
