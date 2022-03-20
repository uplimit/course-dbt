{{
  config(
    materialized='table'
  )
}}

SELECT 
  u.first_name,
  u.last_name,
  u.user_id,
  u.repeated_customer,
  u.address,
  u.zipcode,
  u.state,
  u.email,
  o.order_total,
  o.shipping_service,
  max(o.delivery_credibility) as max_delivery_delay,
  round(avg(o.num_of_prods_in_order),0) as average_product_quantity,
  sum(promo_used) as count_promos_used
FROM {{ ref('dim_users') }} u  
LEFT JOIN {{ ref('fact_orders') }} o
ON u.user_id=o.user_id
GROUP BY
  1,2,3,4,5,6,7,8,9,10