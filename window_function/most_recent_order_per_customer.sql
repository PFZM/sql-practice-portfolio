/* 
------------------------------------------------------------
 SQL Exercise #1 — Most Recent Order Per Customer
------------------------------------------------------------

Dataset:
--------
You have a table named "orders" with the following columns:

    order_id        INT
    customer_id     INT
    order_date      DATE
    order_amount    DECIMAL

Example rows:
--------------
order_id | customer_id | order_date  | order_amount
---------------------------------------------------
101      | 1           | 2023-02-10  | 80
102      | 1           | 2023-05-22  | 120
103      | 1           | 2023-12-01  | 95
201      | 2           | 2023-01-02  | 50
202      | 2           | 2023-01-15  | 60
203      | 2           | 2023-03-11  | 40

------------------------------------------------------------
 Task:
------------------------------------------------------------
Write a SQL query to return each customer's MOST RECENT order.

Requirements:
  - You MUST use ROW_NUMBER().
  - Use a CTE.
  - Do NOT use GROUP BY.
  - Return one row per customer.
  - Include: order_id, customer_id, order_date, order_amount.

Expected output example:
------------------------
order_id | customer_id | order_date  | order_amount
---------------------------------------------------
103      | 1           | 2023-12-01  | 95
203      | 2           | 2023-03-11  | 40

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

WITH rn_orders AS 
(
    SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER()OVER(PARTITION BY customer_id ORDER BY order_date DESC) as rn_date,
    order_amount
    FROM orders 
)
SELECT
order_id,
customer_id,
order_date,
order_amount
FROM rn_orders
WHERE rn_date = 1

