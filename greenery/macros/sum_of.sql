{%- macro sum_of(col_name, col_value) -%}

sum(case when {{ col_name }} = '{{ col_value }}' then 1 else 0 end)
 
{%- endmacro -%}