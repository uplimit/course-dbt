{% test future_dates(model, column_name) %}


   select *
   from {{ model }}
   where ( date({{ column_name }}) - current_date ) > 0


{% endtest %}