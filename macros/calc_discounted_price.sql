{% macro calc_discounted_price(price, discount, tax) %}
    ROUND(({{ price }} * (1 - {{ discount }}) * (1 + {{ tax }})), 2)
{% endmacro %}
