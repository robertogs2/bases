-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS addCity;

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
-- Description:	Adds a city in a determined state and country,
--				if they dont exist, they are created
-- =============================================
CREATE PROCEDURE addCity 
	@cityName VARCHAR(15),
	@stateOfTheCityName VARCHAR(15),
	@countryName VARCHAR(15) 
AS
BEGIN

	-- If the state of the city does not exist its created, the same happens with the country

	EXEC addState	@stateName = @stateOfTheCityName, 
					@countryOfTheStateName = @countryName	-- Adds a state and its country if necessary



-- Check if the city exists, if not create it
	IF (NOT EXISTS (SELECT City.Name
					FROM City 
					WHERE City.Name = @cityName AND City.fk_idState = (SELECT State.idState  -- We search for the idState we need
																		FROM State						
																		WHERE State.Name = @stateOfTheCityName)))
	BEGIN
		BEGIN TRANSACTION cityAdd
	
			INSERT INTO City
				(Name, fk_idState)
			VALUES
				(@cityName, (SELECT State.idState	-- We search for the idState we need
							FROM State				-- and insert it
							WHERE State.Name = @stateOfTheCityName));

		COMMIT TRANSACTION cityAdd -- Commit changes to the database, used in case rollback is needed
	END
END
GO
