with source as (

    select * from {{ source('northwind', 'purchase_order') }}
)

select * from source