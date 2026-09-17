# Lesson 6 — Advanced Store & Product Performance Analysis

## Objective

Analyze store and product performance using advanced SQL techniques including CTEs, window functions, ranking, benchmarking, and multi-metric classification.

## Key Business Questions

1. Which stores generate the highest revenue?
2. Which products rank highest by revenue within each category?
3. Which products rank highest by profit within each category?
4. Which products have the highest profit margins within each category?
5. How do stores rank across revenue, profit, and profit margin?
6. How do stores compare against average revenue and profit benchmarks?
7. How are stores distributed across revenue-profit performance groups?

## Verified Findings

### Store Performance

- Store 31 — Maven Toys Ciudad de Mexico 2 — generated the highest revenue at **$19,073.81**.
- Store 31 also generated the highest profit at **$6,049.00**.
- Store 6 — Maven Toys Mexicali 1 — had the highest store profit margin at **34.86%**.
- Average store revenue was **$10,433.14**.
- Average store profit was **$2,910.06**.

### Product Performance

- Jenga had the highest overall product profit margin at **70.07%**.
- Colorbuds generated the highest profit among products at **$31,328.00**.
- Lego Bricks generated the highest product revenue at **$85,218.69**.
- Revenue ranking and profit ranking produced different results, demonstrating that revenue alone does not describe product profitability.

### Store Benchmark Classification

Using average store revenue and average store profit as benchmarks:

- **16 stores** were classified as High Revenue + High Profit.
- **2 stores** were classified as High Revenue + Low Profit.
- **4 stores** were classified as Low Revenue + High Profit.
- **28 stores** were classified as Low Revenue + Low Profit.

## Business Interpretation

Revenue, profit, and profit margin measure different aspects of performance. A store or product can generate high revenue without having the highest profit margin. Comparing multiple metrics provides a more complete view of business performance.

The revenue-profit quadrant analysis also helps distinguish stores with different performance patterns rather than treating every store below both benchmarks in the same way.

## SQL Concepts Learned

- Common Table Expressions (CTEs)
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `PARTITION BY`
- `CASE WHEN`
- `CROSS JOIN`
- Aggregations
- Multi-metric ranking
- Benchmark analysis
- Performance classification
