{{
  config(
    materialized='table'
  )
}}

WITH source_superheroes AS (
    SELECT * FROM {{ source( 'postgres', 'superheroes' ) }}
)

, renamed_recast AS (
    SELECT id AS superhero_id
           , name
           , lower(REPLACE(gender,' ','_')) AS gender
           , lower(REPLACE(eye_color,' ','_')) AS eye_color
           , lower(REPLACE(race,' ','_')) AS race
           , lower(REPLACE(hair_color,' ','_')) AS hair_color
           , height
           , lower(REPLACE(publisher,' ','_')) AS publisher
           , lower(REPLACE(skin_color,' ','_')) AS skin_color
           , lower(REPLACE(alignment,' ','_')) AS alignment
           , weight
           , created_at::timestamp AS created_at_utc
           , updated_at::timestamp AS updated_at_utc
    FROM source_superheroes
)

SELECT * FROM renamed_recast