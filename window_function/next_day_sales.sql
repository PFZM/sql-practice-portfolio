/*
------------------------------------------------------------
 SQL Exercise — Next Day Sales Using LEAD
------------------------------------------------------------

Dataset:
--------
daily_sales(
  sale_date DATE,
  total_sales DECIMAL
)

Task:
-----
For each day, return:
  - sale_date
  - total_sales
  - next_day_sales
  - sales_change_to_next_day (next - current)

Requirements:
  - Use LEAD(total_sales)
  - Order by sale_date
  - Do NOT use GROUP BY

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

SELECT
sale_date,
total_sales,
LEAD(total_sales, 1) OVER(ORDER BY sale_date) as next_day_sales,
(LEAD(total_sales, 1) OVER(ORDER BY sale_date) - total_sales) as sales_change_to_next_day
FROM daily_sales
;