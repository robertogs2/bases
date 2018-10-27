
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
('Test_User1_Insert', 'Test_User1_Insert');

INSERT INTO Country
("Name")
VALUES
('Test_User1_Insert');

-- Reverse changes to return DB to its original state

DELETE FROM Characteristic
WHERE Characteristic.Name = 'Test_User1_Insert';

DELETE FROM Country
WHERE Country.Name = 'Test_User1_Insert';

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