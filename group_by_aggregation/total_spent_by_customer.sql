/* 
------------------------------------------------------------
 SQL Exercise — Total Spent Per Customer
------------------------------------------------------------

Dataset:
--------
Table: orders

    customer_id
    order_amount

Task:
-----
Calculate the total amount spent by each customer.

Requirements:
  - Use SUM()
  - Must use GROUP BY
  - Return: customer_id, total_spent
  - Sort by total_spent DESC

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

SELECT
customer_id,
SUM(order_amount) as total_spent
FROM orders
Group by customer_id 
Order by total_spent DESC;

