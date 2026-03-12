-- Retail Sales Performance & Profitability Analysis Queries

-- 1 Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM retail_sales;

-- 2 Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM retail_sales;

-- 3 Total Orders
SELECT COUNT(Order_ID) AS Total_Orders
FROM retail_sales;

-- 4 Sales by Category
SELECT Category,
       SUM(Sales) AS Total_Sales
FROM retail_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 5 Profit by Region
SELECT Region,
       SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY Region
ORDER BY Total_Profit DESC;

-- 6 Top 10 Products by Sales
SELECT TOP 10
       Product_Name,
       SUM(Sales) AS Total_Sales
FROM retail_sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

-- 7 Loss Making Products
SELECT Product_Name,
       SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;

-- 8 Sales by Customer Segment
SELECT Customer_Segment,
       SUM(Sales) AS Total_Sales
FROM retail_sales
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC;

-- 9 Monthly Sales Trend
SELECT MONTH(Order_Date) AS Month,
       SUM(Sales) AS Monthly_Sales
FROM retail_sales
GROUP BY MONTH(Order_Date)
ORDER BY Month;

-- 10 Sales by State
SELECT State,
       SUM(Sales) AS Total_Sales
FROM retail_sales
GROUP BY State
ORDER BY Total_Sales DESC;

-- 11 Average Discount
SELECT AVG(Discount) AS Avg_Discount
FROM retail_sales;

-- 12 Profit Margin
SELECT (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percentage
FROM retail_sales;

-- 13 Yearly Sales
SELECT YEAR(Order_Date) AS Year,
       SUM(Sales) AS Total_Sales
FROM retail_sales
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- 14 Rank Products by Sales
SELECT Product_Name,
       SUM(Sales) AS Total_Sales,
       RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM retail_sales
GROUP BY Product_Name;

-- 15 Top Category in Each Region
SELECT Region, Category, Total_Sales
FROM
(
    SELECT Region,
           Category,
           SUM(Sales) AS Total_Sales,
           RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS rnk
    FROM retail_sales
    GROUP BY Region, Category
) t
WHERE rnk = 1;
