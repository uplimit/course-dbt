with

staged_users as (

    select * from {{ ref('stg_public__users')}}

),

staged_addresses as (

    select * from {{ ref('stg_public__addresses')}}

),

final as (

    select
        staged_users.user_guid
        , staged_users.first_name
        , staged_users.last_name
        , staged_users.phone_number
        , staged_users.email
        , staged_addresses.user_address
        , staged_addresses.user_zip_code
        , staged_addresses.user_state
        , staged_addresses.user_country
        , staged_users.created_at_utc
        , staged_users.updated_at_utc
    from staged_users
    left join staged_addresses using(user_address_guid)

)

select * from final