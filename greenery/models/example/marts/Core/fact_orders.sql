{{ config(materialized='table') }}

with int_order_table as (
    SELECT
    *
    from {{ref('int_fact_orders')}}
)

,additions as (
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
        ,o.CUSTOMER_FULL_NAME   
        ,o.SHIP_ADDRESS
        ,o.SHIP_ZIPCODE
        ,o.SHIP_STATE
        ,o.SHIP_COUNTRY
     
    --order details
        ,o.SHIPPING_SERVICE
        ,o.STATUS
        ,case when estimated_delivery_tstamp_est < delivered_at_tstamp_est then 'Delivered Late'
            when estimated_delivery_tstamp_est >= delivered_at_tstamp_est then 'Delivered On Time'
            when delivered_at_tstamp_est is null and estimated_delivery_tstamp_est >= current_timestamp() then 'Pending delivery - On Time'
            when delivered_at_tstamp_est is null and estimated_delivery_tstamp_est < current_timestamp() then 'Pending delivery - Late'
            when estimated_delivery_tstamp_est is null then 'No estimated delivery given'
            else 'NA' 
        end as delivery_timeframe_compliance
        ,rank() over (partition by user_guid order by created_at_tstamp_est) as user_order_rank
        ,case when rank() over (partition by user_guid order by created_at_tstamp_est desc) = 1 then TRUE else FALSE end as user_most_recent_order_flag
        ,case 
            when delivered_at_tstamp_est is not null then rank() over (partition by user_guid order by delivered_at_tstamp_est) 
        end as user_delivered_rank
    
    --numbers
        ,o.ORDER_COST
        ,o.ORDER_DISCOUNT_AMT
        ,o.PRE_DISCOUNT_TOTAL
        ,o.CUSTOMER_SHIPPING_COST
        ,o.CUSTOMER_ORDER_TOTAL
    
    from int_order_table o

)

SELECT
*
from additions