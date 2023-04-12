with source as (
    select * from {{ source('postgres','order_items') }}
),

final as 
(
    select 
    order_id
    ,product_id
    ,quantity

    from source 
)
select * from final