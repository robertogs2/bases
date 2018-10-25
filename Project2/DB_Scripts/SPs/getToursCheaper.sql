-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

DROP PROCEDURE IF EXISTS getToursCheaper;


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
-- Description:	Gets Tors cheaper than a limit in a park
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
	WHERE Park.Name = 'Acadia' and Tour.Price <= 20
	--@parkName

END
GO
