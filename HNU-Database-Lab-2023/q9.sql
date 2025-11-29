select count(*) as 在借图书数量,
       读者表.读者编号,
       姓名,
       工作单位
from 借阅表,
     读者表
where 归还日期 is null
group by 读者表.读者编号,
         姓名,
         工作单位
order by count(*) desc 