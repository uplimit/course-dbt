with src_order_items as (
    select * from {{ source('postgres', 'order_items')}}
)
, renamed_recast as (
    select
        order_id     as order_guid
        , product_id as product_guid
        , quantity
    from src_order_items
)
select * from renamed_recast