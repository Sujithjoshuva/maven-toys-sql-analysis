# Maven Toys SQL Business Analysis

## Project Overview

This project analyzes retail sales data from Maven Toys using SQL.

The objective is to use SQL to explore sales performance, product performance, store performance, inventory, and business trends, and then translate the analysis into meaningful business insights.

This project is being developed incrementally, with each SQL lesson applied directly to the project and documented as part of the portfolio.

---

## Business Objective

The analysis aims to answer business questions such as:

- Which stores perform best and worst?
- Which products generate the highest unit sales?
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
