
-- User2 permissions were set for BASESTECBAK data base
USE BASESTEC; 

--				____________________________
--_____________/Allowed operations for User2\___________

-- Recover data queries
SELECT * FROM Employee;

SELECT * FROM Country;

-- Store data queries
INSERT INTO Characteristic
("Name", "Value")
VALUES
('Test_User2_Insert', 'Test_User2_Insert');

INSERT INTO City
("Name", fk_idState)
VALUES
('TestUser2Insert', 1);

-- Reverse changes to return DB to its original state

DELETE FROM Characteristic
WHERE Characteristic."Name" = 'Test_User2_Insert';

DELETE FROM City
WHERE City."Name" = 'TestUser2Insert';
-- Store Procedures
EXEC GetBeings;

--				______________________________
--_____________/Forbidden operations for User2\___________

-- Recover data queries
SELECT * FROM Park;
SELECT * FROM Person;

-- Store data queries
INSERT INTO AssignedArea
("Name")
VALUES
('Test_User2_Insert');

INSERT INTO Speciality
("Name")
VALUES
('Test_User2_Insert');

-- Reverse changes to return DB to its original state

DELETE FROM AssignedArea
WHERE AssignedArea.Name = 'Test_User2_Insert';

DELETE FROM Speciality
WHERE Speciality.Name = 'Test_User2_Insert';

-- Store Procedures
EXEC GetChain;