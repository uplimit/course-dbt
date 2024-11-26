WITH
products AS (
SELECT 
	product_id
	,name 
	,price
	,inventory
FROM {{ ref("stg_postgres__products") }}
)--products

, ordered_products AS (
SELECT 
	product_id
	,num_orders
	,quantity_shipped
	,quantity_delivered
	,quantity_preparing
	,total_quantity 
FROM {{ ref("int_products") }}
)--ordered_products

SELECT 
	products.product_id
	,products.name 
	,products.price
	,products.inventory
	,ordered_products_summary.num_orders
	,ordered_products_summary.quantity_shipped
	,ordered_products_summary.quantity_delivered
	,ordered_products_summary.quantity_preparing
	,ordered_products_summary.total_quantity 

FROM products
left join ordered_products_summary using (product_id)