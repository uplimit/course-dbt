{{
  config(
    materialized = 'table'
  )
}}


WITH fact_product_conversion_rates AS (
SELECT product_views.product_guid
      , product_views.product_name
      , product_views.sessions_with_product_page_view
      , product_purchases.sessions_with_product_checkout
      , ROUND(product_purchases.sessions_with_product_checkout::numeric 
            / product_views.sessions_with_product_page_view::numeric * 100, 2) AS product_conversion_rate
FROM {{ ref ('int_product_page_views') }} as product_views
JOIN {{ ref ('int_product_checkout_purchases') }} AS product_purchases 
ON product_views.product_guid = product_purchases.product_guid
)
SELECT 
    * 
FROM 
    fact_product_conversion_rates

