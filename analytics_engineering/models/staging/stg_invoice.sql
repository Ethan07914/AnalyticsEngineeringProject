with source as (

    select * from {{ source('northwind', 'invoice') }}
)

select * from source