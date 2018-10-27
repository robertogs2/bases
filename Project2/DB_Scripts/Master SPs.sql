-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO


-- This command sets all country related sps to compile again
EXEC sp_recompile N'Country';  
GO



-- Creates the global cursor for getAllParksInfo
IF CURSOR_STATUS('global','globalParkInfo')>=-1
BEGIN
 DEALLOCATE globalParkInfo
END

DECLARE globalParkInfo CURSOR GLOBAL
FOR
SELECT Park.Name, Park.foundationDate
FROM Park
  


-- Drop all before creating the SPs again

-- INSERTS --
DROP PROCEDURE IF EXISTS addCountry;
DROP PROCEDURE IF EXISTS addState;
DROP PROCEDURE IF EXISTS addCity;
DROP PROCEDURE IF EXISTS addLocation;
DROP PROCEDURE IF EXISTS dbo.addCountriesXMLOpenRowSet;

-- GETTERS --
DROP PROCEDURE IF EXISTS getAllParks;
DROP PROCEDURE IF EXISTS getAllParksInfo;
DROP PROCEDURE IF EXISTS getAllProfessions;
DROP PROCEDURE IF EXISTS getAvailableTours;
DROP PROCEDURE IF EXISTS getParksByLetter;
DROP PROCEDURE IF EXISTS getPlaces;
DROP PROCEDURE IF EXISTS getToursCheaper;
DROP PROCEDURE IF EXISTS getParkTourInfoUnoptimized;
DROP PROCEDURE IF EXISTS getParkTourInfoOptimized;

-- GETTERS FOR NEO4J --
DROP PROCEDURE IF EXISTS GetBeings;
DROP PROCEDURE IF EXISTS GetChain;



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


-- ================================================= INSERT PLACES ================================================= --


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

	-- We create a try catch to rollback when errors occur and commit when they dont
	PRINT 'BEFORE TRY addCountry'
	BEGIN TRY
		BEGIN TRANSACTION;
			PRINT 'First Statement in the addCountry TRY block'
			-- If the country doesnt exists we add it
			IF (NOT EXISTS (SELECT dbo.Country.Name
						FROM dbo.Country 
						WHERE dbo.Country.Name = @countryName))
			BEGIN
				INSERT INTO Country
					(Name)
				VALUES
					(LTRIM(@countryName));
			END

			PRINT 'Last Statement in the addCountry TRY block'
		COMMIT TRANSACTION; -- Commit changes to the database, used in case rollback is needed
	END TRY
	BEGIN CATCH
		PRINT 'In CATCH Block'
		-- @@TRANCOUNT is used to realiably detect errors in nested transactions
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRANSACTION;
		
		THROW; -- raise error to the client
	END CATCH;
	PRINT 'After END CATCH'
END
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

	PRINT 'BEFORE TRY addState'
	BEGIN TRY
		BEGIN TRANSACTION 
			PRINT 'First Statement in the addState TRY block'

			-- Check if the country of the state exists, if not create it
			EXEC addCountry @countryName = @countryOfTheStateName

			-- Check if the state exists, if not create it
			IF (NOT EXISTS (SELECT State.Name
							FROM State 
							WHERE State.Name = @stateName AND State.fk_idCountry = (SELECT Country.idCountry AS country -- We search for the idCountry we need
																					FROM Country						
																					WHERE Country.Name = @countryOfTheStateName)))
			BEGIN -- BEGIN IF
					INSERT INTO State
						(Name, fk_idCountry)
					VALUES
						(@stateName, (	SELECT Country.idCountry AS country -- We search for the idCountry we need
										FROM Country						-- and insert it as the fk
										WHERE Country.Name = @countryOfTheStateName));
			END --END IF
			PRINT 'Last Statement in the addState TRY block'

		COMMIT TRANSACTION  -- Commit changes to the database, used in case rollback is needed
	END TRY
	BEGIN CATCH
		PRINT 'In CATCH Block'
		 -- @@TRANCOUNT is used to realiably detect errors in nested transactions
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRANSACTION;
		
		THROW; -- raise error to the client
	END CATCH
	PRINT 'After END CATCH'
