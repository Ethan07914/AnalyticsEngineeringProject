with source as (

    select * from {{ source('northwind', 'order') }}
)

select * from source