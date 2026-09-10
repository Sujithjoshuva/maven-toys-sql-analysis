Lesson 6: Customer & Store Performance Analysis

Business Question 1
Which stores generated the highest revenue?
select
	s.Store_ID,
  s.Store_Name,
  sum(sa.Units * p.Product_Price) as total_revenue
from stores as s
inner join sales as sa
on s.Store_ID = sa.Store_ID
inner join products as p
on sa.Product_ID = p.Product_ID
group by Store_ID,Store_Name
order by total_revenue desc;


Business Question 2
What is the revenue rank of each store?
SELECT
    Store_ID,
    Store_Name,
    total_revenue,
    ROW_NUMBER() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM (
    SELECT
        s.Store_ID,
        st.Store_Name,
        SUM(s.Units * p.Product_Price) AS total_revenue
    FROM sales AS s
    INNER JOIN products AS p
        ON s.Product_ID = p.Product_ID
    INNER JOIN stores AS st
        ON s.Store_ID = st.Store_ID
    GROUP BY
        s.Store_ID,
        st.Store_Name
) AS store_revenue
ORDER BY revenue_rank;


Business Question 3

Which stores are in the Top 10 by revenue?
select
	rank()over(
    order by total_revenue desc) as revenue_rank,
    Store_ID,
    Store_Name,
    total_revenue
from(
select
	s.Store_ID,
    s.Store_Name,
    sum(sa.Units * p.Product_Price) as total_revenue
from stores as s
inner join sales as sa
on s.Store_ID = sa.Store_ID
inner join products as p
on sa.Product_ID = p.Product_ID
group by Store_ID,Store_Name) as store_revenue
limit 10;

Business Question 4
What is the revenue rank of each product within its own product category?
select
	row_number()over(
    partition by Product_Category
    order by total_revenue desc) as category_revenue_rank,
    Product_ID,
    Product_Name,
    Product_Category,
    total_revenue
from(
select
	p.Product_ID,
	p.Product_Name,
    p.Product_Category,
    sum(s.Units * p.Product_Price) as total_revenue
from products as p
inner join sales as s
on p.Product_ID = s.Product_ID
group by Product_ID,Product_Name,Product_Category) as product_revenue;
