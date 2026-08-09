/* Which insurance types have a loss ratio above the overall company loss ratio? */
with InsurancePerformance as
(
    select
        INSURANCE_TYPE,
        sum(PREMIUM_AMOUNT) as TOTALPREMIUM,
        sum(CLAIM_AMOUNT) as TOTALCLAIMS,
        sum(CLAIM_AMOUNT) * 100.0 /
            nullif(sum(PREMIUM_AMOUNT), 0) as LOSSRATIO
    from INSURANCE
    group by INSURANCE_TYPE
)

select
    INSURANCE_TYPE,
    TOTALPREMIUM,
    TOTALCLAIMS,
    round(LOSSRATIO, 2) as LOSSRATIO
from InsurancePerformance
where LOSSRATIO >
(
    select
        sum(CLAIM_AMOUNT) * 100.0 /
        nullif(sum(PREMIUM_AMOUNT), 0)
    from INSURANCE
)
order by LOSSRATIO desc;


/*. Which claims are higher than the average claim amount? */
select
    TRANSACTION_ID,
    CUSTOMER_ID,
    INSURANCE_TYPE,
    CLAIM_AMOUNT
from INSURANCE
where CLAIM_AMOUNT >
(
    select avg(CLAIM_AMOUNT)
    from INSURANCE
)
order by CLAIM_AMOUNT desc;


/* Which customers have claims above the average customer claim? */
select
    CUSTOMER_ID,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
from INSURANCE
group by CUSTOMER_ID
having sum(CLAIM_AMOUNT) >
(
    select avg(CUSTOMERCLAIM)
    from
    (
        select
            CUSTOMER_ID,
            sum(CLAIM_AMOUNT) as CUSTOMERCLAIM
        from INSURANCE
        group by CUSTOMER_ID
    ) as CustomerClaims
)
order by TOTALCLAIMAMOUNT desc;

/* Rank insurance types by total claim amount */
select
    INSURANCE_TYPE,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,

    rank() over
    (
        order by sum(CLAIM_AMOUNT) desc
    ) as CLAIMRANK

from INSURANCE

group by INSURANCE_TYPE;


/* Rank states by total claim amount */
select
    STATE,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,

    rank() over
    (
        order by sum(CLAIM_AMOUNT) desc
    ) as STATERANK

from INSURANCE

group by STATE

order by STATERANK;


/* Find the top 3 insurance types by claim amount */
with RankedInsurance as
(
    select
        INSURANCE_TYPE,
        sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,

        dense_rank() over
        (
            order by sum(CLAIM_AMOUNT) desc
        ) as RANKNUMBER

    from INSURANCE

    group by INSURANCE_TYPE
)

select
    INSURANCE_TYPE,
    TOTALCLAIMAMOUNT,
    RANKNUMBER
from RankedInsurance
where RANKNUMBER <= 3
order by RANKNUMBER;


/* Find the top 5 customers within each insurance type */
with CustomerClaims as
(
    select
        INSURANCE_TYPE,
        CUSTOMER_ID,
        sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT
    from INSURANCE
    group by
        INSURANCE_TYPE,
        CUSTOMER_ID
),

RankedCustomers as
(
    select
        INSURANCE_TYPE,
        CUSTOMER_ID,
        TOTALCLAIMAMOUNT,

        row_number() over
        (
            partition by INSURANCE_TYPE
            order by TOTALCLAIMAMOUNT desc
        ) as CUSTOMERRANK

    from CustomerClaims
)

select
    INSURANCE_TYPE,
    CUSTOMER_ID,
    TOTALCLAIMAMOUNT,
    CUSTOMERRANK
from RankedCustomers
where CUSTOMERRANK <= 5
order by
    INSURANCE_TYPE,
    CUSTOMERRANK;


/* Calculate each insurance type's percentage of total claims */
select
    INSURANCE_TYPE,

    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,

    round(
        sum(CLAIM_AMOUNT) * 100.0 /
        sum(sum(CLAIM_AMOUNT)) over (),
        2
    ) as CLAIMPERCENTAGE

