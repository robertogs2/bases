USE BASESTEC
GO

IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'triggerStateAdded'
     AND parent_class_desc = N'BASESTEC'
)
	DROP TRIGGER triggerStateAdded ON DATABASE
GO
-- A trigger does an action when a given action occurs
CREATE TRIGGER triggerStateAdded  
	ON State 
	AFTER INSERT -- In this case an insert  
	AS RAISERROR ('New state added', 16, 10);   
GO
