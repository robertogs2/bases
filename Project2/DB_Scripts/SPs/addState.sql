-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS addState;

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
-- Description:	Adds a state in a counrtry, if the country 
--				doesnt exists, its added
-- =============================================
CREATE PROCEDURE addState 
	-- Parameters
	@stateName VARCHAR(15),
	@countryOfTheStateName VARCHAR(15) 
WITH EXECUTE AS OWNER-- Gives permision for table creation and alteration
AS
BEGIN

	-- Check if the country of the state exists, if not create it
	EXEC addCountry @countryName = @countryOfTheStateName

	-- Check if the state exists, if not create it
	IF (NOT EXISTS (SELECT State.Name
					FROM State 
					WHERE State.Name = @stateName AND State.fk_idCountry = (SELECT Country.idCountry AS country -- We search for the idCountry we need
																			FROM Country						
																			WHERE Country.Name = @countryOfTheStateName)))
	BEGIN
		BEGIN TRANSACTION stateAdd
	
			INSERT INTO State
				(Name, fk_idCountry)
			VALUES
				(@stateName, (	SELECT Country.idCountry AS country -- We search for the idCountry we need
								FROM Country						-- and insert it as the fk
								WHERE Country.Name = @countryOfTheStateName));

		COMMIT TRANSACTION stateAdd -- Commit changes to the database, used in case rollback is needed
	END
END
GO
