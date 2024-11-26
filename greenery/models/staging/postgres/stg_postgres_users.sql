with src_users as (
    select * from {{ source('postgres', 'users') }}
),
renamed_recast as (
    select 
    user_id, 
    first_name as user_first_name, 
    last_name as user_last_name, 
    email as user_email,
    phone_number as user_phone_number, 
    created_at::timestamp_ntz as user_created_at_utc,
    updated_at::timestamp_ntz as user_updated_at_utc,
    address_id
    from src_users
)

select * from renamed_recast