END
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

	PRINT 'BEFORE TRY addCity'
	BEGIN TRY
		BEGIN TRANSACTION 
			PRINT 'First Statement in the addCity TRY block'

			-- If the state of the city does not exist its created, the same happens with the country
			EXEC addState	@stateName = @stateOfTheCityName, 
							@countryOfTheStateName = @countryName	-- Adds a state and its country if necessary



			-- Check if the city exists, if not create it
			IF (NOT EXISTS (SELECT City.Name
							FROM City 
							WHERE City.Name = @cityName AND City.fk_idState = (SELECT State.idState  -- We search for the idState we need
																				FROM State						
																				WHERE State.Name = @stateOfTheCityName)))
			BEGIN -- BEGIN IF

				INSERT INTO City
					(Name, fk_idState)
				VALUES
					(@cityName, (SELECT State.idState	-- We search for the idState we need
								FROM State				-- and insert it
								WHERE State.Name = @stateOfTheCityName));
			END --END IF
			PRINT 'Last Statement in the addCity TRY block'
		COMMIT TRANSACTION  -- Commit changes to the database, used in case rollback is needed
	END TRY
	BEGIN CATCH
		PRINT 'In CATCH Block'
		 -- @@TRANCOUNT is used to realiably detect errors in nested transactions
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRANSACTION;
		
		THROW; -- raise error to the client
	END CATCH
	PRINT 'After END CATCH'
END
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

	PRINT 'BEFORE TRY addLocation'
	BEGIN TRY
		BEGIN TRANSACTION 
			PRINT 'First Statement in the addLocation TRY block'

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
			BEGIN -- BEGIN IF
	
					INSERT INTO Location
						(Description, fk_idCity)
					VALUES
						(@locationDescription,(SELECT City.idCity  -- We search for the idCity we need
												FROM City						
												WHERE City.Name = @cityOfTheLocationName));
			END --END IF

			PRINT 'Last Statement in the addLocation TRY block'
		COMMIT TRANSACTION  -- Commit changes to the database, used in case rollback is needed
	END TRY
	BEGIN CATCH
		PRINT 'In CATCH Block'
		 -- @@TRANCOUNT is used to realiably detect errors in nested transactions
		IF(@@TRANCOUNT > 0)
			ROLLBACK TRANSACTION;
		
		THROW; -- raise error to the client
	END CATCH
	PRINT 'After END CATCH'
END
GO

-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Inserts data into a table by XML parsing
-- =============================================
CREATE PROCEDURE addCountriesXMLOpenRowSet
	-- Add the parameters for the stored procedure here
	@path VARCHAR(max),
	@fileName VARCHAR(20),
	@subSection1 VARCHAR(15),
	@subSection2 VARCHAR(15)
AS
BEGIN


		-- OpenRowSet doesnt accept parameters so we create a query and concatenate
		-- the info we need and then execute it
		DECLARE @value varchar(22)= 'Name[1]'', ''VARCHAR(15)'
		DECLARE @node varchar(max)= '/' + @fileName +'/' + @subSection1 +'/' + @subSection2 +''
		DECLARE @SQLStr varchar(max)='
		USE BASESTEC;

		DECLARE @fileData  XML

		SELECT @fileData = BulkColumn FROM OpenRowSet(Bulk'''+ @path +''',Single_blob) x;


		INSERT INTO Country
			("Name") 
		SELECT
			xData.value('''+ @value +''') "Name"       
		FROM @fileData.nodes('''+ @node +''') AS x(xData)'

		PRINT 'XML add script generated'
		BEGIN TRY
			BEGIN TRANSACTION 
				PRINT 'Executing script'
				EXECUTE(@SQLStr);
				PRINT 'Script executed'
			COMMIT TRANSACTION  
		END TRY
		BEGIN CATCH
			PRINT 'In CATCH Block'
			 -- @@TRANCOUNT is used to realiably detect errors in nested transactions
			IF(@@TRANCOUNT > 0)
				ROLLBACK TRANSACTION;
		
			THROW; -- raise error to the client
		END CATCH
		PRINT 'After END CATCH'
