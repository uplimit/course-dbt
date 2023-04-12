with source as (
    select * from {{ source('postgres','products') }}
),

final as 
(
    select 
    product_id
    ,name as product_name
    ,price
    ,inventory

    from source 
)
select * from final