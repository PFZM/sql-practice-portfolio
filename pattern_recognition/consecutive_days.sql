/*
------------------------------------------------------------
 SQL Exercise — Consecutive Days Using ROW_NUMBER Difference
------------------------------------------------------------

Dataset:
--------
user_logins(
  user_id,
  login_date DATE
)

Example:
--------
user_id | login_date
--------------------
1       | 2024-01-01
1       | 2024-01-02
1       | 2024-01-03
1       | 2024-01-05
1       | 2024-01-06

Task:
-----
Group consecutive login dates per user.

Expected logic:
---------------
2024-01-01 → 2024-01-03 (one streak)
2024-01-05 → 2024-01-06 (another streak)

Requirements:
  - Use ROW_NUMBER()
  - Use date arithmetic
  - Use the ROW_NUMBER difference trick
  - Return:
      user_id,
      start_date,
      end_date

------------------------------------------------------------
 SQL solution:
------------------------------------------------------------
*/

WITH num_logings AS 
(
    SELECT
    user_id,
    login_date,
    ROW_NUMBER()OVER(ORDER BY login_date) AS rn_login 
    FROM user_logins
), group_logins AS 
(
    SELECT
    user_id,
    login_date,
    DATEADD(day, -rn_login, login_date) as grp_logins -- SQL SERVER SINTAX
    FROM num_logings
)
SELECT
user_id,
MIN(login_date) AS start_date,
MAX(login_date) AS end_date
FROM group_logins
GROUP BY user_id, grp_logins
ORDER BY user_id, start_date;

