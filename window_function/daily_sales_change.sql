/*
------------------------------------------------------------
 SQL Exercise — Daily Sales Change Using LAG
------------------------------------------------------------

Dataset:
--------
daily_sales(
  sale_date DATE,
  total_sales DECIMAL
)

Example data:
-------------
sale_date   | total_sales
-------------------------
2024-01-01  | 100
2024-01-02  | 120
2024-01-03  | 90
2024-01-04  | 150

Task:
-----
For each day, show:
  - sale_date
  - total_sales
  - previous_day_sales
  - sales_difference (current - previous)

Requirements:
  - Use LAG(total_sales)
  - Order by sale_date
  - Do NOT use GROUP BY

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

SELECT
sale_date,
total_sales,
LAG(total_sales)OVER(ORDER BY sale_date) as previous_day_sales,
(total_sales - LAG(total_sales)OVER(ORDER BY sale_date)) as sales_difference
FROM daily_sales
;