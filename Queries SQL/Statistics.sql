USE marketing_analytic_project;

SELECT
  Brand,
  COUNT(*)                     AS total_campaigns,
  ROUND(AVG(Duration), 1)      AS avg_duration,
  ROUND(AVG(Impressions), 0)   AS avg_impressions,
  ROUND(AVG(Clicks), 0)        AS avg_clicks,
  ROUND(AVG(Conversions), 0)   AS avg_conversions,
  ROUND(SUM(Revenue), 0)       AS total_revenue,
  ROUND(AVG(ROI), 2)           AS avg_roi
FROM campaigns_project
GROUP BY Brand;