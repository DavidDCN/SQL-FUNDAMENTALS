DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE employees(
  emp_id INT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT,
  salary DECIMAL(10,2),
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE
);

CREATE TABLE departments(
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

INSERT INTO employees(emp_id,name,dept_id,salary) VALUES
(1, 'Alice', 101, 90000.00),
(2, 'Bob', 102, 60000.00),
(3, 'Charlie', 101, 85000.00),
(4, 'Diana', NULL, 100000.00);

INSERT INTO departments(dept_id,dept_name) VALUES
(101, 'Engineering'),
(102, 'HR'),
(103, 'Marketing');


--Mission 1: The Standard Payroll (INNER JOIN) The Client (CFO): "I need a payroll report. Show me the department name and the total salary footprint for that department. I only want to see official, matching records—don't include people without departments, and don't include departments without people."

SELECT departments.dept_name,
SUM(employees.salary) AS total_salary
FROM employees
INNER JOIN departments
ON employees.dept_id = departments.dept_id
GROUP BY departments.dept_name;



--Mission 2: The Onboarding Audit (LEFT JOIN): The Client (HR Director): "We are doing an audit of all staff. I need a master list of every single employee's name and their department name. If they haven't been assigned a department yet, I still absolutely need them on this list so we can track them down."
SELECT employees.name,
departments.dept_name
FROM employees
LEFT JOIN departments
ON employees.dept_id = departments.dept_id;


--Mission 3: The Empty Bucket Search (RIGHT JOIN + Aggregation): The Client (Operations Manager): "I am reviewing our company structure. I need to see a list of all departments, along with how many employees are currently inside each. I specifically need to see if we have any empty departments with zero employees."
SELECT departments.dept_name,
COUNT(employees.emp_id) AS head_count
FROM employees
RIGHT JOIN departments
ON employees.dept_id = departments.dept_id
GROUP by departments.dept_name;


--Mission 4: The Hacker's Outer Join (Using UNION): The Client (System Auditor): "I need the ultimate master list to find all data anomalies. Show me every employee and every department. If an employee has no department, show them. If a department has no employees, show it. Our old system supported 'FULL OUTER JOIN', but I know this new one doesn't. Figure it out."
SELECT
employees.name,
departments.dept_name
FROM employees
LEFT JOIN
departments
ON employees.dept_id = departments.dept_id

UNION

SELECT
employees.name,
departments.dept_name
FROM employees
RIGHT JOIN
departments
ON employees.dept_id = departments.dept_id;


SELECT 
    employees.name, 
    departments.dept_name
FROM 
    employees
LEFT JOIN 
    departments 
    ON employees.dept_id = departments.dept_id
GROUP BY 
    departments.dept_name;

SELECT 
    departments.dept_name, 
    COUNT(employees.emp_id) AS headcount
FROM 
    employees
RIGHT JOIN 
    departments 
    ON employees.dept_id = departments.dept_id;