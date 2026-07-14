with source as (
    select distinct
        region_code,
        region_name
    from {{ ref('stg_population') }}
)

select
    row_number() over (order by region_code) as region_id,
    region_code,
    region_name
from source