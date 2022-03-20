{{
  config(
    materialized='table'
  )
}}

with user_order_count as 
( SELECT user_id,
         count (distinct (order_id)) as num_of_orders,
         min(order_creation_date) as first_order_date
FROM {{ ref('stg_orders') }}
GROUP BY 1
)

SELECT
  u.user_id,
  u.email,
  u.first_name,
  u.last_name,
  u.user_registerion_date,
  add.address,
  add.zipcode,
  add.state,
  uoc.first_order_date,
  case 
  when uoc.num_of_orders >=2 then 'Repeated Customer'
  when uoc.num_of_orders =1 then 'One-time Customer'
  else 'Never ordered'
  end as repeated_customer
FROM {{ ref('stg_users') }} u
LEFT JOIN user_order_count uoc
ON u.user_id = uoc.user_id
LEFT JOIN {{ ref('stg_addresses') }} add
ON u.address_id=add.address_id