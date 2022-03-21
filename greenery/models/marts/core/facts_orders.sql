
with stg_orders as (
    select * from {{ref('stg_orders')}}
)

, stg_promos as (
    select * 
    from {{ref('stg_promos')}}

)

, stg_addresses as (
    
    select * from {{ref('stg_addresses')}}
)

SELECT 
 stg_orders.*  
, case when stg_promos.discount is not null then 1 else 0 end as discount_used  
, stg_addresses.address 
, stg_addresses.zipcode 
, stg_addresses.state 
, stg_addresses.country
FROM stg_orders 
LEFT JOIN stg_promos 
    ON stg_orders.promo_id = stg_promos.promo_id 
LEFT JOIN  stg_addresses 
    ON stg_orders.address_id = stg_addresses.address_id 