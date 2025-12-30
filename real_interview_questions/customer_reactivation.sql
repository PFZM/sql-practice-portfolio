/*
------------------------------------------------------------
 Real Interview SQL Question — Customer Reactivation
------------------------------------------------------------

Dataset:
--------
orders(
  order_id,
  customer_id,
  order_date DATE,
  order_amount DECIMAL
)

Definition:
-----------
A customer is considered "reactivated" if:
- They place an order
- AND their previous order was more than 90 days earlier

Task:
-----
Return all reactivated orders.

Return:
  order_id,
  customer_id,
  order_date,
  previous_order_date,
  days_since_last_order

Requirements:
  - Use LAG()
  - Partition by customer_id
  - Order by order_date
  - Do NOT use GROUP BY
  - Only return rows that qualify as reactivated

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

WITH prev_orders AS 
(
    SELECT
    order_id,
    customer_id,
    order_date,
    LAG(order_date)OVER(PARTITION BY customer_id ORDER BY order_date) as previous_order_date
    FROM orders 
) 
SELECT
order_id,
customer_id,
order_date,
previous_order_date,
DATEDIFF(day, previous_order_date, order_date) as days_since_last_order
FROM prev_orders
WHERE DATEDIFF(day, previous_order_date, order_date) > 90 
;