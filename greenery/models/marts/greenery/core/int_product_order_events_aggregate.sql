{{ 
    config(
        materialized = 'table'
    )  
}}

SELECT
	, se.session_guid 
	, MAX(se.order_guid) order_guid 
	, MAX(se.product_guid) product_guid 
	, MAX(user_guid) user_guid
	, COUNT(event_guid ) as session_events
	, COUNT(1) filter( WHERE event_type = 'add_to_cart') AS add_to_cart
	, COUNT(1) filter( WHERE event_type = 'checkout') AS checkout
	, COUNT(1) filter( WHERE event_type = 'page_view') AS page_view
	, COUNT(1) filter( WHERE event_type = 'package_shipped') AS package_shipped
FROM
	{{
      ref('stg_greenery__orders') 
    }}
GROUP BY
	se.session_id