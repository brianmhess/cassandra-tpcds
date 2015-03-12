
select  c_customer_id as customer_id
       ,concat(c_last_name, ', ', c_first_name) as customername
 from customer
     ,customer_address
     ,customer_demographics
     ,household_demographics
     ,income_band
     ,store_returns
 where ca_city	        =  'Hopewell'
   and customer.c_current_addr_sk = customer_address.ca_address_sk
   and ib_lower_bound   >=  32287
   and ib_upper_bound   <=  32287 + 50000
   and income_band.ib_income_band_sk = household_demographics.hd_income_band_sk
   and customer_demographics.cd_demo_sk = customer.c_current_cdemo_sk
   and household_demographics.hd_demo_sk = customer.c_current_hdemo_sk
   and store_returns.sr_cdemo_sk = customer_demographics.cd_demo_sk
 order by customer_id
 limit 100;


