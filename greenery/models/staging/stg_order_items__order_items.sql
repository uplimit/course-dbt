with order_items as (
    select * from {{ source('greenery', 'order_items')}}
),

final as (
    select 
        order_id
        ,product_id
        ,quantity
    from order_items
)

select * from final