# 🛡️ Insurance Analytics — End-to-End Data Analysis & Power BI

> An end-to-end insurance analytics project using **Excel, SQL Server, and Power BI** to analyze premiums, claims, customers, risk, incidents, vendors, and geographic exposure.

## 🎯 Project Objective

The objective of this project is to transform raw insurance data into actionable business insights through a complete data analytics workflow.

The project focuses on:

* Premium and claim performance
* Claim approval and denial analysis
* Customer segmentation
* Risk analysis
* Insurance-type performance
* Incident severity
* Geographic claim exposure
* Customer and vendor analytics
* Monthly claim trends
* Customer-level investigation

---

## 🔄 End-to-End Workflow

```text
Raw Data
   ↓
Excel Data Cleaning
   ↓
Data Validation
   ↓
SQL Server
   ↓
Business & Advanced SQL Analysis
   ↓
Power BI Data Modeling
   ↓
DAX Measures & KPIs
   ↓
Interactive Dashboard
   ↓
Customer Drill-Through
```

---

## 🛠️ Tech Stack

| Category           | Tools                        |
| ------------------ | ---------------------------- |
| Data Cleaning      | Microsoft Excel, Power Query |
| Database           | Microsoft SQL Server         |
| Query Language     | T-SQL                        |
| BI & Visualization | Microsoft Power BI           |
| Calculations       | DAX                          |
| Data Modeling      | Power BI                     |
| Version Control    | Git & GitHub                 |

---

# 📁 Project Structure

```text
Insurance_Data/
│
├── Dataset/
│   ├── employee_data.xlsx
│   ├── insurance_data.xlsx
│   └── vendor_data.xlsx
│
├── Cleaned_Data/
│   ├── employee_data_cleaned.xlsx
│   ├── insurance_data_cleaned.xlsx
│   └── vendor_data_cleaned.xlsx
│
├── SQL/
│   ├── Creating-Database-and-View-All-Data.sql
│   ├── Business KPIs.sql
│   ├── Insurance Claims & Risk Analytics.sql
│   ├── Customer & Vendor Analytics.sql
│   └── Advanced_SQL_Anlytics_.sql
│
├── Dashboard/
│   └── Insurance_Analytics.pbix
│
├── Screenshots/
│   ├── Executive_Overview.png
│   ├── Customer_Analysis.png
│   ├── Claim_Analysis.png
│   ├── Transaction_&_Premium_Analysis.png
│   ├── Risk_Analysis.png
│   └── Customer_360.png
│
└── README.md

```

# 🧹 1. Data Cleaning & Preparation

The raw datasets were first prepared using **Microsoft Excel**.

### Data Preparation Activities

* Data type validation
* Missing-value checks
* Duplicate checks
* Date validation
* Numeric field validation
* Premium and claim validation
* Preparation of analysis-ready datasets

The cleaned datasets were then used for SQL Server analysis and Power BI reporting.

---

# 🗄️ 2. SQL Server Analysis

SQL Server was used to perform data validation and business-oriented analysis before visualization.

## SQL Analysis Areas

### 🔹 Data Validation

* Record counts
* Duplicate transaction IDs
* Duplicate policy numbers
* Missing values
* Negative premium/claim values
* Date validation
* Insurance-type validation
* Claim and premium statistics

### 🔹 Business KPIs

* Total Premium
* Total Claims
* Total Customers
* Total Policies
* Average Premium
* Average Claim
* Approved Claims
* Denied Claims
* Claim Approval Rate
* Claim Denial Rate
* Average Customer Age
* Loss Ratio

### 🔹 Claims & Risk Analytics

* Claims by insurance type
* Claim exposure by risk segment
* Claim severity analysis
* State-level claim exposure
* Approval rate by insurance type
* Approval rate by state
* Police report vs approval
* Incident time analysis
* Claim reporting delay

### 🔹 Customer Analytics

* Top customers by premium
* Top customers by claim amount
* Customers with multiple claims
* Customer risk analysis
* Customer tenure analysis
* Claims by age
* Claims by education
* Claims by social class
* Claims by city

### 🔹 Vendor Analytics

* Claims handled by vendor
* Total claim amount handled
* Average claim amount
* Vendor approval rate
* High-value claims handled
* High-risk customer claims

---

# 🧠 3. Advanced SQL

