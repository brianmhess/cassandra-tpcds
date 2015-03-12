create keyspace if not exists tpcds WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

use tpcds;

drop table if exists call_center;

create table call_center(
cc_call_center_sk int
, cc_call_center_id text
, cc_rec_start_date text
, cc_rec_end_date text
, cc_closed_date_sk int
, cc_open_date_sk int
, cc_name text
, cc_class text
, cc_employees int
, cc_sq_ft int
, cc_hours text
, cc_manager text
, cc_mkt_id int
, cc_mkt_class text
, cc_mkt_desc text
, cc_market_manager text
, cc_division int
, cc_division_name text
, cc_company int
, cc_company_name text
, cc_street_number text
, cc_street_name text
, cc_street_type text
, cc_suite_number text
, cc_city text
, cc_county text
, cc_state text
, cc_zip text
, cc_country text
, cc_gmt_offset double
, cc_tax_percentage double
, PRIMARY KEY ((cc_call_center_sk))
);

drop table if exists catalog_page;

create table catalog_page(
cp_catalog_page_sk int
, cp_catalog_page_id text
, cp_start_date_sk int
, cp_end_date_sk int
, cp_department text
, cp_catalog_number int
, cp_catalog_page_number int
, cp_description text
, cp_type text
, PRIMARY KEY ((cp_catalog_page_sk))
);

drop table if exists catalog_returns;

create table catalog_returns
(
cr_returned_date_sk int,
cr_returned_time_sk int,
cr_item_sk int,
cr_refunded_customer_sk int,
cr_refunded_cdemo_sk int,
cr_refunded_hdemo_sk int,
cr_refunded_addr_sk int,
cr_returning_customer_sk int,
cr_returning_cdemo_sk int,
cr_returning_hdemo_sk int,
cr_returning_addr_sk int,
cr_call_center_sk int,
cr_catalog_page_sk int,
cr_ship_mode_sk int,
cr_warehouse_sk int,
cr_reason_sk int,
cr_order_number int,
cr_return_quantity int,
cr_return_amount double,
cr_return_tax double,
cr_return_amt_inc_tax double,
cr_fee double,
cr_return_ship_cost double,
cr_refunded_cash double,
cr_reversed_charge double,
cr_store_credit double,
cr_net_loss double
, PRIMARY KEY ((cr_item_sk, cr_order_number))
);

drop table if exists catalog_sales;

create table catalog_sales
(
cs_sold_date_sk int,
cs_sold_time_sk int,
cs_ship_date_sk int,
cs_bill_customer_sk int,
cs_bill_cdemo_sk int,
cs_bill_hdemo_sk int,
cs_bill_addr_sk int,
cs_ship_customer_sk int,
cs_ship_cdemo_sk int,
cs_ship_hdemo_sk int,
cs_ship_addr_sk int,
cs_call_center_sk int,
cs_catalog_page_sk int,
cs_ship_mode_sk int,
cs_warehouse_sk int,
cs_item_sk int,
cs_promo_sk int,
cs_order_number int,
cs_quantity int,
cs_wholesale_cost double,
cs_list_price double,
cs_sales_price double,
cs_ext_discount_amt double,
cs_ext_sales_price double,
cs_ext_wholesale_cost double,
cs_ext_list_price double,
cs_ext_tax double,
cs_coupon_amt double,
cs_ext_ship_cost double,
cs_net_paid double,
cs_net_paid_inc_tax double,
cs_net_paid_inc_ship double,
cs_net_paid_inc_ship_tax double,
cs_net_profit double
, PRIMARY KEY ((cs_item_sk, cs_order_number))
);

drop table if exists customer_address;

create table customer_address
(
ca_address_sk int,
ca_address_id text,
ca_street_number text,
ca_street_name text,
ca_street_type text,
ca_suite_number text,
ca_city text,
ca_county text,
ca_state text,
ca_zip text,
ca_country text,
ca_gmt_offset double,
ca_location_type text
, PRIMARY KEY ((ca_address_sk))
);

drop table if exists customer_demographics;

create table customer_demographics
(
cd_demo_sk int,
cd_gender text,
cd_marital_status text,
cd_education_status text,
cd_purchase_estimate int,
cd_credit_rating text,
cd_dep_count int,
cd_dep_employed_count int,
cd_dep_college_count int
, PRIMARY KEY ((cd_demo_sk))
);

drop table if exists customer;

create table customer
(
c_customer_sk int,
c_customer_id text,
c_current_cdemo_sk int,
c_current_hdemo_sk int,
c_current_addr_sk int,
c_first_shipto_date_sk int,
c_first_sales_date_sk int,
c_salutation text,
c_first_name text,
c_last_name text,
c_preferred_cust_flag text,
c_birth_day int,
c_birth_month int,
c_birth_year int,
c_birth_country text,
c_login text,
c_email_address text,
c_last_review_date text
, PRIMARY KEY ((c_customer_sk))
);

