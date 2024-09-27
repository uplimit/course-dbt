{% macro get_event_types() %}
    {{ return(["checkout", "package_shipped", "add_to_cart", "page_view"]) }}
{% endmacro %}