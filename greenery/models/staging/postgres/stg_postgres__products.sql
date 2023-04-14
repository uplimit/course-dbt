WITH base AS(
  SELECT
    *
  FROM {{source('postgres','products')}}
),

rename_recast AS(
  SELECT
    product_id AS product_guid,
    name,
    price,
    inventory
  FROM base
)

SELECT * FROM rename_recast