drop table if exists date_dim;

create table date_dim
(
d_date_sk int,
d_date_id text,
d_date text,
d_month_seq int,
d_week_seq int,
d_quarter_seq int,
d_year int,
d_dow int,
d_moy int,
d_dom int,
d_qoy int,
d_fy_year int,
d_fy_quarter_seq int,
d_fy_week_seq int,
d_day_name text,
d_quarter_name text,
d_holiday text,
d_weekend text,
d_following_holiday text,
d_first_dom int,
d_last_dom int,
d_same_day_ly int,
d_same_day_lq int,
d_current_day text,
d_current_week text,
d_current_month text,
d_current_quarter text,
d_current_year text
, PRIMARY KEY ((d_date_sk))
);

drop table if exists household_demographics;

create table household_demographics
(
hd_demo_sk int,
hd_income_band_sk int,
hd_buy_potential text,
hd_dep_count int,
hd_vehicle_count int
, PRIMARY KEY ((hd_demo_sk))
);

drop table if exists income_band;

create table income_band(
ib_income_band_sk int
, ib_lower_bound int
, ib_upper_bound int
, PRIMARY KEY ((ib_income_band_sk))
);

drop table if exists inventory;

create table inventory
(
inv_date_sk int,
inv_item_sk int,
inv_warehouse_sk int,
inv_quantity_on_hand int
, PRIMARY KEY ((inv_date_sk, inv_item_sk))
);

drop table if exists item;

create table item
(
i_item_sk int,
i_item_id text,
i_rec_start_date text,
i_rec_end_date text,
i_item_desc text,
i_current_price double,
i_wholesale_cost double,
i_brand_id int,
i_brand text,
i_class_id int,
i_class text,
i_category_id int,
i_category text,
i_manufact_id int,
i_manufact text,
i_size text,
i_formulation text,
i_color text,
i_units text,
i_container text,
i_manager_id int,
i_product_name text
, PRIMARY KEY ((i_item_sk))
);

drop table if exists promotion;

create table promotion
(
p_promo_sk int,
p_promo_id text,
p_start_date_sk int,
p_end_date_sk int,
p_item_sk int,
p_cost double,
p_response_target int,
p_promo_name text,
p_channel_dmail text,
p_channel_email text,
p_channel_catalog text,
p_channel_tv text,
p_channel_radio text,
p_channel_press text,
p_channel_event text,
p_channel_demo text,
p_channel_details text,
p_purpose text,
p_discount_active text
, PRIMARY KEY ((p_promo_sk))
);

drop table if exists reason;

create table reason(
r_reason_sk int
, r_reason_id text
, r_reason_desc text
, PRIMARY KEY ((r_reason_sk))
);

drop table if exists ship_mode;

create table ship_mode(
sm_ship_mode_sk int
, sm_ship_mode_id text
, sm_type text
, sm_code text
, sm_carrier text
, sm_contract text
, PRIMARY KEY ((sm_ship_mode_sk))
);

drop table if exists store_returns;

create table store_returns
(
sr_returned_date_sk int,
sr_return_time_sk int,
sr_item_sk int,
sr_customer_sk int,
sr_cdemo_sk int,
sr_hdemo_sk int,
sr_addr_sk int,
sr_store_sk int,
sr_reason_sk int,
sr_ticket_number int,
sr_return_quantity int,
sr_return_amt double,
sr_return_tax double,
sr_return_amt_inc_tax double,
sr_fee double,
sr_return_ship_cost double,
sr_refunded_cash double,
sr_reversed_charge double,
sr_store_credit double,
sr_net_loss double
, PRIMARY KEY ((sr_item_sk, sr_ticket_number))
);

drop table if exists store_sales;

create table store_sales
(
ss_sold_date_sk int,
ss_sold_time_sk int,
ss_item_sk int,
ss_customer_sk int,
ss_cdemo_sk int,
ss_hdemo_sk int,
ss_addr_sk int,
ss_store_sk int,
ss_promo_sk int,
ss_ticket_number int,
ss_quantity int,
ss_wholesale_cost double,
ss_list_price double,
ss_sales_price double,
ss_ext_discount_amt double,
ss_ext_sales_price double,
ss_ext_wholesale_cost double,
ss_ext_list_price double,
ss_ext_tax double,
ss_coupon_amt double,
ss_net_paid double,
ss_net_paid_inc_tax double,
ss_net_profit double
, PRIMARY KEY ((ss_item_sk, ss_ticket_number))
);

