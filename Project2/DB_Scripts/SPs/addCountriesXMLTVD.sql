USE BASESTEC;
	GO
	DROP PROCEDURE IF EXISTS dbo.insertCountryTVP;
	DROP TYPE IF EXISTS dbo.CountryTableType;

	CREATE TYPE CountryTableType AS TABLE   
	("Name" VARCHAR(15));
	GO  

	/* Create a procedure to receive data for the table-valued parameter. */
	  
	CREATE PROCEDURE insertCountryTVP 
		@TVP CountryTableType READONLY  
    AS   
    --SET NOCOUNT ON  
	INSERT INTO Country  
           (Name)  
        SELECT *
        FROM  @TVP; 
        GO 

	DECLARE @LocationTVP AS CountryTableType;
	DECLARE @fileData  XML

	SELECT @fileData = BulkColumn FROM OpenRowSet(Bulk'D:\TEC\Bases\Grupo\bases\Project2\DB_Scripts\SPs\addCountries2.xml',Single_blob) x;


	INSERT INTO  @LocationTVP
		("Name") 
	SELECT
		xData.value('Name[1]', 'VARCHAR(15)') "Name"       
	FROM @fileData.nodes('/addCountries/Countries/Country') AS x(xData);

/* Pass the table variable data to a stored procedure. */  
EXEC insertCountryTVP @LocationTVP;  
GO 