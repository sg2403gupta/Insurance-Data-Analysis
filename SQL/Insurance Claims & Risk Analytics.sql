/* Insurance Claims & Risk Analytics */

/* Which insurance type has the highest number of claims? */
select
    INSURANCE_TYPE,
    COUNT(*) as TotalClaims
from Insurance
group by INSURANCE_TYPE
order by TotalClaims desc

/* Which insurance type has the highest total claim amount? */
select
    insurance_type,
    sum(premium_amount) as totalpremium
from insurance
group by insurance_type
order by totalpremium desc

/* What is the claim frequency by insurance type? */
select
    insurance_type,
    count(*) as totalclaims,
    count(distinct policy_number) as totalpolicies,
    round(
        count(*) * 100.0 /
        nullif(count(distinct policy_number), 0),
        2
    ) as claimfrequencypercentage
from insurance
group by insurance_type
order by claimfrequencypercentage desc;

/* Which states have the highest claim amount? */
select
    STATE,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by STATE
order by TOTALCLAIMAMOUNT desc;

/* Which states have the highest number of claims? */
select
    STATE,
    count(*) as TOTALCLAIMS
from INSURANCE
group by STATE
order by TOTALCLAIMS desc;

/* What is the average claim amount by state? */
select
    STATE,
    count(*) as TOTALCLAIMS,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE
group by STATE
order by AVERAGECLAIM desc;

/* How do claims differ across risk segments? */
select
    RISK_SEGMENTATION,
    count(*) as TOTALCLAIMS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE
group by RISK_SEGMENTATION
order by TOTALCLAIMAMOUNT desc;

/* Which risk segment has the highest loss ratio? */
select
    RISK_SEGMENTATION,
    sum(PREMIUM_AMOUNT) as TOTALPREMIUM,
    sum(CLAIM_AMOUNT) as TOTALCLAIMS,
    round(
        sum(CLAIM_AMOUNT) * 100.0 /
        nullif(sum(PREMIUM_AMOUNT), 0),
        2
    ) as LOSSRATIO
from INSURANCE
group by RISK_SEGMENTATION
order by LOSSRATIO desc;

/* What is the approval and denial rate by insurance type? */
select
    INSURANCE_TYPE,
    count(*) as TOTALCLAIMS,

    sum(case
        when CLAIM_STATUS = 'Approved' then 1
        else 0
    end) as APPROVEDCLAIMS,

    sum(case
        when CLAIM_STATUS = 'Denied' then 1
        else 0
    end) as DENIEDCLAIMS,

    round(
        sum(case
            when CLAIM_STATUS = 'Approved' then 1
            else 0
        end) * 100.0 / nullif(count(*), 0),
        2
    ) as APPROVALRATE

from INSURANCE
group by INSURANCE_TYPE
order by APPROVALRATE desc;


/* What is the approval rate by state? */
select
    STATE,
    count(*) as TOTALCLAIMS,

    sum(case
        when CLAIM_STATUS = 'Approved' then 1
        else 0
    end) as APPROVEDCLAIMS,

    round(
        sum(case
            when CLAIM_STATUS = 'Approved' then 1
            else 0
        end) * 100.0 / nullif(count(*), 0),
        2
    ) as APPROVALRATE

from INSURANCE
group by STATE
order by APPROVALRATE desc;

/* Which incident severity has the highest claim amount? */
select
    INCIDENT_SEVERITY,
    count(*) as TOTALCLAIMS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE
group by INCIDENT_SEVERITY
order by TOTALCLAIMAMOUNT desc;

/* Does incident severity affect claim approval? */
select
    INCIDENT_SEVERITY,
    count(*) as TOTALCLAIMS,

    sum(case
        when CLAIM_STATUS = 'Approved' then 1
        else 0
    end) as APPROVEDCLAIMS,

    sum(case
        when CLAIM_STATUS = 'Denied' then 1
        else 0
    end) as DENIEDCLAIMS

from INSURANCE
group by INCIDENT_SEVERITY
order by TOTALCLAIMS desc;

/* Do injury-related claims have higher claim amounts? */
select
    ANY_INJURY,
    count(*) as TOTALCLAIMS,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by ANY_INJURY
order by AVERAGECLAIM desc;

/* Does having a police report affect claim approval? */
select
    POLICE_REPORT_AVAILABLE,
    count(*) as TOTALCLAIMS,

    sum(case
        when CLAIM_STATUS = 'Approved' then 1
        else 0
    end) as APPROVEDCLAIMS,

    round(
        sum(case
            when CLAIM_STATUS = 'Approved' then 1
            else 0
        end) * 100.0 / nullif(count(*), 0),
        2
    ) as APPROVALRATE

from INSURANCE
group by POLICE_REPORT_AVAILABLE;

/* Which age group has the highest average claim? */
select
    case
        when AGE between 18 and 25 then '18-25'
        when AGE between 26 and 35 then '26-35'
        when AGE between 36 and 45 then '36-45'
        when AGE between 46 and 55 then '46-55'
        else '56+'
    end as AGEGROUP,

    count(*) as TOTALCLAIMS,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM

from INSURANCE

group by
    case
        when AGE between 18 and 25 then '18-25'
        when AGE between 26 and 35 then '26-35'
        when AGE between 36 and 45 then '36-45'
        when AGE between 46 and 55 then '46-55'
        else '56+'
    end

order by AVERAGECLAIM desc;

/* How does employment status affect claims? */
select
    EMPLOYMENT_STATUS,
    count(*) as TOTALCLAIMS,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by EMPLOYMENT_STATUS
order by TOTALCLAIMAMOUNT desc;

/* At what time of day do most incidents occur? */
select
    case
        when INCIDENT_HOUR_OF_THE_DAY between 0 and 5
            then 'night'
        when INCIDENT_HOUR_OF_THE_DAY between 6 and 11
            then 'morning'
        when INCIDENT_HOUR_OF_THE_DAY between 12 and 17
            then 'afternoon'
        else 'evening'
    end as INCIDENTTIMEBUCKET,

    count(*) as TOTALINCIDENTS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT

from INSURANCE

group by
    case
        when INCIDENT_HOUR_OF_THE_DAY between 0 and 5
            then 'night'
        when INCIDENT_HOUR_OF_THE_DAY between 6 and 11
            then 'morning'
        when INCIDENT_HOUR_OF_THE_DAY between 12 and 17
            then 'afternoon'
        else 'evening'
    end

order by TOTALINCIDENTS desc;

/* How long does it take customers to report incidents? */
select
    avg(datediff(day, LOSS_DT, REPORT_DT)) as AVERAGEREPORTINGDELAY,
    min(datediff(day, LOSS_DT, REPORT_DT)) as MINIMUMREPORTINGDELAY,
    max(datediff(day, LOSS_DT, REPORT_DT)) as MAXIMUMREPORTINGDELAY
from INSURANCE