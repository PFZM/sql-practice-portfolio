/* 
------------------------------------------------------------
 SQL Exercise — Running Total of Sales Per Customer
------------------------------------------------------------

Dataset:
--------
Table: orders

    order_id        INT
    customer_id     INT
    order_date      DATE
    order_amount    DECIMAL

Task:
-----
For each customer, calculate a running total of order_amount ordered by order_date.

Requirements:
  - Use SUM() OVER(...)
  - Partition by customer_id
  - Order by order_date
  - Do NOT use GROUP BY
  - Return: customer_id, order_id, order_date, order_amount, running_total

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

SELECT
customer_id,
order_id,
order_date,
order_amount,
SUM(order_amount)OVER(partition by customer_id ORDER BY order_date) as running_total
FROM orders 
order by customer_id, order_date; 
