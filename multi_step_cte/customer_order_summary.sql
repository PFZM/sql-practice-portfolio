/*
------------------------------------------------------------
 SQL Exercise — Customer Order Summary (Advanced)
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
Build a final dataset with ONE row per customer containing:

  - total_spent
  - order_count
  - avg_order_amount
  - most_recent_order_date
  - order_amount_of_most_recent_order

Requirements:
  - Use at least 2 CTEs
  - Use GROUP BY for aggregates
  - Use ROW_NUMBER() for most recent order
  - Do NOT use subqueries in SELECT
  - Final result must be one row per customer

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH ord_agg AS 
(
    SELECT
    customer_id,
    SUM(order_amount) as total_spent,
    COUNT(order_id) as order_count,
    AVG(order_amount) as avg_order_amount 
    FROM orders 
    GROUP BY customer_id
), rn_orders AS 
(
    SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date desc) as rn_date
    FROM orders 
)
SELECT
oa.customer_id,
oa.total_spent,
oa.order_count,
oa.avg_order_amount,
rno.order_date AS most_recent_order_date,
rno.order_amount AS order_amount_of_most_recent_order
FROM ord_agg oa 
LEFT JOIN rn_orders rno ON oa.customer_id = rno.customer_id
AND rno.rn_date = 1
;