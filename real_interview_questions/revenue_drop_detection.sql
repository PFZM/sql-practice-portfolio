/*
------------------------------------------------------------
 Real Interview SQL Question — Revenue Drop Detection
------------------------------------------------------------

Dataset:
--------
daily_revenue(
  revenue_date DATE,
  total_revenue DECIMAL
)

Definition:
-----------
A "revenue drop" occurs when:
- Today's total_revenue is at least 30% LOWER than yesterday's revenue

Task:
-----
Return all dates where a revenue drop occurred.

Return:
  revenue_date,
  total_revenue,
  previous_day_revenue,
  drop_percentage

Notes:
------
drop_percentage should be calculated as:
  (previous_day_revenue - total_revenue) / previous_day_revenue

Requirements:
  - Use LAG()
  - Order by revenue_date
  - Do NOT use GROUP BY
  - Only return rows where a drop occurred

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH prev_day_rev AS 
(
    SELECT
    revenue_date,
    total_revenue,
    LAG(total_revenue)OVER(ORDER BY revenue_date) as previous_day_revenue
    FROM daily_revenue
), pecentage_drop AS 
(
    SELECT
    revenue_date,
    total_revenue,
    previous_day_revenue,
    (previous_day_revenue - total_revenue) / previous_day_revenue as drop_percentage
    FROM prev_day_rev
)
SELECT
revenue_date,
total_revenue,
previous_day_revenue,
drop_percentage
FROM pecentage_drop
WHERE drop_percentage <= 0.30
ORDER BY revenue_date
;