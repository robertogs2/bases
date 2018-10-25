-- Create the DB
--CREATE DATABASE BASESTEC;

-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO
/*
SELECT *
FROM Country
*/

EXEC getPlaces @placeName = 'a'


-- EXEC getAllProfessions		-- Local cursor test
-- EXEC getAllParksInfo			-- Global cursor test




-- SELECT * FROM [Employee info] -- View query
-- Add multiple countries by XML using tvp
/*EXEC addCountriesXMLTVP	@path =  'D:\TEC\Bases\Grupo\Project2\DB_Scripts\SPs\addCountries2.xml',
						@fileName = 'addCountries',
						@subSection1 = 'Countries',
						@subSection2 = 'Country'*/

-- Add multiple countries by XML the normal way
/*EXEC addCountriesXMLOpenRowSet	@path =  'D:\TEC\Bases\Grupo\Project2\DB_Scripts\SPs\addCountries.xml',
						@fileName = 'addCountries',
						@subSection1 = 'Countries',
						@subSection2 = 'Country'*/

--Mega SP
--EXEC getParkTourInfo

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
