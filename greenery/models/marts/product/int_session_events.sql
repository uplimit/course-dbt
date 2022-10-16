{{
  config(
    materialized='table'
  )
}}

WITH events AS (
  SELECT * 
  
  FROM {{ ref('stg_events') }}
),

final AS (
  SELECT
  user_id,
  session_id,
  SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkouts,
  SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS packages_shipped,
  SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_carts,
  SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_views


  FROM {{ ref('stg_events') }}

  GROUP BY 1,2
)

SELECT *

FROM final