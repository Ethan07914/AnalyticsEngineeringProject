with source as (

    select * from {{ source('northwind', 'purchase_order_detail') }}
)

select * from source