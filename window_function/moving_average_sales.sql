/*
------------------------------------------------------------
 SQL Exercise — 3-Day Moving Average of Sales
------------------------------------------------------------

Dataset:
--------
daily_sales(
  sale_date DATE,
  total_sales DECIMAL
)

Task:
-----
For each day, calculate the 3-day moving average of total_sales
(including the current day and the two previous days).

Requirements:
  - Use AVG() OVER
  - Order by sale_date
  - Use ROWS BETWEEN
  - No GROUP BY

Return:
  sale_date,
  total_sales,
  moving_avg_3_days

------------------------------------------------------------
SQL solution: 
------------------------------------------------------------
*/

SELECT
sale_date,
total_sales,
AVG(total_sales)OVER(ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS moving_avg_3_days
FROM daily_sales
;