month_num,rep_name,sales
1,Alice,100
2,Alice,150
3,Alice,120
1,Bob,200
2,Bob,200
3,Bob,250

USE WIN_FUNCTIONS;
DROP TABLE IF EXISTS sales_data;

CREATE TABLE sales_data(
  month_num INT,
  rep_name VARCHAR(255),
  sales INT
);
INSERT INTO sales_data(month_num,rep_name,sales) VALUES
(1,'Alice',100),    
(2,'Alice',150),    
(3,'Alice',120),    
(1,'Bob',200),    
(2,'Bob',200),    
(3,'Bob',250);

SELECT 
    month_num,
    rep_name,
    sales,
    SUM(sales) OVER(PARTITION BY rep_name) AS total_rep_sales
FROM 
    sales_data;




USE saas_sales_data;


--Scenario 1: The "Running Total" (Cumulative Revenue)The Professional Problem: Executive dashboards rarely just want to see how much money was made on a specific day. They want a chart showing cumulative growth over time to see if they are hitting their quarterly goals. The Window Function Solution: You use SUM() but instead of collapsing the data with GROUP BY, you use OVER (ORDER BY ...) to add up the revenue row by row.
SELECT 
    transaction_date, 
    transaction_id,
    revenue_amount,
    -- This calculates the running total of revenue chronologically
    SUM(revenue_amount) OVER (ORDER BY transaction_id) AS cumulative_revenue
FROM saas_sales_data;