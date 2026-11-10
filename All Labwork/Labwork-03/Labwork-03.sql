-- Labwork 03 - SQL

-- Question 1
USE employees;

SELECT *
FROM employees;

-- Question 2
USE employees;

SELECT *
FROM departments;

-- Question 3
USE employees;

SELECT first_name, last_name
FROM employees;

-- Question 4
USE employees;

SELECT dept_name
FROM departments;

-- Question 5
USE employees;

SELECT DISTINCT e.emp_no, e.first_name, e.last_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- Question 6
USE employees;

SELECT DISTINCT e.emp_no, e.first_name, e.last_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Finance'
  AND e.gender = 'M';

-- Question 7
USE employees;

SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE d.dept_name = 'Marketing'
  AND e.gender = 'F';

-- Question 8
USE employees;

SELECT DISTINCT e.emp_no, e.first_name, e.last_name,
       m.first_name AS mgr_first_name, m.last_name AS mgr_last_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN dept_manager dm ON de.dept_no = dm.dept_no
JOIN employees m ON dm.emp_no = m.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE e.last_name = m.last_name
  AND e.emp_no <> m.emp_no
  AND de.from_date <= dm.to_date
  AND dm.from_date <= de.to_date;

-- Question 9
USE employees;

-- Managers who have been manager at least twice (self-join)
SELECT DISTINCT e.emp_no, e.first_name, e.last_name
FROM dept_manager dm1
JOIN dept_manager dm2 ON dm1.emp_no = dm2.emp_no
     AND (dm1.dept_no <> dm2.dept_no OR dm1.from_date <> dm2.from_date)
JOIN employees e ON e.emp_no = dm1.emp_no;

-- Confirmation: max times any person was manager
SELECT MAX(times) AS max_times_as_manager
FROM (
    SELECT emp_no, COUNT(*) AS times
    FROM dept_manager
    GROUP BY emp_no
) AS t;

-- Question 10
USE employees;

SELECT DISTINCT e.emp_no, e.first_name, e.last_name
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > 100000;

-- Question 11
USE employees;

SELECT DISTINCT d.dept_name
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
WHERE s.salary > 100000;

-- Part 2: Merge departments
USE employees;

START TRANSACTION;

-- 1. Create the two new departments
INSERT INTO departments (dept_no, dept_name) VALUES
    ('d010', 'Research and Development'),
    ('d011', 'Marketing and Sales');

-- 2. Move CURRENT employees (to_date = '9999-01-01') into the new departments
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
SELECT DISTINCT emp_no, 'd010', CURDATE(), '9999-01-01'
FROM dept_emp
WHERE dept_no IN ('d005', 'd008') AND to_date = '9999-01-01';

INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
SELECT DISTINCT emp_no, 'd011', CURDATE(), '9999-01-01'
FROM dept_emp
WHERE dept_no IN ('d001', 'd007') AND to_date = '9999-01-01';

-- 3. Close the current assignments in the old departments (history is kept)
UPDATE dept_emp
SET to_date = CURDATE()
WHERE dept_no IN ('d005', 'd008', 'd001', 'd007') AND to_date = '9999-01-01';

-- 4. The current managers of the old departments manage the new ones
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
SELECT DISTINCT emp_no, 'd010', CURDATE(), '9999-01-01'
FROM dept_manager
WHERE dept_no IN ('d005', 'd008') AND to_date = '9999-01-01';

INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
SELECT DISTINCT emp_no, 'd011', CURDATE(), '9999-01-01'
FROM dept_manager
WHERE dept_no IN ('d001', 'd007') AND to_date = '9999-01-01';

UPDATE dept_manager
SET to_date = CURDATE()
WHERE dept_no IN ('d005', 'd008', 'd001', 'd007') AND to_date = '9999-01-01';

COMMIT;

-- Check: current number of employees per department
SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS current_employees
FROM departments d
LEFT JOIN dept_emp de ON d.dept_no = de.dept_no AND de.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no;

-- Check: current managers
SELECT dm.dept_no, d.dept_name, e.first_name, e.last_name, dm.from_date
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'
ORDER BY dm.dept_no;