The project also includes advanced SQL analysis using:

```text
CTEs
JOINs
Subqueries
CASE
GROUP BY
HAVING
Window Functions
RANK()
DENSE_RANK()
ROW_NUMBER()
LAG()
Aggregations
Time-Series Analysis
```

### Examples of Advanced Analysis

* Ranking insurance types by claim exposure
* Finding top customers within each insurance type
* Calculating monthly running claims
* Month-over-month claim comparison
* Identifying high-loss customers
* Identifying potentially high-risk claims
* Detecting late claim reporting

---

# 📈 4. Power BI Dashboard

The Power BI report contains **6 analytical pages**.

---

## 1️⃣ Executive Overview

<img width="1172" height="672" alt="Executive_Overview" src="https://github.com/user-attachments/assets/73433404-ce1f-490a-80e3-c1e6d3d13f69" />


Provides a high-level view of portfolio performance.

### KPIs

* Total Premium
* Total Claim Amount
* Total Customers
* Total Transactions
* Approved Claims
* Claim Approval Rate

### Analysis

* Premium Trend
* Premium by Insurance Type
* Claims by Insurance Type
* Claim Approval Status
* Premium by Risk Segment
* Top Cities by Premium

### Example 2021 View

| KPI             |    Value |
| --------------- | -------: |
| Total Premium   | $413.58K |
| Total Claims    |  $78.18M |
| Customers       |       5K |
| Transactions    |       5K |
| Approved Claims |       4K |
| Approval Rate   |   95.16% |

---

## 2️⃣ Customer Analysis

<img width="1170" height="685" alt="Customer_Analysis" src="https://github.com/user-attachments/assets/5a9f2464-e8e1-44ef-ac27-e8f314efd516" />


Focuses on customer demographics and segmentation.

### KPIs

* Total Customers
* Average Age
* Average Family Size
* Average Tenure
* Average Premium

### Analysis

* Customers by Age Group
* Employment Distribution
* Social Class
* Education Profile
* Family Size
* Customer Risk Distribution
* Claims by Risk Segment
* Premium Contribution by Social Class
* Customers by City

---

## 3️⃣ Claims Analysis

<img width="1165" height="680" alt="Claim_Analysis" src="https://github.com/user-attachments/assets/d5ada81c-d77d-45b7-bdbd-cdd4829eaf5a" />


Provides detailed analysis of claim exposure.

### KPIs

* Total Premium
* Total Claims
* Approved Claims
* Claim Approval Rate
* Average Claim Amount

### Analysis

* Claims by Insurance Type
* Premium Exposure by Insurance Type
* Claims by Social Class
* Claim Exposure by Incident Severity
* Claim Severity Distribution
* Claims by Risk Segment
* Monthly Claim Exposure

### Overall Dashboard View

| KPI             |    Value |
| --------------- | -------: |
| Total Premium   | $885.09K |
| Total Claims    | $165.64M |
| Approved Claims |       9K |
| Approval Rate   |   94.97% |
| Average Claim   |  $16.56K |

---

## 4️⃣ Transaction & Premium Analysis

<img width="1178" height="669" alt="Transaction_ _Premium_Analysis" src="https://github.com/user-attachments/assets/cd1c522f-f809-43cd-bd74-ea9703517cd2" />


Provides detailed transaction-level analysis.

### Analysis

* Top 10 Customers by Premium
* Bottom 10 Customers by Premium
* Premium by Incident Severity
* Claims by Claim Amount Band
* Customers by Claim Status
* Transaction-level details

The transaction table includes fields such as:

* Transaction ID
* Customer ID
* Transaction Date
* Insurance Type
* Premium Amount
* Claim information

---

## 5️⃣ Risk Analysis

<img width="1171" height="675" alt="Risk_Analysis" src="https://github.com/user-attachments/assets/c89d88d0-24ae-4d73-a0e1-ffd5e26b96f5" />


Focuses on customer risk and claim exposure.

### KPIs

* Total Customers
* High-Risk Customers
* Total Claim Amount
* Average Claim Amount

### Analysis

* Customer Risk Distribution
* Claim Exposure by Risk Segment
* Risk × Claim Severity
* Top States by Claim
* Top States by Premium
* Incident Severity
* Top Incident Locations
* Premium Exposure by Insurance Type
* Customers by City

---

