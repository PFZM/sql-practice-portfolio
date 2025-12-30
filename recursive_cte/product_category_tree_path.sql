/*
------------------------------------------------------------
 Real Interview Recursive SQL — Product Category Tree + Path
 (Consulting-style: KPMG / Deloitte / EY)
------------------------------------------------------------

Dataset:
--------
categories(
  category_id INT,
  category_name VARCHAR,
  parent_category_id INT NULL
)

Example hierarchy:
------------------
Electronics (1)
├── Computers (2)
│   ├── Laptops (3)
│   └── Desktops (4)
└── Phones (5)
    └── Smartphones (6)

Task:
-----
Return the full category hierarchy with:
  - category_id
  - category_name
  - parent_category_id
  - level (root = 1)
  - path (root > child > grandchild)
  - root_category_name (the very top ancestor name)

Requirements:
  - MUST use a recursive CTE
  - MUST build a path column
  - MUST include ALL categories (all roots and their descendants)
  - Order output by: root_category_name, path

Notes:
------
- Root categories are those where parent_category_id IS NULL.
- Path must be built using ' > ' as the delimiter.

------------------------------------------------------------
SQL solution:
------------------------------------------------------------
*/

-- SQL SERVER
WITH cte_categories AS 
(
    SELECT
    category_id,
    category_name,
    parent_category_id,
    1 as level,
    CAST(category_name AS VARCHAR(500)) as path,
    category_name as root_category_name
    FROM categories
    WHERE parent_category_id is NULL

    UNION ALL 

    SELECT
    ca.category_id,
    ca.category_name,
    ca.parent_category_id,
    cte.level + 1 as level,
    CONCAT(cte.path, ' > ', ca.category_name) as path,
    cte.root_category_name
    FROM categories ca 
    JOIN cte_categories cte ON ca.parent_category_id = cte.category_id
)
SELECT * 
FROM cte_categories 
ORDER BY root_category_name, path
;
