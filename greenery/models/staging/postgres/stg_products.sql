{{
  config(
    materialized='view'
  )
}}

with source as (
    select
        *
    from {{ source('postgres', 'products') }}
)
--difference between recasting and transoforming col in source
, reaname_recast as ( 
    SELECT
        product_id AS product_uuid,
        name as product_name,
        price,
        inventory
    FROM source
)

select * from reaname_recast


