/* Customer & Vendor Analytics */
select * from Insurance
select * from Customer
select * from Vendor

/* Part A — Customer Analytics */

/* How many customers have insurance transactions? */
select
    count(distinct CUSTOMER_ID) as TOTALCUSTOMERS
from INSURANCE;

/* Which customers have the highest total claim amount? */
select top 10
    CUSTOMER_ID,
    CUSTOMER_NAME,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by
    CUSTOMER_ID,
    Customer_name
order by TOTALCLAIMAMOUNT desc;


/* Which customers have the highest total premium? */
select top 10
    CUSTOMER_ID,
    CUSTOMER_NAME,
    sum(PREMIUM_AMOUNT) as TOTALPREMIUM
from INSURANCE
group by
    CUSTOMER_ID,
    CUSTOMER_NAME
order by TOTALPREMIUM desc;

/* Which customers have multiple claims? */
select
    CUSTOMER_ID,
    CUSTOMER_NAME,
    count(TRANSACTION_ID) as TOTALCLAIMS
from INSURANCE
group by
    CUSTOMER_ID,
    CUSTOMER_NAME
having count(TRANSACTION_ID) > 1
order by TOTALCLAIMS desc;


/* Which customers have both high premiums and high claims? */
select top 20
    CUSTOMER_ID,
    CUSTOMER_NAME,
    sum(PREMIUM_AMOUNT) as TOTALPREMIUM,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,
    round(
        sum(CLAIM_AMOUNT) * 100.0 /
        nullif(sum(PREMIUM_AMOUNT), 0),
        2
    ) as LOSSRATIO
from INSURANCE
group by
    CUSTOMER_ID,
    CUSTOMER_NAME
order by LOSSRATIO desc;


/* What is the average claim amount by customer age? */
select
    AGE,
    count(TRANSACTION_ID) as TOTALCLAIMS,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE
group by AGE
order by AGE;


/* Which customer education level has the highest claim amount? */
select
    CUSTOMER_EDUCATION_LEVEL,
    count(TRANSACTION_ID) as TOTALCLAIMS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE
group by CUSTOMER_EDUCATION_LEVEL
order by TOTALCLAIMAMOUNT desc;


/* Which cities have the highest claim exposure? */
select top 10
    CITY,
    count(TRANSACTION_ID) as TOTALCLAIMS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by CITY
order by TOTALCLAIMAMOUNT desc;


/* How does customer tenure affect claims? */
select
    case
        when TENURE < 24 then 'New Customer'
        when TENURE < 60 then 'Established Customer'
        else 'Long-Term Customer'
    end as CUSTOMERTENUREGROUP,

    count(TRANSACTION_ID) as TOTALCLAIMS,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM,
    sum(PREMIUM_AMOUNT) as TOTALPREMIUM

from INSURANCE

group by
    case
        when TENURE < 24 then 'New Customer'
        when TENURE < 60 then 'Established Customer'
        else 'Long-Term Customer'
    end

order by TOTALCLAIMS desc;


/* Which customer social class has the highest loss ratio? */
select
    SOCIAL_CLASS,
    sum(PREMIUM_AMOUNT) as TOTALPREMIUM,
    sum(CLAIM_AMOUNT) as TOTALCLAIMS,
    round(
        sum(CLAIM_AMOUNT) * 100.0 /
        nullif(sum(PREMIUM_AMOUNT), 0),
        2
    ) as LOSSRATIO
from INSURANCE
group by SOCIAL_CLASS
order by LOSSRATIO desc;