from INSURANCE

group by INSURANCE_TYPE

order by CLAIMPERCENTAGE desc;


/* Calculate running claim amount by month */
with MonthlyClaims as
(
    select
        year(LOSS_DT) as CLAIMYEAR,
        month(LOSS_DT) as CLAIMMONTH,
        sum(CLAIM_AMOUNT) as MONTHLYCLAIMAMOUNT

    from INSURANCE

    group by
        year(LOSS_DT),
        month(LOSS_DT)
)

select
    CLAIMYEAR,
    CLAIMMONTH,
    MONTHLYCLAIMAMOUNT,

    sum(MONTHLYCLAIMAMOUNT) over
    (
        order by CLAIMYEAR, CLAIMMONTH
        rows between unbounded preceding and current row
    ) as RUNNINGCLAIMAMOUNT

from MonthlyClaims

order by
    CLAIMYEAR,
    CLAIMMONTH;


/* Calculate monthly claim trends */
select
    year(LOSS_DT) as CLAIMYEAR,
    month(LOSS_DT) as CLAIMMONTH,
    count(*) as TOTALCLAIMS,
    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,
    avg(CLAIM_AMOUNT) as AVERAGECLAIM

from INSURANCE

group by
    year(LOSS_DT),
    month(LOSS_DT)

order by
    CLAIMYEAR,
    CLAIMMONTH;


/* Compare monthly claims with the previous month */
with MonthlyClaims as
(
    select
        year(LOSS_DT) as CLAIMYEAR,
        month(LOSS_DT) as CLAIMMONTH,
        sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT

    from INSURANCE

    group by
        year(LOSS_DT),
        month(LOSS_DT)
),

PreviousMonth as
(
    select
        CLAIMYEAR,
        CLAIMMONTH,
        TOTALCLAIMAMOUNT,

        lag(TOTALCLAIMAMOUNT) over
        (
            order by CLAIMYEAR, CLAIMMONTH
        ) as PREVIOUSMONTHCLAIM

    from MonthlyClaims
)

select
    CLAIMYEAR,
    CLAIMMONTH,
    TOTALCLAIMAMOUNT,
    PREVIOUSMONTHCLAIM,

    TOTALCLAIMAMOUNT - PREVIOUSMONTHCLAIM
        as CLAIMAMOUNTCHANGE,

    round(
        (TOTALCLAIMAMOUNT - PREVIOUSMONTHCLAIM) * 100.0 /
        nullif(PREVIOUSMONTHCLAIM, 0),
        2
    ) as MONTHOVERMONTHGROWTH

from PreviousMonth

order by
    CLAIMYEAR,
    CLAIMMONTH;


/* Find the highest-value customers based on premium */
with CustomerPremium as
(
    select
        CUSTOMER_ID,
        CUSTOMER_NAME,
        sum(PREMIUM_AMOUNT) as TOTALPREMIUM
    from INSURANCE
    group by
        CUSTOMER_ID,
        CUSTOMER_NAME
)

select
    CUSTOMER_ID,
    CUSTOMER_NAME,
    TOTALPREMIUM,

    dense_rank() over
    (
        order by TOTALPREMIUM desc
    ) as CUSTOMERRANK

from CustomerPremium

order by CUSTOMERRANK;


/* Identify customers with a loss ratio above 100% */
select
    CUSTOMER_ID,
    CUSTOMER_NAME,

    sum(PREMIUM_AMOUNT) as TOTALPREMIUM,

    sum(CLAIM_AMOUNT) as TOTALCLAIMS,

    round(
        sum(CLAIM_AMOUNT) * 100.0 /
        nullif(sum(PREMIUM_AMOUNT), 0),
        2
    ) as LOSSRATIO

from INSURANCE

group by
    CUSTOMER_ID,
    CUSTOMER_NAME

having
    sum(CLAIM_AMOUNT) >
    sum(PREMIUM_AMOUNT)

order by LOSSRATIO desc;


