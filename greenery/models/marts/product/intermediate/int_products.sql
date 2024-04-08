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

-- i first pull the last timestamp for every product before the current record
with previous_inventory_timestamp as (
select 
    h.product_id 
    , max(h.dbt_updated_at) as previous_inventory_timestamp
 
from {{ ref('hist_products') }} h 

where 1 = 1 
    and h.dbt_valid_to is not null 

group by 1
)
-- i now pull the inventory counts for the last timestamp, intentionally, not using window functions here as window functions can get quite costly on snapshot tables
, previous_inventory as (
select 
    h.product_id 
    , h.inventory as previous_inventory 
    , p.previous_inventory_timestamp
  
from {{ ref('hist_products') }} h 
  
join previous_inventory_timestamp p
    on h.product_id = p.product_id 
    and h.dbt_updated_at = p.previous_inventory_timestamp
)

select 
    p.product_id 
    , p.name as product_name 
    , p.price as product_price
    , p.inventory as product_current_inventory
    , p2.previous_inventory as product_previous_inventory
    , p2.previous_inventory_timestamp

from {{ ref('postgres__products') }} p

left join previous_inventory p2
    on p.product_id = p2.product_id 