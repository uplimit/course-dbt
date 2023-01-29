{{
  config(
    materialized='table'
  )
}}

select
	o.order_id
	, o.user_id
	, o.promo_id
	, p.discount
	, o.address_id
	, a.address
	, a.zipcode
	, a.state
	, a.country
	, o.CREATED_AT
	, o.order_cost
	, o.shipping_cost
	, o.order_total
	, o.tracking_id
	, o.shipping_service
	, o.estimated_delivery_at
	, o.delivered_at
	, o.status
	, oi.order_items
    , oi.products_ordered
from {{ ref('staging_postgres_orders') }} o
left join {{ ref('staging_postgres_addresses') }} a
    on a.address_id = o.address_id
left join {{ ref('staging_postgres_promos') }} p
    on p.promo_id = o.promo_id
LEFT JOIN (
    SELECT oi.order_id
        , ARRAY_AGG(
            object_construct('product', ps.name, 
                             'quantity', oi.quantity, 
                             'price_per_product', ps.price::varchar,
                             'total_price_per_product', (oi.quantity * ps.price::float)::varchar)
        ) as order_items
        , array_agg(distinct ps.name) as products_ordered
    FROM {{ ref('staging_postgres_order_items') }} oi
    LEFT JOIN {{ ref('staging_postgres_products') }} ps on ps.product_id = oi.product_id
    group by 1    
) oi on oi.order_id = o.order_id