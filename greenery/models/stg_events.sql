SELECT 
event_id AS event_id,
session_id AS session_id,
user_id AS user_id,
page_url AS page_url,
created_at AS created_at,
event_type AS event_type,
order_id AS order_id,
product_id AS product_id
FROM {{ source('greenery', 'events') }}
