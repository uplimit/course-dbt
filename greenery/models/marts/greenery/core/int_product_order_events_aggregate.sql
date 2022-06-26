{{ 
    config(
        materialized = 'table'
    )  
}}

SELECT
	session_guid 
	, MAX(order_guid) AS order_guid 
	, MAX(product_guid) AS product_guid 
	, MAX(user_guid) AS user_guid
	, COUNT(event_guid ) AS session_events
	, COUNT(1) filter( WHERE event_type = 'add_to_cart') AS add_to_cart
	, COUNT(1) filter( WHERE event_type = 'checkout') AS checkout
	, COUNT(1) filter( WHERE event_type = 'page_view') AS page_view
	, COUNT(1) filter( WHERE event_type = 'package_shipped') AS package_shipped
FROM
	{{
      ref('stg_greenery__events') 
    }}
GROUP BY
	session_guid