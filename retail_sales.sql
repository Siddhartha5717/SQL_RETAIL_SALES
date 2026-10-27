create database sql_project_p2;

use sql_project_p2;

select * from retail_sales_analysis;

select count(*) from retail_sales_analysis;

-- DATA CLEANNG STARTS

ALTER TABLE retail_sales_analysis
MODIFY COLUMN ï»¿transactions_id INT primary key;

alter table retail_sales_analysis
modify column sale_date date;

alter table retail_sales_analysis
modify column customer_id int;

alter table retail_sales_analysis
modify column gender varchar(15);


SELECT *
FROM retail_sales_analysis
WHERE age = '';

update retail_sales_analysis
set age = null
where age = '';

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE retail_sales_analysis
MODIFY COLUMN age INT NULL;

SELECT *
FROM retail_sales_analysis
WHERE age IS NULL;

alter table retail_sales_analysis
modify column category varchar(15);

select * from retail_sales_analysis;

alter table retail_sales_analysis
modify column quantiy int null;

UPDATE retail_sales_analysis
SET quantiy = NULL
WHERE TRIM(quantiy) = '';

SELECT *
FROM retail_sales_analysis
WHERE quantiy IS NULL;

SELECT price_per_unit
FROM retail_sales_analysis
LIMIT 10 OFFSET 678;

SELECT price_per_unit
FROM retail_sales_analysis
WHERE TRIM(price_per_unit) = '';

SET SQL_SAFE_UPDATES = 0;


UPDATE retail_sales_analysis
SET price_per_unit = NULL
WHERE TRIM(price_per_unit) = '';

ALTER TABLE retail_sales_analysis
MODIFY COLUMN price_per_unit FLOAT NULL;

SELECT *
FROM retail_sales_analysis;

SELECT cogs
FROM retail_sales_analysis
WHERE TRIM(cogs) = '';

UPDATE retail_sales_analysis
SET cogs = NULL
WHERE TRIM(cogs) = '';

ALTER TABLE retail_sales_analysis
MODIFY COLUMN cogs float NULL;

SELECT total_sale
FROM retail_sales_analysis
WHERE TRIM(total_sale) = '';

UPDATE retail_sales_analysis
SET total_sale = NULL
WHERE TRIM(total_sale) = '';

ALTER TABLE retail_sales_analysis
MODIFY COLUMN total_sale float NULL;

desc retail_sales_analysis;

UPDATE retail_sales_analysis
SET sale_time = REPLACE(sale_time, '.', ':')
WHERE sale_time LIKE '%.%.%';

ALTER TABLE retail_sales_analysis
MODIFY COLUMN sale_time TIME NULL;

select * from retail_sales_analysis
where ï»¿transactions_id is null or
sale_date is null or
sale_time is null or 
customer_id is null or
gender is null or
age is null or
category is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null ;

set sql_safe_updates =0;

-- DATA CLEANING
delete from retail_sales_analysis
where ï»¿transactions_id is null or
sale_date is null or
sale_time is null or 
customer_id is null or
gender is null or
age is null or
category is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null ;


-- DATA EXPLORATION

-- HOW MAN SALS WE HAVE

select count(*) AS TOTA_SALES from retail_sales_analysis;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE
select  * from retail_sales_analysis;

select count(distinct(customer_id)) AS UNIQUE_CUSTOMERS from retail_sales_analysis;

-- HOW MANY UNIQUE CATEGORIES  WE HAVE
select  * from retail_sales_analysis;

select count(distinct(category)) AS UNIQUE_CATEGORIES from retail_sales_analysis;

 select distinct(category) AS UNIQUE_CATEGORIES from retail_sales_analysis; 
 
 -- DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWERS
 
 -- Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than equalto 4 in the month of Nov-2022:

SELECT *
FROM retail_sales_analysis
WHERE category = 'Clothing' 
AND quantiy >= 4  
AND  sale_date BETWEEN '2022-11-01' AND '2022-11-30' ;

-- Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category, sum(total_sale) as NET_SALES
FROM retail_sales_analysis
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT ROUND(avg(age),2) AS AVG_CUSTOMER_AGE
FROM retail_sales_analysis
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT ï»¿transactions_id, total_sale
FROM retail_sales_analysis
WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender,count(*) AS TOTAL_NO_OF_TRANSACTIONS
FROM retail_sales_analysis
GROUP BY category,gender
order by category;


SELECT *
FROM retail_sales_analysis;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT year(sale_date) AS YEAR,
month(sale_date) AS MONTH,
ROUND(avg(total_sale),2) AS AVG_SALES
FROM retail_sales_analysis
group by YEAR, month
ORDER BY YEAR, AVG_SALES DESC;

SELECT * FROM
(SELECT year(sale_date) AS YEAR,
month(sale_date) AS MONTH,
ROUND(avg(total_sale),2) AS AVG_SALES,
RANK() OVER(partition by year(sale_date) ORDER BY ROUND(avg(total_sale),2) DESC) AS SALES_RANK
FROM retail_sales_analysis
group by YEAR, month) AS T1
WHERE SALES_RANK = 1;


-- **Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT customer_id, sum(total_sale) AS TOTAL_SALES
FROM retail_sales_analysis
GROUP BY customer_id
ORDER BY TOTAL_SALES DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT * FROM retail_sales_analysis;

SELECT category,count(distinct(customer_id)) AS NO_OF_UNIQUE_CUSTOMERS
FROM retail_sales_analysis
group by category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH HOURLY_SALE AS
(
SELECT *,
CASE
WHEN hour(sale_time) <12 THEN 'MORNING'
WHEN hour(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'EVENING'
END AS SHIFT
 FROM retail_sales_analysis)
SELECT SHIFT, count(*) AS TOTAL_ORDERS
 FROM HOURLY_SALE
 GROUP BY SHIFT;
 
 -- END OF PROJECT






