SELECT
     products.product_id
    ,products.product_name
    ,products.price
    ,products.inventory
    ,SUM(order_items.quantity) AS total_number_of_sold_items
FROM {{ ref('stg_products')}} products
LEFT JOIN {{ ref('stg_order_items') }} order_items ON products.product_id = order_items.product_id

{{ dbt_utils.group_by(n=4) }}
