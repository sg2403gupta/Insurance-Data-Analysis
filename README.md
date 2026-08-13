Insurance Analytics — End-to-End Data Analysis & Power BI Dashboard

An end-to-end Insurance Analytics project covering data preparation, SQL-based business analysis, and interactive Power BI reporting.

The project demonstrates a practical Data Analyst / Business Intelligence workflow:

Raw Data → Excel Cleaning → SQL Server → Business Analysis → Power BI → Interactive Dashboard → Customer Drill-Through

📌 Project Overview

This project analyzes insurance data to understand:

Premium and claim performance
Claim approval and denial behavior
Customer demographics and segmentation
Insurance-type claim exposure
Risk-segment performance
Incident severity and claim behavior
Geographic claim and premium concentration
Customer premium and claim contribution
Vendor claim-handling performance
Claim reporting delays
High-risk claim indicators
Monthly claim trends
Customer-level insurance and risk profiles

The project combines Excel, SQL Server, Power Query, Power BI, and DAX into one complete analytics workflow.

🎯 Business Objectives

The analysis is designed to answer practical insurance-business questions such as:

How much premium has been collected?
What is the total claim exposure?
What percentage of claims are approved or denied?
Which insurance types generate the highest claim exposure?
Which risk segments contribute the most claims?
Which states and cities have the highest claim exposure?
How does incident severity affect claim amounts?
Which customer segments contribute the most premium and claims?
Which vendors handle the highest claim volumes and values?
Are claims being reported unusually late?
Which claims may require additional risk review?
How do claim amounts change month over month?
Which customers have unusually high claim exposure?
How can a manager drill from portfolio-level metrics to an individual customer?
🗂️ Project Structure
Insurance_Data/
│
├── Cleaned_Data/
│   ├── employee_data_cleaned.xlsx
│   ├── insurance_data_cleaned.xlsx
│   └── vendor_data_cleaned.xlsx
│
├── Dashboard/
│   └── Power BI dashboard/report files
│
├── Dataset/
│   ├── employee_data.xlsx
│   ├── insurance_data.xlsx
│   └── vendor_data.xlsx
│
├── SQL/
│   ├── Creating-Database-and-View-All-Data.sql
│   ├── Business KPIs.sql
│   ├── Insurance Claims & Risk Analytics.sql
│   ├── Customer & Vendor Analytics.sql
│   └── Advanced_SQL_Anlytics_.sql
│
└── README.md
🔄 Analytics Workflow
Raw Dataset
     ↓
Excel Data Cleaning
     ↓
Data Validation & Quality Checks
     ↓
SQL Server Import
     ↓
Business & Advanced SQL Analysis
     ↓
Power BI Data Modeling
     ↓
DAX Measures & KPIs
     ↓
Interactive Dashboard
     ↓
Customer Drill-Through & Business Insights
🧹 1. Data Preparation — Excel

The raw datasets are maintained separately from the cleaned datasets.

Raw datasets
insurance_data.xlsx
employee_data.xlsx
vendor_data.xlsx
Cleaned datasets
insurance_data_cleaned.xlsx
employee_data_cleaned.xlsx
vendor_data_cleaned.xlsx

The cleaned files are used as the analysis-ready layer before loading the data into SQL Server and Power BI.

The project separates raw data from cleaned data so that the original source remains preserved and the transformation stage is reproducible.

🗄️ 2. SQL Server Analysis

SQL Server is used for data validation, business analysis, customer/vendor analysis, claims analysis, risk analysis, and advanced analytical queries.

The SQL work is divided into five scripts.

Creating-Database-and-View-All-Data.sql

This script focuses on initial data validation and quality checks, including:

Record counts
Duplicate transaction IDs
Duplicate policy numbers
Missing-value checks
Claim statistics
Premium statistics
Claim date range
Available insurance types
Negative premium/claim checks
Invalid reporting dates

Example validation questions:

-- Are there duplicate Transaction IDs?


-- Are there duplicate Policy Numbers?


-- Which columns contain NULL values?


-- Are there negative premium or claim amounts?


-- Are claims reported before the loss occurred?
📊 3. Business KPIs

Business KPIs.sql calculates core insurance KPIs, including:

