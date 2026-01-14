with source as (

    select * from {{ source('northwind', 'supplier') }}
)

select * from source