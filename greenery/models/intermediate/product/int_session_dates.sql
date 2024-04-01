select session_id, min(created_at) as session_start_date, max(created_at) as session_end_date
from {{ref('stg_postgres__events')}}
group by session_id