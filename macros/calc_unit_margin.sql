{% macro calc_unit_margin(net_price, quantity, supply_cost) %}
    ROUND(({{ net_price }} / NULLIF({{ quantity }}, 0)) - {{ supply_cost }}, 2)
{% endmacro %}
