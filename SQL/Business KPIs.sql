/* Business KPIs */


/* What is the total premium collected? */
select 
	sum(premium_amount) as TotalPremiumAmnt
from Insurance

/* What is the total claim amount? */
select 
	sum(claim_amount) as TotalClaimedAmnt
from Insurance

/* How many unique customers do we have? */
select
	count(distinct(agent_id)) as UniqueCustomers
from Insurance

/* How many policies are active? */
select 
	count(distinct(policy_number)) as TotalPolicies
from Insurance

/* What is the average premium amount? */
select 
	avg(premium_amount) as AvgPremiumAmnt
from Insurance

/* What is the average claim amount? */
select
	avg(claim_amount) as AvgClaimAmnt
from Insurance

/* How many claims were Approved vs Denied? */
select 
	Claim_Status,
	count(*) as TotalClaims
from Insurance
group by CLAIM_STATUS


/* What is the claim approval percentage? */
select
round(
	sum(case when claim_status = 'Approved' then 1 else 0 end) *100/count(*),
	2) as ApprovedPercentage
from Insurance

/* What is the claim denial percentage? */
select 
	ROUND(
		sum(case when claim_status = 'Denied' then 1 else 0 end)*100/count(*),
		2
	) as DenialPercentage
from Insurance

/* What is the highest claim amount? */
select 
	max(claim_amount) as MaxClaimedAmnt
from Insurance

/* What is the lowest claim amount? */
select 
	min(claim_amount) as MinClaimedAmnt
from Insurance

/* What is the highest premium amount? */
select
	max(premium_amount) as MaxPremiumAmnt
from Insurance

/* What is the lowest premium amount? */
select 
	min(premium_amount) as MinPremiumAmnt
from Insurance

/* What is the average customer age? */
select
	avg(age) as AvgCustomerAge
from Insurance

/* What is the Loss Ratio? */
select
	round(
		sum(claim_amount)*100.0/
		sum(premium_amount),
		2
		) as LossRatio
from Insurance