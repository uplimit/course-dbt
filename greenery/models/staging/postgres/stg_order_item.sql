SELECT
    {{ dbt_utils.surrogate_key(['order_id', 'product_id']) }} AS surrogate_key
    , order_id
    , product_id
    , quantity
FROM {{ source('postgres', 'order_items') }}