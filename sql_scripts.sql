-- Case Scenario I

-- Q1: Which product category had the highest sales?
SELECT 
    Product_Category,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
GROUP BY 
    Product_Category
ORDER BY 
    Total_Sales DESC
LIMIT 1;

-- Q2: What are the Top 3 and Bottom 3 regions in terms of sales?
-- Top 3 regions by sales
SELECT 
    Region,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
GROUP BY 
    Region
ORDER BY 
    Total_Sales DESC
LIMIT 3;

-- Bottom 3 regions by sales
SELECT 
    Region,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
GROUP BY 
    Region
ORDER BY 
    Total_Sales ASC
LIMIT 3;

-- Q3: What were the total sales of appliances in Ontario?
SELECT 
    SUM(Sales) AS Total_Sales_Appliances_Ontario
FROM 
    KMS_Case_Study
WHERE 
    Product_Category = 'Appliances'
    AND Region = 'Ontario';

-- Q4: Advise management on increasing revenue from the bottom 10 customers (lowest sales)
SELECT 
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales ASC
LIMIT 10;

-- Q5: Which shipping method incurred the most shipping cost?
SELECT 
    Ship_Mode,
    SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM 
    KMS_Case_Study
GROUP BY 
    Ship_Mode
ORDER BY 
    Total_Shipping_Cost DESC
LIMIT 1;


-- Case Scenario II

-- Q6: Who are the most valuable customers, and what products/services do they purchase?
SELECT 
    Customer_Name,
    Product_Category,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
GROUP BY 
    Customer_Name, Product_Category
ORDER BY 
    Total_Sales DESC
LIMIT 10;

-- Q7: Which small business customer had the highest sales?
SELECT 
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
WHERE 
    Customer_Segment = 'Small Business'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC
LIMIT 1;

-- Q8: Which Corporate customer placed the most orders in 2009–2012?
SELECT 
    Customer_Name,
    COUNT(Order_ID) AS Order_Count
FROM 
    KMS_Case_Study
WHERE 
    Customer_Segment = 'Corporate'
    AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY 
    Customer_Name
ORDER BY 
    Order_Count DESC
LIMIT 1;

-- Q9: Which consumer customer was the most profitable?
SELECT 
    Customer_Name,
    SUM(Profit) AS Total_Profit
FROM 
    KMS_Case_Study
WHERE 
    Customer_Segment = 'Consumer'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Profit DESC
LIMIT 1;

-- Q10: Which customer returned items, and what segment do they belong to?
SELECT DISTINCT 
    Customer_Name, 
    Customer_Segment, 
    Status
FROM 
    KMS_Case_Study
WHERE 
    Status = 'Returned';

-- Q11: Analyze shipping costs vs order priority and shipping method
SELECT 
    Order_Priority,
    Ship_Mode,
    COUNT(*) AS Order_Count,
    AVG(Shipping_Cost) AS Avg_Shipping_Cost
FROM 
    KMS_Case_Study
GROUP BY 
    Order_Priority, Ship_Mode
ORDER BY 
    Order_Priority, Avg_Shipping_Cost DESC;
