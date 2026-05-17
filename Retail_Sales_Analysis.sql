CREATE DATABASE Retail_Sales_DB;
USE Retail_Sales_DB;

CREATE TABLE retail_sales_DB(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(10,2)
);

SELECT * FROM retail_sales_db LIMIT 10;
SELECT COUNT(*) AS total_records FROM retail_sales_DB;

/*1. Find the hour from sale_time and create a column for weekday from sale_date.*/
SELECT 
    sale_date,
    DAYNAME(sale_date) AS weekday,
    HOUR(sale_time) AS sale_hour
FROM retail_sales_db;

/*2. Create a table with count of transactions for each category.*/
SELECT 
    category,
    COUNT(*) AS no_of_transactions
FROM retail_sales_db
GROUP BY category;

/*3. Find total sales and total quantity sold for each category.*/
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    SUM(quantiy) AS total_quantiy
FROM retail_sales_db
GROUP BY category;

/*📌 4. Count number of transactions by gender.*/
SELECT 
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales_db
GROUP BY gender;

/*5. Find average sale value per transaction.*/
SELECT 
    AVG(total_sale) AS avg_sale_value
FROM retail_sales_db;

/*6. Find top 5 customers based on total purchase amount.*/
SELECT 
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales_db
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

/*7. Create age groups and find total sales for each age group.*/
SELECT 
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 40 THEN '25-40'
        ELSE 'Above 40'
    END AS age_group,
    SUM(total_sale) AS total_sales
FROM retail_sales_db
GROUP BY age_group;

/*8. Find total profit generated for each category.*/
SELECT 
    category,
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales_db
GROUP BY category;

/*9. Find peak sales hour (hour with highest sales value).*/
SELECT 
    HOUR(sale_time) AS sale_hour,
    SUM(total_sale) AS total_sales
FROM retail_sales_db
GROUP BY sale_hour
ORDER BY total_sales DESC
LIMIT 1;
------------------------
ALTER TABLE retail_sales_db
ADD month INT;

SET SQL_SAFE_UPDATES = 0;

UPDATE retail_sales_db
SET sale_date = STR_TO_DATE(sale_date, '%m/%d/%Y')
WHERE sale_date IS NOT NULL;

SELECT MONTH(sale_date) AS month FROM retail_sales_db;

UPDATE retail_sales_db
SET month = MONTH(sale_date);

/*10. Find monthly sales trend.*/
SELECT 
    MONTH(sale_date) AS month,
    SUM(total_sale) AS monthly_sales
FROM retail_sales_db
GROUP BY MONTH(sale_date)
ORDER BY MONTH(sale_date);

/*11. Find categories where average quantity sold is more than 2.*/
SELECT 
    category,
    AVG(quantiy) AS avg_quantity
FROM retail_sales_db
GROUP BY category
HAVING AVG(quantiy) > 2;

/*12. Create a column to classify transactions based on total sale amount*/
SELECT *,
CASE
    WHEN total_sale < 500 THEN 'Low Value'
    WHEN total_sale BETWEEN 500 AND 1000 THEN 'Medium Value'
    ELSE 'High Value'
END AS sale_type
FROM retail_sales_DB;

/*13.Find total sales for each weekday (derived from sale_date)*/
SELECT 
    DAYNAME(sale_date) AS weekday,
    SUM(total_sale) AS total_sales
FROM retail_sales_DB
GROUP BY weekday
ORDER BY total_sales DESC;

/*14.Find average profit per transaction*/
SELECT 
    AVG(total_sale - cogs) AS avg_profit
FROM retail_sales_DB;

/*15.Identify categories where total sales are greater than 10,000*/
SELECT 
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales_DB
GROUP BY category
HAVING SUM(total_sale) > 10000;

-- Final Answer --
SELECT
    sale_date,
    DAYNAME(sale_date) AS weekday,
    MONTH(sale_date) AS month,
    HOUR(sale_time) AS sale_hour,
    category,
    gender,
    quantiy,
    total_sale,
    (total_sale - cogs) AS profit,
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 40 THEN '25-40'
        ELSE 'Above 40'
    END AS age_group
FROM retail_sales_DB;

SHOW TABLES;
SELECT * 
FROM retail_sales_DB;

--------------------------------------
/*SHOW COLUMNS FROM retail_sales_db;
DESCRIBE retail_sales_db;*/
----------------------------------------
USE Retail_Sales_DB;
SELECT DATABASE();

DESC retail_sales;

SELECT DISTINCT gender FROM retail_sales;

SELECT COUNT(*) FROM retail_sales_db;
USE Retail_Sales_DB;
SHOW TABLES;
DESC retail_sales_db;
SELECT COUNT(*) FROM retail_sales_db;
SELECT * FROM retail_sales_db LIMIT 5;

DROP TABLE IF EXISTS retail_sales_db;









