select 读者表.读者编号, 姓名, sum(单价) 在借图书总价
from 读者表,
     借阅表,
     图书表,
     图书分类表
where 归还日期 is null
  and 图书表.图书编号 = 借阅表.图书编号
  and 借阅表.读者编号 = 读者表.读者编号
group by 读者编号, 姓名
having 在借图书总价 >= 200