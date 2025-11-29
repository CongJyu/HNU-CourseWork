select 图书表.分类号, 分类名称, max(单价) as 最高价格, avg(单价) as 平均价格
from 图书表,
     图书分类表
group by 图书表.分类号, 分类名称
order by 最高价格 desc