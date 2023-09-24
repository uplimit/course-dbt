WITH
orders AS (
SELECT 
	order_id
	,promo_id 
	,user_id
	,address_id
	,created_at
	,order_cost
	,shipping_cost
	,order_total
	,tracking_id
	,shipping_service
	,estimated_delivery_at
	,delivered_at
	,status 
FROM {{ ref("stg_postgres__orders") }}
)--orders

, promos AS (
SELECT 
	promo_id
	,discount 
	,status
FROM {{ ref("stg_postgres__promos") }}
)--promos

SELECT 
	orders.order_id
	,orders.promo_id 
	,orders.user_id
	,orders.address_id
	,orders.created_at
	,orders.order_cost
	,orders.shipping_cost
	,orders.order_total
	,orders.tracking_id
	,orders.shipping_service
	,orders.estimated_delivery_at
	,orders.delivered_at
	,orders.status 
	,promos.discount AS promo_discount
FROM orders
LEFT JOIN promos 
	ON orders.promo_id = promos.promo_id