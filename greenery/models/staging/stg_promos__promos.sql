with promos as (
    select * from {{ source('src_promos', 'promos') }}
),

final as (
    select 
        promo_id
        ,discount
        ,status
    from promos
)

select * from final 