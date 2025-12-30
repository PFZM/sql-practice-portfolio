/*
------------------------------------------------------------
 SQL Exercise — Consecutive Login Streaks
------------------------------------------------------------

Dataset:
--------
logins(
  user_id,
  login_date DATE
)

Task:
-----
For each user, return all login streaks
where the user logged in on consecutive days.

Return:
  user_id,
  streak_start_date,
  streak_end_date,
  streak_length

Requirements:
  - Use ROW_NUMBER()
  - Use the ROW_NUMBER difference trick
  - Use GROUP BY
  - streak_length >= 2 only

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

with stk_logings AS
(
    SELECT
    user_id,
    login_date,
    ROW_NUMBER()OVER(PARTITION BY user_id ORDER BY login_date) as rn_login
    FROM logins 
), group_logins AS 
(
    SELECT
    user_id,
    login_date,
    DATEADD(day, -rn_login, login_date) as grp_logins
    FROM stk_logings
), streak_logins AS 
(
    SELECT
    user_id,
    MIN(login_date) as streak_start_date,
    MAX(login_date) as streak_end_date,
    COUNT(*) as streak_length
    FROM group_logins
    Group by user_id, grp_logins
)
SELECT
user_id,
streak_start_date,
streak_end_date
streak_length
FROM streak_logins
WHERE streak_length >= 2
;