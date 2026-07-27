USE marketing_analytic_project;

SET GLOBAL local_infile = 1;
SET SQL_SAFE_UPDATES = 0;

-- Import Nykaa
LOAD DATA LOCAL INFILE 'E:/My Folder/Data/nykaa_campaign_data.csv'
INTO TABLE campaigns_project
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Campaign_ID, Campaign_Type, Target_Audience, Duration,
 Channel_Used, Impressions, Clicks, Leads, Conversions,
 Revenue, Acquisition_Cost, ROI, Language,
 Engagement_Score, Customer_Segment, @date_raw)
SET Campaign_Date = STR_TO_DATE(@date_raw, '%d-%m-%Y');

UPDATE campaigns_project SET Brand = 'Nykaa'
WHERE Campaign_ID LIKE 'NY-%' AND Brand IS NULL;

-- Import Purplle
LOAD DATA LOCAL INFILE 'E:/My Folder/Data/purplle_campaign_data.csv'
INTO TABLE campaigns_project
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Campaign_ID, Campaign_Type, Target_Audience, Duration,
 Channel_Used, Impressions, Clicks, Leads, Conversions,
 Revenue, Acquisition_Cost, ROI, Language,
 Engagement_Score, Customer_Segment, @date_raw)
SET Campaign_Date = STR_TO_DATE(@date_raw, '%d-%m-%Y');

UPDATE campaigns_project SET Brand = 'Purplle'
WHERE Campaign_ID LIKE 'PU-%' AND Brand IS NULL;

-- Import Tira Beauty
LOAD DATA LOCAL INFILE 'E:/My Folder/Data/tira_campaign_data.csv'
INTO TABLE campaigns_project
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Campaign_ID, Campaign_Type, Target_Audience, Duration,
 Channel_Used, Impressions, Clicks, Leads, Conversions,
 Revenue, Acquisition_Cost, ROI, Language,
 Engagement_Score, Customer_Segment, @date_raw)
SET Campaign_Date = STR_TO_DATE(@date_raw, '%d-%m-%Y');

UPDATE campaigns_project SET Brand = 'Tira Beauty'
WHERE Campaign_ID LIKE 'TI-%' AND Brand IS NULL;

-- Total Rows
SELECT COUNT(*) AS total_rows FROM campaigns_project;

-- Total Rows by Brand
SELECT Brand, COUNT(*) AS rows_count
FROM campaigns_project GROUP BY Brand;