/* Part B — Vendor Analytics */
/* How many claims are handled by each vendor? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,
    count(i.TRANSACTION_ID) as TOTALCLAIMS
from INSURANCE i
inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID
group by
    v.VENDOR_ID,
    v.VENDOR_NAME
order by TOTALCLAIMS desc;


/* Which vendors handle the highest claim amount? */
select top 10
    v.VENDOR_ID,
    v.VENDOR_NAME,
    sum(i.CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE i
inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID
group by
    v.VENDOR_ID,
    v.VENDOR_NAME
order by TOTALCLAIMAMOUNT desc;


/* What is the average claim amount handled by each vendor? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,
    count(i.TRANSACTION_ID) as TOTALCLAIMS,
    avg(i.CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE i
inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID
group by
    v.VENDOR_ID,
    v.VENDOR_NAME
order by AVERAGECLAIM desc;


/* Which vendors have the highest claim approval rate? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,

    count(i.TRANSACTION_ID) as TOTALCLAIMS,

    sum(
        case
            when i.CLAIM_STATUS = 'Approved' then 1
            else 0
        end
    ) as APPROVEDCLAIMS,

    sum(
        case
            when i.CLAIM_STATUS = 'Denied' then 1
            else 0
        end
    ) as DENIEDCLAIMS,

    round(
        sum(
            case
                when i.CLAIM_STATUS = 'Approved' then 1
                else 0
            end
        ) * 100.0 /
        nullif(count(i.TRANSACTION_ID), 0),
        2
    ) as APPROVALRATE

from INSURANCE i

inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID

group by
    v.VENDOR_ID,
    v.VENDOR_NAME

order by APPROVALRATE desc;


/* Which vendors handle the most severe incidents? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,
    i.INCIDENT_SEVERITY,
    count(i.TRANSACTION_ID) as TOTALCLAIMS
from INSURANCE i
inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID
group by
    v.VENDOR_ID,
    v.VENDOR_NAME,
    i.INCIDENT_SEVERITY
order by TOTALCLAIMS desc;


/* Which vendors have unusually high average claim values? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,
    count(i.TRANSACTION_ID) as TOTALCLAIMS,
    avg(i.CLAIM_AMOUNT) as AVERAGECLAIM
from INSURANCE i
inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID
group by
    v.VENDOR_ID,
    v.VENDOR_NAME
having count(i.TRANSACTION_ID) >= 10
order by AVERAGECLAIM desc;


/* Part C — Multi-table Analysis */
/* Which insurance type has the highest claims among different customer segments? */
select
    SOCIAL_CLASS,
    INSURANCE_TYPE,
    count(TRANSACTION_ID) as TOTALCLAIMS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by
    SOCIAL_CLASS,
    INSURANCE_TYPE
order by TOTALCLAIMAMOUNT desc;


/* Which risk segment has the highest claims per customer? */
select
    RISK_SEGMENTATION,
    count(TRANSACTION_ID) as TOTALCLAIMS,
    count(distinct CUSTOMER_ID) as UNIQUECUSTOMERS,

    round(
        count(TRANSACTION_ID) * 1.0 /
        nullif(count(distinct CUSTOMER_ID), 0),
        2
    ) as CLAIMSPERCUSTOMER

from INSURANCE

group by RISK_SEGMENTATION

order by CLAIMSPERCUSTOMER desc;


/* Which vendors handle high-risk customers? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,
    i.RISK_SEGMENTATION,
    count(i.TRANSACTION_ID) as TOTALCLAIMS,
    sum(i.CLAIM_AMOUNT) as TOTALCLAIMAMOUNT

from INSURANCE i

inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID

where i.RISK_SEGMENTATION = 'High'

group by
    v.VENDOR_ID,
    v.VENDOR_NAME,
    i.RISK_SEGMENTATION

order by TOTALCLAIMAMOUNT desc;


/* Which vendors have both high claim volume and high average claim value? */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,
    count(i.TRANSACTION_ID) as TOTALCLAIMS,
    sum(i.CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,
    avg(i.CLAIM_AMOUNT) as AVERAGECLAIM

from INSURANCE i

inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID

group by
    v.VENDOR_ID,
    v.VENDOR_NAME

having count(i.TRANSACTION_ID) >= 10

order by TOTALCLAIMAMOUNT desc;