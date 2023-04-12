{{
  config(
    materialized='table',
    enabled=false
  )
}}

SELECT 
    id AS superhero_id,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    NULLIF(height, -99) AS height,
    publisher,
    skin_color,
    alignment,
    NULLIF(weight, -99) AS weight_lbs,
    {{ lbs_to_kgs('weight_lbs') }} AS weight_kg
FROM {{ source('tutorial', 'superheroes') }}