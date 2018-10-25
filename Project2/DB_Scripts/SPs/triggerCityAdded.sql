USE BASESTEC
GO

IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'triggerCityAdded'
     AND parent_class_desc = N'BASESTEC'
)
	DROP TRIGGER triggerCityAdded ON DATABASE
GO
-- A trigger does an action when a given action occurs
CREATE TRIGGER triggerCityAdded  
	ON City 
	AFTER INSERT -- In this case an insert  
	AS RAISERROR ('New city added', 16, 10);   
GO
