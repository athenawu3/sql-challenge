CREATE VIEW employees_info AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON s.emp_no = e.emp_no;

CREATE VIEW employees_1986 AS
SELECT e.first_name, e.last_name, e.hire_date
FROM employees AS e
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

CREATE VIEW dept_managers_info AS
SELECT e.emp_no, e.first_name, e.last_name, d.dept_no, dept.dept_name
FROM employees AS e
INNER JOIN dept_manager AS d ON d.emp_no = e.emp_no
INNER JOIN departments AS dept ON dept.dept_no = d.dept_no;

CREATE VIEW dept_employees_info AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_no, dept.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON d.emp_no = e.emp_no
INNER JOIN departments AS dept ON dept.dept_no = d.dept_no;

CREATE VIEW hercules_b AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

CREATE VIEW sales_employees AS
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN(
	SELECT emp_no 
	FROM dept_emp
	WHERE dept_no IN(
		SELECT dept_no 
		FROM departments
		WHERE dept_name = 'Sales'
	)
);

CREATE VIEW sales_development_employees AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp ON dept_emp.emp_no = e.emp_no
INNER JOIN departments AS d ON d.dept_no = dept_emp.dept_no
WHERE e.emp_no IN(
	SELECT emp_no 
	FROM dept_emp
	WHERE dept_no IN(
		SELECT dept_no 
		FROM departments AS d
		WHERE dept_name = 'Sales' OR dept_name = 'Development'
	)
);

CREATE VIEW last_names AS
SELECT last_name, COUNT(last_name) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC;