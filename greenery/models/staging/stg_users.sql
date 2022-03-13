with 

source as (
    select  
      -- UUID for each unique user on platform
        user_id,
        -- first name of the user
        first_name,
        -- last name of the user
        last_name,
        -- email address of the user
        email,
        -- phone number of the user
        phone_number,
        -- timestamp the user was created
        created_at,
        -- timestamp the user was last updated
        updated_at,
        -- default delivery address for the user
        address_id
    from {{ source('greenery', 'users') }}
)

select * from source