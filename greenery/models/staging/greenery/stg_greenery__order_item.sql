{{
    config(
        materialized = 'view'
    )
}}

with order_item_source as (
    select * from {{ source('src_greenery__order_item', 'order_items') }}
)

, renamed_recast as (
    SELECT
    order_id as order_guid
    , product_id as product_guid
    , quantity
    from order_item_source
)

select * from renamed_recast