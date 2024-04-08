select
    session_id,
    min(created_at) as session_started_at,
    max(created_at) as session_ended_at,
from {{ ref("stg_postgres__events") }}
group by 1
