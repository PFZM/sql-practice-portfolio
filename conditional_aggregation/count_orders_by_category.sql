/* 
------------------------------------------------------------
 SQL Exercise — Conditional Aggregation
------------------------------------------------------------

Dataset:
--------
Tables:
  orders(order_id, customer_id, product_id)
  products(product_id, category)

Task:
-----
For each customer, count:
  - how many orders were in category 'A'
  - how many orders were in category 'B'

Requirements:
  - Use SUM(CASE WHEN ... THEN 1 END)
  - Must use GROUP BY customer_id
  - Join products table
  - Return: customer_id, count_category_A, count_category_B

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

SELECT
customer_id,
SUM(CASE WHEN p.category = 'A' THEN 1 ELSE 0 END) AS count_category_A,
SUM(CASE WHEN p.category = 'B' THEN 1 ELSE 0 END) AS count_category_B
FROM orders o 
LEFT JOIN products p ON o.product_id = p.product_id   
GROUP BY customer_id;

