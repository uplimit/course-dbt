{{
    config(
        materialzed = 'view'
    )
}}

WITH promos_source AS (
    SELECT
        LOWER(
            regexp_replace(promo_id, '[- ]', '','g')
            )  AS promo_id    -- mostly nulls 
        , discount
        , status
    FROM
        {{
            source('greenery', 'promos')
        }}
)

, renamed_casted as (
    SELECT
        (promo_id::varchar) AS promo_description
        , discount
        , status
    FROM 
        promos_source  
)

SELECT 
    promo_description
    , discount
    , status
FROM 
    renamed_casted
