/* 
------------------------------------------------------------
 SQL Exercise — Top 5 Customers by Total Spent
------------------------------------------------------------

Dataset:
--------
orders(order_id, customer_id, order_amount)

Task:
-----
Find the TOP 5 customers by total order_amount.

Requirements:
  - Use SUM(order_amount)
  - Use RANK() or DENSE_RANK()
  - Use a CTE
  - Return: customer_id, total_spent, rank

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH customer_spent AS 
(
    SELECT
    customer_id,
    SUM(order_amount) as total_spent
    FROM orders
    GROUP BY customer_id  
), rn_customers AS 
(
    SELECT
    customer_id,
    total_spent,
    RANK()OVER(ORDER BY total_spent DESC) as rn_cust
    FROM customer_spent
)
SELECT 
customer_id,
total_spent,
rn_cust as rank
FROM rn_customers
WHERE rn_cust <=5 
ORDER by rn_cust;