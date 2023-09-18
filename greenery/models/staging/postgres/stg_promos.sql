{{
  config(
    materialized='view'
  )
}}

with source as (
    select
        *
    from {{ source('postgres', 'promos') }}
)

, reaname_recast as ( 
    SELECT 
      promo_id as promo_name,
      discount as discount_amount,
      status as promo_status
    FROM source
)

select * from reaname_recast


