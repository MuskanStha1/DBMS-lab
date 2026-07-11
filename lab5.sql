-- ==========================================
-- LAB: Authentication and Authorization
-- ==========================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS Lab5;
USE Lab5;

-- ==========================================
-- 2. Create Employee Table
-- ==========================================

CREATE TABLE Employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- ==========================================
-- 3. Insert Sample Data
-- ==========================================

INSERT INTO Employee VALUES
(1,'Ram','IT',35000),
(2,'Shyam','HR',30000),
(3,'Hari','Finance',40000),
(4,'Sita','Marketing',38000);

-- Check Data
SELECT * FROM Employee;

-- ==========================================
-- 4. AUTHENTICATION
-- Create Users
-- ==========================================

CREATE USER 'student1'@'localhost'
IDENTIFIED BY 'student123';

CREATE USER 'teacher1'@'localhost'
IDENTIFIED BY 'teacher123';

-- ==========================================
-- 5. AUTHORIZATION
-- Grant Permissions
-- ==========================================

-- Student can only read data
GRANT SELECT
ON Lab5.Employee
TO 'student1'@'localhost';

-- Teacher can read, insert and update
GRANT SELECT, INSERT, UPDATE
ON Lab5.Employee
TO 'teacher1'@'localhost';

-- Apply Privileges
FLUSH PRIVILEGES;

-- ==========================================
-- 6. Check Granted Permissions
-- ==========================================

SHOW GRANTS FOR 'student1'@'localhost';

SHOW GRANTS FOR 'teacher1'@'localhost';

-- ==========================================
-- 7. Test Permissions
-- ==========================================

-- Login as student1
-- This will work:
SELECT * FROM Employee;

-- These should fail for student1
-- INSERT INTO Employee VALUES (5,'Gita','IT',42000);
-- UPDATE Employee SET salary=50000 WHERE eid=1;
-- DELETE FROM Employee WHERE eid=1;

-- ==========================================
-- 8. Revoke Permission
-- ==========================================

REVOKE UPDATE
ON Lab5.Employee
FROM 'teacher1'@'localhost';

FLUSH PRIVILEGES;

-- Check Again
SHOW GRANTS FOR 'teacher1'@'localhost';

-- ==========================================
-- 9. Create a View (Optional)
-- Hide Salary from Students
-- ==========================================

CREATE VIEW Employee_View AS
SELECT eid, ename, department
FROM Employee;

GRANT SELECT
ON Lab5.Employee_View
TO 'student1'@'localhost';

-- ==========================================
-- 10. Remove Users
-- ==========================================

-- Uncomment only if you want to delete users

-- DROP USER 'student1'@'localhost';
-- DROP USER 'teacher1'@'localhost';

-- ==========================================
-- END OF PROGRAM
-- ==========================================