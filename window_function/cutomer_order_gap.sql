/*
------------------------------------------------------------
 SQL Exercise — Days Between Customer Orders
------------------------------------------------------------

Dataset:
--------
orders(
  order_id,
  customer_id,
  order_date
)

Task:
-----
For each order, calculate:
  - previous_order_date per customer
  - days_between_orders

Requirements:
  - Use LAG(order_date)
  - Partition by customer_id
  - Order by order_date
  - Use DATE difference logic
  - Do NOT use GROUP BY

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH lagged_orders AS 
(
SELECT
order_id,
customer_id,
order_date,
LAG(order_date)OVER(PARTITION by customer_id ORDER BY order_date) as previous_order_date
FROM orders 
)
SELECT 
order_id,
customer_id,
order_date,
previous_order_date,
DATEDIFF(day, previous_order_date, order_date) as days_between_orders
FROM lagged_orders
;