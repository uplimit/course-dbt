{{ config(
    tags=['PII']
)
}}

WITH order_agg AS (
    SELECT *
    FROM {{ ref('int_orders_agg') }}
)

SELECT 
      order_id
      ,order_discount
      ,promotion_status
      ,user_id
      ,user_name
      ,shipping_address
      ,created_at_utc
      ,order_cost
      ,shipping_cost
      ,order_total_amount
      ,order_profits
      ,shipping_tracking_id
      ,estimated_delivery_at_utc
      ,delivered_at_utc
      ,order_status
      ,number_of_purchased_products
      ,total_purchased_product_quantities
FROM order_agg
