-- Specify its usage only on BASESTEC, if removed it doesnt work
USE BASESTEC;
GO

IF OBJECT_ID(N'dbo.normalizeNumber', N'FN') IS NOT NULL
	DROP FUNCTION normalizeNumber;
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
-- Description:	Check if a parameter is null and returns 0
-- else returns the number it contains
-- =============================================
CREATE FUNCTION normalizeNumber 
(
	-- Parameters
	@data INT
)
RETURNS INT
AS
BEGIN
	DECLARE @number INT;

	IF(@data IS NULL)
	BEGIN
		SET @number = 0
	END

	ELSE
	BEGIN
		SET @number = 1
	END

	RETURN @number

END
GO