OUTDIR=out
TPCDS_ROOT=../tpcds-kit
TPCDS_SCALE_FACTOR=1

LIST = 1 2 3 4 5 6 7 8 9 10
LISTLEN = 10

dirs:
	- mkdir out

datatargets = $(addprefix data., $(LIST))
data: $(datatargets) dirs

$(datatargets): data.%:
	${TPCDS_ROOT}/tools/dsdgen -SCALE ${TPCDS_SCALE_FACTOR} -DISTRIBUTIONS ${TPCDS_ROOT}/tools/tpcds.idx -TERMINATE N -DIR ${OUTDIR} -PARALLEL ${LISTLEN} -CHILD $*

ddl: cass-create-tables.sh
	./cass-create-tables.sh

store_sales_targets = $(addprefix store_sales., $(LIST))
customer_demographics_targets = $(addprefix customer_demographics., $(LIST))
date_dim_targets = $(addprefix date_dim., $(LIST))
time_dim_targets = $(addprefix time_dim., $(LIST))
item_targets = $(addprefix item., $(LIST))
store_targets = $(addprefix store., $(LIST))
customer_targets = $(addprefix customer., $(LIST))
promotion_targets = $(addprefix promotion., $(LIST))
household_demographics_targets = $(addprefix household_demographics., $(LIST))
customer_address_targets = $(addprefix customer_address., $(LIST))
inventory_targets = $(addprefix inventory., $(LIST))

store_sales: $(store_sales_targets)

$(store_sales_targets): store_sales.%:
	if [ -f ${OUTDIR}/store_sales_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.store_sales(ss_sold_date_sk,ss_sold_time_sk,ss_item_sk,ss_customer_sk,ss_cdemo_sk,ss_hdemo_sk,ss_addr_sk,ss_store_sk,ss_promo_sk,ss_ticket_number,ss_quantity,ss_wholesale_cost,ss_list_price,ss_sales_price,ss_ext_discount_amt,ss_ext_sales_price,ss_ext_wholesale_cost,ss_ext_list_price,ss_ext_tax,ss_coupon_amt,ss_net_paid,ss_net_paid_inc_tax,ss_net_profit) FROM '${OUTDIR}/store_sales_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

customer_demographics: $(customer_demographics_targets)

$(customer_demographics_targets): customer_demographics.%:
	if [ -f ${OUTDIR}/customer_demographics_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.customer_demographics(cd_demo_sk,cd_gender,cd_marital_status,cd_education_status,cd_purchase_estimate,cd_credit_rating,cd_dep_count,cd_dep_employed_count,cd_dep_college_count) FROM '${OUTDIR}/customer_demographics_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

date_dim: $(date_dim_targets)

$(date_dim_targets): date_dim.%:
	if [ -f ${OUTDIR}/date_dim_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.date_dim(d_date_sk,d_date_id,d_date,d_month_seq,d_week_seq,d_quarter_seq,d_year,d_dow,d_moy,d_dom,d_qoy,d_fy_year,d_fy_quarter_seq,d_fy_week_seq,d_day_name,d_quarter_name,d_holiday,d_weekend,d_following_holiday,d_first_dom,d_last_dom,d_same_day_ly,d_same_day_lq,d_current_day,d_current_week,d_current_month,d_current_quarter,d_current_year) FROM '${OUTDIR}/date_dim_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

time_dim: $(time_dim_targets)

$(time_dim_targets): time_dim.%:
	if [ -f ${OUTDIR}/time_dim_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.time_dim(t_time_sk,t_time_id,t_time,t_hour,t_minute,t_second,t_am_pm,t_shift,t_sub_shift,t_meal_time) FROM '${OUTDIR}/time_dim_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

item: $(item_targets)

$(item_targets): item.%:
	if [ -f ${OUTDIR}/item_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.item(i_item_sk,i_item_id,i_rec_start_date,i_rec_end_date,i_item_desc,i_current_price,i_wholesale_cost,i_brand_id,i_brand,i_class_id,i_class,i_category_id,i_category,i_manufact_id,i_manufact,i_size,i_formulation,i_color,i_units,i_container,i_manager_id,i_product_name) FROM '${OUTDIR}/item_$*_${LISTLEN}.dat' WITH DELIMITER='|'"; fi;

store: $(store_targets)

$(store_targets): store.%:
	if [ -f ${OUTDIR}/store_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.store(s_store_sk,s_store_id,s_rec_start_date,s_rec_end_date,s_closed_date_sk,s_store_name,s_number_employees,s_floor_space,s_hours,s_manager,s_market_id,s_geography_class,s_market_desc,s_market_manager,s_division_id,s_division_name,s_company_id,s_company_name,s_street_number,s_street_name,s_street_type,s_suite_number,s_city,s_county,s_state,s_zip,s_country,s_gmt_offset,s_tax_precentage) FROM '${OUTDIR}/store_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

customer: $(customer_targets)

$(customer_targets): customer.%:
	if [ -f ${OUTDIR}/customer_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.customer(c_customer_sk,c_customer_id,c_current_cdemo_sk,c_current_hdemo_sk,c_current_addr_sk,c_first_shipto_date_sk,c_first_sales_date_sk,c_salutation,c_first_name,c_last_name,c_preferred_cust_flag,c_birth_day,c_birth_month,c_birth_year,c_birth_country,c_login,c_email_address,c_last_review_date) FROM '${OUTDIR}/customer_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

promotion: $(promotion_targets)

$(promotion_targets): promotion.%:
	if [ -f ${OUTDIR}/promotion_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.promotion(p_promo_sk,p_promo_id,p_start_date_sk,p_end_date_sk,p_item_sk,p_cost,p_response_target,p_promo_name,p_channel_dmail,p_channel_email,p_channel_catalog,p_channel_tv,p_channel_radio,p_channel_press,p_channel_event,p_channel_demo,p_channel_details,p_purpose,p_discount_active) FROM '${OUTDIR}/promotion_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

household_demographics: $(household_demographics_targets)

$(household_demographics_targets): household_demographics.%:
	if [ -f ${OUTDIR}/household_demographics_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.household_demographics(hd_demo_sk,hd_income_band_sk,hd_buy_potential,hd_dep_count,hd_vehicle_count) FROM '${OUTDIR}/household_demographics_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

customer_address: $(customer_address_targets)

$(customer_address_targets): customer_address.%:
	if [ -f ${OUTDIR}/customer_address_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.customer_address(ca_address_sk,ca_address_id,ca_street_number,ca_street_name,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset,ca_location_type) FROM '${OUTDIR}/customer_address_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

inventory: $(inventory_targets)

$(inventory_targets): inventory.%:
	if [ -f ${OUTDIR}/inventory_$*_${LISTLEN}.dat ]; then cqlsh -e "COPY tpcds.inventory(inv_date_sk,inv_item_sk,inv_warehouse_sk,inv_quantity_on_hand) FROM '${OUTDIR}/customer_address_$*_${LISTLEN}.dat' WITH DELIMITER='|'"

load: store_sales customer_demographics date_dim time_dim item store customer promotion household_demographics customer_address inventory



clean:
	- rm ${OUTDIR}/*



