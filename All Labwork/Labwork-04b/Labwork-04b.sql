-- Labwork 04b - Subqueries

-- Question 1
USE employees;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN (
    SELECT e.first_name
    FROM employees e
    JOIN dept_manager dm ON e.emp_no = dm.emp_no
    WHERE dm.dept_no = (
        SELECT dept_no FROM departments
        WHERE dept_name = 'Finance'
    )
)
AND emp_no NOT IN (
    SELECT emp_no FROM dept_manager
    WHERE dept_no = (
        SELECT dept_no FROM departments
        WHERE dept_name = 'Finance'
    )
)
ORDER BY first_name, last_name;

-- Question 2
USE employees;

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE de.dept_no = (
    SELECT dept_no FROM departments
    WHERE dept_name = 'Production'
)
AND e.hire_date > (
    SELECT MAX(from_date)
    FROM dept_manager
    WHERE dept_no = (
        SELECT dept_no FROM departments
        WHERE dept_name = 'Production'
    )
)
ORDER BY e.hire_date, e.emp_no;

-- Question 3
USE employees;

SELECT d.dept_name, AVG(t.avg_salary) AS avg_salary
FROM (
    SELECT de.dept_no, s.emp_no, AVG(s.salary) AS avg_salary
    FROM salaries s
    JOIN dept_emp de ON s.emp_no = de.emp_no
    GROUP BY de.dept_no, s.emp_no
) AS t
JOIN departments d ON d.dept_no = t.dept_no
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- Question 4
USE employees;

SELECT t.title, AVG(t.avg_salary) AS avg_salary
FROM (
    SELECT ti.title, s.emp_no, AVG(s.salary) AS avg_salary
    FROM titles ti
    JOIN salaries s ON ti.emp_no = s.emp_no
    WHERE ti.title LIKE '%Engineer%'
      AND s.from_date >= ti.from_date
      AND s.from_date < ti.to_date
    GROUP BY ti.title, s.emp_no
) AS t
GROUP BY t.title
ORDER BY avg_salary DESC;
