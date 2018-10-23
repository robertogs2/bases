-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS getAvailableTours;

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
-- Description:	Uses union to obtain all employees in all
-- the parks, migth be usefull for a company to know this
-- =============================================
CREATE PROCEDURE getAvailableTours
	-- Parameters
		@parkName VARCHAR(15)
AS
BEGIN
	SELECT DISTINCT Tour.Name
    FROM Tour
	INNER JOIN AccommodationXTour	ON Tour.idTour = AccommodationXTour.fk_idTour
	INNER JOIN Accommodation		ON Accommodation.idAccommodation = AccommodationXTour.fk_idAccommodation
	INNER JOIN Park					ON Park.idPark = Accommodation.fk_idPark
	WHERE Park.Name = @parkName;
END
GO
