-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS getPlaces;

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
-- Description:	Creates union table
-- =============================================
CREATE PROCEDURE getPlaces
	-- Parameters
	@placeName VARCHAR(15) 
AS
BEGIN
 
	SELECT City.Name, City.idCity AS IdPlace
	FROM City
	WHERE City.Name LIKE @placeName + '%'
	
	UNION

	SELECT State.Name, State.idState AS IdPlace
	FROM State
	WHERE State.Name LIKE @placeName + '%'

	UNION

	SELECT Country.Name, Country.idCountry AS IdPlace
	FROM Country
	WHERE Country.Name LIKE @placeName + '%'
	
END
GO
