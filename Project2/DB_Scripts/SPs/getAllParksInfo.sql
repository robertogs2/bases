-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS getAllParksInfo;

DECLARE globalParkInfo CURSOR GLOBAL
FOR
SELECT Park.Name, Park.foundationDate
FROM Park

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
-- Description:	Creates a global cursor and iterates over 
-- all the inserted parks in the db
-- =============================================
CREATE PROCEDURE getAllParksInfo 
	-- Parameters
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
