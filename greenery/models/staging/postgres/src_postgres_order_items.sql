{{ 
    config(
        MATERIALIZED = 'table'
    )
}}


WITH order_items_source AS 
(
    SELECT
    	order_id
    	, product_id
    	, quantity
    FROM 
        {{ source('postgres', 'order_items') }}
)

SELECT
	ois.order_id
	, ois.product_id
	, ois.quantity
FROM 
	order_items_source ois
