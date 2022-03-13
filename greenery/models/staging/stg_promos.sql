with 

source as (
    select  
        -- Each unique promocode on platform
        promo_id,
        -- Absolute dollar amount that is given off with the code
        discount,
        -- Is the promo code active or disabled
        status
    from {{ source('greenery', 'promos') }}
)

select * from source