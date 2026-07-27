USE marketing_analytic_project;
SET SQL_SAFE_UPDATES = 0;

-- 1: Using TRIM() to clean whitespace
-- ============================================================
UPDATE campaigns_project SET Campaign_Type   = TRIM(Campaign_Type);
UPDATE campaigns_project SET Language         = TRIM(Language);
UPDATE campaigns_project SET Customer_Segment = TRIM(Customer_Segment);
UPDATE campaigns_project SET Target_Audience  = TRIM(Target_Audience);

-- Verify
SELECT DISTINCT Campaign_Type FROM campaigns_project;

-- 2: Delete NULL data
DELETE FROM campaigns_project
WHERE Impressions IS NULL
   OR Clicks IS NULL
   OR Leads IS NULL
   OR Conversions IS NULL
   OR Revenue IS NULL
   OR Acquisition_Cost IS NULL;

-- 3: Delete DUPLICATE data
CREATE TABLE campaigns_tmp LIKE campaigns_project;
ALTER TABLE campaigns_tmp ADD PRIMARY KEY (Campaign_ID);
INSERT IGNORE INTO campaigns_tmp
SELECT * FROM campaigns_project;
DROP TABLE campaigns_project;
RENAME TABLE campaigns_tmp TO campaigns_project;

-- Verify:
SELECT Campaign_ID, COUNT(*) AS dup_count
FROM campaigns_project
GROUP BY Campaign_ID
HAVING COUNT(*) > 1;

-- 4: Delete the rows that violates the logic funnel.
DELETE FROM campaigns_project
WHERE Clicks > Impressions
   OR Leads > Clicks
   OR Conversions > Leads;
   
-- 5: Delete negative data
DELETE FROM campaigns_project
WHERE Impressions < 0
   OR Revenue < 0;

-- 6: Xử lý ngày không hợp lệ
DELETE FROM campaigns_project
WHERE Campaign_Date < '2024-01-01'
   OR Campaign_Date > '2025-12-31';

-- 7: Verify all

-- Total rows
SELECT COUNT(*) AS total_rows FROM campaigns_project;

-- NULL check
SELECT
  SUM(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END)
    AS null_imp,
  SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END)
    AS null_rev
FROM campaigns_project;

-- Duplicate check
SELECT COUNT(*) FROM (
  SELECT Campaign_ID FROM campaigns_project
  GROUP BY Campaign_ID HAVING COUNT(*) > 1) t;

-- Funnel logic check
SELECT SUM(CASE WHEN Clicks > Impressions
  THEN 1 ELSE 0 END) AS errors FROM campaigns_project;

-- Negative check
SELECT SUM(CASE WHEN Impressions < 0 OR Revenue < 0
  THEN 1 ELSE 0 END) AS negatives FROM campaigns_project;