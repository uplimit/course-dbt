{%- macro order_revenue(price_col, quantity_col, discount_col = 0) %}
{{ price_col }} * {{ quantity_col }} * (1 - {{ discount_col }})
{% endmacro -%}