with population as (
    select * from {{ ref('stg_population') }}
),

dim_region as (
    select * from {{ ref('dim_region') }}
),

dim_time as (
    select * from {{ ref('dim_time') }}
)

select
    dr.region_id,
    dt.time_id,
    p.population,
    p.growth
from population p
left join dim_region dr on p.region_code = dr.region_code
left join dim_time dt on p.year = dt.year