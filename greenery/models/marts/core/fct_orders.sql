SELECT 
       orders.order_id
      ,promos.discount AS order_discount
      ,promos.status AS promotion_status
      ,users.user_id
      ,CONCAT(users.first_name, ' ', users.last_name) AS user_name
      ,CONCAT(addresses.address, ', ', addresses.state, ' ', addresses.zip_code, ', ', addresses.country) AS shipping_address
      ,orders.created_at_utc
      ,orders.order_cost
      ,orders.shipping_cost
      ,orders.order_total_amount
      ,orders.shipping_tracking_id
      ,orders.estimated_delivery_at_utc
      ,orders.delivered_at_utc
      ,orders.order_status
      ,COUNT(DISTINCT items.product_id) AS number_of_products
FROM {{ ref('stg_orders')}} orders
LEFT JOIN {{ ref('stg_promos')}} promos ON orders.promotion_id = promos.promotion_id
JOIN {{ ref('stg_addresses')}} addresses ON orders.address_id = addresses.address_id
JOIN {{ ref('stg_users')}} users ON orders.user_id = users.user_id
JOIN {{ ref('stg_order_items')}} items ON orders.order_id = items.order_id

{{ dbt_utils.group_by(n=14) }}
