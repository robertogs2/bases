-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

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
-- Description:	4-table modification sp. Adds a location
--				the city, state and country if neededd
-- =============================================
CREATE PROCEDURE addLocation 
	-- Procedure parameters
	@locationDescription VARCHAR(50) = '', 
	@cityOfTheLocationName VARCHAR(15),
	@stateName VARCHAR(15),
	@countryOfTheLocationName VARCHAR(15) 
AS
BEGIN

	-- If the city of the location does not exist its created, the same happens with the state and country
	EXEC addCity	@cityName = @cityOfTheLocationName,
					@stateOfTheCityName = @stateName, 
					@countryName = @countryOfTheLocationName -- Adds a city, state and country if necessary



	-- Check if the location exists, if not create it
	IF (NOT EXISTS (SELECT Location.Description
					FROM Location 
					WHERE Location.Description = @locationDescription AND Location.fk_idCity = (SELECT City.idCity  -- We search for the idCity we need
																								FROM City						
																								WHERE City.Name = @cityOfTheLocationName)))
	BEGIN
		BEGIN TRANSACTION locationAdd
	
			INSERT INTO Location
				(Description, fk_idCity)
			VALUES
				(@locationDescription,(SELECT City.idCity  -- We search for the idCity we need
										FROM City						
										WHERE City.Name = @cityOfTheLocationName));

		COMMIT TRANSACTION locationAdd -- Commit changes to the database, used in case rollback is needed
	END
END
GO
