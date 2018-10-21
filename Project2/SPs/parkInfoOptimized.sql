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
-- Description:	Park and tours info
-- =============================================
CREATE PROCEDURE getParkTourInfoOpt
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
