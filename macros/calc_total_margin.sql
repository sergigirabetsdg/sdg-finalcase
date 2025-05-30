{% macro calc_total_margin(net_price, total_cost) %}
    ROUND({{ net_price }} - {{ total_cost }}, 2)
{% endmacro %}
