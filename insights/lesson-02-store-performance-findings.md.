# Lesson 2 — Store Performance Analysis

## Objective

Analyze store-level performance using transaction activity, total units sold, average units sold per transaction, and product-level performance.

---

## 1. Store Performance Metrics

For each store, we calculated:

- Total transactions
- Total units sold
- Average units sold per transaction

### Key finding

**Maven Toys Ciudad de Mexico 2 (Store 31)** recorded:

- 1,029 transactions
- 1,519 total units sold
- 1.4762 average units per transaction

Store 31 ranked highest in both transaction activity and average units per transaction in the analysis.

---

## 2. Top Stores by Transaction Activity

The five stores with the highest transaction counts were:

| Rank | Store ID | Store Name | Transactions |
|---:|---:|---|---:|
| 1 | 31 | Maven Toys Ciudad de Mexico 2 | 1,029 |
| 2 | 9 | Maven Toys Ciudad de Mexico 1 | 934 |
| 3 | 17 | Maven Toys Toluca 1 | 856 |
| 4 | 30 | Maven Toys Guadalajara 3 | 855 |
| 5 | 7 | Maven Toys Monterrey 2 | 807 |

### Insight

Maven Toys Ciudad de Mexico 2 recorded the highest transaction activity with 1,029 transactions.

---

## 3. Top Stores by Average Units per Transaction

The five stores with the highest average units per transaction were:

| Rank | Store ID | Store Name | Transactions | Avg Units / Transaction |
|---:|---:|---|---:|---:|
| 1 | 31 | Maven Toys Ciudad de Mexico 2 | 1,029 | 1.4762 |
| 2 | 47 | Maven Toys Monterrey 4 | 579 | 1.4439 |
| 3 | 42 | Maven Toys Hermosillo 3 | 542 | 1.4096 |
| 4 | 49 | Maven Toys Culiacan 1 | 500 | 1.3980 |
| 5 | 17 | Maven Toys Toluca 1 | 856 | 1.3960 |

### Insight

Store 31 also ranked first in average units per transaction, indicating strong performance in both transaction activity and units sold per transaction.

Store 47 had 579 transactions but a high average of 1.4439 units per transaction, showing that transaction volume and average units per transaction measure different aspects of store performance.

---

## 4. Top 5 Products by Store

`ROW_NUMBER()` with `PARTITION BY Store_ID` was used to rank products within each store.

### Store 31 — Top 5 Products

| Rank | Product | Units Sold |
|---:|---|---:|
| 1 | Colorbuds | 236 |
| 2 | Deck Of Cards | 157 |
| 3 | Glass Marbles | 153 |
| 4 | PlayDoh Can | 136 |
| 5 | Splash Balls | 120 |

### Store 40 — Top 5 Products

| Rank | Product | Units Sold |
|---:|---|---:|
| 1 | Splash Balls | 64 |
| 2 | Deck Of Cards | 62 |
| 3 | Lego Bricks | 53 |
| 4 | Magic Sand | 45 |
| 5 | PlayDoh Can | 44 |

### Insight

The top-selling product differs between the two stores:

- Store 31: Colorbuds — 236 units
- Store 40: Splash Balls — 64 units

This demonstrates why store-level product analysis is useful instead of relying only on overall product rankings.

---

## 5. Store Performance Benchmarks

Two benchmarks were calculated for store classification:

| Metric | Benchmark |
|---|---:|
| Average transactions per store | 600 |
| Overall average units per transaction | 1.3193 |

Stores meeting or exceeding both benchmarks were classified as having high transaction activity and a high basket size.

---

## 6. Store Performance Classification

Each of the 50 stores was classified into one of four groups.

| Performance Category | Number of Stores |
|---|---:|
| Strong Performer | 12 |
| Higher Traffic, Lower Basket | 4 |
| Lower Traffic, Higher Basket | 10 |
| Needs Improvement | 24 |
| **Total** | **50** |

### Classification logic

#### Strong Performer

High transaction activity + high average units per transaction.

#### Higher Traffic, Lower Basket

High transaction activity + low average units per transaction.

#### Lower Traffic, Higher Basket

Low transaction activity + high average units per transaction.

#### Needs Improvement

Low transaction activity + low average units per transaction.

---

## 7. Strong Performer Stores

The 12 Strong Performer stores were:

| Store ID | Store Name | Transactions | Avg Units / Transaction |
|---:|---|---:|---:|
| 6 | Maven Toys Mexicali 1 | 632 | 1.3877 |
| 7 | Maven Toys Monterrey 2 | 807 | 1.3197 |
| 9 | Maven Toys Ciudad de Mexico 1 | 934 | 1.3319 |
| 10 | Maven Toys Campeche 1 | 640 | 1.3875 |
| 17 | Maven Toys Toluca 1 | 856 | 1.3960 |
| 28 | Maven Toys Puebla 2 | 621 | 1.3607 |
| 30 | Maven Toys Guadalajara 3 | 855 | 1.3240 |
| 31 | Maven Toys Ciudad de Mexico 2 | 1,029 | 1.4762 |
| 37 | Maven Toys Ciudad de Mexico 3 | 655 | 1.3695 |
| 39 | Maven Toys Xalapa 2 | 702 | 1.3362 |
| 41 | Maven Toys Hermosillo 2 | 644 | 1.3276 |
| 45 | Maven Toys Ciudad de Mexico 4 | 629 | 1.3243 |

---

## 8. Key Business Insights

### Store 31 is the strongest overall performer

Maven Toys Ciudad de Mexico 2 recorded the highest transaction count and the highest average units per transaction among the stores analyzed.

### A large proportion of stores fall below both benchmarks

24 of the 50 stores were classified as Needs Improvement based on the defined benchmarks.

### Some stores have strong basket size but lower transaction activity

10 stores were classified as Lower Traffic, Higher Basket.

These stores may provide opportunities to increase transaction activity while maintaining their relatively strong average units per transaction.

### Some stores have high traffic but lower basket size

4 stores were classified as Higher Traffic, Lower Basket.

These stores have relatively strong transaction activity but lower average units per transaction compared with the benchmark.

---

## Important Analytical Note

The performance classifications are benchmark-based.

The benchmarks used were:

- 600 transactions
- 1.3193 average units per transaction

Therefore, "Needs Improvement" means the store was below both selected benchmarks. It does not represent an absolute judgment of store quality.

---

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
- Filtering ranked results
- Creating benchmark-based classifications
- Turning SQL results into business insights
