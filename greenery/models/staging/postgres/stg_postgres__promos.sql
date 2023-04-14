WITH base AS(
  SELECT
    *
  FROM {{source('postgres','promos')}}
),

rename_recast AS(
  SELECT
    promo_id,
    discount,
    status
  FROM base
)

SELECT * FROM rename_recast
