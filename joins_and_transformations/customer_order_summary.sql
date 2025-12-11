/* 
------------------------------------------------------------
 SQL Exercise — Customer Order Summary (Join + Transform)
------------------------------------------------------------

Dataset:
--------
orders(order_id, customer_id, order_date, order_amount, product_id)
customers(customer_id, customer_name, region)
products(product_id, category)

Task:
-----
Return a dataset containing:
  - customer_id
  - customer_name
  - region
  - total number of orders
  - total amount spent
  - distinct number of product categories purchased

Requirements:
  - Must join all 3 tables
  - Use GROUP BY
  - Use COUNT(DISTINCT ...)
  - Return one row per customer

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH cust_orders AS 
(
    SELECT
    customer_id,
    COUNT(order_id) as total_number_of_orders,
    SUM(order_amount) as total_amount_spent,
    COUNT(DISTINCT p.category) as number_of_product_categories
    FROM orders o
    LEFT JOIN products p ON o.product_id = p.product_id 
    GROUP BY Customer_id  
)
SELECT
c.customer_id,
c.customer_name,
c.region,
co.total_number_of_orders,
co.total_amount_spent,
co.number_of_product_categories
FROM customers c
LEFT JOIN cust_orders co on c.customer_id = co.customer_id
;