END
GO







-- ================================================= GETTERS ================================================= --

-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Uses COALESCE to iterate over all park names
-- and returns them together in one line
-- =============================================
CREATE PROCEDURE getAllParks
AS
BEGIN

	DECLARE @parkName VARCHAR(MAX) 

	-- COALESCE is used as a pivot, it takes the name of every park
	-- concatenates it and return the result string with all the names
	
	-- COALESCE function is to return the first not NULL value it gets
	SELECT @parkName = COALESCE(@parkName,'') + Park.Name + '; '  
	FROM Park 

	SELECT @parkName AS ParkNames 
	
END
GO

-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Creates a global cursor and iterates over 
-- all the inserted parks in the db getting its name and fundation date
-- =============================================
CREATE PROCEDURE getAllParksInfo 
AS
BEGIN

	OPEN globalParkInfo

	FETCH NEXT FROM globalParkInfo
	WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH NEXT FROM globalParkInfo
	END
	CLOSE globalParkInfo
	DEALLOCATE globalParkInfo
	
END
GO

-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Creates a local cursor and iterates over 
-- all the inserted profesions in the db getting its name
-- =============================================
CREATE PROCEDURE getAllProfessions 
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


-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Uses SUBSTRING to search parks by
-- its initial letter
-- =============================================
CREATE PROCEDURE getParksByLetter
	-- Parameters
	@initial CHAR
AS
BEGIN

	SELECT  Park.Name
	FROM Park 
	WHERE SUBSTRING(Park.Name, 1, 1) = @initial;
	
END
GO


-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Creates union table, with all places 
-- in the db that have similar initials
-- =============================================
CREATE PROCEDURE getPlaces
	-- Parameters
	@placeName VARCHAR(15) 
AS
BEGIN
 
	-- Search a city whose name starts with @placeName
	SELECT City.Name, City.idCity AS IdPlace
	FROM City
	WHERE City.Name LIKE @placeName + '%'
	
	UNION

	-- Search a state whose name starts with @placeName
	SELECT State.Name, State.idState AS IdPlace
	FROM State
	WHERE State.Name LIKE @placeName + '%'

	UNION

	-- Search a country whose name starts with @placeName
	SELECT Country.Name, Country.idCountry AS IdPlace
	FROM Country
	WHERE Country.Name LIKE @placeName + '%'

	-- And get them all together with the union
	
END
GO

-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Gets Tours cheaper than a limit price
-- =============================================
CREATE PROCEDURE getToursCheaper 
	-- Procedure parameters
	@parkName VARCHAR(50), 
	@price INT
AS
BEGIN
	
	SELECT Tour.Name, Tour.Price
	FROM Park					
	INNER JOIN Accommodation		ON Accommodation.fk_idPark = Park.idPark
	INNER JOIN AccommodationXTour	ON AccommodationXTour.fk_idAccommodation = Accommodation.idAccommodation
	INNER JOIN Tour					ON Tour.idTour = AccommodationXTour.fk_idTour
	WHERE Park.Name = @parkName and Tour.Price <= 20

END
GO


CREATE PROCEDURE getParkTourInfoUnoptimized
	-- Parameters