## 6️⃣ Customer 360 Drill-Through


<img width="1169" height="671" alt="Customer_360" src="https://github.com/user-attachments/assets/c0c74f3a-99d0-4365-8a9b-12d9a0c94f34" />

The final page provides detailed customer-level investigation.

### Customer Profile

* Customer ID
* Age
* Education
* City
* Employment Status
* Marital Status
* Family Size
* Claim Status

### Insurance Profile

* Insurance Type
* Policy Effective Date
* Loss Date
* Premium Amount
* Claim Amount

### Risk Profile

* Risk Segment
* Claim Severity
* Claim Status
* Incident Location
* Incident Severity
* Police Report
* Incident Time

The page also provides a **Customer Premium vs Claim** comparison.

---

# 💡 Key Business Insights

The dashboard enables analysis of several important business patterns.

### Insurance-Type Exposure

Life insurance represents the highest claim exposure in the displayed claims analysis, followed by Property and Health insurance.

### Risk Exposure

The customer population is divided across Low, Medium, and High risk segments, allowing claim exposure to be compared against customer risk.

### Geographic Exposure

The dashboard identifies states and cities with the highest premium and claim concentrations.

### Claim Severity

Claims are analyzed across:

* Minor Loss
* Major Loss
* Total Loss

This helps identify how claim severity contributes to overall claim exposure.

### Customer Segmentation

Customer behavior can be analyzed by:

* Age
* Education
* Employment
* Social Class
* Family Size
* Risk Segment
* Tenure

---

# ⚠️ Data Interpretation Note

The dashboard currently shows claim amounts substantially higher than premium amounts in the overall dataset.

For example:

```text
Total Premium  → $885.09K
Total Claims   → $165.64M
```

This creates an unusually high claim-to-premium relationship.

Therefore, the **monetary units and source-data definitions should be validated before using these figures to draw real-world insurance profitability conclusions**.

This project is primarily intended to demonstrate the complete:

**Data Cleaning → SQL Analysis → Power BI Modeling → KPI Development → Dashboard Design → Risk & Claims Analysis → Customer Drill-Through**

workflow.

> If you notice the unusually high claim-to-premium relationship while reviewing the dashboard, this is a characteristic of the source dataset and has been documented intentionally for transparency.

---

# 📌 Key Skills Demonstrated

### Data Analysis

* Data Cleaning
* Data Validation
* Exploratory Data Analysis
* Business Analysis

### SQL

* T-SQL
* Joins
* CTEs
* Subqueries
* Aggregations
* Window Functions
* Ranking
* Time-Series Analysis

### Power BI

* Power Query
* DAX
* Data Modeling
* KPI Development
* Dashboard Design
* Interactive Filtering
* Drill-Through
* Data Visualization

### Business Analytics

* Insurance Claims Analytics
* Risk Analytics
* Customer Analytics
* Vendor Analytics
* Geographic Analysis
* Performance Monitoring

---

# 🚀 How to Use

### 1. Clone the repository

```bash
git clone <your-repository-url>
cd Insurance_Data
```

### 2. Review the datasets

Start with the files inside:

```text
Dataset/
```

### 3. Review the cleaned data

```text
Cleaned_Data/
```

### 4. Run the SQL scripts

Open the scripts in **SQL Server Management Studio (SSMS)** and execute them in the appropriate order.

### 5. Open the Power BI report

Open:

```text
Dashboard/Insurance_Analytics.pbix
```

Use the slicers and drill-through functionality to explore the analysis.

---

# 📊 Project Outcome

This project demonstrates a complete **end-to-end Data Analyst workflow**:

```text
Raw Data
    ↓
Excel Cleaning
    ↓
SQL Server
    ↓
Business Analysis
    ↓
Advanced SQL
    ↓
Power BI
    ↓
DAX & KPIs
    ↓
Interactive Dashboard
    ↓
Customer-Level Insights
```

The final solution transforms raw insurance data into an interactive business intelligence report that can support **claims monitoring, risk analysis, customer segmentation, geographic analysis, and operational decision-making**.

---

## 👨‍💻 Author

**Shubham Gupta**

**Data Analyst | SQL | Excel | Power BI | Python**

Interested in **Data Analytics, Business Intelligence, and Data-driven Decision Making**.

---

⭐ If you find this project useful, consider giving the repository a star.
