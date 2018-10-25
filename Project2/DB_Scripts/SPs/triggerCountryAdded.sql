USE BASESTEC
GO

IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'triggerCountryAdded'
     AND parent_class_desc = N'BASESTEC'
)
	DROP TRIGGER triggerCountryAdded ON DATABASE
GO
-- A trigger does an action when a given action occurs
CREATE TRIGGER triggerCountryAdded  
	ON Country 
	AFTER INSERT -- In this case an insert  
	AS RAISERROR ('New country added', 16, 10);   
GO


