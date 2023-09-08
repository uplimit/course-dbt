{{
  config(
    materialized='table'
  )
}}

WITH source_promos AS (
    SELECT * FROM {{ source( 'postgres', 'promos' ) }}
)

, renamed_recast AS (
    SELECT lower(REPLACE(REPLACE(promo_id,'-','_'),' ','_')) AS promo_type
           , discount
           , REPLACE(status,' ','_') AS status
    FROM source_promos
)

SELECT * FROM renamed_recast