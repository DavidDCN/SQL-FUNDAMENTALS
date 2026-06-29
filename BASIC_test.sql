DROP TABLE IF EXISTS audit;

CREATE TABLE audit(
  id INT PRIMARY KEY ,
  name VARCHAR(50),
  department VARCHAR(50),
  job_role VARCHAR(50), 
  salary DECIMAL(10,2),
  bonus_amount DECIMAL(10,2),
  hire_date DATE
);

INSERT INTO audit(id,name,department,job_role,salary,bonus_amount,hire_date) VALUES
(1, "Alice", "Engineering", "Senior Dev", 120000, 2000, "2019-01-15"),
(2, "Bob", "HR", "Recruiter", 60000, NULL, "2021-11-01"),
(3, "Charlie", "Engineering", "Junior Dev", 75000, 500, "2022-03-10"),
(4, "Diana", "Sales", "Manager", 100000, 1500, "2018-06-22"),
(5, "Evan", "Engineering", "Junior Dev", 75000, NULL, "2023-08-05"),
(6, "Fiona", "HR", "Manager", 90000, 1000, "2017-05-12"),
(7, "George", "Sales", "Rep", 65000, 800, "2022-09-01"),
(8, "Hannah", "Sales", "Rep", 65000, 1200, "2023-01-15"),
(9, "Ian", "Engineering", "Senior Dev", 125000, 2500, "2018-02-20");


--1.The CEO's Request: "I want a summary of every department. Exclude anyone hired this year (2023) because they are still onboarding. Show me the headcount and average base salary per department. I only want to see departments that have more than 1 person left after filtering. Sort it so the most expensive department on average is at the top."

SELECT department,
COUNT(*) AS headcount,
AVG(salary) AS average_base_salary
FROM audit
WHERE hire_date < "2023-01-01"
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY  average_base_salary DESC;


--2
SELECT job_role,
SUM(bonus_amount) AS total_bonuses,
MAX(bonus_amount) AS max_bonuses
FROM audit
WHERE job_role != "Recruiter"
GROUP BY job_role
HAVING total_bonuses >= 2000
ORDER BY total_bonuses DESC;

