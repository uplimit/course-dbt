with 

source as (
    select  
        -- OrderId of this order
        order_id,
        -- ProductId of a single item in this order
        product_id,
        -- Number of units of the product in this order
        quantity
    from {{ source('greenery', 'order_items') }}
)

select * from source