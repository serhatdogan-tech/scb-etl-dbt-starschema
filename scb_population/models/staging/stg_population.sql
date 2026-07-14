with source as ( select * from {{ source('public', 'population_data') }} 
),

renamed as (
    select 
        region as region_code,
        region_name,
        year,
        population,
        growth
        from source
)

SELECT * FROM renamed
