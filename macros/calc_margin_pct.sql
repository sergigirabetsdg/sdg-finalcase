{% macro calc_margin_pct(net_price, total_cost) %}
    ROUND(100 * (({{ net_price }} - {{ total_cost }}) / NULLIF({{ total_cost }}, 0)), 2)
{% endmacro %}
