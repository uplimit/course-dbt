{{
    config(
        materialzed = 'view'
    )
}}

WITH promos_source AS (
    SELECT
        promo_id
        , discount
        , status
    FROM
        {{
            source('greenery', 'promos')
        }}
)

, renamed_casted as (
    SELECT
        promo_id
        , discount
        , status
    FROM 
        promos_source  
)

SELECT 
    promo_id
    , discount
    , status
FROM 
    renamed_casted
