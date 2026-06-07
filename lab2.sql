USE student_db;
SELECT *FROM students;
ALTER TABLE students ADD COLUMN email varchar(255);
UPDATE students
SET email = 'muskan@example.com'
WHERE id = 1;

UPDATE students
SET email = 'anjali@example.com'
WHERE id = 2;
INSERT INTO students (id, name, age, email)
VALUES (3, 'Sara', 19, 'sara@gmail.com'),
       ( 4,'jipsum',15,'jipusm@example.gmail.com'),
       (5,'sampanna',32,'sampanna@gmail.com'),
       (6,'sarmila',42,'sarmila@gmail.com');
       SELECT *FROM students where name like 's%';
