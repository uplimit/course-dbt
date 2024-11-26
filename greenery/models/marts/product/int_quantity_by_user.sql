WITH
quantities_purchased_by_user AS (
SELECT
	orders.user_id
    ,lines.product_id
	,SUM(lines.quantity) AS quantity_purchased_by_user

FROM {{ ref("stg_postgres__orders") }} AS orders
LEFT JOIN {{ ref("stg_postgres__order_items") }} AS lines 
	ON orders.id = lines.order_id
GROUP BY orders.user_id, lines.product_id
)--quantities_purchased_by_user

SELECT

	user_id
	,product_id
	,quantity_purchased_by_user

FROM quantities_purchased_by_user