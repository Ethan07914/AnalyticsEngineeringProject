with source as (

    select * from {{ source('northwind', 'employee_privilege') }}
)

select * from source