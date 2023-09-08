{{
    config(materialized = 'table')
}}

with source as (
    select user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at
    , updated_at
    , address_id from {{ source('postgres', 'users') }}
)

, renamed_recast as (
    select
        user_id as user_guid
        , first_name
        , last_name
        , email
        , phone_number
        , created_at
        , updated_at
        , address_id as address_guid
    from source
)

select * from renamed_recast