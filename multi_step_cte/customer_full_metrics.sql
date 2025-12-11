/* 
------------------------------------------------------------
 SQL Exercise — Customer Full Metrics (Advanced Multi-CTE)
------------------------------------------------------------

Dataset:
--------
orders(order_id, customer_id, order_date, order_amount)

Task:
-----
Build a customer metrics dataset showing:
  - total_spent
  - avg_order_amount
  - order_count
  - most_recent_order_date
  - highest_order_amount
  - order_id of the highest order
  - running total as of most recent order

Requirements:
  - Use at least 2–3 CTEs
  - Mix GROUP BY + window functions
  - Use ROW_NUMBER() to identify specific orders
  - Final output must return one row per customer

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

WITH agg_customers AS 
(
    SELECT
    customer_id,
    SUM(order_amount) AS total_spent,
    AVG(order_amount) AS avg_order_amount,
    COUNT(*) AS order_count,
    FROM orders
    GROUP BY customer_id
), rn_orders_date AS
(
    SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS rn_date_orders
    FROM orders
), rn_orders_amount AS
(
    SELECT
    order_id,
    customer_id,
    order_amount,
    ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_amount DESC) AS rn_amount_orders
    FROM orders
), running_totals AS 
(
    SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    SUM(order_amount)OVER(PARTITION BY customer_id ORDER BY order_date) AS running_total_as_of_last_order
    FROM orders 
)
SELECT
ac.customer_id,
ac.total_spent,
ac.avg_order_amount,
ac.order_count,
rod.order_date AS most_recent_order_date,
rad.order_amount AS highest_order_amount,
rad.order_id AS highest_order_id,
rt.running_total_as_of_last_order
FROM agg_customers ac 
LEFT JOIN rn_orders_date rod ON ac.customer_id = rod.customer_id
    AND rod.rn_date_orders = 1
LEFT JOIN rn_orders_amount rad ON ac.customer_id = rad.customer_id
    AND rad.rn_amount_orders = 1
LEFT JOIN running_totals rt ON ac.customer_id = rt.customer_id
    AND rt.order_id = rod.order_id
;   
