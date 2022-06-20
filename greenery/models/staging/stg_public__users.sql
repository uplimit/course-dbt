-- stg_public__users.sql

with

source as (

    select * from {{ source('public', 'users') }}

),

source_standardized as (

    select

          user_id       as user_guid
        , first_name
        , last_name
        , email
        , phone_number
        , created_at    as created_at_utc
        , updated_at    as updated_at_utc
        , address_id    as user_address_guid

    from source

)

select * from source_standardized