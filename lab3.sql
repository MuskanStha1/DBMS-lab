CREATE DATABASE College;
drop DATABASE College;
use College;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_hour INT
);

-- Create Enrollment Table
CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
SELECT *FROM enrollment;
INSERT INTO Students (student_id, name, age, email, phone_number) VALUES
(1, 'Alice Smith', 20, 'alice@example.com', '555-0101'),
(2, 'Bob Johnson', 22, 'bob@example.com', '555-0102'),
(3, 'Charlie Brown', 19, 'charlie@example.com', '555-0103'),
(4, 'Diana Prince', 21, 'diana@example.com', '555-0104'),
(5, 'Evan Wright', 23, 'evan@example.com', '555-0105');

-- Insert Data into Courses
INSERT INTO courses (course_id, name, credit_hour) VALUES
(101, 'Introduction to Computer Science', 3),
(102, 'Data Structures', 4),
(103, 'Database Management Systems', 3),
(104, 'Web Development', 3),
(105, 'Artificial Intelligence', 4);

-- Insert Data into Enrollment
INSERT INTO enrollment (enrollment_id, course_id, student_id) VALUES
(1001, 101, 1),
(1002, 103, 1),
(1003, 102, 2),
(1004, 104, 2),
(1005, 101, 3),
(1006, 105, 4),
(1007, 103, 5),
(1008, 105, 5),
(1009, 102, 1);



--performing lab questions
--q1 basic selection and filiering
SELECT *FROM Students;
--q2
SELECT name , email FROM Students;
--q3
SELECT *FROM students where age>20;
--q4 using like operator
SELECT name FROM students where name like 'a%';
--q5 
SELECT name FROM courses where name like '%science%';
--q6 sorting age in descending
SELECT *FROM students ORDER BY age DESC;
--q7
SELECT *FROM students where phone_number like '555-0105';
--crud operations
--part1:alter(Modifying table structures)
--q1
ALTER TABLE students ADD COLUMN address VARCHAR(255);
--q2
ALTER TABLE students ADD COLUMN is_active BOOLEAN DEFAULT true;
--q3
ALTER TABLE Students
MODIFY COLUMN phone_number VARCHAR(50);
--q4
ALTER TABLE courses
RENAME COLUMN name TO course_name;
--q5
ALTER TABLE Students
DROP COLUMN age;
--q6
ALTER TABLE courses
ADD CONSTRAINT chk_credit_hour
CHECK (credit_hour >= 1);
ALTER TABLE courses
DROP CONSTRAINT chk_credit_hour;


--part2:UPDATE(modifying existing data)

--q7
UPDATE Students
SET phone_number = '555-9999'
WHERE student_id = 1;

--q8 age coloum was deleted earlier so error aayo
-- UPDATE Students
-- SET age = 23,
--     email = 'bob.j@newemail.com'
-- WHERE student_id = 2;
--q8 so update name and email 
UPDATE Students
 SET name = 'bobmarli',
     email = 'bobmarli.j@newemail.com'
 WHERE student_id = 2;

 --q9
 UPDATE courses
SET credit_hour = credit_hour + 1
WHERE credit_hour = 3;

--q10 (update function without where use garda pop up just to conform aako thyo )
UPDATE Students
SET email = LOWER(email);

--q11
UPDATE courses
SET credit_hour = 5
WHERE course_id = (
    SELECT course_id
    FROM (
        SELECT course_id
        FROM courses
        WHERE course_name = 'Data Structures'
    ) AS temp
);

--part3:DELETE(Removeing data)
--q12
-- Delete Evan Wright's enrollments first
DELETE FROM enrollment
WHERE student_id = 5;

-- Then delete Evan Wright
DELETE FROM students
WHERE name = 'Evan Wright';
--q13
DELETE FROM Courses
WHERE credit_hour < 3;
--q14
DELETE FROM Enrollment
WHERE student_id = 3;

DELETE FROM Students
WHERE student_id = 3;
--q15

