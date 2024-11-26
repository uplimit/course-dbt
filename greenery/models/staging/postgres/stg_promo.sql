SELECT
    promo_id
    , INITCAP(promo_id) AS promo_name
    , discount / 100 AS discount_percentage
    , status AS promo_status
FROM {{ source('postgres', 'promos') }}