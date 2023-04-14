WITH base AS(
  SELECT
    *
  FROM {{source('postgres','addresses')}}
),

rename_recast AS(
  SELECT
    address_id AS address_guid,
    address,
    state,
    lpad(zipcode,5, 0) AS zip_code,
    country
  FROM base
)

SELECT * FROM rename_recast
