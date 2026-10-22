CREATE DATABASE walmart_sales_db;
USE walmart_sales_db;

CREATE TABLE walmart (
Sales_Row_ID INT AUTO_INCREMENT PRIMARY KEY,
Order_ID VARCHAR(50),
Order_Date DATE,
Ship_Date DATE,
Email_ID VARCHAR(255),
Country VARCHAR(100),
City VARCHAR(100),
State VARCHAR(100),
Category VARCHAR(100),
Product_Name VARCHAR(255),
Sales DECIMAL(12,2),
Quantity INT,
Profit DECIMAL(12,4)
);

-- data exploration

DESCRIBE walmart;

SELECT COUNT(*) AS total_rows
FROM walmart;

SELECT * FROM walmart
LIMIT 10;

SELECT order_date, ship_date
FROM walmart
LIMIT 10;

-- data cleaning

-- checking duplicates
SELECT
    order_id,
    product_name,
    order_date,
    COUNT(*) AS duplicate_count
FROM walmart
GROUP BY
    order_id,
    product_name,
    order_date
HAVING COUNT(*) > 1;

SELECT *
FROM walmart
WHERE (
    order_id = 'US-2014-103828'
    AND product_name = 'Staples'
    AND order_date = '2014-08-14'
)
OR (
    order_id = 'CA-2011-166961'
    AND product_name = 'Staples'
    AND order_date = '2011-12-27'
)
OR (
    order_id = 'CA-2014-118017'
    AND product_name = 'Memorex Micro Travel Drive 16 GB'
    AND order_date = '2014-12-04'
);

SELECT
    order_id,
    product_name,
    order_date,
    sales,
    quantity,
    profit,
    city,
    state
FROM walmart
WHERE order_id IN (
    'US-2014-103828',
    'CA-2011-166961',
    'CA-2014-118017'
)
ORDER BY order_id, product_name;

-- checking null values
SELECT
    SUM(CASE WHEN order_id IS NULL OR TRIM(order_id) = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
	SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS missing_ship_date,
    SUM(CASE WHEN email_id IS NULL OR TRIM(email_id) = '' THEN 1 ELSE 0 END) AS missing_email_id,
    SUM(CASE WHEN country IS NULL OR TRIM(country) = '' THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN city IS NULL OR TRIM(city) = '' THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN state IS NULL OR TRIM(state) = '' THEN 1 ELSE 0 END) AS missing_state,
    SUM(CASE WHEN category IS NULL OR TRIM(category) = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN product_name IS NULL OR TRIM(product_name) = '' THEN 1 ELSE 0 END) AS missing_product,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM walmart;

-- validating numerical columns
SELECT
    MIN(sales) AS minimum_sales,
    MAX(sales) AS maximum_sales,
    MIN(quantity) AS minimum_quantity,
    MAX(quantity) AS maximum_quantity,
    MIN(profit) AS minimum_profit,
    MAX(profit) AS maximum_profit
FROM walmart;

-- Answering business queries

-- Q1. What is the overall business performance?
SELECT
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold,
    ROUND(AVG(sales), 2) AS average_sales_per_record
FROM walmart;

-- Q2. Which product categories generate the most sales and profit?
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY category
ORDER BY total_sales DESC;

-- Q3. What are the top 10 products by sales?
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Q4. Which States Generate the Highest Sales and Profit?
SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY state
ORDER BY total_sales DESC;

-- Q5. Which Cities Generate the Highest Sales?
SELECT
    city,
    state,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM walmart
GROUP BY city, state
ORDER BY total_sales DESC
LIMIT 10;

-- Q6. What Is the Monthly Sales Trend?
SELECT
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM walmart
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    sales_year,
    sales_month;

-- Q7. Which Products Generate the Highest Profit?
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold
FROM walmart
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Q8. Which Products Generate the Biggest Losses?
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM walmart
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;

-- Q9. Which Categories Have the Highest Profit Margins?
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS profit_margin_percentage
FROM walmart
GROUP BY category
ORDER BY profit_margin_percentage DESC;

-- Q10. How many unique orders, products, cities, and states are represented?
SELECT
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT product_name) AS unique_products,
    COUNT(DISTINCT city) AS unique_cities,
    COUNT(DISTINCT state) AS unique_states,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS overall_profit_margin_percentage
FROM walmart;