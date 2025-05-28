{%macro calc_discount_from_retail(retail_price, net_price, quantity)%}
    ROUND(({{ retail_price  }} - ({{ net_price }} / NULLIF({{ quantity }}, 0))), 2)
{% endmacro %}
