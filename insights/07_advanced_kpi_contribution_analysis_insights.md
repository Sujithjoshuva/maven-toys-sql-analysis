# Lesson 7: Advanced KPI & Contribution Analysis

## 1. Objective

Analyze store revenue contribution, cumulative revenue contribution, revenue quartiles, total profit, and profit margins to understand how stores contribute to overall business performance.

## 2. Dataset Note

This analysis uses a 30,000-row sample of sales data, not the complete original sales dataset. Findings are based on this sample.

## 3. Key Findings

### Store Revenue Contribution

- Total revenue across the 50 stores was **$521,657.21**.
- Store 31, Maven Toys Ciudad de Mexico 2, generated the highest revenue of **$19,073.81**, contributing **3.66%** of total revenue.
- Store 43, Maven Toys Durango 1, generated the lowest revenue of **$7,412.95**, contributing **1.42%**.

### Cumulative Revenue Contribution

- The top 5 stores contributed **15.23%** of total revenue.
- The top 10 stores contributed **26.97%**.
- The top 20 stores contributed **48.09%**.
- All 50 stores accounted for **100%** of the analyzed revenue.

### Revenue Quartile Performance

Stores were divided into four revenue quartiles using `NTILE(4)`.

| Quartile | Stores | Total Revenue | Total Profit | Average Revenue per Store | Average Profit per Store |
|---|---:|---:|---:|---:|---:|
| 1 — Highest Revenue | 13 | $175,322.62 | $47,847 | $13,486.36 | $3,680.54 |
| 2 | 13 | $136,097.35 | $38,371 | $10,469.03 | $2,951.62 |
| 3 | 12 | $113,127.64 | $32,127 | $9,427.30 | $2,677.25 |
| 4 — Lowest Revenue | 12 | $97,109.60 | $27,158 | $8,092.47 | $2,263.17 |

Quartile 1 generated the highest total revenue and profit. Average revenue and average profit per store decreased across the four quartiles in this analysis.

### Profit Margin by Quartile

| Quartile | Profit Margin |
|---|---:|
| 1 — Highest Revenue | 27.29% |
| 2 | 28.19% |
| 3 | 28.40% |
| 4 — Lowest Revenue | 27.97% |

Quartile 3 had the highest profit margin at **28.40%**, while Quartile 1 had the lowest at **27.29%**. The highest-revenue group did not have the highest profit margin.

## 4. Business Interpretation

Revenue, total profit, and profit margin provide different perspectives on store performance. High revenue does not automatically mean the highest profit margin. Comparing these metrics together provides a more balanced view of store performance.

## 5. SQL Concepts Practiced

- Common Table Expressions (CTEs)
- Window functions using `SUM() OVER()`
- Cumulative totals
- Revenue contribution percentages
- `NTILE(4)` for quartile analysis
- `GROUP BY` and aggregate functions
- Profit margin calculation

## 6. Limitations

- The analysis uses a 30,000-row sales sample.
- Results may differ when the complete sales dataset is analyzed.
- Revenue quartiles are based on revenue, not customer satisfaction, inventory availability, or other operational measures.
- These results describe observed performance and do not establish the causes of differences between stores.

## 7. Conclusion

The analysis identified the leading and lowest-revenue stores, measured cumulative revenue contribution, and compared profitability across revenue quartiles. It demonstrates how SQL window functions, CTEs, and aggregation can support multi-metric business analysis.
