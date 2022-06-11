{{
    config(
        materialized='view'
    )
}}

with products_source as (
    select * from {{source('src_greenery','products')}}

)

, renamed_recast as (
    select
    product_id
    ,name
    ,price
    ,inventory
     
    from products_source
)


select * from renamed_recast 