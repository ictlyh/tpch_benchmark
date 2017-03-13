-- the query
insert overwrite table q1_pricing_summary_report 
select 
  l_returnflag, l_linestatus, sum(l_quantity), sum(l_extendedprice), sum(l_extendedprice*(1-l_discount)), sum(l_extendedprice*(1-l_discount)*(1+l_tax)), avg(l_quantity), avg(l_extendedprice), avg(l_discount), cast(count(1) as int)
from 
  lineitem 
where 
  l_shipdate<='1998-09-02' 
group by l_returnflag, l_linestatus 
order by l_returnflag, l_linestatus
limit 2147483647;