AS
BEGIN

	SELECT	CONVERT( varchar,Park.Name) as[Park name],

			(	SELECT COUNT(ResearchProject.idResearchProject)
				FROM ResearchProject) AS [Cantidad de investigaciones],

			(	SELECT Presupuesto = 
				CASE
					-- If there are no investigations it ill be NULL so we check if that happens
					-- if its not NULL then we return the average 
					WHEN dbo.normalizeNumber(AVG(ResearchProject.Budget)) = 1 THEN AVG(ResearchProject.Budget)
					-- if its NULL we return 0
					ELSE 0
				END
				FROM ResearchProject) AS [Average budget for investigation],

			COUNT(Tour.idTour) AS [Number of Tours in the park],

			(	SELECT COUNT(Employee.idEmployee)
				FROM Employee) AS [Amount of workers],

			COUNT(Vehicle.idVehicle) AS [Amount of park vehicles]



	FROM	Park 
			INNER jOIN Vehicle				ON	Vehicle.fk_idPark = Park.idPark
			INNER JOIN Accommodation		ON	Accommodation.fk_idPark = Park.idPark
			INNER JOIN AccommodationXTour	ON	AccommodationXTour.fk_idAccommodation = Accommodation.fk_idPark
			INNER JOIN Tour					ON	Tour.idTour = AccommodationXTour.fk_idTour 

GROUP BY(Park.Name)
ORDER BY(Park.Name)
END
GO

-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Gets all relevant info in the parks.
-- Optimized version
-- =============================================
CREATE PROCEDURE getParkTourInfoOptimized
	-- Parameters
AS
BEGIN

	SELECT	Park.Name as[Park name],

			COUNT(ResearchProject.idResearchProject) AS [Cantidad de investigaciones],

			(	SELECT Presupuesto = 
				CASE
					-- If there are no investigations it ill be NULL so we check if that happens
					-- if its not NULL then we return the average 
					WHEN ISNUMERIC(AVG(ResearchProject.Budget)) = 1 THEN AVG(ResearchProject.Budget)
					-- if its NULL we return 0
					ELSE 0
				END) AS [Average budget for investigation],

			COUNT(Tour.idTour) AS [Number of Tours in the park],

			COUNT(Employee.idEmployee) AS [Amount of workers],

			COUNT(Vehicle.idVehicle) AS [Amount of park vehicles]



	FROM	Park 
			INNER JOIN Accommodation			ON	Accommodation.fk_idPark = Park.idPark
			INNER JOIN AccommodationXTour		ON	AccommodationXTour.fk_idAccommodation = Accommodation.fk_idPark
			INNER JOIN Tour						ON	Tour.idTour = AccommodationXTour.fk_idTour 
			INNER JOIN Employee					ON	Employee.fk_idPark = Park.idPark
			INNER JOIN ResearchProjectXEmployee	ON	ResearchProjectXEmployee.fk_idEmployee = Employee.idEmployee
			INNER JOIN ResearchProject			ON	ResearchProject.idResearchProject = ResearchProjectXEmployee.fk_idResearchProject
			INNER jOIN Vehicle					ON	Vehicle.fk_idPark = Park.idPark

GROUP BY(Park.Name)
ORDER BY(Park.Name)
END
GO












-- ================================================= GETTERS FOR NEO4J ================================================= --


-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Gets all the foodchain actors
-- =============================================
CREATE PROCEDURE GetBeings 
AS
BEGIN
	WITH IDTable 
	AS (SELECT fk_idConsumer AS id FROM FoodChainLink
	UNION
	SELECT fk_idFood AS id FROM FoodChainLink)
	SELECT IDSpecies, fk_idSpeciesType AS IDType, ScientificName, NonScientificName FROM Species
	INNER JOIN IDTable ON IDTable.id = Species.idSpecies
	WHERE fk_idSpeciesType = 1 OR fk_idSpeciesType = 2
END
GO


-- =============================================
-- Author:		CodingBrotherhood
-- Create date: 
-- Description:	Gets the relations between food and depredator
-- =============================================
CREATE PROCEDURE GetChain 
AS
BEGIN
	SELECT fk_idConsumer AS IDConsumer, fk_idFood AS IDFood
	FROM FoodChainLink
END
GO













