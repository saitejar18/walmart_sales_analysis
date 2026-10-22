# Walmart Sales Analysis

## Project Overview

This project analyzes Walmart sales data using **MySQL** and **Power
BI** to explore sales performance, profit, product and category trends,
and geographic and monthly patterns. The goal is to turn raw sales data
into useful business insights through SQL queries and an interactive
dashboard.

## Tools Used

-   **Microsoft Excel** --- initial data review
-   **MySQL** --- data querying and business analysis
-   **Power BI** --- dashboard and visual reporting

## Project Structure

``` text
Walmart Sales Analysis/
├── Data/
│   ├── walmart_sales_raw.xlsx
│   └── walmart_sales_cleaned.csv
├── MySQL/
│   └── walmart_sales_analysis.sql
├── PowerBI/
│   ├── walmart_sales_analysis_dashboard.pbix
│   └── walmart_sales_analysis_dashboard.pdf
└── Document/
    └── walmart_sales_analysis_document.pdf
```

## Analysis Performed

The SQL queries and Power BI dashboard explore the following business questions:

1. What is the overall sales and profit performance?
2. Which product categories generate the most sales and profit?
3. What are the top 10 products by sales?
4. Which states generate the highest sales and profit?
5. Which cities generate the highest sales?
6. What is the monthly sales trend?
7. Which products generate the highest profit?
8. Which products generate the biggest losses?
9. Which categories have the highest profit margins?
10. How many unique orders, products, cities, and states are represented, and what is the overall profit margin?


## Dashboard Highlights

The Power BI dashboard presents key performance indicators and visuals
for sales, profit, order volume, quantity, product performance, category
distribution, geographic performance, and monthly trends. Use the
available filters to explore the data.

## How to Use

1.  Open `MySQL/walmart_sales_analysis.sql` and review the queries.
2.  Load the cleaned CSV into MySQL using your preferred import method,
    ensuring the table columns and data types match the SQL queries.
3.  Run the SQL queries to reproduce the analysis.
4.  Open `PowerBI/walmart_sales_analysis_dashboard.pbix` in Power BI
    Desktop to explore the dashboard.
5.  Use the PDF exports for a quick, non-interactive preview.

## Data Validation Note

The raw Excel file and cleaned CSV may have different row counts. Before
interpreting the results, verify the cleaning steps and the number of
rows imported into MySQL. Confirm that the MySQL row count matches the
intended source file and investigate any import warnings or rejected
rows. Do not assume rows were intentionally removed without checking the
import process.

## Key Learning Outcomes

-   Writing SQL queries for business questions
-   Summarizing and comparing sales and profit
-   Identifying product, category, time, and location trends
-   Communicating findings through a Power BI dashboard

## Notes

This is a portfolio/learning project. Findings reflect the data included
in the project files and should not be interpreted as official Walmart
corporate reporting.
