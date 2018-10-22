-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS addCountry;

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
-- Description:	Adds a country
-- =============================================
CREATE PROCEDURE addCountry 
	-- Parameters
	@countryName VARCHAR(15) 
AS
BEGIN

	IF (NOT EXISTS (SELECT dbo.Country.Name
						FROM dbo.Country 
						WHERE dbo.Country.Name = @countryName))
	BEGIN
		BEGIN TRANSACTION countryAdd
			INSERT INTO Country
				(Name)
			VALUES
				(@countryName);
		COMMIT TRANSACTION countryAdd -- Commit changes to the database, used in case rollback is needed
	END
	
END
GO
