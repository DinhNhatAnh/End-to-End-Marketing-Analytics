USE marketing_analytic_project;

-- 1. Check UNIQUE
SELECT DISTINCT Campaign_Type FROM campaigns_project;
SELECT DISTINCT Language FROM campaigns_project;
SELECT DISTINCT Customer_Segment FROM campaigns_project;

-- 2. Check NULL
SELECT
  SUM(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END)
    AS null_impressions,
  SUM(CASE WHEN Clicks IS NULL THEN 1 ELSE 0 END)
    AS null_clicks,
  SUM(CASE WHEN Leads IS NULL THEN 1 ELSE 0 END)
    AS null_leads,
  SUM(CASE WHEN Conversions IS NULL THEN 1 ELSE 0 END)
    AS null_conversions,
  SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END)
    AS null_revenue,
  SUM(CASE WHEN Acquisition_Cost IS NULL THEN 1 ELSE 0 END)
    AS null_acq_cost
FROM campaigns_project;

-- 3. Check DUPLICATE
SELECT Campaign_ID, COUNT(*) AS dup_count
FROM campaigns_project
GROUP BY Campaign_ID
HAVING COUNT(*) > 1
ORDER BY dup_count DESC
LIMIT 10;

-- 4. Check logic funnel (Impression > Click > Lead > Conversion)
SELECT
  SUM(CASE WHEN Clicks > Impressions THEN 1 ELSE 0 END)
    AS clicks_gt_impressions,
  SUM(CASE WHEN Leads > Clicks THEN 1 ELSE 0 END)
    AS leads_gt_clicks,
  SUM(CASE WHEN Conversions > Leads THEN 1 ELSE 0 END)
    AS conversions_gt_leads
FROM campaigns_project
WHERE Impressions IS NOT NULL
  AND Clicks IS NOT NULL;
  
-- 5. Check Negative data
SELECT
  SUM(CASE WHEN Impressions < 0 THEN 1 ELSE 0 END)
    AS neg_impressions,
  SUM(CASE WHEN Revenue < 0 THEN 1 ELSE 0 END)
    AS neg_revenue
FROM campaigns_project;

-- 6. Check invalid data
SELECT Campaign_Date, COUNT(*) AS cnt
FROM campaigns_project
WHERE Campaign_Date IS NOT NULL
  AND STR_TO_DATE(Campaign_Date, '%d-%m-%Y') IS NULL
GROUP BY Campaign_Date;