select
    part_id,
    part_name,
    part_manufacturer,
    part_brand,
    part_type,
    part_size,
    part_container,
    part_retail_price
from {{ ref('trans_part') }}