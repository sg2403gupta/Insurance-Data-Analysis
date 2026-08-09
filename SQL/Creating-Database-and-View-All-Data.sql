/* Data Validation & Data Quality */


/*
Q1. Record Count
Q2. Duplicate Transaction IDs
Q3. Duplicate Policy Numbers
Q4. Missing Values
Q5. Claim Statistics
Q6. Premium Statistics
Q7. Date Range
Q8. Insurance Types
Q9. Negative Amount Check
Q10. Invalid Reporting Dates
*/


/* How many records are present in each table? */
select count(*) as TotalInsuaranceRecords from Insurance
select count(*) as TotalVendors from Vendor
select count(*) as TotalEmployees from Employee

/* Are there any duplicate Transaction IDs? */
select Transaction_id, count(*) as DuplicateTransaction from Insurance
group by TRANSACTION_ID 
having count(*) > 1

/* Are there any duplicate Policy Numbers? */
select Policy_Number,count(*) as DuplicatePolicy from Insurance
group by POLICY_NUMBER
having count(*) > 1

/* Which columns contain NULL values? */
select 
	SUM(case when city is null then 1 else 0 end) as MissingCity,
	sum(case when state is null then 1 else 0 end) as MissingState,
	sum(case when customer_education_level is null then 1 else 0 end) as MissingEducation,
	sum(case when incident_city is null then 1 else 0 end) as MissingIncidentCites,
	sum(case when vendor_id is null then 1 else 0 end) as MissingVendorId
from Insurance

/* What is the minimum, maximum, and average Claim Amount? */
select 
	min(claim_amount) as MinClaimAmnt,
	max(claim_amount) as MaxClaimAmnt,
	avg(claim_amount) as AvgClaimAmnt
from Insurance

/* What is the minimum, maximum, and average Premium Amount? */
select 
	MIN(Premium_amount) as MinPremiumAmnt,
	MAX(Premium_amount) as MaxPremiumAmnt,
	AVG(Premium_amount) as AvgPremiumAmnt
From Insurance

/* What is the date range of claims? */
select
	min(loss_dt) as FirstClaimDate, 
	max(loss_dt) LastClaimDate 
from Insurance

/* What insurance products exist? */
select Distinct(Insurance_type) from Insurance order by INSURANCE_TYPE

/* Are there any negative premium or claim amounts? */
select *
	from Insurance
where PREMIUM_AMOUNT<0 or
CLAIM_AMOUNT <0

/* Are there claims reported before the loss occurred? */
select 
	TRANSACTION_ID,
	LOSS_DT,
	REPORT_DT
from Insurance
where REPORT_DT < LOSS_DT
