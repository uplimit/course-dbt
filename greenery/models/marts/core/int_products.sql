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


, orders_items AS (
SELECT
	order_id
	,product_id 
	,quantity
FROM {{ ref("stg_postgres__order_items") }}
)--orders


, ordered_products_summary AS (
SELECT
	orders_items.product_id
	,COUNT(orders_items.product_id) AS num_orders
	,SUM(CASE WHEN orders.status = 'shipped' 
			  THEN orders_items.quantity 
			  ELSE 0 
			  END
         ) AS quantity_shipped,
	,SUM(CASE WHEN orders.status = 'delivered' 
			  THEN orders_items.quantity 
			  ELSE 0 
			  END
         ) AS quantity_delivered,
	,SUM(CASE WHEN orders.status = 'preparing' 
			  THEN orders_items.quantity 
			  ELSE 0 
			  END
         ) AS quantity_preparing,
    ,SUM(orders_items.quantity) AS total_quantity
FROM orders_items
LEFT JOIN orders 
	ON orders_items.order_id = orders.order_id
GROUP BY orders_items.product_id
    )

SELECT 
	product_id
	,num_orders
	,quantity_shipped
	,quantity_delivered
	,quantity_preparing
	,total_quantity
FROM ordered_products_summary