drop table if exists store;

create table store
(
s_store_sk int,
s_store_id text,
s_rec_start_date text,
s_rec_end_date text,
s_closed_date_sk int,
s_store_name text,
s_number_employees int,
s_floor_space int,
s_hours text,
s_manager text,
s_market_id int,
s_geography_class text,
s_market_desc text,
s_market_manager text,
s_division_id int,
s_division_name text,
s_company_id int,
s_company_name text,
s_street_number text,
s_street_name text,
s_street_type text,
s_suite_number text,
s_city text,
s_county text,
s_state text,
s_zip text,
s_country text,
s_gmt_offset double,
s_tax_precentage double
, PRIMARY KEY ((s_store_sk))
);

drop table if exists time_dim;

create table time_dim
(
t_time_sk int,
t_time_id text,
t_time int,
t_hour int,
t_minute int,
t_second int,
t_am_pm text,
t_shift text,
t_sub_shift text,
t_meal_time text
, PRIMARY KEY ((t_time_sk))
);

drop table if exists warehouse;

create table warehouse(
w_warehouse_sk int
, w_warehouse_id text
, w_warehouse_name text
, w_warehouse_sq_ft int
, w_street_number text
, w_street_name text
, w_street_type text
, w_suite_number text
, w_city text
, w_county text
, w_state text
, w_zip text
, w_country text
, w_gmt_offset double
, PRIMARY KEY ((w_warehouse_sk))
);

drop table if exists web_page;

create table web_page(
wp_web_page_sk int
, wp_web_page_id text
, wp_rec_start_date text
, wp_rec_end_date text
, wp_creation_date_sk int
, wp_access_date_sk int
, wp_autogen_flag text
, wp_customer_sk int
, wp_url text
, wp_type text
, wp_char_count int
, wp_link_count int
, wp_image_count int
, wp_max_ad_count int
, PRIMARY KEY ((wp_web_page_sk))
);

drop table if exists web_returns;

create table web_returns
(
wr_returned_date_sk int,
wr_returned_time_sk int,
wr_item_sk int,
wr_refunded_customer_sk int,
wr_refunded_cdemo_sk int,
wr_refunded_hdemo_sk int,
wr_refunded_addr_sk int,
wr_returning_customer_sk int,
wr_returning_cdemo_sk int,
wr_returning_hdemo_sk int,
wr_returning_addr_sk int,
wr_web_page_sk int,
wr_reason_sk int,
wr_order_number int,
wr_return_quantity int,
wr_return_amt double,
wr_return_tax double,
wr_return_amt_inc_tax double,
wr_fee double,
wr_return_ship_cost double,
wr_refunded_cash double,
wr_reversed_charge double,
wr_account_credit double,
wr_net_loss double
, PRIMARY KEY ((wr_order_number, wr_item_sk))
);

drop table if exists web_sales;

create table web_sales
(
ws_sold_date_sk int,
ws_sold_time_sk int,
ws_ship_date_sk int,
ws_item_sk int,
ws_bill_customer_sk int,
ws_bill_cdemo_sk int,
ws_bill_hdemo_sk int,
ws_bill_addr_sk int,
ws_ship_customer_sk int,
ws_ship_cdemo_sk int,
ws_ship_hdemo_sk int,
ws_ship_addr_sk int,
ws_web_page_sk int,
ws_web_site_sk int,
ws_ship_mode_sk int,
ws_warehouse_sk int,
ws_promo_sk int,
ws_order_number int,
ws_quantity int,
ws_wholesale_cost double,
ws_list_price double,
ws_sales_price double,
ws_ext_discount_amt double,
ws_ext_sales_price double,
ws_ext_wholesale_cost double,
ws_ext_list_price double,
ws_ext_tax double,
ws_coupon_amt double,
ws_ext_ship_cost double,
ws_net_paid double,
ws_net_paid_inc_tax double,
ws_net_paid_inc_ship double,
ws_net_paid_inc_ship_tax double,
ws_net_profit double
, PRIMARY KEY ((ws_item_sk, ws_order_number))
);

drop table if exists web_site;

create table web_site
(
web_site_sk int,
web_site_id text,
web_rec_start_date text,
web_rec_end_date text,
web_name text,
web_open_date_sk int,
web_close_date_sk int,
web_class text,
web_manager text,
web_mkt_id int,
web_mkt_class text,
web_mkt_desc text,
web_market_manager text,
web_company_id int,
web_company_name text,
web_street_number text,
web_street_name text,
web_street_type text,
web_suite_number text,
web_city text,
web_county text,
web_state text,
web_zip text,
web_country text,
web_gmt_offset double,
web_tax_percentage double
, PRIMARY KEY ((web_site_sk))
);
