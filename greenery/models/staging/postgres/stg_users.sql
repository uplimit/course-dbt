{{
  config(
    materialized='view'
  )
}}

with source as (
    select
        *
    from {{ source('postgres', 'users') }}
)
--difference between recasting and transoforming col in source
, reaname_recast as ( 
    SELECT 
        user_id as user_uuid,
        address_id as address_uuid,
        first_name,
        last_name,
        phone_number,
        email,
        created_at as user_created_at,
        updated_at as user_updated_at
    FROM source
)

select * from reaname_recast


