{{
  config(
    materialized='table'
  )
}}

/*
DIM_DATE:
Generic Date dimension starting from the first day of the earliest month
in our source data and going until 1 year after today.
*/

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart = "day",
        start_date = "cast('2021-02-01' as date)",
        end_date = "cast(dateadd('year', 1, current_date()) as date)"
        )
    }}
),

results as (
    select
        date_day,
        date_part('year', date_day) as year,
        date_part('month', date_day) as month,
        date_part('day', date_day) as day

    from date_spine
)

select * from results