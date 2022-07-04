SELECT 
    products.product_id
    , products.name as product_name
    , products.price
    , CASE WHEN products.inventory = 0 THEN false ELSE true END AS is_in_stock
    , products.inventory as number_in_stock
    , COUNT(DISTINCT order_items.order_id) as number_of_orders_with_product
FROM {{ ref('stg_products__products') }} AS products
LEFT JOIN {{ ref('stg_order_items__order_items')}} AS order_items ON products.product_id = order_items.product_id
GROUP BY 1, 2, 3, 4, 5