# Lesson 1 — Data Understanding & Data Quality Checks

## Objective

The objective of this lesson was to understand the Maven Toys dataset and verify its structural and data quality before beginning business analysis.

The checks focused on:

- Table sizes
- Primary-key uniqueness
- Missing values
- Composite-key uniqueness
- Foreign-key relationships
- Invalid numerical values
- Date ranges
- Currency formatting

---

## 1. Dataset Baseline

| Table | Rows |
|---|---:|
| `products` | 35 |
| `stores` | 50 |
| `inventory` | 1,593 |
| `sales` | 30,000 |

The `sales` table contains a 30,000-row sample used for this project.

---

## 2. Products Data Quality

### Primary Key

`Product_ID` is the primary key.

- Duplicate `Product_ID`: **0**
- Missing `Product_ID`: **0**

### Missing Values

| Field | Missing Values |
|---|---:|
| `Product_ID` | 0 |
| `Product_Name` | 0 |
| `Product_Category` | 0 |
| `Product_Cost` | 0 |
| `Product_Price` | 0 |

### Result

The `products` table passed the duplicate and missing-value checks.

---

## 3. Stores Data Quality

### Primary Key

`Store_ID` is the primary key.

- Duplicate `Store_ID`: **0**
- Missing `Store_ID`: **0**

### Missing Values

| Field | Missing Values |
|---|---:|
| `Store_ID` | 0 |
| `Store_Name` | 0 |
| `Store_City` | 0 |
| `Store_Location` | 0 |
| `Store_Open_Date` | 0 |

### Result

The `stores` table passed the duplicate and missing-value checks.

---

## 4. Inventory Data Quality

`inventory` uses a composite primary key:

```text
(Store_ID, Product_ID)
