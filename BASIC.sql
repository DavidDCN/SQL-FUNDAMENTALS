--Practice Count SQL queries
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    bonus_amount DECIMAL(10,2)
);

INSERT INTO employees (employee_id, name, department, bonus_amount) VALUES
(1, 'Alice', 'Engineering', 500.00),
(2, 'Bob', 'HR', NULL),
(3, 'Charlie', 'Engineering', 500.00),
(4, 'Diana', 'Sales', 1200.00),
(5, 'Evan', 'Engineering', NULL);

--1. Count total number of employees
SELECT COUNT(*) AS total_employees FROM employees;
--2.COunt number of employees with non-null bonus amounts
SELECT COUNT(bonus_amount) AS employee_with_bunos FROM employees;

--3. Count the number of unique departments
SELECT COUNT(DISTINCT department) AS UNIQUE_DEPARTMENTS FROM employees;


SELECT 
COUNT(*) AS TOTAL_ROWS,
COUNT(bonus_amount) AS non_null_bonuses,
COUNT(DISTINCT department) AS unique_departments
FROM employees;


--Sum exploration
DROP TABLE IF EXISTS salaries;
CREATE TABLE SALARIES (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    bonus_amount DECIMAL(10,2)
);

INSERT INTO SALARIES(employee_id, name, department, salary, bonus_amount) VALUES
(1, 'Alice', 'Engineering', 90000.00, 500.00),
(2, 'Bob', 'HR', 60000.00, NULL),
(3, 'Charlie', 'Engineering', 85000.00, 500.00),
(4, 'Diana', 'Sales', 100000.00, 1200.00),
(5, 'Evan', 'Engineering', 75000.00, NULL);

--1.Summing all 5 employee salaries
SELECT SUM(SALARY) AS total_salary
FROM salaries;

--2.summing all bunoses
SELECT SUM(bonus_amount) AS total_bonuses
FROM salaries;

--3. total salary increase next year
SELECT 
    SUM(salary * 0.10) AS projected_raise_cost 
FROM 
    SALARIES;

--Learning Avg use salaries table
--1.avg salary
SELECT AVG(SALARY) AS total_avarage_salary FROM salaries;
--2.avg bonus amount
SELECT AVG(bonus_amount) AS total_average_bonus FROM salaries;
--3. USE COALESCE to turn null to zero
SELECT AVG(COALESCE(bonus_amount, 0.00)) AS total_average_bonus FROM salaries;


SELECT 
AVG(SALARY) AS total_avg_salary,
AVG(bonus_amount) AS total_avg_bonus,
AVG(COALESCE(bonus_amount, 0.00)) AS avg_total_bonus
FROM salaries;

--Min and Max exploration
DROP TABLE IF EXISTS HIRING;
CREATE TABLE HIRING(
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    bonus_amount DECIMAL(10,2),
    hire_date VARCHAR(100)
);


--Mastering Min and MAX
INSERT INTO HIRING(employee_id, name, department, salary, bonus_amount, hire_date) VALUES
(1,"Alice", "Engineering", 9000, 500, "2021-01-15"),
(2,"Bob", "HR", 6000, NULL, "2019-11-01"),
(3,"Charlie", "Engineering", 8500, 500,"2022-03-10"),
(4,"Diana", "Sales", 10000, 1100,"2018-06-22"),
(5,"Evan", "Engineering", 7500, NULL,"2023-08-05");

--show min and max salary
SELECT
MIN(salary) AS minimum_salary,
MAX(SALARY) AS maximum_salary
FROM HIRING;

--show the oldest and newest hire
SELECT
MIN(hire_date) AS earliest_hire_date,
MAX(hire_date) AS latest_hire_date
FROM HIRING;

--show the smallest and highest bonus
SELECT
MIN(bonus_amount) AS smallest_bonus,
MAX(bonus_amount) AS highest_bonus
FROM HIRING;

--Now we will learn about order by
--order by is being used to arrange inputs inside column
SELECT name, salary
FROM HIRING
ORDER by salary DESC; 
--It does arrange salary from highest to lowest
--notice names follow their sallary


--we will use two inputs then the first value will be sorted the second value will be the tie breaker
SELECT name, department, salary
FROM hiring
ORDER BY department ASC, salary DESC;


--GROUP by

DROP TABLE IF EXISTS EMPLOYEES;
CREATE TABLE EMPLOYEES(
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    bonus_amount DECIMAL(10,2)
);

INSERT INTO EMPLOYEES(employee_id, name, department, salary, bonus_amount) VALUES
(1,"Alice", "Engineering", 9000, 500),
(2,"Bob", "HR", 6000, NULL),
(3,"Charlie", "Engineering", 8500, 500),
(4,"Diana", "Sales", 10000, 1100),
(5,"Evan", "Engineering", 7500, NULL),
(6,"Fiona", "HR", 6500, 300);

--1. this will print each employees according to its dep
SELECT department,
COUNT(*) AS number_of_employees
FROM employees
GROUP BY department;


--this will print each dep, salary sum and avg
SELECT department,
SUM(salary) AS total_payrol,
AVG(salary) AS average_payrol
FROM employees
GROUP BY department;

--this will group each dup get the sum of their bonuses and rank them highest to lowest

SELECT department,
AVG(bonus_amount) AS average_bonuses
FROM employees
GROUP by department
ORDER by average_bonuses DESC;

SELECT department, name, SUM(salary) FROM employees GROUP BY department;


--Understanding group by having

DROP TABLE IF EXISTS NEW_HIRING;

CREATE TABLE NEW_HIRING(
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    bonus_amount DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO NEW_HIRING(employee_id,name,department,salary,bonus_amount,hire_date) VALUES
(1, "Alice", "Engineering", 90000, 500, "2021-01-15"),
(2, "Bob", "HR", 60000, NULL, "2019-11-01"),
(3, "Charlie", "Engineering", 85000, 500, "2022-03-10"),
(4, "Diana", "Sales", 100000, 1100, "2018-06-22"),
(5, "Evan", "Engineering", 75000, NULL, "2023-08-05"),
(6, "Fiona", "HR", 65000, 300, "2021-05-12"),
(7,"George", "Sales", 95000, 800, "2020-09-01");

--print only the group which have more than 150000 salary in total
SELECT department,
SUM(salary) AS total_payroll
FROM NEW_HIRING
GROUP BY department
HAVING total_payroll >150000;

--Group them by department, only the departments where the avg salary of those recent hires is greater than 80,000
SELECT department,
AVG(salary) AS avg_salary
FROM NEW_HIRING
WHERE hire_date > "2021-01-01"
GROUP by department
HAVING avg_salary > 80000;


--We need to know which department are getting too large. write a query to show the department name and headcount, but only for departments that have 3 or more employees


SELECT department,
COUNT(*) AS headcount
FROM NEW_HIRING
GROUP BY department
HAVING COUNT(*) >= 3;

--WHich department are spending more than $1000 total on bonuses?
SELECT department,
SUM(bonus_amount) AS total_bonuses
FROM new_hiring
GROUP BY department
HAVING total_bonuses > 1000;


--we are evaluating base salaries, ignoring anyone in hr. we want to see the maximum salaries for the remaining departments, but only show departments where the maximum salary is $95,000
SELECT department,
MAX(salary) AS max_salary
FROM NEW_HIRING
WHERE department != "HR"
GROUP BY department
HAVING max_salary >95000;