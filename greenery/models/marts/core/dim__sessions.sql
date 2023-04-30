 {{
  config(
    materialized='table'
  )
}}

WITH sessions AS (
    SELECT
          stge.session_id
        , stge.user_id
        , MIN(stge.created_at) AS start_time
        , MAX(stge.created_at) AS end_time
    FROM {{ ref('stg_postgres__events') }} AS stge
    GROUP BY stge.session_id, stge.user_id
)

SELECT 
    * 
FROM sessions