DELETE FROM Enrollment;
--aggregate function 
--q8
SELECT COUNT(*) AS total_students
FROM Students;
--q9 age colum was deleted so new age coloum add garera avg calculate garnu parxa
ALTER TABLE Students
ADD COLUMN age INT;

UPDATE Students SET age = 20 WHERE student_id = 1;
UPDATE Students SET age = 22 WHERE student_id = 2;
UPDATE Students SET age = 19 WHERE student_id = 3;
UPDATE Students SET age = 21 WHERE student_id = 4;
UPDATE Students SET age = 23 WHERE student_id = 5;
SELECT AVG(age) AS average_age
FROM Students;

--q10 ans=5
SELECT MAX(credit_hour) AS maximum_credit_hour
FROM Courses;
--q11 ans=20
SELECT MIN(age) AS youngest_student_age
FROM Students;
--q12 ans=21
SELECT SUM(credit_hour) AS total_credit_hours
FROM Courses;

--grouping data
--q13
SELECT course_id, COUNT(student_id) AS total_students
FROM enrollment
GROUP BY course_id;
--q14
SELECT student_id, COUNT(course_id) AS total_courses
FROM enrollment
GROUP BY student_id;
--q15
SELECT course_id, COUNT(student_id) AS total_students
FROM enrollment
GROUP BY course_id
HAVING COUNT(student_id) > 2;
--q16
SELECT student_id, COUNT(course_id) AS total_courses
FROM enrollment
GROUP BY student_id
HAVING COUNT(course_id) = 2;


SELECT * FROM enrollment;

SELECT * FROM students;
INSERT INTO enrollment (enrollment_id, course_id, student_id) VALUES
(1001, 101, 1),
(1002, 103, 1),
(1003, 102, 2),
(1004, 104, 2),
(1006, 105, 4),
(1009, 102, 1);

-- table relations and joins
--q17
SELECT s.name, e.course_id
FROM Students s
JOIN Enrollment e
ON s.student_id = e.student_id;
--q18
SELECT s.name AS student_name,
       c.course_name
FROM Students s
JOIN Enrollment e
ON s.student_id = e.student_id
JOIN Courses c
ON e.course_id = c.course_id;
--q19
SELECT c.course_name,
       COUNT(e.student_id) AS total_students
FROM Courses c
LEFT JOIN Enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;
--q20
SELECT s.name
FROM Students s
JOIN Enrollment e
ON s.student_id = e.student_id
JOIN Courses c
ON e.course_id = c.course_id
WHERE c.course_name = 'Database Management Systems';
--q21
SELECT s.student_id,
       s.name
FROM Students s
LEFT JOIN Enrollment e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
--q22

SELECT s.name,
       SUM(c.credit_hour) AS total_credit_hours
FROM Students s
JOIN Enrollment e
ON s.student_id = e.student_id
JOIN Courses c
ON e.course_id = c.course_id
GROUP BY s.student_id, s.name;
--Subqueries and Advanced Logic
--q23
SELECT DISTINCT s.name
FROM Students s
JOIN Enrollment e
ON s.student_id = e.student_id
JOIN Courses c
ON e.course_id = c.course_id
WHERE c.credit_hour = (
    SELECT MAX(credit_hour)
    FROM Courses
);
--q24
SELECT c.course_id,
       c.course_name,
       COUNT(e.student_id) AS enrollment_count
FROM Courses c
LEFT JOIN Enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) >
(
    SELECT AVG(course_count)
    FROM
    (
        SELECT COUNT(student_id) AS course_count
        FROM Enrollment
        GROUP BY course_id
    ) AS avg_table
);
--q25
SELECT name, age
FROM Students
WHERE age >
(
    SELECT AVG(age)
    FROM Students
);
--Stored Procedures and DML
--q26
DELIMITER //

CREATE PROCEDURE GetStudentCourses(IN p_student_id INT)
BEGIN
    SELECT c.course_name
    FROM Courses c
    JOIN Enrollment e
        ON c.course_id = e.course_id
    WHERE e.student_id = p_student_id;
END //
CALL GetStudentCourses(1);
DELIMITER ;
--q27


--q28
