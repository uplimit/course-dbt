SELECT
    promo_id AS promotion_id,
    discount,
    status
FROM {{ source('tutorial', 'promos') }}
