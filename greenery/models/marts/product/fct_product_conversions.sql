WITH purchase_events AS
(
    SELECT
        stg_order_items.product_id
        ,CAST(COUNT(DISTINCT int_agg.session_id) AS INTEGER) AS number_of_purchase_events
    FROM {{ ref('int_session_events_agg')}} int_agg
    JOIN {{ ref('stg_order_items')}} ON int_agg.order_id = stg_order_items.order_id
    GROUP BY 1

),

page_views AS 
(
    SELECT
        product_id
        ,SUM(page_view) AS number_of_page_views
    FROM {{ ref('int_session_events_agg')}}
    GROUP BY 1
)
 
SELECT
    page_views.product_id
    ,dim_products.product_name
    ,purchase_events.number_of_purchase_events
    ,page_views.number_of_page_views
    ,TO_CHAR((purchase_events.number_of_purchase_events/page_views.number_of_page_views)*100, 'fm00D00%') AS product_conversion_rate
FROM page_views
LEFT JOIN purchase_events ON page_views.product_id = purchase_events.product_id
JOIN {{ ref('dim_products')}} ON page_views.product_id = dim_products.product_id
ORDER BY product_conversion_rate DESC

