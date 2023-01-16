with src_products as (
    select * from {{ source('postgres', 'products') }}
),
    renamed_recast as (
  select 
    product_id,
    name as product_name,
    price as product_price,
    inventory as product_inventory

 from src_products
)

select * from renamed_recast