OUTDIR=out
TPCDS_ROOT=../tpcds-kit
# TPCDS_SCALE_FACTOR:
#     1 is for development
#     The official scale factors are: 100, 300, 1000, 3000,
#                                     10000, 30000, 100000
#     These represent numbers of GB (100 = 100GB)
TPCDS_SCALE_FACTOR=1

LIST = 1 2 3 4 5 6 7 8 9 10
LISTLEN = 10

dirs:
	- mkdir out
	- mkdir build

datatargets = $(addprefix data., $(LIST))
data: $(datatargets) dirs

$(datatargets): data.%:
	${TPCDS_ROOT}/tools/dsdgen -SCALE ${TPCDS_SCALE_FACTOR} -DISTRIBUTIONS ${TPCDS_ROOT}/tools/tpcds.idx -TERMINATE N -DIR ${OUTDIR} -PARALLEL ${LISTLEN} -CHILD $*

ddl: cass-create-tables.sh
	cqlsh -f alltables.sql

compile: dirs DelimParser DelimLoad

DelimParser: DelimParser.java
	javac -d build -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" DelimParser.java

DelimLoad: DelimLoad.java
	javac -d build -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" DelimLoad.java

clean:
	- rm ${OUTDIR}/*


loadall: call_center catalog_page catalog_returns catalog_sales customer_address customer_demographics customer date_dim household_demographics income_band inventory item promotion reason ship_mode store_returns store_sales store time_dim warehouse web_page web_returns web_sales web_site


call_center_targets = $(addprefix call_center., $(LIST))

call_center: $(call_center_targets)

$(call_center_targets): call_center.%:
	if [ -f ${OUTDIR}/call_center_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/call_center_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.call_center(cc_call_center_sk int,cc_call_center_id text,cc_rec_start_date text,cc_rec_end_date text,cc_closed_date_sk int,cc_open_date_sk int,cc_name text,cc_class text,cc_employees int,cc_sq_ft int,cc_hours text,cc_manager text,cc_mkt_id int,cc_mkt_class text,cc_mkt_desc text,cc_market_manager text,cc_division int,cc_division_name text,cc_company int,cc_company_name text,cc_street_number text,cc_street_name text,cc_street_type text,cc_suite_number text,cc_city text,cc_county text,cc_state text,cc_zip text,cc_country text,cc_gmt_offset double,cc_tax_percentage double)"; fi;



catalog_page_targets = $(addprefix catalog_page., $(LIST))

catalog_page: $(catalog_page_targets)

$(catalog_page_targets): catalog_page.%:
	if [ -f ${OUTDIR}/catalog_page_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/catalog_page_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.catalog_page(cp_catalog_page_sk int,cp_catalog_page_id text,cp_start_date_sk int,cp_end_date_sk int,cp_department text,cp_catalog_number int,cp_catalog_page_number int,cp_description text,cp_type text)"; fi;



catalog_returns_targets = $(addprefix catalog_returns., $(LIST))

catalog_returns: $(catalog_returns_targets)

$(catalog_returns_targets): catalog_returns.%:
	if [ -f ${OUTDIR}/catalog_returns_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/catalog_returns_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.catalog_returns(cr_returned_date_sk int,cr_returned_time_sk int,cr_item_sk int,cr_refunded_customer_sk int,cr_refunded_cdemo_sk int,cr_refunded_hdemo_sk int,cr_refunded_addr_sk int,cr_returning_customer_sk int,cr_returning_cdemo_sk int,cr_returning_hdemo_sk int,cr_returning_addr_sk int,cr_call_center_sk int,cr_catalog_page_sk int,cr_ship_mode_sk int,cr_warehouse_sk int,cr_reason_sk int,cr_order_number int,cr_return_quantity int,cr_return_amount double,cr_return_tax double,cr_return_amt_inc_tax double,cr_fee double,cr_return_ship_cost double,cr_refunded_cash double,cr_reversed_charge double,cr_store_credit double,cr_net_loss double)"; fi;



catalog_sales_targets = $(addprefix catalog_sales., $(LIST))

catalog_sales: $(catalog_sales_targets)

$(catalog_sales_targets): catalog_sales.%:
	if [ -f ${OUTDIR}/catalog_sales_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/catalog_sales_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.catalog_sales(cs_sold_date_sk int,cs_sold_time_sk int,cs_ship_date_sk int,cs_bill_customer_sk int,cs_bill_cdemo_sk int,cs_bill_hdemo_sk int,cs_bill_addr_sk int,cs_ship_customer_sk int,cs_ship_cdemo_sk int,cs_ship_hdemo_sk int,cs_ship_addr_sk int,cs_call_center_sk int,cs_catalog_page_sk int,cs_ship_mode_sk int,cs_warehouse_sk int,cs_item_sk int,cs_promo_sk int,cs_order_number int,cs_quantity int,cs_wholesale_cost double,cs_list_price double,cs_sales_price double,cs_ext_discount_amt double,cs_ext_sales_price double,cs_ext_wholesale_cost double,cs_ext_list_price double,cs_ext_tax double,cs_coupon_amt double,cs_ext_ship_cost double,cs_net_paid double,cs_net_paid_inc_tax double,cs_net_paid_inc_ship double,cs_net_paid_inc_ship_tax double,cs_net_profit double)"; fi;



customer_address_targets = $(addprefix customer_address., $(LIST))

customer_address: $(customer_address_targets)

$(customer_address_targets): customer_address.%:
	if [ -f ${OUTDIR}/customer_address_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/customer_address_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.customer_address(ca_address_sk int,ca_address_id text,ca_street_number text,ca_street_name text,ca_street_type text,ca_suite_number text,ca_city text,ca_county text,ca_state text,ca_zip text,ca_country text,ca_gmt_offset double,ca_location_type text)"; fi;



customer_demographics_targets = $(addprefix customer_demographics., $(LIST))

customer_demographics: $(customer_demographics_targets)

$(customer_demographics_targets): customer_demographics.%:
	if [ -f ${OUTDIR}/customer_demographics_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/customer_demographics_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.customer_demographics(cd_demo_sk int,cd_gender text,cd_marital_status text,cd_education_status text,cd_purchase_estimate int,cd_credit_rating text,cd_dep_count int,cd_dep_employed_count int,cd_dep_college_count int)"; fi;



customer_targets = $(addprefix customer., $(LIST))

customer: $(customer_targets)

$(customer_targets): customer.%:
	if [ -f ${OUTDIR}/customer_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/customer_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.customer(c_customer_sk int,c_customer_id text,c_current_cdemo_sk int,c_current_hdemo_sk int,c_current_addr_sk int,c_first_shipto_date_sk int,c_first_sales_date_sk int,c_salutation text,c_first_name text,c_last_name text,c_preferred_cust_flag text,c_birth_day int,c_birth_month int,c_birth_year int,c_birth_country text,c_login text,c_email_address text,c_last_review_date text)"; fi;



date_dim_targets = $(addprefix date_dim., $(LIST))

date_dim: $(date_dim_targets)

$(date_dim_targets): date_dim.%:
	if [ -f ${OUTDIR}/date_dim_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/date_dim_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.date_dim(d_date_sk int,d_date_id text,d_date text,d_month_seq int,d_week_seq int,d_quarter_seq int,d_year int,d_dow int,d_moy int,d_dom int,d_qoy int,d_fy_year int,d_fy_quarter_seq int,d_fy_week_seq int,d_day_name text,d_quarter_name text,d_holiday text,d_weekend text,d_following_holiday text,d_first_dom int,d_last_dom int,d_same_day_ly int,d_same_day_lq int,d_current_day text,d_current_week text,d_current_month text,d_current_quarter text,d_current_year text)"; fi;



household_demographics_targets = $(addprefix household_demographics., $(LIST))

household_demographics: $(household_demographics_targets)

$(household_demographics_targets): household_demographics.%:
	if [ -f ${OUTDIR}/household_demographics_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/household_demographics_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.household_demographics(hd_demo_sk int,hd_income_band_sk int,hd_buy_potential text,hd_dep_count int,hd_vehicle_count int)"; fi;



income_band_targets = $(addprefix income_band., $(LIST))

income_band: $(income_band_targets)

$(income_band_targets): income_band.%:
	if [ -f ${OUTDIR}/income_band_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/income_band_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.income_band(ib_income_band_sk int,ib_lower_bound int,ib_upper_bound int)"; fi;



inventory_targets = $(addprefix inventory., $(LIST))

inventory: $(inventory_targets)

$(inventory_targets): inventory.%:
	if [ -f ${OUTDIR}/inventory_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/inventory_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.inventory(inv_date_sk int,inv_item_sk int,inv_warehouse_sk int,inv_quantity_on_hand int)"; fi;



item_targets = $(addprefix item., $(LIST))

item: $(item_targets)

$(item_targets): item.%:
	if [ -f ${OUTDIR}/item_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/item_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.item(i_item_sk int,i_item_id text,i_rec_start_date text,i_rec_end_date text,i_item_desc text,i_current_price double,i_wholesale_cost double,i_brand_id int,i_brand text,i_class_id int,i_class text,i_category_id int,i_category text,i_manufact_id int,i_manufact text,i_size text,i_formulation text,i_color text,i_units text,i_container text,i_manager_id int,i_product_name text)"; fi;



promotion_targets = $(addprefix promotion., $(LIST))

promotion: $(promotion_targets)

$(promotion_targets): promotion.%:
	if [ -f ${OUTDIR}/promotion_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/promotion_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.promotion(p_promo_sk int,p_promo_id text,p_start_date_sk int,p_end_date_sk int,p_item_sk int,p_cost double,p_response_target int,p_promo_name text,p_channel_dmail text,p_channel_email text,p_channel_catalog text,p_channel_tv text,p_channel_radio text,p_channel_press text,p_channel_event text,p_channel_demo text,p_channel_details text,p_purpose text,p_discount_active text)"; fi;



reason_targets = $(addprefix reason., $(LIST))

reason: $(reason_targets)

$(reason_targets): reason.%:
	if [ -f ${OUTDIR}/reason_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/reason_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.reason(r_reason_sk int,r_reason_id text,r_reason_desc text)"; fi;



ship_mode_targets = $(addprefix ship_mode., $(LIST))

ship_mode: $(ship_mode_targets)

$(ship_mode_targets): ship_mode.%:
	if [ -f ${OUTDIR}/ship_mode_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/ship_mode_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.ship_mode(sm_ship_mode_sk int,sm_ship_mode_id text,sm_type text,sm_code text,sm_carrier text,sm_contract text)"; fi;



store_returns_targets = $(addprefix store_returns., $(LIST))

store_returns: $(store_returns_targets)

$(store_returns_targets): store_returns.%:
	if [ -f ${OUTDIR}/store_returns_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/store_returns_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.store_returns(sr_returned_date_sk int,sr_return_time_sk int,sr_item_sk int,sr_customer_sk int,sr_cdemo_sk int,sr_hdemo_sk int,sr_addr_sk int,sr_store_sk int,sr_reason_sk int,sr_ticket_number int,sr_return_quantity int,sr_return_amt double,sr_return_tax double,sr_return_amt_inc_tax double,sr_fee double,sr_return_ship_cost double,sr_refunded_cash double,sr_reversed_charge double,sr_store_credit double,sr_net_loss double)"; fi;



store_sales_targets = $(addprefix store_sales., $(LIST))

store_sales: $(store_sales_targets)

$(store_sales_targets): store_sales.%:
	if [ -f ${OUTDIR}/store_sales_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/store_sales_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.store_sales(ss_sold_date_sk int,ss_sold_time_sk int,ss_item_sk int,ss_customer_sk int,ss_cdemo_sk int,ss_hdemo_sk int,ss_addr_sk int,ss_store_sk int,ss_promo_sk int,ss_ticket_number int,ss_quantity int,ss_wholesale_cost double,ss_list_price double,ss_sales_price double,ss_ext_discount_amt double,ss_ext_sales_price double,ss_ext_wholesale_cost double,ss_ext_list_price double,ss_ext_tax double,ss_coupon_amt double,ss_net_paid double,ss_net_paid_inc_tax double,ss_net_profit double)"; fi;



store_targets = $(addprefix store., $(LIST))

store: $(store_targets)

$(store_targets): store.%:
	if [ -f ${OUTDIR}/store_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/store_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.store(s_store_sk int,s_store_id text,s_rec_start_date text,s_rec_end_date text,s_closed_date_sk int,s_store_name text,s_number_employees int,s_floor_space int,s_hours text,s_manager text,s_market_id int,s_geography_class text,s_market_desc text,s_market_manager text,s_division_id int,s_division_name text,s_company_id int,s_company_name text,s_street_number text,s_street_name text,s_street_type text,s_suite_number text,s_city text,s_county text,s_state text,s_zip text,s_country text,s_gmt_offset double,s_tax_precentage double)"; fi;



time_dim_targets = $(addprefix time_dim., $(LIST))

time_dim: $(time_dim_targets)

$(time_dim_targets): time_dim.%:
	if [ -f ${OUTDIR}/time_dim_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/time_dim_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.time_dim(t_time_sk int,t_time_id text,t_time int,t_hour int,t_minute int,t_second int,t_am_pm text,t_shift text,t_sub_shift text,t_meal_time text)"; fi;



warehouse_targets = $(addprefix warehouse., $(LIST))

warehouse: $(warehouse_targets)

$(warehouse_targets): warehouse.%:
	if [ -f ${OUTDIR}/warehouse_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/warehouse_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.warehouse(w_warehouse_sk int,w_warehouse_id text,w_warehouse_name text,w_warehouse_sq_ft int,w_street_number text,w_street_name text,w_street_type text,w_suite_number text,w_city text,w_county text,w_state text,w_zip text,w_country text,w_gmt_offset double)"; fi;



web_page_targets = $(addprefix web_page., $(LIST))

web_page: $(web_page_targets)

$(web_page_targets): web_page.%:
	if [ -f ${OUTDIR}/web_page_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/web_page_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.web_page(wp_web_page_sk int,wp_web_page_id text,wp_rec_start_date text,wp_rec_end_date text,wp_creation_date_sk int,wp_access_date_sk int,wp_autogen_flag text,wp_customer_sk int,wp_url text,wp_type text,wp_char_count int,wp_link_count int,wp_image_count int,wp_max_ad_count int)"; fi;



web_returns_targets = $(addprefix web_returns., $(LIST))

web_returns: $(web_returns_targets)

$(web_returns_targets): web_returns.%:
	if [ -f ${OUTDIR}/web_returns_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/web_returns_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.web_returns(wr_returned_date_sk int,wr_returned_time_sk int,wr_item_sk int,wr_refunded_customer_sk int,wr_refunded_cdemo_sk int,wr_refunded_hdemo_sk int,wr_refunded_addr_sk int,wr_returning_customer_sk int,wr_returning_cdemo_sk int,wr_returning_hdemo_sk int,wr_returning_addr_sk int,wr_web_page_sk int,wr_reason_sk int,wr_order_number int,wr_return_quantity int,wr_return_amt double,wr_return_tax double,wr_return_amt_inc_tax double,wr_fee double,wr_return_ship_cost double,wr_refunded_cash double,wr_reversed_charge double,wr_account_credit double,wr_net_loss double)"; fi;



web_sales_targets = $(addprefix web_sales., $(LIST))

web_sales: $(web_sales_targets)

$(web_sales_targets): web_sales.%:
	if [ -f ${OUTDIR}/web_sales_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/web_sales_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.web_sales(ws_sold_date_sk int,ws_sold_time_sk int,ws_ship_date_sk int,ws_item_sk int,ws_bill_customer_sk int,ws_bill_cdemo_sk int,ws_bill_hdemo_sk int,ws_bill_addr_sk int,ws_ship_customer_sk int,ws_ship_cdemo_sk int,ws_ship_hdemo_sk int,ws_ship_addr_sk int,ws_web_page_sk int,ws_web_site_sk int,ws_ship_mode_sk int,ws_warehouse_sk int,ws_promo_sk int,ws_order_number int,ws_quantity int,ws_wholesale_cost double,ws_list_price double,ws_sales_price double,ws_ext_discount_amt double,ws_ext_sales_price double,ws_ext_wholesale_cost double,ws_ext_list_price double,ws_ext_tax double,ws_coupon_amt double,ws_ext_ship_cost double,ws_net_paid double,ws_net_paid_inc_tax double,ws_net_paid_inc_ship double,ws_net_paid_inc_ship_tax double,ws_net_profit double)"; fi;



web_site_targets = $(addprefix web_site., $(LIST))

web_site: $(web_site_targets)

$(web_site_targets): web_site.%:
	if [ -f ${OUTDIR}/web_site_$*_${LISTLEN}.dat ]; then java -cp "build:lib/cassandra-java-driver/*:lib/cassandra-java-driver/lib/*" com.datastax.loader.DelimLoad ${OUTDIR}/web_site_$*_${LISTLEN}.dat 10.109.180.2 "tpcds.web_site(web_site_sk int,web_site_id text,web_rec_start_date text,web_rec_end_date text,web_name text,web_open_date_sk int,web_close_date_sk int,web_class text,web_manager text,web_mkt_id int,web_mkt_class text,web_mkt_desc text,web_market_manager text,web_company_id int,web_company_name text,web_street_number text,web_street_name text,web_street_type text,web_suite_number text,web_city text,web_county text,web_state text,web_zip text,web_country text,web_gmt_offset double,web_tax_percentage double)"; fi;


