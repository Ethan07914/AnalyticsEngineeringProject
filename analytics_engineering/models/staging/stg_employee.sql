with source as (

    select * from {{ source('northwind', 'employee') }}
)

select * from source