SELECT  step
       ,COUNT
       ,LAG(COUNT, 1) OVER()
       ,ROUND((1.0 - COUNT::numeric/LAG(COUNT, 1) over ()),2) as drop_off
FROM {{ ref('int_funnel_events') }}
