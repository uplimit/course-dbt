with order_items as (

    select *

    from {{ source('src_greenery', 'order_items')}}

)

select * from order_items