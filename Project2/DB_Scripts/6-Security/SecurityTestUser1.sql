
-- User1 permissions were set for BASESTECBAK data base
USE BASESTECBAK; 

--				____________________________
--_____________/Allowed operations for User1\___________

-- Recover data queries
SELECT * FROM Employee;

SELECT * FROM City;

SELECT * FROM Community;

-- Store data queries
INSERT INTO Characteristic
("Name", "Value")
VALUES
('TestUser1Insert', 'TestUser1Insert');

INSERT INTO Country
("Name")
VALUES
('TestUser1Insert');

-- Reverse changes to return DB to its original state

DELETE FROM Characteristic
WHERE Characteristic.Name = 'TestUser1Insert';

DELETE FROM Country
WHERE Country.Name = 'TestUser1Insert';

-- Store Procedures
EXEC GetChain;

--				______________________________
--_____________/Forbidden operations for User1\___________

-- Recover data queries
SELECT * FROM Park;
SELECT * FROM Person;

-- Store data queries
INSERT INTO AssignedArea
("Name")
VALUES
('Test_User1_Insert');

INSERT INTO Speciality
("Name")
VALUES
('Test_User1_Insert');

-- Reverse changes to return DB to its original state

DELETE FROM AssignedArea
WHERE AssignedArea.Name = 'Test_User1_Insert';

DELETE FROM Speciality
WHERE Speciality.Name = 'Test_User1_Insert';

-- Store Procedures
EXEC GetBeings;