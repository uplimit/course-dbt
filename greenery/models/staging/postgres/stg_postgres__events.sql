
WITH base AS(
  SELECT
    *
  FROM {{source('postgres','events')}}
),

rename_recast AS(
  SELECT
    event_id AS address_guid,
    session_id AS session_guid,
    event_type,
    page_url,
    created_at,
    order_id AS order_guid,
    product_id AS product_guid
  FROM base
)

SELECT * FROM rename_recast
