with source as (

    select * from {{ source('northwind', 'inventory_transaction_type') }}
)

select * from source