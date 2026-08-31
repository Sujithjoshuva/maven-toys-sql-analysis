# Lesson 4 — Inventory Analysis

## Objective

Analyze product inventory relative to historical sales to identify potential replenishment and overstock candidates.

---

## Key Metrics

### Inventory-to-Sales Ratio

\[
Inventory\text{-}to\text{-}Sales\ Ratio =
\frac{Total\ Stock}{Total\ Units\ Sold}
\]

A lower ratio indicates relatively lower inventory compared with historical sales, while a higher ratio indicates relatively higher inventory compared with historical sales.

---

## Benchmarks Used

| Metric | Benchmark |
|---|---:|
| Average units sold per product | 1,130.8286 |
| Inventory-to-sales ratio threshold | 1.0 |

The average units sold benchmark was calculated from the product-level sales data.

---

## Key Findings

### Highest Inventory Products

The products with the highest total inventory included:

| Product | Category | Total Stock |
|---|---|---:|
| Deck Of Cards | Games | 2,738 |
| Dinosaur Figures | Toys | 2,272 |
| PlayDoh Can | Art & Crafts | 2,129 |
| Magic Sand | Art & Crafts | 1,922 |
| Rubik's Cube | Games | 1,497 |

### Lowest Inventory Products

The products with the lowest total inventory included:

| Product | Category | Total Stock |
|---|---|---:|
| Jenga | Games | 181 |
| Monopoly | Games | 207 |
| Mini Basketball Hoop | Sports & Outdoors | 234 |
| Classic Dominoes | Games | 241 |
| Uno Card Game | Games | 241 |

---

## Category Inventory Analysis

| Rank | Category | Total Stock | Total Units Sold | Inventory-to-Sales Ratio |
|---:|---|---:|---:|---:|
| 1 | Electronics | 2,418 | 4,961 | 0.49 |
| 2 | Art & Crafts | 8,635 | 11,871 | 0.73 |
| 3 | Toys | 7,553 | 9,643 | 0.78 |
| 4 | Sports & Outdoors | 4,981 | 6,112 | 0.81 |
| 5 | Games | 6,155 | 6,992 | 0.88 |

### Category Insight

Electronics had the lowest inventory-to-sales ratio at **0.49**, while Games had the highest at **0.88**.

This indicates that Electronics had relatively lower inventory compared with historical sales, while Games had relatively higher inventory compared with historical sales.

---

## Potential Replenishment Candidates

Products were classified as potential replenishment candidates when:

- Total units sold ≥ 1,130.8286
- Inventory-to-sales ratio < 1.0

### Key Examples

| Product | Category | Units Sold | Stock | Ratio |
|---|---|---:|---:|---:|
| Colorbuds | Electronics | 3,916 | 1,159 | 0.30 |
| PlayDoh Can | Art & Crafts | 3,730 | 2,129 | 0.57 |
| Barrel O' Slime | Art & Crafts | 3,453 | 1,282 | 0.37 |
| Deck Of Cards | Games | 2,992 | 2,738 | 0.92 |
| Splash Balls | Sports & Outdoors | 2,247 | 893 | 0.40 |

A total of **13 products** were classified as potential replenishment candidates.

---

## Potential Overstock Candidates

Products were classified as potential overstock candidates when:

- Total units sold < 1,130.8286
- Inventory-to-sales ratio > 1.0

### Key Examples

| Product | Category | Units Sold | Stock | Ratio |
|---|---|---:|---:|---:|
| Uno Card Game | Games | 87 | 241 | 2.77 |
| PlayDoh Playset | Art & Crafts | 225 | 550 | 2.44 |
| Mr. Potatohead | Toys | 315 | 709 | 2.25 |
| Plush Pony | Toys | 222 | 497 | 2.24 |
| Supersoaker Water Gun | Sports & Outdoors | 236 | 513 | 2.17 |

A total of **17 products** were classified as potential overstock candidates.

---

## Inventory Status Summary

| Inventory Status | Product Count |
|---|---:|
| Potential Overstock | 17 |
| Potential Replenishment | 13 |
| Normal Inventory Position | 5 |
| **Total** | **35** |

---

## Business Insights

- **13 products** showed high historical sales combined with relatively low inventory and may require closer replenishment attention.
- **17 products** showed lower historical sales combined with relatively high inventory and may require closer overstock review.
- **5 products** fell outside both conditions and were classified as having a normal inventory position.
- Electronics had the lowest category inventory-to-sales ratio at **0.49**.
- Games had the highest category inventory-to-sales ratio at **0.88**.
- Inventory and sales should be analyzed together rather than independently when evaluating inventory position.

---

## Important Limitation

The inventory classifications are analytical indicators based on historical sales and current stock levels.

They do **not** confirm actual stockouts or overstock conditions because the analysis does not include factors such as:

- Inventory age
- Sales period duration
- Replenishment lead time
- Future demand
- Seasonality
- Stock replenishment schedules

Therefore, the results should be used to identify products for **further inventory review**, rather than as definitive inventory decisions.
