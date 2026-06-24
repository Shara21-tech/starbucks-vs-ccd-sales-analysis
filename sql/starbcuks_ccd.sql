CREATE DATABASE coffee_project;
USE coffee_project;

SHOW TABLES;
DESCRIBE starbucks_customers;
DESCRIBE starbucks_products;
DESCRIBE starbucks_stores;
DESCRIBE starbucks_orders;
DESCRIBE starbucks_order_details;

DESCRIBE ccd_customers;
DESCRIBE ccd_products;
DESCRIBE ccd_stores;
DESCRIBE ccd_orders;
DESCRIBE ccd_order_details;

1)Total Revenue
SELECT SUM(od.Quantity * p.Price) AS Total_Revenue
FROM starbucks_order_details od
JOIN starbucks_products p
ON od.Product_ID = p.Product_ID;

2)Avg Order Value
SELECT
ROUND(AVG(Order_Value),2) AS Avg_Order_Value
FROM
(
    SELECT o.Order_ID,
           SUM(od.Quantity * p.Price) AS Order_Value
    FROM starbucks_orders o
    JOIN starbucks_order_details od
    ON o.Order_ID = od.Order_ID
    JOIN starbucks_products p
    ON od.Product_ID = p.Product_ID
    GROUP BY o.Order_ID
) x;

3)Top 10 Best selling products
SELECT
p.Product_Name,
SUM(od.Quantity) AS Units_Sold
FROM starbucks_order_details od
JOIN starbucks_products p
ON od.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Units_Sold DESC
LIMIT 10;

4)Revenue by category
SELECT
p.Category,
SUM(od.Quantity * p.Price) AS Revenue
FROM starbucks_order_details od
JOIN starbucks_products p
ON od.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Revenue DESC;

5)monthly sales trend
SELECT
YEAR(o.Order_Date) AS Year,
MONTH(o.Order_Date) AS Month,
SUM(od.Quantity * p.Price) AS Revenue
FROM starbucks_orders o
JOIN starbucks_order_details od
ON o.Order_ID = od.Order_ID
JOIN starbucks_products p
ON od.Product_ID = p.Product_ID
GROUP BY YEAR(o.Order_Date), MONTH(o.Order_Date)
ORDER BY Year, Month;

6)product by category
SELECT
Category,
COUNT(Product_ID) AS Total_Products
FROM starbucks_products
GROUP BY Category
ORDER BY Total_Products DESC;

7)total quantity sold by product
SELECT
Product_ID,
SUM(Quantity) AS Total_Sold
FROM starbucks_order_details
GROUP BY Product_ID
ORDER BY Total_Sold DESC
LIMIT 10;