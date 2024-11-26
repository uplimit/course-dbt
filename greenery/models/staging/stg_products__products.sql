with products as (
    select * from {{ source('greenery', 'products')}}
),

final as (
    select 
        product_id
        ,name
        ,price
        ,inventory
    from products
)

select * from final