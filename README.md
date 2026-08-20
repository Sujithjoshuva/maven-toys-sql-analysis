# Maven Toys SQL Business Analysis

## Project Overview

This project analyzes retail sales data from Maven Toys using SQL.

The objective is to explore sales performance, product performance, store performance, inventory, and business trends, and translate the analysis into meaningful business insights.

This project is being developed incrementally. Each SQL lesson is applied directly to the Maven Toys dataset and documented as part of the portfolio.

---

## Business Objectives

The analysis aims to answer business questions such as:

- Which stores perform best and worst?
- Which products generate the highest unit sales?
- Which products generate the highest revenue and profit?
- Which product categories perform best?
- How does inventory compare with sales activity?
- How do sales change over time?
- What patterns can help support business decisions?

---

## Dataset

The project uses the Maven Toys retail dataset.

### Tables

| Table | Description | Rows |
|---|---|---:|
| `products` | Product information | 35 |
| `stores` | Store information | 50 |
| `inventory` | Product stock by store | 1,593 |
| `sales` | Sales transactions | 30,000 |

The `sales` table used in this project contains a 30,000-row sample of the available sales data.

---

## Table Relationships

```text
products
   |
   | Product_ID
   |
   +------------------+
                      |
                    sales
                      |
                      | Store_ID
                      |
                    stores

products
   |
   | Product_ID
   |
inventory
   |
   | Store_ID
   |
stores
```

---

# Lesson 1 — Data Quality Checks

## Objective

Validate the dataset and identify potential data quality issues before performing business analysis.

## SQL Concepts Learned

- `SELECT`
- `COUNT()`
- `DISTINCT`
- `GROUP BY`
- `ORDER BY`
- `WHERE`
- Aggregate functions
- Data validation checks

## Analysis Performed

- Checked row counts across the project tables
- Reviewed available columns and table structures
- Checked for missing values
- Checked for duplicate records
- Validated product and store identifiers
- Performed basic data quality checks before beginning business analysis

## Project Files

- [Lesson 1 SQL](sql/01_data_quality_checks.sql)
- [Lesson 1 Insights](insights/01_data_quality_insights.md)

---

# Lesson 2 — Store Performance Analysis

## Objective

Analyze store-level performance using transaction activity, total units sold, average units sold per transaction, and product-level rankings.

## SQL Concepts Learned

- `COUNT()`
- `SUM()`
- `AVG()`
- `GROUP BY`
- `ORDER BY`
- `INNER JOIN`
- Subqueries
- `ROW_NUMBER()`
- `PARTITION BY`
- `CASE WHEN`
- Benchmark-based classification
- Multi-level query structure

## Analysis Performed

- Ranked stores by transaction activity
- Calculated total units sold by store
- Calculated average units sold per transaction
- Identified top products within individual stores
- Used `ROW_NUMBER()` and `PARTITION BY` to rank products within each store
- Created store performance benchmarks
- Classified all 50 stores into four performance groups
- Translated SQL results into business insights

## Key Findings

- Maven Toys Ciudad de Mexico 2 (Store 31) recorded the highest transaction activity with **1,029 transactions**.
- Store 31 also recorded the highest average units per transaction at **1.4762**.
- **12 of 50 stores** were classified as Strong Performers.
- **4 of 50 stores** were classified as Higher Traffic, Lower Basket.
- **10 of 50 stores** were classified as Lower Traffic, Higher Basket.
- **24 of 50 stores** were classified as Needs Improvement based on the selected benchmarks.

## Store Performance Benchmarks

| Metric | Benchmark |
|---|---:|
| Average transactions per store | 600 |
| Average units per transaction | 1.3193 |

## Project Files

- [Lesson 2 SQL](sql/02_store_performance_analysis.sql)
- [Lesson 2 Insights](insights/02_store_performance_insights.md)

---

# Lesson 3 — Product and Category Performance Analysis

## Objective

Analyze product and category performance using total units sold, revenue, profit, profit margin, and ranking techniques.

## SQL Concepts Learned

- `INNER JOIN`
- `SUM()`
- `GROUP BY`
- `ORDER BY`
- Calculated fields
- Revenue calculation
- Cost calculation
- Profit calculation
- Profit margin calculation
- Subqueries
- Window functions
- `ROW_NUMBER()`
- Multi-metric ranking

## Analysis Performed

- Identified products with the highest units sold
- Calculated product-level revenue
- Calculated product-level total cost and total profit
- Analyzed product-level profit margins
- Compared category performance using units, revenue, profit, and profit margin
- Ranked categories by total units sold
- Ranked categories by total revenue
- Ranked categories by total profit
- Ranked categories by profit margin
- Combined multiple performance rankings into a single category comparison

## Key Findings

- **Colorbuds** recorded the highest verified product-level unit sales with **3,916 units sold**.
- **Lego Bricks** generated the highest verified product-level revenue at **$85,218.69**.
- **Colorbuds** generated the highest verified product-level total profit at **$31,328.00**.
- **Jenga** had the highest verified product-level profit margin at approximately **70.07%**.
- **Art & Crafts** ranked first in category-level units sold with **11,871 units**.
- **Toys** ranked first in category-level revenue at **$183,076.57**.
- **Toys** also ranked first in category-level total profit at **$38,877.00**.
- **Electronics** ranked first in category-level profit margin at approximately **44.85%**, despite ranking fifth in total units sold.
- The analysis showed that high sales volume, high revenue, high profit, and high profit margin do not necessarily belong to the same category.

## Category Performance Comparison

| Category | Units Rank | Revenue Rank | Profit Rank | Profit Margin Rank |
|---|---:|---:|---:|---:|
| Toys | 2 | 1 | 1 | 5 |
| Art & Crafts | 1 | 2 | 3 | 3 |
| Electronics | 5 | 3 | 2 | 1 |
| Games | 3 | 4 | 4 | 2 |
| Sports & Outdoors | 4 | 5 | 5 | 4 |

## Project Files

- [Lesson 3 SQL](sql/03_product_category_performance.sql)
- [Lesson 3 Insights](insights/03_product_category_performance_insights.md)

---

# Project Structure

```text
maven-toys-sql-analysis/
│
├── sql/
│   ├── 01_data_quality_checks.sql
│   ├── 02_store_performance_analysis.sql
│   └── 03_product_category_performance.sql
│
├── insights/
│   ├── 01_data_quality_insights.md
│   ├── 02_store_performance_insights.md
│   └── 03_product_category_performance_insights.md
│
└── README.md
```

---

# Skills Demonstrated

Through Lessons 1 to 3, this project demonstrates:

- Data quality validation
- Data aggregation
- Business metric calculations
- `INNER JOIN`
- `GROUP BY`
- `HAVING`
- `CASE WHEN`
- Subqueries
- Window functions
- `ROW_NUMBER()`
- `PARTITION BY`
- Revenue analysis
- Cost analysis
- Profit analysis
- Profit margin analysis
- Store performance classification
- Product performance analysis
- Category performance ranking
- Translating SQL results into business insights

---

# Project Progress

- [x] Lesson 1 — Data Quality Checks
- [x] Lesson 2 — Store Performance Analysis
- [x] Lesson 3 — Product and Category Performance Analysis
- [ ] Lesson 4 — Upcoming
