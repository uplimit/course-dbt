SELECT
    product_id
    , name AS product_name
    , price
    , inventory
FROM {{ source('postgres', 'products') }}