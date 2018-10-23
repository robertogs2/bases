-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS getAllParks;

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
-- Description:	Creates a global cursor and iterates over 
-- all the inserted parks in the db
-- =============================================
CREATE PROCEDURE getAllParks
	-- Parameters

AS
BEGIN

	DECLARE @parkName VARCHAR(MAX) 

	-- Coalescense is used as a pivot, it takes the name of every park
	-- concatenates it and return the result string with all the names
	SELECT @parkName = COALESCE(@parkName,'') + Park.Name + '; '  
	FROM Park 

	SELECT @parkName AS ParkNames 
	
END
GO
