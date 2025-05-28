{% macro calc_item_delivery(interval_unit, ship_date, receipt_date) %}
    DATEDIFF({{ interval_unit }}, {{ ship_date }}, {{ receipt_date }})
{% endmacro %}
