{{ config(materialized='view') }}

with orders as (
    SELECT
    *
    from {{ref('src_orders')}}
)

,addresses as (
    SELECT
    *
    from {{ref('src_addresses')}}
)

,promos as (
    SELECT
    *
    from {{ref('src_promos')}}
)

,users as (
    SELECT
    *
    from {{ref('src_users')}}
)

,combined as (
    SELECT
    --ids
        o.ORDER_GUID
        ,o.USER_GUID
        ,o.PROMO_GUID
        ,o.ADDRESS_GUID
        ,o.TRACKING_GUID
    --timestamps
        ,o.CREATED_AT_TSTAMP_EST
        ,o.DELIVERED_AT_TSTAMP_EST
        ,o.ESTIMATED_DELIVERY_TSTAMP_EST
    --user
        ,u.FULL_NAME AS CUSTOMER_FULL_NAME   
        ,a.ADDRESS AS SHIP_ADDRESS
        ,a.ZIPCODE AS SHIP_ZIPCODE
        ,a.STATE AS SHIP_STATE
        ,a.COUNTRY AS SHIP_COUNTRY
        
    --order details
        ,o.SHIPPING_SERVICE
        ,o.STATUS
    --numbers
        ,o.ORDER_COST
        ,coalesce(p.DISCOUNT,0) as ORDER_DISCOUNT_AMT
        ,o.ORDER_COST - ORDER_DISCOUNT_AMT as PRE_DISCOUNT_TOTAL
        ,o.SHIPPING_COST as CUSTOMER_SHIPPING_COST
        ,o.ORDER_TOTAL AS CUSTOMER_ORDER_TOTAL
    from orders o
    left join users u
        on o.user_guid = u.user_guid
    left join addresses a
        on o.address_guid = a.address_guid
    left join promos p
        on o.promo_guid = p.promo_guid
)

select 
*
from combined