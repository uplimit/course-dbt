WITH base AS(
  SELECT
    *
  FROM {{source('postgres','order_items')}}
),

rename_recast AS(
  SELECT
    order_id AS order_guid,
    product_id AS product_guid,
    quantity
  FROM base
)

SELECT * FROM rename_recast
