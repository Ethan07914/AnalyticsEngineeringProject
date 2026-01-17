{{ config(
    partition_by={
    "field": "order_date",
    "data_type": "date"
    }
)}}
--To select partition field think of what field you will be filtering on most often
--Partitions will help you speed up querying
--BigQuery uses columnar storage partitioning splits the column up so you only query the data in a certain partition meaning you query less data making it cheaper


with source as (select od.order_id,
        od.product_id,
        o.customer_id,
        o.employee_id,
        o.shipper_id,
        od.quantity,
        od.unit_price,
        od.discount,
        od.status_id,
        od.date_allocated,
        od.purchase_order_id,
        od.inventory_id,
        date(o.order_date) as order_date,
        o.shipped_date,
        o.paid_date,
       current_timestamp() as insertion_timestamp
        from {{ ref('stg_order') }} as o
        left join {{ ref('stg_order_detail') }} as od
        on o.id = od.order_id
        where od.order_id is not null), --We don't want any null values

unique_source as (
    select *,
            row_number() over(partition by customer_id, employee_id, order_id, product_id, shipper_id, purchase_order_id, shipper_id, order_date) as row_number
    from source --Row should be unique against all foreign keys
        )

select *
    except(row_number)
from unique_source
    where row_number = 1