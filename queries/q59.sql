-- start query 1 in stream 0 using template query59.tpl
select
  s_store_name1,
  s_store_id1,
  d_week_seq1,
  sun_sales1 / sun_sales2,
  mon_sales1 / mon_sales2,
  tue_sales1 / tue_sales2,
  wed_sales1 / wed_sales2,
  thu_sales1 / thu_sales2,
  fri_sales1 / fri_sales2,
  sat_sales1 / sat_sales2
from
  (select
    s_store_name s_store_name1,
    wss.d_week_seq d_week_seq1,
    s_store_id s_store_id1,
    sun_sales sun_sales1,
    mon_sales mon_sales1,
    tue_sales tue_sales1,
    wed_sales wed_sales1,
    thu_sales thu_sales1,
    fri_sales fri_sales1,
    sat_sales sat_sales1
  from
    (select
      /*+ MAPJOIN(date_dim) */
      d_week_seq,
      ss_store_sk,
      sum(case when(d_day_name = 'Sunday') then ss_sales_price else null end) sun_sales,
      sum(case when(d_day_name = 'Monday') then ss_sales_price else null end) mon_sales,
      sum(case when(d_day_name = 'Tuesday') then ss_sales_price else null end) tue_sales,
      sum(case when(d_day_name = 'Wednesday') then ss_sales_price else null end) wed_sales,
      sum(case when(d_day_name = 'Thursday') then ss_sales_price else null end) thu_sales,
      sum(case when(d_day_name = 'Friday') then ss_sales_price else null end) fri_sales,
      sum(case when(d_day_name = 'Saturday') then ss_sales_price else null end) sat_sales
    from
      store_sales
      join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
    where 
      -- ss_date between '1998-10-01' and '1999-09-30'
      ss_sold_date_sk between 2451088 and 2451452
    group by
      d_week_seq,
      ss_store_sk
    ) wss
    join store on (wss.ss_store_sk = store.s_store_sk)
    join date_dim d on (wss.d_week_seq = d.d_week_seq)
  where
    d_month_seq between 1185 and 1185 + 11
  ) y
  join 
  (select
    s_store_name s_store_name2,
    wss.d_week_seq d_week_seq2,
    s_store_id s_store_id2,
    sun_sales sun_sales2,
    mon_sales mon_sales2,
    tue_sales tue_sales2,
    wed_sales wed_sales2,
    thu_sales thu_sales2,
    fri_sales fri_sales2,
    sat_sales sat_sales2
  from
    (select
      /*+ MAPJOIN(date_dim) */
      d_week_seq,
      ss_store_sk,
      sum(case when(d_day_name = 'Sunday') then ss_sales_price else null end) sun_sales,
      sum(case when(d_day_name = 'Monday') then ss_sales_price else null end) mon_sales,
      sum(case when(d_day_name = 'Tuesday') then ss_sales_price else null end) tue_sales,
      sum(case when(d_day_name = 'Wednesday') then ss_sales_price else null end) wed_sales,
      sum(case when(d_day_name = 'Thursday') then ss_sales_price else null end) thu_sales,
      sum(case when(d_day_name = 'Friday') then ss_sales_price else null end) fri_sales,
      sum(case when(d_day_name = 'Saturday') then ss_sales_price else null end) sat_sales
    from
      store_sales
      join date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
    where 
      -- ss_date between '1999-10-01' and '2000-09-30'
      ss_sold_date_sk between 2451088 and 2451452
    group by
      d_week_seq,
      ss_store_sk
    ) wss
    join store on (wss.ss_store_sk = store.s_store_sk)
    join date_dim d on (wss.d_week_seq = d.d_week_seq)
  where
    d_month_seq between 1185 + 12 and 1185 + 23
  ) x
  on (y.s_store_id1 = x.s_store_id2)
where
  d_week_seq1 = d_week_seq2 - 52
order by
  s_store_name1,
  s_store_id1,
  d_week_seq1
limit 100;
-- end query 1 in stream 0 using template query59.tpl
exit;
