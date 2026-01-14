with source as (

    select * from {{ source('northwind', 'string') }}
)

select * from source