SELECT 
promo_id AS promo_id,
discount AS discount,
status AS status
FROM {{ source('greenery', 'promos') }}
