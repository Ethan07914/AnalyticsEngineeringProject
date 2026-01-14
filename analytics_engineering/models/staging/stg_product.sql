with source as (

    select * from {{ source('northwind', 'product') }}
)

select * from source