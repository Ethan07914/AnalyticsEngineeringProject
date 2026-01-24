with source as (
    select id as employee_id,
            company,
            last_name,
            first_name,
            email_address,
            job_title,
            business_phone,
            home_phone,
            mobile_phone,
            fax_number,
            address,
            city,
            state_province,
            zip_postal_code,
            country_region,
            web_page,
            notes,
            attachments,
            current_timestamp() as insertion_timestamp
    from {{ ref('stg_employee') }}),

unique_source as (
    select *,
           row_number() over(partition by employee_id) as row_number
            --if you wanted to store the same employee at a different time you could also partition by a datatime field in addition
           from source
           --Allows deduplication
)

select *
    except(row_number)
from unique_source 
    where row_number = 1