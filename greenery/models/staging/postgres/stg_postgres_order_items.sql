with src_order_items as (
    select * from {{ source('postgres', 'order_items') }}
),
    renamed_recast as (
  select 
    order_id as order_id,
    product_id as product_id,
    quantity as order_item_quantity
    
 from src_order_items
)

select * from renamed_recast