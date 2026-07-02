-- s


use college;
drop DATABASE college;

-- Step 1: Create Database
CREATE DATABASE CollegeDB;

-- Step 2: Use Database
USE CollegeDB;

-- Step 3: Create Student Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Semester INT,
    Marks INT
);

-- Step 4: Insert Sample Data
INSERT INTO Student VALUES
(101, 'Ram', 'CS', 4, 85),
(102, 'Sita', 'IT', 3, 78),
(103, 'Hari', 'CS', 4, 92),
(104, 'Gita', 'BCA', 2, 88),
(105, 'Shyam', 'IT', 1, 75);

-- Step 5: Display Table
SELECT * FROM Student;
CREATE VIEW CS_Students AS
SELECT StudentID, Name, Semester, Marks
FROM Student
WHERE Department = 'CS';

SELECT * FROM CS_Students;

CREATE VIEW TopStudents AS
SELECT StudentID, Name, Department, Marks
FROM Student
WHERE Marks > 80;

SELECT * FROM TopStudents;

DELIMITER //

CREATE PROCEDURE ShowStudents()
BEGIN
    SELECT * FROM Student;
END //

DELIMITER ;

CALL ShowStudents();

--procedure with parameters
DELIMITER //

CREATE PROCEDURE GetStudentByID(IN sid INT)
BEGIN
    SELECT *
    FROM Student
    WHERE StudentID = sid;
END //

DELIMITER ;
CALL GetStudentByID(103);
--create view
DROP VIEW IF EXISTS TopStudents;

CREATE VIEW TopStudents AS
SELECT StudentID, Name, Department, Marks
FROM Student
WHERE Marks > 80;
SELECT * FROM TopStudents;


