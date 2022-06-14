with promos as (
    select * from {{ source('greenery', 'promos') }}
),

final as (
    select 
        promo_id
        ,discount
        ,status
    from promos
)

select * from final 