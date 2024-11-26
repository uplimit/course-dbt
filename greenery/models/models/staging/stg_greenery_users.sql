{{config(
    materialized='table'
) }}

with sources as (
    select * from {{ source('greenery_src', 'users') }} as users
)

, rename_recast as (
    SELECT
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        address_id as user_address_id,
        created_at as created_at_utc,
        updated_at as updated_at_utc

    FROM sources
)

select * from rename_recast