/*
------------------------------------------------------------
 SQL Exercise — Sales Trend Flag
------------------------------------------------------------

Dataset:
--------
daily_sales(
  sale_date,
  total_sales
)

Task:
-----
For each day, classify the trend as:
  - 'UP'     → sales increased vs previous day
  - 'DOWN'   → sales decreased
  - 'SAME'   → no change
  - 'FIRST'  → no previous day

Requirements:
  - Use LAG(total_sales)
  - Use CASE WHEN
  - Order by sale_date

------------------------------------------------------------
SQL solution below this line:
------------------------------------------------------------
*/

WITH previus_day_sale AS 
(
    SELECT
    sale_date,
    total_sales,
    LAG(total_sales, 1) OVER (ORDER BY sale_date) as total_sales_prev
    FROM daily_sales
)
SELECT
sale_date,
total_sales,
total_sales_prev as total_sale_previous_day,
CASE WHEN total_sale_prev IS NULL THEN 'FIRST'
     WHEN total_sale_prev < total_sales THEN 'UP'
     WHEN total_sale_prev > total_sales THEN 'DOWN'
     WHEN total_sale_prev = total_sales THEN 'SAME'
     END AS sales_trend
FROM previus_day_sale