/*
------------------------------------------------------------
 SQL Exercise — Top 2 Products per Category
------------------------------------------------------------

Dataset:
--------
products(
  product_id,
  product_name,
  category,
  price
)

Task:
-----
For each category, return the TOP 2 most expensive products.

Requirements:
  - Use ROW_NUMBER() or RANK()
  - Partition by category
  - Order by price DESC
  - Return:
      category,
      product_id,
      product_name,
      price
  - Only include the top 2 per category

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH products_det AS
(
    SELECT
    product_id,
    product_name,
    category,
    price,
    RANK()OVER(PARTITION BY category ORDER BY price desc) as rn_cat 
    FROM products 
)
SELECT
category,
product_id,
product_name,
price
FROM products_det
WHERE rn_cat <= 2;