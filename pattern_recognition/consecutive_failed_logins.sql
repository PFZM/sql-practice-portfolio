/*
------------------------------------------------------------
 SQL Exercise — Consecutive Failed Logins
------------------------------------------------------------

Dataset:
--------
logins(
  user_id,
  login_time,
  status  -- 'SUCCESS' or 'FAIL'
)

Task:
-----
Return users who had 3 FAILED logins in a row.

Requirements:
  - Use LAG()
  - Compare current row with previous rows
  - Order by login_time
  - Return DISTINCT user_id

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH fail_logings AS 
(
    SELECT
    user_id,
    status,
    LAG(status, 1) OVER(PARTITION BY user_id, ORDER BY login_time) AS prev_1,
    LAG(status, 2) OVER(PARTITION BY user_id, ORDER BY login_time) AS prev_2
    FROM logins 
)
SELECT DISTINCT
user_id
FROM fail_logings
WHERE status = 'FAIL'
AND prev_1 = 'FAIL'
AND prev_2 = 'FAIL';
