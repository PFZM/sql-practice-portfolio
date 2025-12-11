/* 
------------------------------------------------------------
 SQL Exercise — Customer Order Breakdown by Category
------------------------------------------------------------

Dataset:
--------
orders(order_id, customer_id, product_id)
products(product_id, category)

Task:
-----
For each customer, return:
  - total orders
  - orders in category 'A'
  - orders in category 'B'
  - orders in category 'C'

Requirements:
  - Use SUM(CASE WHEN ...)
  - Use GROUP BY customer_id
  - Must join the products table

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

SELECT
o.customer_id,
COUNT(*) as total_orders,
SUM(CASE WHEN p.category = 'A' THEN 1 ELSE 0 END) AS orders_in_category_A,
SUM(CASE WHEN p.category = 'B' THEN 1 ELSE 0 END) AS orders_in_category_B,
SUM(CASE WHEN p.category = 'C' THEN 1 ELSE 0 END) AS orders_in_category_C
FROM orders o 
LEFT JOIN products p ON o.product_id = p.product_id 
GROUP BY o.customer_id;

