-- Create the DB
--CREATE DATABASE BASESTEC;

-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO
/*
SELECT *
FROM State, Country, City
WHERE	State.fk_idCountry = Country.idCountry AND 
		City.fk_idState = State.idState 
ORDER BY Country.Name
*/

-- SP 4 table modification and subprocedures call
--EXEC addCountry @countryName = Indonesia									-- Adds a country
--EXEC addState @countryOfTheStateName = Indonesia, @stateName = Bali		-- Adds a state in a pre added country
--EXEC addState @countryOfTheStateName = Nicaragua, @stateName = Managua	-- Adds a state and its country
/*EXEC addCity	@cityName = David,
				@stateOfTheCityName = Chiriqui, 
				@countryName = Panama -- Adds a city, state and country */
/*EXEC addLocation	@locationDescription = Loc1,
					@cityOfTheLocationName = David,
					@stateName = Chiriqui, 
					@countryOfTheLocationName = Panama -- Adds a city, state and country*/
