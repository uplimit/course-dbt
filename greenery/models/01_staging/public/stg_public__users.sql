-- stg_public__users.sql

with

source as (

    select * from {{ source('public', 'users') }}

),

standardized as (

    select

        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id

    from source

)

select * from standardized