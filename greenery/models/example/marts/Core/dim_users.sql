{{ config(materialized='table') }}


with users as (
    SELECT
    *
    from {{ref('src_users')}}
)

,first_order AS (
    SELECT
        DISTINCT 
        USER_GUID,
        CREATED_AT_TSTAMP_EST as FIRST_ORDER_CREATED_TSTAMP_EST
    FROM {{ref('fact_orders')}}
    WHERE USER_ORDER_RANK = 1
)

,first_delivered_order AS (
    SELECT
    DISTINCT 
        USER_GUID,
        DELIVERED_AT_TSTAMP_EST as FIRST_ORDER_DELIVERED_TSTAMP_EST
    FROM {{ref('fact_orders')}}
    WHERE USER_DELIVERED_RANK = 1
)


,combined AS (
    select
        u.USER_GUID
        ,u.FIRST_NAME
        ,u.LAST_NAME
        ,u.FULL_NAME
        ,u.EMAIL
        ,u.PHONE_NUMBER
        ,u.CREATED_AT_TSTAMP_EST as SYSTEM_CREATED_TSTAMP_EST
        ,u.UPDATED_AT_TSTAMP_EST AS SYSTEM_UPDATED_TSTAMP_EST
        ,fo.FIRST_ORDER_CREATED_TSTAMP_EST
        ,fd.FIRST_ORDER_DELIVERED_TSTAMP_EST
    from users u
    left join first_order fo
        on u.user_guid = fo.user_guid
    left join first_delivered_order fd
        on u.user_guid = fd.user_guid

)


SELECT
*
from combined