select 读者表.读者编号, 姓名, sum(单价) as 借书总价
from 读者表,
     借阅表,
     图书表
where 读者表.读者编号 = 借阅表.读者编号
group by 读者表.读者编号, 姓名
order by 借书总价 desc 