CREATE DATABASE "PizzaDB";

USE PizzaDB;

SELECT * FROM pizza_sales;

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;


-- 2. Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS Avg_Order_Value FROM pizza_sales;


-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;


-- 4. Total Orders
SELECT COUNT(DISTINCT(order_id)) AS Total_Orders FROM pizza_sales;


-- 5. Average Pizzas per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales;


-- 6. Chart Daily Trend For Total Orders
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales 
	GROUP BY DATENAME(DW, order_date);

-- 7. Chart Monthly Trend For Total Orders
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales 
	GROUP BY DATENAME(MONTH, order_date)
	ORDER BY COUNT(DISTINCT order_id) DESC;

-- 8. Percentage of Sales by Pizza Category
SELECT  pizza_category, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS Pct_Sales
	FROM pizza_sales
	WHERE MONTH(order_date) = 1
	GROUP BY pizza_category;

-- 9. Percentage of Sales by Pizza Size
SELECT  pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS DECIMAL(10,2)) AS Pct_Sales 
	FROM pizza_sales
	WHERE DATEPART(QUARTER, order_date) = 1
	GROUP BY pizza_size
	ORDER BY Pct_Sales DESC;


-- 10. TOP 5 Total Revenue by Pizza Name
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Revenue DESC;

-- 11. LAST 5 Total Revenue by Pizza Name
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Revenue;

-- 12. TOP 5 Total Quantity by Pizza Name
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Quantity DESC;

-- 13. Last 5 Total Quantity by Pizza Name
SELECT TOP 5 pizza_name, SUM(quantity)  AS Total_Quantity
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Quantity;


-- 14. Top 5 Total Order by Pizza Name
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id)  AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Orders DESC;

-- 15. Last 5 Total Order by Pizza Name
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id)  AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
	ORDER BY Total_Orders;


