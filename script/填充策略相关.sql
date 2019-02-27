select count( distinct request_id,location ) from  gen.gen_yx_show_log_det_hour where dt = "2019-01-07" and  ctr_strategy_type like "%diversity_group_filer_exp_0104%" and status = '3';

select location,  count(*) from (select distinct request_id,location from  gen.gen_yx_show_log_det_hour where dt = "2019-01-07" and  ctr_strategy_type like "%diversity_group_filer_exp_0104%" and status = '0')a group by a.location;


select sum(winprc),',',h  from gen.gen_yx_cost_log_det_hour where adplan_id  = '160177'  and dt = "2019-01-18"  group by h order by h;


select sum(winprc),',',h,substring(from_unixtime(request_time,'mm'),0,1)  from gen.gen_yx_cost_log_det_hour where adplan_id  = '160177'  and dt = "2019-01-05"  group by h,substring(from_unixtime(request_time,'mm'),0,1) ;


select count( distinct request_id,location),status from  gen.gen_yx_show_log_det_hour where dt >= "2019-01-05" and dt <= "2019-01-08" and  ctr_strategy_type like "%diversity_group_filer_exp%" group by status;



select count(*) 
from 
(select 
    request_id,location 
    from  gen.gen_yx_click_log_det_hour 
    where dt = "2019-01-04" and  ctr_strategy_type like "%diversity_compensation_20_0104%" and status = '0'
)a 


select count(*) 
from 
(select 
    distinct request_id,location 
    from  gen.gen_yx_click_log_det_hour 
    where dt = "2019-01-05" and  ctr_strategy_type like "%diversity_compensation_20_0104%" and status = '0'
)a 

select count(*) 
from 
(select 
    distinct request_id,location 
    from  gen.gen_yx_click_log_det_hour 
    where dt = '2019-01-05' and  ctr_strategy_type like '%diversity_group_filer_base0104%' and status = '0'
)a 
inner join
(select 
    distinct request_id,location 
    from  gen.gen_yx_show_log_det_hour 
    where dt = '2019-01-05' and  ctr_strategy_type like '%diversity_group_filer_base0104%' and status = '0'
)b
on a.request_id = b.request_id and a.location = b.location