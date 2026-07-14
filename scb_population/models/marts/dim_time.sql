with source as (
    select distinct
        year
    from {{ ref('stg_population') }}
)

select
    row_number() over (order by year) as time_id,
    year
from source