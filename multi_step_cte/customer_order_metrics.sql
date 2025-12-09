/* 
------------------------------------------------------------
 SQL Exercise — Multi-step CTE Customer Metrics
------------------------------------------------------------

Dataset:
--------
Table: orders

    order_id
    customer_id
    order_date
    order_amount

Task:
-----
Using multiple CTEs, build a metrics table that includes:
  - total_spent per customer
  - order_count per customer
  - avg_order_amount per customer
  - most_recent_order_date per customer (using ROW_NUMBER())

Requirements:
  - Use at least 2 CTEs
  - Mix GROUP BY and window functions
  - Final result must be one row per customer
  - Return: customer_id, total_spent, order_count, avg_order_amount, most_recent_order_date

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

WITH cust_agg AS 
(
    SELECT
    customer_id,
    SUM(order_amount) AS total_spent,
    COUNT(order_id) AS order_count,
    AVG(order_amount) AS avg_order_amount
    FROM orders 
    GROUP BY customer_id
), rn_order AS
(
    SELECT 
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date DESC) as rn_date
    FROM orders 
)
SELECT
ca.customer_id,
ca.total_spent,
ca.order_count,
ca.avg_order_amount,
ro.order_date as most_recent_order_date
FROM cust_agg ca 
LEFT JOIN rn_order ro on ca.customer_id = ro.customer_id
AND ro.rn_date = 1;
