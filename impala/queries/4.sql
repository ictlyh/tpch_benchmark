-- the query
insert overwrite table q4_order_priority_tmp 
select 
  distinct l_orderkey 
from 
  lineitem 
where 
  l_commitdate < l_receiptdate;
insert overwrite table q4_order_priority 
select o_orderpriority, cast(count(1) as int) as order_count 
from 
  orders o join q4_order_priority_tmp t 
  on 
o.o_orderkey = t.o_orderkey and o.o_orderdate >= '1993-07-01' and o.o_orderdate < '1993-10-01' 
group by o_orderpriority 
order by o_orderpriority
limit 2147483647;
