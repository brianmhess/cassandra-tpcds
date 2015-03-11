#!/bin/bash
TPCDS_DBNAME=tpcds

cqlsh -e "DROP KEYSPACE IF EXISTS $TPCDS_DBNAME";
cqlsh -e "CREATE KEYSPACE $TPCDS_DBNAME WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.store_sales"
cqlsh -e "create table $TPCDS_DBNAME.store_sales
(
  ss_sold_date_sk           int,
  ss_sold_time_sk           int,
  ss_item_sk                int,
  ss_customer_sk            int,
  ss_cdemo_sk               int,
  ss_hdemo_sk               int,
  ss_addr_sk                int,
  ss_store_sk               int,
  ss_promo_sk               int,
  ss_ticket_number          int,
  ss_quantity               int,
  ss_wholesale_cost         double,
  ss_list_price             double,
  ss_sales_price            double,
  ss_ext_discount_amt       double,
  ss_ext_sales_price        double,
  ss_ext_wholesale_cost     double,
  ss_ext_list_price         double,
  ss_ext_tax                double,
  ss_coupon_amt             double,
  ss_net_paid               double,
  ss_net_paid_inc_tax       double,
  ss_net_profit             double,
  PRIMARY KEY ((ss_item_sk, ss_ticket_number))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.customer_demographics"
cqlsh -e "create table $TPCDS_DBNAME.customer_demographics
(
  cd_demo_sk                int,
  cd_gender                 text,
  cd_marital_status         text,
  cd_education_status       text,
  cd_purchase_estimate      int,
  cd_credit_rating          text,
  cd_dep_count              int,
  cd_dep_employed_count     int,
  cd_dep_college_count      int,
  PRIMARY KEY ((cd_demo_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.date_dim"
cqlsh -e "create table $TPCDS_DBNAME.date_dim
(
  d_date_sk                 int,
  d_date_id                 text,
  d_date                    text, -- YYYY-MM-DD format
  d_month_seq               int,
  d_week_seq                int,
  d_quarter_seq             int,
  d_year                    int,
  d_dow                     int,
  d_moy                     int,
  d_dom                     int,
  d_qoy                     int,
  d_fy_year                 int,
  d_fy_quarter_seq          int,
  d_fy_week_seq             int,
  d_day_name                text,
  d_quarter_name            text,
  d_holiday                 text,
  d_weekend                 text,
  d_following_holiday       text,
  d_first_dom               int,
  d_last_dom                int,
  d_same_day_ly             int,
  d_same_day_lq             int,
  d_current_day             text,
  d_current_week            text,
  d_current_month           text,
  d_current_quarter         text,
  d_current_year            text,
  PRIMARY KEY ((d_date_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.time_dim"
cqlsh -e "create table $TPCDS_DBNAME.time_dim
(
  t_time_sk                 int,
  t_time_id                 text,
  t_time                    int,
  t_hour                    int,
  t_minute                  int,
  t_second                  int,
  t_am_pm                   text,
  t_shift                   text,
  t_sub_shift               text,
  t_meal_time               text,
  PRIMARY KEY ((t_time_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.item"
cqlsh -e "create table $TPCDS_DBNAME.item
(
  i_item_sk                 int,
  i_item_id                 text,
  i_rec_start_date          text,
  i_rec_end_date            text,
  i_item_desc               text,
  i_current_price           double,
  i_wholesale_cost          double,
  i_brand_id                int,
  i_brand                   text,
  i_class_id                int,
  i_class                   text,
  i_category_id             int,
  i_category                text,
  i_manufact_id             int,
  i_manufact                text,
  i_size                    text,
  i_formulation             text,
  i_color                   text,
  i_units                   text,
  i_container               text,
  i_manager_id              int,
  i_product_name            text,
  PRIMARY KEY ((i_item_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.store"
cqlsh -e "create table $TPCDS_DBNAME.store
(
  s_store_sk                int,
  s_store_id                text,
  s_rec_start_date          text,
  s_rec_end_date            text,
  s_closed_date_sk          int,
  s_store_name              text,
  s_number_employees        int,
  s_floor_space             int,
  s_hours                   text,
  s_manager                 text,
  s_market_id               int,
  s_geography_class         text,
  s_market_desc             text,
  s_market_manager          text,
  s_division_id             int,
  s_division_name           text,
  s_company_id              int,
  s_company_name            text,
  s_street_number           text,
  s_street_name             text,
  s_street_type             text,
  s_suite_number            text,
  s_city                    text,
  s_county                  text,
  s_state                   text,
  s_zip                     text,
  s_country                 text,
  s_gmt_offset              double,
  s_tax_precentage          double,
  PRIMARY KEY ((s_store_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.customer"
cqlsh -e "create table $TPCDS_DBNAME.customer
(
  c_customer_sk             int,
  c_customer_id             text,
  c_current_cdemo_sk        int,
  c_current_hdemo_sk        int,
  c_current_addr_sk         int,
  c_first_shipto_date_sk    int,
  c_first_sales_date_sk     int,
  c_salutation              text,
  c_first_name              text,
  c_last_name               text,
  c_preferred_cust_flag     text,
  c_birth_day               int,
  c_birth_month             int,
  c_birth_year              int,
  c_birth_country           text,
  c_login                   text,
  c_email_address           text,
  c_last_review_date        text,
  PRIMARY KEY ((c_customer_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.promotion"
cqlsh -e "create table $TPCDS_DBNAME.promotion
(
  p_promo_sk                int,
  p_promo_id                text,
  p_start_date_sk           int,
  p_end_date_sk             int,
  p_item_sk                 int,
  p_cost                    double,
  p_response_target         int,
  p_promo_name              text,
  p_channel_dmail           text,
  p_channel_email           text,
  p_channel_catalog         text,
  p_channel_tv              text,
  p_channel_radio           text,
  p_channel_press           text,
  p_channel_event           text,
  p_channel_demo            text,
  p_channel_details         text,
  p_purpose                 text,
  p_discount_active         text,
  PRIMARY KEY ((p_promo_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.household_demographics"
cqlsh -e "create table $TPCDS_DBNAME.household_demographics
(
  hd_demo_sk                int,
  hd_income_band_sk         int,
  hd_buy_potential          text,
  hd_dep_count              int,
  hd_vehicle_count          int,
  PRIMARY KEY ((hd_demo_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.customer_address"
cqlsh -e "create table $TPCDS_DBNAME.customer_address
(
  ca_address_sk             int,
  ca_address_id             text,
  ca_street_number          text,
  ca_street_name            text,
  ca_street_type            text,
  ca_suite_number           text,
  ca_city                   text,
  ca_county                 text,
  ca_state                  text,
  ca_zip                    text,
  ca_country                text,
  ca_gmt_offset             int,
  ca_location_type          text,
  PRIMARY KEY ((ca_address_sk))
);"

cqlsh -e "DROP TABLE IF EXISTS $TPCDS_DBNAME.inventory"
cqlsh -e "create table $TPCDS_DBNAME.inventory
(
  inv_date_sk               int,
  inv_item_sk               int,
  inv_warehouse_sk          int,
  inv_quantity_on_hand      int,
  PRIMARY KEY ((inv_date_sk, inv_item_sk, inv_warehouse_sk))
);"


