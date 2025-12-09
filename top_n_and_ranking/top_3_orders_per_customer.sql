/* 
------------------------------------------------------------
 SQL Exercise — Top 3 Orders Per Customer
------------------------------------------------------------

Dataset:
--------
Table: orders

    order_id
    customer_id
    order_amount

Task:
-----
Return the TOP 3 highest order_amount values per customer.

Requirements:
  - Use ROW_NUMBER(), RANK(), or DENSE_RANK
  - Use a CTE
  - Do NOT use GROUP BY
  - Return: customer_id, order_id, order_amount
  - Only include rows ranked 1, 2, or 3

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

with customer_orders AS 
(
    SELECT
    customer_id,
    order_id,
    order_amount,
    RANK()OVER(PARTITION BY customer_id ORDER BY order_amount DESC) as rn_orders
    FROM orders 
)
SELECT
customer_id,
order_id,
order_amount
FROM customer_orders
WHERE rn_orders <= 3;

