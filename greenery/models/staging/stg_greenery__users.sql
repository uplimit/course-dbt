{{
    config(
        materialized = 'view'
    )
}}

with user_source as (
    select * from {{ source('src_greenery__users', 'users') }}
)

, renamed_recast as (
    SELECT
    user_id as user_guid
    , first_name
    , last_name
    , email
    , phone_number
    , created_at as user_created_as_utc
    , updated_at as user_updated_as_utc
    , address_id as address_guid
    from user_source
)

select * from renamed_recast