/* Rank vendors by total claim amount */
select
    v.VENDOR_ID,
    v.VENDOR_NAME,

    sum(i.CLAIM_AMOUNT) as TOTALCLAIMAMOUNT,

    rank() over
    (
        order by sum(i.CLAIM_AMOUNT) desc
    ) as VENDORRANK

from INSURANCE i

inner join VENDOR v
    on i.VENDOR_ID = v.VENDOR_ID

group by
    v.VENDOR_ID,
    v.VENDOR_NAME

order by VENDORRANK;


/* Find the top 5 vendors for each insurance type */
with VendorPerformance as
(
    select
        i.INSURANCE_TYPE,
        i.VENDOR_ID,
        sum(i.CLAIM_AMOUNT) as TOTALCLAIMAMOUNT

    from INSURANCE i

    group by
        i.INSURANCE_TYPE,
        i.VENDOR_ID
),

RankedVendors as
(
    select
        INSURANCE_TYPE,
        VENDOR_ID,
        TOTALCLAIMAMOUNT,

        row_number() over
        (
            partition by INSURANCE_TYPE
            order by TOTALCLAIMAMOUNT desc
        ) as VENDORRANK

    from VendorPerformance
)

select
    INSURANCE_TYPE,
    VENDOR_ID,
    TOTALCLAIMAMOUNT,
    VENDORRANK

from RankedVendors

where VENDORRANK <= 5

order by
    INSURANCE_TYPE,
    VENDORRANK;


/* Which claims were reported unusually late? */
select
    TRANSACTION_ID,
    LOSS_DT,
    REPORT_DT,

    datediff(
        day,
        LOSS_DT,
        REPORT_DT
    ) as REPORTINGDELAY

from INSURANCE

where datediff(
    day,
    LOSS_DT,
    REPORT_DT
) > 7

order by REPORTINGDELAY desc;


/* What percentage of claims were reported late? */
select
    round(
        sum(
            case
                when datediff(day, LOSS_DT, REPORT_DT) > 7
                then 1
                else 0
            end
        ) * 100.0 / nullif(count(*), 0),
        2
    ) as LATEREPORTINGPERCENTAGE

from INSURANCE;


/* Identify potentially high-risk claims
Using:
High claim amount
Injury
Police report unavailable
High incident severity */
select
    TRANSACTION_ID,
    CLAIM_AMOUNT,
    INCIDENT_SEVERITY,
    ANY_INJURY,
    POLICE_REPORT_AVAILABLE,

    case
        when CLAIM_AMOUNT >= 20000
             and ANY_INJURY = 1
             and POLICE_REPORT_AVAILABLE = 0
        then 'High Risk'

        when CLAIM_AMOUNT >= 10000
        then 'Medium Risk'

        else 'Low Risk'
    end as CLAIMRISKLEVEL

from INSURANCE

order by CLAIM_AMOUNT desc;


/* Which insurance types have the best and worst loss ratios? */
select
    INSURANCE_TYPE,

    sum(PREMIUM_AMOUNT) as TOTALPREMIUM,

    sum(CLAIM_AMOUNT) as TOTALCLAIMS,

    round(
        sum(CLAIM_AMOUNT) * 100.0 /
        nullif(sum(PREMIUM_AMOUNT), 0),
        2
    ) as LOSSRATIO

from INSURANCE

group by INSURANCE_TYPE

order by LOSSRATIO desc;


/* Which insurance types combine high claim volume with high claim severity? */

select
    INSURANCE_TYPE,

    count(*) as TOTALCLAIMS,

    avg(CLAIM_AMOUNT) as AVERAGECLAIM,

    sum(CLAIM_AMOUNT) as TOTALCLAIMAMOUNT

from INSURANCE

group by INSURANCE_TYPE

having
    count(*) >
    (
        select avg(CLAIMCOUNT)
        from
        (
            select
                INSURANCE_TYPE,
                count(*) as CLAIMCOUNT
            from INSURANCE
            group by INSURANCE_TYPE
        ) as ClaimFrequency
    )

order by AVERAGECLAIM desc;
