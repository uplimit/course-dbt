{{ 
    config(
        MATERIALIZED = 'table'
    )
}}

WITH promos_source AS 
(
    SELECT
        promo_id
        , discount
        , status
    FROM
        {{ source('postgres', 'promos') }}
)

SELECT 
    ps.promo_id
    , ps.discount
    , ps.status
FROM promos_source ps
