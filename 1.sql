CREATE DATABASE student_db;
USE student_db;
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
INSERT INTO students VALUES
(1, 'Muskan', 19),
(2, 'Anjali', 20);
SELECT * FROM students;