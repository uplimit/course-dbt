with src_orders as (
    select * from {{ source('postgres', 'orders') }}
), 
renamed_recast as (
  select 
    ORDER_ID,
    USER_ID,
    md5(PROMO_ID) as promo_id,
    ADDRESS_ID,
    CREATED_AT::timestamp_ntz as created_at_utc,
    ORDER_COST,
    SHIPPING_COST,
    ORDER_TOTAL,
    TRACKING_ID,
    SHIPPING_SERVICE,
    ESTIMATED_DELIVERY_AT::timestamp_ntz as estimated_delivery_at_utc,
    DELIVERED_AT::timestamp_ntz as delivery_at_utc,
    STATUS
 from src_orders
)

select * from renamed_recast