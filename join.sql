DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments(
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50)
);

CREATE TABLE employees(
  employee_id INT PRIMARY KEY,
  name VARCHAR(50),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
);

INSERT INTO departments(department_id,department_name) VALUES
(101,'Engineering'), 
(102,'HR'),
(103,'Marketing');

INSERT INTO employees(employee_id,name,department_id) VALUES
(1,'Alice',101),
(2,'Bob',102),
(3,'Charlie',101),
(4,'Diana',NULL);


--INNER JOIN gets what both tables have does not produce NULL values as it only gets data in both have present values so one side of the table must have values and if others doesn't have that corresponding values both of them don't get added to the megatable
SELECT 
  employees.name,
  departments.department_name
FROM
  employees
INNER JOIN
  departments
  ON employees.department_id = departments.department_id;

--I Created two samples, there only diff is that the FROM and  JOIN ON clause are diff, in the first sample Marketing value is NULL as the Deparment have marketing and employees don't have any value in the department_id column, lets run the second sample, diane is null as there is no corrsponding value in the departments table or simply it is already NULL
--1.sample
SELECT 
employees.name,
departments.department_name
FROM departments
LEFT JOIN
employees
ON departments.department_id = employees.department_id;


--2.sample
SELECT 
employees.name,
departments.department_name
FROM employees
LEFT JOIN
departments
ON employees.department_id = departments.department_id;


--RIGHT we will also doo the same in the left part
SELECT
employees.name,
departments.department_name
FROM departments
RIGHT JOIN employees
ON departments.department_id = employees.department_id;

SELECT
employees.name,
departments.department_name
FROM employees
RIGHT JOIN departments
ON employees.department_id = departments.department_id;


--OUTER JOIN combines all values in both tables regardless if it is NULL
SELECT
employees.name,
departments.department_name
FROM departments
FULL OUTER JOIN employees
ON departments.department_id = employees.department_id;

SELECT 
    employees.name, 
    departments.dept_name
FROM 
    employees
FULL OUTER JOIN 
    departments 
    ON employees.dept_id = departments.dept_id;


--NOW lets have basic test