



--creating database
CREATE DATABASE security_lab;
--use database
USE security_lab;

--create a table
CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
enrollment_date DATE NOT NULL
);

--create a table
CREATE TABLE courses (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(100) NOT NULL,
instructor VARCHAR(100),
credits INT NOT NULL
);


--create a table
CREATE TABLE enrollments (
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT NOT NULL,
course_id INT NOT NULL,
grade VARCHAR(2),
enrollment_date DATE NOT NULL,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

--Q2. Create a new database user named app_user that can only connect from localhost, with password AppPass123!
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'AppPass123!';
--Q3. Create a user named report_user that can connect from any host.

CREATE USER 'report_user'@'%' IDENTIFIED BY 'ReportPass456!';

--Q4. Change (reset) the password for an existing user, app_user.

ALTER USER 'app_user'@'localhost' IDENTIFIED BY 'NewSecurePass789!';

--Q5. Lock (disable login for) the user report_user without deleting the account, then unlock it later.

-- Lock the account
ALTER USER 'report_user'@'%' ACCOUNT LOCK;
-- Unlock the account
ALTER USER 'report_user'@'%' ACCOUNT UNLOCK;


--Q6. Permanently remove the user app_user from the server.

DROP USER 'app_user'@'localhost';

--Q7. Grant app_user permission to only read (SELECT) data from the students table.

GRANT SELECT ON security_lab.students TO 'app_user'@'localhost';

--Q8. Grant app_user permission to SELECT, INSERT, and UPDATE on all tables in security_lab.

GRANT SELECT, INSERT, UPDATE ON security_lab.* TO 'app_user'@'localhost';

--Q9. Grant a user the ability to update only the email column of the students table (column-level privilege).

GRANT UPDATE (email) ON security_lab.students TO 'app_user'@'localhost';

--Q10. Grant report_user full privileges on security_lab AND allow it to grant those same privileges to other users.

GRANT ALL PRIVILEGES ON security_lab.* TO 'report_user'@'%' WITH GRANT
OPTION;

--Q11. After granting privileges, how do you make MySQL reload the privilege tables immediately?

FLUSH PRIVILEGES;
--Q12. View all privileges currently granted to app_user.

SHOW GRANTS FOR 'app_user'@'localhost';

--Section 4: Revoking Privileges (REVOKE)
--Q13. Revoke the INSERT privilege on the courses table from app_user.

REVOKE INSERT ON security_lab.courses FROM 'app_user'@'localhost';
--Q14. Revoke every privilege app_user has on the entire security_lab database.

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'app_user'@'localhost';

--Q15. Revoke only the GRANT OPTION from report_user, while keeping its other privileges intact.

REVOKE GRANT OPTION ON security_lab.* FROM 'report_user'@'%';

--Section 5: Role-Based Access Control (RBAC)
--Instead of granting privileges directly to individual users, RBAC groups privileges into reusable roles. Roles are
--then granted to users, which makes access easier to audit and maintain.
--Q16. Create three roles for security_lab: read_only_role, data_entry_role, and admin_role.

CREATE ROLE 'read_only_role';
CREATE ROLE 'data_entry_role';
CREATE ROLE 'admin_role';
--Q17. Assign appropriate privileges to each role: read-only access for read_only_role, insert/update
--access for data_entry_role, and full access for admin_role.
GRANT SELECT ON security_lab.* TO 'read_only_role';
GRANT SELECT, INSERT, UPDATE ON security_lab.* TO 'data_entry_role';
GRANT ALL PRIVILEGES ON security_lab.* TO 'admin_role';
--Q18. Create a new user, alice, and assign her the data_entry_role.
CREATE USER 'alice'@'%' IDENTIFIED BY 'AlicePass!23';
GRANT 'data_entry_role' TO 'alice'@'%';
--Q19. Make data_entry_role automatically active whenever alice logs in, without her needing to
--activate it manually.

SET DEFAULT ROLE 'data_entry_role' TO 'alice'@'%';
--Q20. Inside an active session, how would alice manually activate a role that was granted to her (if
--it is not already her default)?

SET ROLE 'data_entry_role';
-- or activate every role granted to the current user:
SET ROLE ALL;

--Q21. List which roles have been granted to alice.

SHOW GRANTS FOR 'alice'@'%';

--Q22. Remove the data_entry_role from alice (she keeps her account, but loses that role's
--privileges).

REVOKE 'data_entry_role' FROM 'alice'@'%';
--Q23. Delete the read_only_role entirely from the system.

DROP ROLE 'read_only_role';

CREATE ROLE 'ta_role';
GRANT SELECT ON security_lab.students TO 'ta_role';
GRANT SELECT ON security_lab.courses TO 'ta_role';
GRANT SELECT, UPDATE (grade) ON security_lab.enrollments TO 'ta_role';
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'BobPass!99';
GRANT 'ta_role' TO 'bob'@'localhost';
SET DEFAULT ROLE 'ta_role' TO 'bob'@'localhost';













