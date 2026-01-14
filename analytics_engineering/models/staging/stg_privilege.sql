with source as (

    select * from {{ source('northwind', 'privilege') }}
)

select * from source