Total premium collected
Total claim amount
Unique customers
Total policies
Average premium
Average claim
Approved vs. denied claims
Claim approval percentage
Claim denial percentage
Maximum claim
Minimum claim
Maximum premium
Minimum premium
Average customer age
Loss ratio

Example:

SELECT
    ROUND(
        SUM(CLAIM_AMOUNT) * 100.0 /
        NULLIF(SUM(PREMIUM_AMOUNT), 0),
        2
    ) AS LossRatio
FROM Insurance;

These measures form the analytical foundation for the Power BI executive and claims dashboards.

⚠️ 4. Insurance Claims & Risk Analytics

Insurance Claims & Risk Analytics.sql focuses on insurance-specific claims and risk questions.

Insurance Analysis
Claim volume by insurance type
Claim amount by insurance type
Claim frequency by insurance type
State-level claim exposure
Average claim by state
Risk-segment claim analysis
Loss ratio by risk segment
Approval and denial rates by insurance type
Approval rate by state
Incident Analysis
Claim exposure by incident severity
Approval behavior by incident severity
Injury vs. claim amount
Police-report availability vs. approval rate
Age-group claim behavior
Employment-status claim behavior
Incident time-of-day analysis
Claim reporting delay

The incident-hour analysis groups incidents into:

Night
Morning
Afternoon
Evening
👥 5. Customer & Vendor Analytics

Customer & Vendor Analytics.sql contains customer, vendor, and multi-table analysis.

Customer Analytics

The analysis covers:

Total customers
Top customers by claim amount
Top customers by premium
Customers with multiple claims
Customers with high premiums and high claims
Claim behavior by age
Claim exposure by education level
Claim exposure by city
Customer tenure groups
Loss ratio by social class

Customer tenure is segmented into:

New Customer        < 24 months
Established         24–59 months
Long-Term Customer  60+ months
Vendor Analytics

Vendor performance is evaluated using:

Claims handled by vendor
Total claim amount handled
Average claim amount
Claim approval rate
Incident severity handled
Vendors with high average claim values
Vendors handling high-risk customers
Vendors with high claim volume and high average claim value
Multi-table Analysis

The project also analyzes relationships between:

Social class × insurance type
Risk segment × customers
Vendors × high-risk customers
Vendors × claim volume × claim value

This demonstrates practical use of JOIN, GROUP BY, HAVING, aggregation, and multi-dimensional analysis.

🧠 6. Advanced SQL Analytics

Advanced_SQL_Anlytics_.sql demonstrates advanced SQL techniques used for deeper analytical questions.

Techniques Used
Common Table Expressions (CTEs)
Window functions
RANK()
DENSE_RANK()
ROW_NUMBER()
LAG()
Subqueries
Conditional logic using CASE
Aggregations
Percentage calculations
Running totals
Month-over-month comparison
Customer-level loss-ratio analysis
Examples
Insurance-Type Ranking

Insurance types are ranked by total claim amount.

Top Customers Within Each Insurance Type

ROW_NUMBER() with PARTITION BY is used to identify the top customers for each insurance type.

Monthly Running Claims

A cumulative claim amount is calculated using a window function.

Month-over-Month Claim Comparison

LAG() is used to compare current-month claim exposure with the previous month.

High-Loss Customers

Customers whose total claims exceed their total premiums are identified.

High-Risk Claim Identification

Potentially high-risk claims are flagged using a combination of:

Claim amount
Injury indicator
Police-report availability
Incident severity
Late Claim Reporting

Claims reported more than seven days after the loss date are identified and the overall late-reporting percentage is calculated.

📈 7. Power BI Dashboard

The Power BI report contains six analytical pages, progressing from executive-level monitoring to customer-level investigation.

The dashboard uses slicers, KPI cards, charts, tables, and drill-through navigation.

Page 1 — Executive Overview

Provides a high-level view of insurance portfolio performance.

KPIs
Total Premium Amount
Total Claim Amount
Total Customers
Total Transactions
Approved Claims
Claim Approval Rate
Visuals
Premium Trend
Premium by Insurance Type
Claims by Insurance Type
Claim Approval Status
Premium by Risk Segment
Top 5 Cities by Premium
Filters
Year
Insurance Type
Claim Status
City

For the displayed 2021 view, the dashboard shows approximately:

$413.58K Total Premium
$78.18M Total Claim Amount
5K Customers
5K Transactions
4K Approved Claims
95.16% Claim Approval Rate
Page 2 — Customer Analysis

