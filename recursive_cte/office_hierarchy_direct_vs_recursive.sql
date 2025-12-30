/*
------------------------------------------------------------
 Real Interview SQL — Office Hierarchy (Direct vs Recursive)
------------------------------------------------------------

Dataset:
--------
offices(
    office_id INT,
    name_office VARCHAR,
    parent_office_id INT NULL
)

Example data:
-------------
office_id | name_office | parent_office_id
-------------------------------------------
10        | New York    | NULL
20        | Detroit     | 10
30        | Michigan    | 10
40        | Melbourne  | NULL
50        | Sydney     | 40
60        | Canberra   | 40
70        | Brisbane   | 50
80        | Florida    | 20
90        | London     | NULL
100       | Cambridge  | 90

Hierarchy example:
------------------
New York (10)
├── Detroit (20)
│   └── Florida (80)
└── Michigan (30)

Melbourne (40)
├── Sydney (50)
│   └── Brisbane (70)
└── Canberra (60)

London (90)
└── Cambridge (100)

============================================================
 STEP 1 — Direct Children (Non-Recursive)
============================================================

Task:
-----
Write a SQL query to return, for each office:

- office_id
- name_office
- number of offices that report DIRECTLY to it


------------------------------------------------------------
 SQL solution for STEP 1 below this line:
------------------------------------------------------------
*/

SELECT
o.office_id,
o.name_office,
COUNT(o2.office_id) AS no_of_reports_directly
FROM offices o
LEFT JOIN offices o2 ON o.office_id = o2.parent_office_id 
GROUP BY o.office_id, o.name_office
ORDER BY o.office_id
;


/*
============================================================
 STEP 2 — All Descendants (Recursive CTE)
============================================================

Task:
-----
Write a SQL query to return, for each office:

- office_id
- name_office
- total number of offices that report to it
  directly OR indirectly (all levels)

Requirements:
-------------
- MUST use a recursive CTE
- Handle multiple hierarchy levels
- One row per office
- Offices with no descendants should return 0

------------------------------------------------------------
 SQL solution for STEP 2 below this line:
------------------------------------------------------------
*/

WITH RECURSIVE cte_offices AS 
(
    SELECT
    parent_office_id as root_office_id,
    office_id as descendant_office_id
    FROM offices
    WHERE parent_office_id IS NOT NULL

    UNION ALL 

    SELECT
    cte.root_office_id,
    o.office_id as descendant_office_id
    FROM cte_offices cte  
    JOIN offices o ON cte.descendant_office_id = o.parent_office_id 
)
SELECT
o.office_id,
o.name_office,
count(cte.descendant_office_id) as total_number_offices_report
FROM offices o
LEFT JOIN cte_offices cte on cte.root_office_id = o.office_id 
GROUP BY o.office_id, o.name_office
ORDER BY o.office_id
;