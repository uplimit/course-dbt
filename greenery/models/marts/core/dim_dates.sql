with dates as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2019-01-01' as date)",
        end_date="cast('2030-01-01' as date)"
    )
    }}
)

select * from dates