Focuses on customer demographics, segmentation, and behavior.

KPIs
Total Customers
Average Customer Age
Average Family Size
Average Tenure
Average Premium Amount
Visuals
Customers by Age Group
Customers by Employment
Customers by Social Class
Customer Education Profile
Customers by Family Size
Customer Risk Distribution
Claims by Risk Segment
Premium Contribution by Social Class
Top Customers by City

The displayed overall view contains approximately 10K customers, with:

Average age: 44
Average family size: 4
Average tenure: 63
Average premium: $88.51
Page 3 — Claims Analysis

Provides a detailed view of claim exposure and severity.

KPIs
Total Premium Amount
Total Claim Amount
Approved Claims
Claim Approval Rate
Average Claim Amount
Visuals
Claim Amount by Insurance Type
Premium Exposure by Insurance Type
Claim by Social Class
Claim Exposure by Incident Severity
Claim Severity Distribution
Claims by Risk Segmentation
Monthly Claim Exposure

The displayed overall view contains approximately:

$885.09K Total Premium
$165.64M Total Claim Amount
9K Approved Claims
94.97% Claim Approval Rate
$16.56K Average Claim Amount
Page 4 — Transaction & Premium Analysis

Provides customer ranking and transaction-level visibility.

KPIs
Total Transactions
Total Premium Amount
Total Claim Amount
Average Premium Amount
Average Claim Amount
Visuals
Top 10 Customers by Premium
Bottom 10 Customers by Premium
Premium by Incident Severity
Claims by Claim Amount Band
Customers by Claim Status
Transaction-level detail table

The transaction table includes fields such as:

Transaction ID
Customer ID
Transaction Date
Insurance Type
Premium Amount
Claim-related information
Page 5 — Risk Analysis

Focuses on risk exposure and geographic concentration.

KPIs
Total Customers
High Risk Customers
Total Claim Amount
Average Claim Amount
Visuals
Customer Risk Distribution
Claim Exposure by Risk Segment
Risk × Claim Severity
Top 10 States by Claim
Top 10 States by Premium
Claim by Incident Severity
Top 10 Incident Locations by Claim Amount
Premium Exposure by Insurance Type
Top 5 Customers by City

The displayed report shows approximately 1K high-risk customers and provides a comparison of claim exposure across Low, Medium, and High risk segments.

Page 6 — Customer Drill-Through

The final page provides a customer-level investigation view.

For a selected customer, the report displays:

Customer Profile
Customer ID
Age
Education
City
Employment Status
Marital Status
Family Size
Claim Status
Insurance Profile
Insurance Type
Policy Effective Date
Loss Date
Premium Amount
Claim Amount
Customer Risk Segment
Risk Segment
Claim Severity
Claim Status
Risk Profile
Incident Location
Incident Severity
Police Report Availability
Incident Time

The page also includes a Customer Premium vs Claim comparison.

This creates a drill-down path from portfolio-level analysis to an individual customer and incident profile.

📌 Key Analytical Areas
Dimension	Analysis
Financial	Premium, claims, averages, loss ratio
Claims	Approval, denial, severity, frequency
Risk	Risk segmentation and claim exposure
Customer	Age, education, social class, employment, tenure
Geographic	State, city, incident location
Insurance	Insurance-type performance
Vendor	Claim volume, value, approval rate
Time	Monthly trends and reporting delays
Operations	Transaction and claim-level analysis
Drill-through	Customer-specific investigation
🛠️ Technology Stack
Data Preparation
Microsoft Excel
Power Query
Database & SQL
Microsoft SQL Server
T-SQL
Business Intelligence
Microsoft Power BI
DAX
Power Query
Power BI Data Modeling
Analytical Techniques
Aggregation
Filtering
Grouping
Conditional logic
CTEs
Subqueries
Window functions
Ranking
Time-series analysis
Drill-through analysis
KPI development
📐 Core SQL Concepts Demonstrated
SELECT
WHERE
GROUP BY
HAVING
ORDER BY
CASE
JOIN
INNER JOIN
COUNT
COUNT DISTINCT
SUM
AVG
MIN
MAX
NULLIF
ROUND
DATEDIFF
YEAR
MONTH
CTE
RANK
DENSE_RANK
ROW_NUMBER
LAG
Window Functions
Subqueries
📊 Power BI Concepts Demonstrated
Data loading
Data transformation
Data modeling
DAX measures
KPI cards
Slicers
Bar charts
Line charts
Donut charts
Treemap
Matrix/table reporting
Conditional formatting
Drill-through
Interactive filtering
Dashboard navigation
Customer-level detail analysis
🔍 Data Quality & Validation

