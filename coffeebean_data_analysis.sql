SELECT *
FROM coffeeorder;

----PART A.Sales Analysis-----
-- 1. What is the total sales revenue for each country?
SELECT country,
       coffee_typename,
	   roast_typename,
	   SUM(sales) AS total_revenue  
FROM coffeeorder
GROUP BY 1,2,3
ORDER BY 4 DESC;

-- 2. Which coffee type generates the highest sales revenue?
SELECT coffee_typename,
       SUM(sales) AS total_revenue
FROM coffeeorder
GROUP BY 1
ORDER BY 2 DESC;

-- 3. What is the average sales per order by coffee_type?
SELECT coffee_typename,
 	   ROUND(AVG(sales),2) AS avg_sales_per_order
FROM coffeeorder
GROUP BY 1;

-- 4. What is the total sales revenue for each country by roast type?
SELECT country,
	   roast_typename,
       SUM(sales) AS total_revenue
FROM coffeeorder
GROUP BY 1,2
ORDER BY 1,2;


----PART B.Customer Analysis----
-- 1. How many unique customers have placed orders across the year?
SELECT coffee_typename,
	   COUNT(DISTINCT(customer_id)) AS unique_customer_order 
FROM coffeeorder
GROUP BY 1;


-- 2. Who are the top 10 customers based on the total quantity ordered?
SELECT customer_id,
       customer_name,
	   SUM(quantity) AS total_quantity_ordered
FROM coffeeorder
GROUP BY 1,2
ORDER BY 3 DESC;

-- 3. What is the average quantity of coffee purchased by customers?
WITH avg_quantity_customer AS(
	SELECT customer_id,
		   customer_name,
		   coffee_typename,
		   quantity		   
	FROM coffeeorder
	GROUP BY 1,2,3,4)
SELECT  coffee_typename,
		ROUND(AVG(quantity),2) AS avg_quantity_coffee_customer
FROM avg_quantity_customer
GROUP BY 1;

-- 4. Who are the top 10 customers based on the total sales?
SELECT 
       customer_name,
	   SUM(quantity) AS total_quantity_ordered,
	   SUM(sales) AS total_sales
FROM coffeeorder
GROUP BY 1
ORDER BY 3 DESC;



----PART C.Product Analysis----
-- 1. Which coffee type and roast type combination is the most popular?
SELECT coffee_typename,
       roast_typename,
	   COUNT(*) AS popularity
FROM coffeeorder
GROUP BY 1,2
ORDER BY 3 DESC;

-- 2. What is the average unit price for each coffee type and roast type?
SELECT coffee_typename,
       roast_typename,
	   ROUND(AVG(unit_price),2) AS avg_unit_price
FROM coffeeorder
GROUP BY 1,2
ORDER BY 1;

-- 3. What is the total quantity sold for each coffee type?
SELECT coffee_type,
       SUM(quantity) AS total_quantity_sold
FROM coffeeorder
GROUP BY 1
ORDER BY 2 DESC;

----PART D.Geographical Analysis----
-- 1. Which country has the highest and lowest sales volume?	  
SELECT country,
       SUM(sales) AS sales_volume
FROM coffeeorder
GROUP BY 1;	  

-- 2. Is there any correlation between the quantity ordered and the country?
SELECT country,
       CORR(quantity,unit_price) AS correlation
FROM coffeeorder
GROUP BY 1;

----PART E.Time-based Analysis----
-- 1. How has sales revenue changed over time by coffee type  (e.g., monthly, quarterly)?
SELECT DATE_TRUNC('month', "order_date")::DATE AS Month,
       coffee_typename,
	   SUM(sales) AS monthly_revenue
FROM coffeeorder
GROUP BY 1,2
ORDER BY 1;

SELECT DATE_TRUNC('quarter',"order_date")::DATE AS Quarter,
	   EXTRACT(QUARTER FROM "order_date") AS Custom_Quarter,
	   coffee_typename,
	   SUM(sales) as Quarter_revenue
FROM coffeeorder
GROUP BY 1,2,3
ORDER BY 1;

-- 2. What is the average quantity ordered per month?
SELECT DATE_TRUNC('month',"order_date")::DATE AS month,
	   ROUND(AVG(quantity),2) AS avg_quantity_ordered
FROM coffeeorder
GROUP BY 1
ORDER BY 1;