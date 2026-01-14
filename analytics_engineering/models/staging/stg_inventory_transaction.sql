with source as (

    select * from {{ source('northwind', 'inventory_transaction') }}
)

select * from source