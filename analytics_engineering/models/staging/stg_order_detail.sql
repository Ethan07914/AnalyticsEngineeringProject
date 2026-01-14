with source as (

    select * from {{ source('northwind', 'order_detail') }}
)

select * from source