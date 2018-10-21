-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS dbo.addCountriesXMLOpenRowSet;


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

		EXECUTE(@SQLStr);
END
GO