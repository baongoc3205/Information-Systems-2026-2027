-- Labwork 04a - Built-in Functions

-- Question 1
USE employees;

SELECT e.emp_no, e.first_name, e.last_name, AVG(s.salary) AS avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name;

-- Question 2
USE employees;

SELECT e.emp_no, e.first_name, e.last_name, SUM(s.salary) AS total_paid
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name;

-- Question 3
USE employees;

SELECT d.dept_no, d.dept_name,
       MIN(s.salary) AS min_salary,
       MAX(s.salary) AS max_salary,
       SUM(s.salary) AS total_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name;

-- Question 4
USE employees;

SELECT d.dept_no, d.dept_name, SUM(s.salary) AS total_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name
HAVING SUM(s.salary) > 20000000000;

-- Question 5
USE employees;

SELECT d.dept_no, d.dept_name, SUM(s.salary) AS total_male_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.gender = 'M'
GROUP BY d.dept_no, d.dept_name;

-- Question 6
USE employees;

SELECT d.dept_no, d.dept_name, SUM(s.salary) AS total_manager_salary
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_no, d.dept_name
ORDER BY total_manager_salary DESC;
