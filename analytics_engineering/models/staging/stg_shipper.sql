with source as (

    select * from {{ source('northwind', 'shipper') }}
)

select * from source