Before analytical reporting, the project includes SQL checks for:

Duplicate transaction IDs
Duplicate policy numbers
Missing values
Negative premium amounts
Negative claim amounts
Invalid reporting dates
Claim date range
Record counts
Insurance-type validation
Claim and premium statistics

This validation layer helps reduce the risk of producing misleading business insights from inconsistent records.

⚠️ Data Interpretation & Source-Data Limitation

The dashboard currently displays claim amounts that are substantially larger than premium amounts in the overall dataset.

For example:

Total Premium Amount   → $885.09K
Total Claim Amount     → $165.64M

This produces an unusually high claim-to-premium relationship.

Therefore, the monetary units and source-data definitions should be validated before using these figures to draw real-world insurance profitability conclusions.

This does not change the purpose of the project. The project primarily demonstrates the complete data analytics and business intelligence workflow, including:

Data Cleaning
     ↓
SQL Analysis
     ↓
KPI Development
     ↓
Power BI Modeling
     ↓
Dashboard Design
     ↓
Risk & Claims Analysis
     ↓
Customer Drill-Through

This limitation has been documented intentionally so that the analysis remains transparent and reproducible.

🚀 How to Reproduce the Project
Step 1 — Prepare the Data

Start with the files inside:

Dataset/

Perform data cleaning and preparation using the cleaned datasets inside:

Cleaned_Data/
Step 2 — Load Data into SQL Server

Create the required tables and import the cleaned datasets into SQL Server.

Run:

SQL/Creating-Database-and-View-All-Data.sql

to perform initial data validation.

Step 3 — Run Business Analysis

Execute the SQL scripts:

SQL/Business KPIs.sql


SQL/Insurance Claims & Risk Analytics.sql


SQL/Customer & Vendor Analytics.sql


SQL/Advanced_SQL_Anlytics_.sql

These scripts progressively move from basic validation and KPIs to advanced analytical queries.

Step 4 — Open Power BI

Open the Power BI report from:

Dashboard/

Review the report pages in this order:

1. Executive Overview
2. Customer Analysis
3. Claims Analysis
4. Transaction & Premium Analysis
5. Risk Analysis
6. Customer Drill-Through
💼 Business Value

This project demonstrates how raw insurance data can be transformed into actionable business intelligence.

The analysis supports:

Portfolio monitoring
Claims management
Risk assessment
Customer segmentation
Vendor performance analysis
Geographic exposure analysis
Claim severity analysis
Operational analysis
Customer-level investigation

The final Power BI report allows decision-makers to move from:

High-Level KPIs → Segment Analysis → Claims Analysis → Risk Analysis → Transaction Details → Individual Customer Investigation

📁 Repository Organization

The repository separates each stage of the analytics lifecycle:

Dataset/
    Raw source files


Cleaned_Data/
    Analysis-ready files


SQL/
    Data validation
    Business KPIs
    Claims & risk analytics
    Customer & vendor analytics
    Advanced SQL analytics


Dashboard/
    Power BI reporting layer


README.md
    Project documentation

This structure makes the project easier to understand, review, reproduce, and maintain.

👨‍💻 Skills Demonstrated
Data Cleaning
Data Validation
Exploratory Data Analysis
SQL Analytics
Advanced SQL
T-SQL
CTEs
Window Functions
KPI Development
DAX
Power Query
Power BI
Data Visualization
Business Intelligence
Risk Analytics
Claims Analytics
Customer Analytics
Vendor Analytics
Dashboard Design
Drill-through Reporting
⭐ Project Summary

Insurance Analytics is an end-to-end business intelligence project combining Excel data preparation, SQL Server analytics, and Power BI dashboarding to analyze insurance premiums, claims, customers, vendors, risk, incidents, and geographic exposure.

The project demonstrates a complete analyst workflow:

Raw Data → Cleaned Data → Validated Database → Analytical SQL → Power BI Modeling → Interactive Dashboard → Customer-Level Drill-Through.
