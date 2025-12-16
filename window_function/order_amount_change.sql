/*
------------------------------------------------------------
 SQL Exercise — Change in Order Amount per Customer
------------------------------------------------------------

Dataset:
--------
orders(
  order_id,
  customer_id,
  order_date,
  order_amount
)

Task:
-----
For each order, calculate:
  - previous_order_amount (per customer)
  - difference_from_previous_order

Requirements:
  - Use LAG(order_amount)
  - Partition by customer_id
  - Order by order_date
  - Do NOT use GROUP BY

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH previous_orders AS 
(
    SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    LAG(order_amount) OVER (PARTITION BY customer_id ORDER BY  order_date) as previous_order_amount
    FROM orders 
)
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    (order_amount - previous_order_amount) as difference_from_previous_order
FROM previous_orders
;
