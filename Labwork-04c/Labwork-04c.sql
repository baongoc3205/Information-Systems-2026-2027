-- Labwork 04c - View

-- Question 1
USE employees;

CREATE OR REPLACE VIEW finance_managers AS
SELECT e.emp_no, e.first_name, e.last_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
WHERE d.dept_name = 'Finance';

SELECT * FROM finance_managers;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN (SELECT first_name FROM finance_managers)
  AND emp_no NOT IN (SELECT emp_no FROM finance_managers)
ORDER BY first_name, last_name;

-- Question 2
USE employees;

CREATE OR REPLACE VIEW production_employees AS
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Production';

CREATE OR REPLACE VIEW production_managers AS
SELECT dm.emp_no, dm.from_date, dm.to_date
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
WHERE d.dept_name = 'Production';

SELECT emp_no, first_name, last_name, hire_date
FROM production_employees
WHERE hire_date > (SELECT MAX(from_date) FROM production_managers)
ORDER BY hire_date, emp_no;

-- Question 3
USE employees;

CREATE OR REPLACE VIEW emp_dept_avg_salary AS
SELECT de.dept_no, s.emp_no, AVG(s.salary) AS avg_salary
FROM salaries s
JOIN dept_emp de ON s.emp_no = de.emp_no
GROUP BY de.dept_no, s.emp_no;

SELECT d.dept_name, AVG(v.avg_salary) AS avg_salary
FROM emp_dept_avg_salary v
JOIN departments d ON d.dept_no = v.dept_no
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- Question 4
USE employees;

CREATE OR REPLACE VIEW engineer_avg_salary AS
SELECT ti.title, s.emp_no, AVG(s.salary) AS avg_salary
FROM titles ti
JOIN salaries s ON ti.emp_no = s.emp_no
WHERE ti.title LIKE '%Engineer%'
  AND s.from_date >= ti.from_date
  AND s.from_date < ti.to_date
GROUP BY ti.title, s.emp_no;

SELECT title, AVG(avg_salary) AS avg_salary
FROM engineer_avg_salary
GROUP BY title
ORDER BY avg_salary DESC;
