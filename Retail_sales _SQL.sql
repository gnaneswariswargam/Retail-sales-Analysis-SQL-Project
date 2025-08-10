--SQL Retail_Sales_Analysis--
--create table--
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
(
  transactions_id INT,	
  sale_date DATE,
  sale_time	TIME,
  customer_id INT,
  gender VARCHAR(10),	
  age INT,	
  category VARCHAR(20),
  quantiy INT,	
  price_per_unit FLOAT,	
  cogs	FLOAT,
  total_sale FLOAT
  ); 
--DATA CLEANING--

  SELECT * FROM retail_sales
  LIMIT 10;
  
  -- NO OF ROWS IN TABLE--
  SELECT COUNT(*) FROM  retail_sales;
  
  --CHECK NULL VALUES IN TABLE--
  SELECT * FROM retail_sales
   WHERE 
         transactions_id IS NULL
		 OR
		 sale_date IS NULL
		 OR
		 sale_time IS NULL
		 OR
		 customer_id IS NULL
		 OR
		 gender IS NULL
		 OR
		 age IS NULL
		 OR
		 category IS NULL
		 OR
		 quantiy IS NULL
		 OR
		 price_per_unit IS NULL
		 OR
		 cogs IS NULL
		 OR
		 total_sale IS NULL;
		 
--HOW TO DELETE NULL VALUES IN TABLE--

DELETE FROM retail_sales
  WHERE
		transactions_id IS NULL
		 OR
		sale_date IS NULL
		 OR
		 sale_time IS NULL
		 OR
		 customer_id IS NULL
		 OR
		 gender IS NULL
		 OR
		 age IS NULL
		 OR
		 category IS NULL
		 OR
		 quantiy IS NULL
		 OR
		 price_per_unit IS NULL
		 OR
		 cogs IS NULL
		 OR
		 total_sale IS NULL;

---DATA EXPLORATION--

--HOW MANY SALES WE HAVE--
SELECT COUNT(*) AS total_sale FROM retail_sales;	

--HOW MANY  UNIQUE  CUSTOMERS WE HAVE--
SELECT COUNT (distinct customer_id) AS total_customer FROM retail_sales;

--HOW MANY UNIQUE CATEGORY WE HAVE--
SELECT DISTINCT category FROM retail_sales;

--DATA ANALYSIS & KEY INSIGHT--
--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:--
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:--


   SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

--3.Write a SQL query to calculate the total sales (total_sale) for each category.:--
SELECT category,sum(total_sale) AS Total_revenue,count(*) AS TOTAL_ORDERS
FROM retail_sales
GROUP BY category

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:--
SELECT 
ROUND(AVG(age),2) AS AVERAGE_AGE
FROM retail_sales
WHERE category='Beauty'

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:--
   SELECT *
   FROM retail_sales
   WHERE total_sale>1000;

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
   select 
   category,
   gender,
   count(*) AS total_transactions
   from retail_sales
   GROUP BY 
   category,gender
   order by category

 --7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year: 
 SELECT YEAR,
        MONTH,
		avg_sale
FROM
(
 SELECT
 EXTRACT (YEAR FROM sale_date) AS year,
 EXTRACT(MONTH FROM sale_date) AS MONTH,
 AVG(total_sale) AS avg_sale,
 RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) AS rank
 FROM retail_sales
 GROUP BY  1,2
 )
 AS t1
 where rank=1

--8.Write a SQL query to find the top 5 customers based on the highest total sales --
select 
customer_id,
SUM(total_sale) AS Highest_sale 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
limit 5;


--9.Write a SQL query to find the number of unique customers who purchased items from each category.:--
SELECT 
       category,
	  count(distinct customer_id) AS Total_unique_customer
	   FROM retail_sales
	   GROUP BY category


--10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):--
WITH hourly_sale
AS
(
SELECT *,
   CASE WHEN EXTRACT(HOUR FROM sale_time) <12 THEN'Morning'
        WHEN  EXTRACT(HOUR FROM sale_time)Between 12 and 17 THEN'Afternoon'
		ELSE 'Evening'
		END  AS shift
		FROM retail_sales
)
   SELECT 
        shift,
		count(*) AS Total_sales
		FRom hourly_sale
		GROUP BY shift
   -- END PROJECT--
		




























  