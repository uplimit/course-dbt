with src_promos as (
    select * from {{ source('postgres', 'promos') }}
),
renamed_recast as (
  select 
  md5(promo_id) as promo_id,
  promo_id as promo_name,
  discount as promo_discount,
  status as promo_status
  from src_promos
)

select * from renamed_recast