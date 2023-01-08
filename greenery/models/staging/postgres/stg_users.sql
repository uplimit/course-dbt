with source as (

    select * from {{ source('postgres', 'users') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id
    from
        source

)

select * from renamed
