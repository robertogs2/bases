-- Create the DB
--CREATE DATABASE BASESTEC;

-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO
-- VIEW Y TOP
PRINT 'Selecting view'
SELECT *
FROM [Employee info]
PRINT 'View selected'

PRINT 'Adding Guatemala'
-- LTRIM
EXEC addCountry @countryName = 'Guatemala'
PRINT 'Added Guatemala'

-- AND Y EXECUTE AS 
PRINT 'Adding Nicaragua and Managua'
EXEC addState @countryOfTheStateName = Nicaragua, @stateName = Managua
PRINT 'Added Nicaragua and Managua'

PRINT 'Adding Panama, Chrirqui and David'
EXEC addCity	@cityName = David,
				@stateOfTheCityName = Chiriqui, 
				@countryName = Panama
PRINT 'Added Panama, Chrirqui and David' 


-- ESCRITURA DE 4 TABLAS Y SCRIPTS ANIDADOS
PRINT 'Adding Panama, Chrirqui, David and Loc1'
EXEC addLocation	@locationDescription = Loc1,
					@cityOfTheLocationName = David,
					@stateName = Chiriqui, 
					@countryOfTheLocationName = Panama
PRINT 'Added Panama, Chrirqui, David and Loc1'


-- MEGA SP, AVG Y CASE
PRINT 'Getting park info unoptimized'
EXEC getParkTourInfoUnoptimized

PRINT 'Getting park info optimized'
EXEC getParkTourInfoOptimized


-- AGREGA PAISES POR XML
PRINT 'Agregando por XML'
EXEC addCountriesXML	@path =  'D:\TEC\Bases\Grupo\Project2\DB_Scripts\5-Scripts\addCountries.xml',
						@fileName = 'addCountries',
						@subSection1 = 'Countries',
						@subSection2 = 'Country'
PRINT 'XML agregado'

-- AGREGA PAISES POR XML Y TVP, MERGE SE USA AQUI
PRINT 'Agregando por XML Y TVP'
EXEC addCountriesXMLTVP	@path =  'D:\TEC\Bases\Grupo\Project2\DB_Scripts\5-Scripts\addCountries2.xml',
						@fileName = 'addCountries',
						@subSection1 = 'Countries',
						@subSection2 = 'Country'
PRINT 'XML agregado'


-- LOCAL CURSOR 
PRINT 'Obteniendo todas las profesiones'
EXEC getAllProfessions	


-- GLOBAL CURSOR  
PRINT 'Obteniendo informacion de todos los parques'	
EXEC getAllParksInfo


-- COALESCE
PRINT 'Obteniendo los nombres de todos los parques'	
EXEC getAllParks



-- SUBSTRING
PRINT 'Obteniene los nombres de los parque con la misma inicial'	
EXEC getParksByLetter @initial = 'A'



-- UNION
PRINT 'Obteniene los nombres de los lugares con la misma inicial'	
EXEC getPlaces @placeName = 'A'


-- DISTINCT
PRINT 'Obteniene los nombres de las personas con nombre diferentes'	
EXEC getDifferentPersons

SELECT *
FROM Country
