with

staged_order_items as (

    select * from {{ ref('stg_public__order_items')}}

),

-- calculate total items per order/basket
final as (

    select
        order_guid
        , sum(product_quantity) as total_items
    
    from staged_order_items

    group by 1

)

select * from final

