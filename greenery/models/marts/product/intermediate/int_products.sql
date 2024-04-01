{{
    config(
        materialized = 'table'
        , unique_key = 'product_id'
    )
}}
/*
Grain/primary key : One row per product_id
Stakeholders : Product Team (Product Manager X)
Purpose : Understand product data by adding/enriching it with more data points
*/

select 
    p.product_id 
    , p.name as product_name 
    , p.price as product_price

from {{ ref('postgres__products') }} p

