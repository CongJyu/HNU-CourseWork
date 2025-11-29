select 出版社名称, 分类名称, avg(单价) as 平均价格
from 出版社表,
     图书表,
     图书分类表
group by 分类名称, 出版社名称