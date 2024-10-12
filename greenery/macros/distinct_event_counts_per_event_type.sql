{%- macro distinct_event_counts_per_event_type() -%}

{% set event_types = ["checkout", "package_shipped", "add_to_cart","page_view"] %}

    {% for event_type in event_types %}
        count(distinct case when event_type = '{{event_type}}' then event_id end) as distinct_counts_of_{{event_type}}_events
        {%- if not loop.last  -%} 
        , 
        {%- endif -%}
    {% endfor %}

{%- endmacro -%}