WITH
page_views AS (
SELECT 

	event_id
	,session_id
	,user_id
	,page_url
	,created_date
	,product_id

FROM {{ ref("stg_postgres__events") }}
WHERE event_type = 'page_view'
)--page_views


, products AS (
SELECT 

	product_id
	,name 
	,price
	,inventory 

FROM {{ ref("stg_postgres__products") }}
)


, products_added_to_cart_during_session AS (
SELECT

	DISTINCT session_id
	,product_id

FROM {{ ref("stg_postgres__events") }}
WHERE event_type = 'add_to_cart'
)--products_added_to_cart_during_session


products_added_to_cart_by_user AS (
SELECT
	DISTINCT user_id
	,product_id

FROM {{ ref("stg_postgres__events") }}
WHERE event_type = 'add_to_cart'
)--products_added_to_cart_by_user


, quantities_purchased_by_user AS (
SELECT 

	user_id
	,product_id
	,quantity_purchased_by_user 

from {{ ref("int_quantity_by_user") }}
)--quantities_purchased_by_user


SELECT

    page_views.event_id
	,page_views.session_id
	,page_views.user_id
	,page_views.page_url
	,page_views.created_date
	,page_views.product_id
    ,products.product_name
    ,CASE WHEN products_added_to_cart_during_session.product_id IS NOT NULL
		  THEN 1 
		  ELSE 0
    	  END AS added_to_cart_during_session
    ,CASE WHEN products_added_to_cart_by_user.product_id IS NOT NULL
		  THEN 1 
		  ELSE 0
    	  END AS added_to_cart_by_user
    ,quantities_purchased_by_user.quantity_purchased_by_user

FROM page_views
LEFT JOIN products 
	ON page_views.product_id = products.product_id
LEFT JOIN products_added_to_cart_during_session 
	ON page_views.session_id = products_added_to_cart_during_session.session_id
	AND page_views.product_id = products_added_to_cart_during_session.product_id
LEFT JOIN products_added_to_cart_by_user
	ON page_views.user_id = products_added_to_cart_during_session.user_id
	AND page_views.product_id = products_added_to_cart_during_session.product_id
LEFT JOIN quantities_purchased_by_user
	ON page_views.user_id = quantities_purchased_by_user.user_id
	AND page_views.product_id = quantities_purchased_by_user.product_id