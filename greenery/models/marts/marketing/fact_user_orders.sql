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

, user_order_summary AS (

SELECT
	user_id
    ,MIN(created_at)::date AS first_order_date
    ,MAX(created_at)::date AS last_order_date
	,ROUND(SUM(order_total), 2) AS total_spent
    ,COUNT(order_id) as num_orders
    ,SUM(CASE WHEN status = 'shipped'
			  THEN 1 
			  ELSE 0 
			  END
		) AS num_shipped
    ,SUM(CASE WHEN status = 'delivered'
			  THEN 1 
			  ELSE 0 
			  END
		) AS num_delivered
    ,SUM(CASE WHEN status = 'preparing'
			  THEN 1 
			  ELSE 0 
			  END
		) AS num_preparing

FROM orders
GROUP BY user_id
)--user_order_summary

SELECT

	user_id
	,first_order_date
	,last_order_date
	,total_spent
	,num_orders
	,num_shipped
	,num_delivered
	,num_preparing

FROM user_order_summary