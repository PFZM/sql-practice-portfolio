/*
------------------------------------------------------------
 Recursive CTE Exercise — Employee Reporting Tree
------------------------------------------------------------

Dataset:
--------
employees(
  employee_id,
  employee_name,
  manager_id
)

Task:
-----
Starting from a given manager_id = 2,
return all employees that report directly or indirectly
to that manager.

Return:
  employee_id,
  employee_name,
  manager_id,
  level

------------------------------------------------------------
 SQL Solution:
------------------------------------------------------------
*/

WITH RECURSIVE empl_reporting AS 
(
    SELECT
    employee_id,
    employee_name,
    manager_id,
    1 as level
    FROM employees
    WHERE employee_id = 2

    UNION ALL 
    
    SELECT
    e.employee_id,
    e.employee_name,
    e.manager_id,
    er.level + 1 as level
    FROM employees e 
    JOIN empl_reporting er ON e.manager_id = er.employee_id
)
SELECT *
FROM empl_reporting
ORDER BY level, employee_id
;
