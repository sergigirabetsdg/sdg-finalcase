select
    part_id,
    part_name,
    part_brand,
    part_type,
    part_size,
    part_container,
    part_retail_price,
    part_manufacturer
from {{ ref('trans_part') }}