/*
------------------------------------------------------------
 SQL Exercise — Session Gap Detection
------------------------------------------------------------

Dataset:
--------
user_sessions(
  user_id,
  session_start,
  session_end
)

Task:
-----
For each session, calculate:
  - next_session_start (per user)
  - gap_minutes_between_sessions

Requirements:
  - Use LEAD(session_start)
  - Partition by user_id
  - Order by session_start
  - Calculate gap in minutes
  - NULL gap for last session

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

WITH next_sessions AS
(
    SELECT
    user_id,
    session_start,
    session_end,
    LEAD(session_start)OVER(PARTITION BY user_id ORDER BY session_start) as next_session_start
    FROM user_sessions
)
SELECT 
user_id,
session_start,
session_end,
next_session_start,
DATEDIFF(minute, next_session_start - session_start) AS gap_minutes_between_sessions
FROM next_sessions
;