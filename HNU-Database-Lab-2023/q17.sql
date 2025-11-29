select 读者表.读者编号, 读者表.姓名, 图书表.图书编号, 图书名称
from 读者表,
     借阅表,
     图书表,
     (select 读者表.读者编号, 姓名, count(*) as cnt
      from 读者表,
           借阅表
      where 归还日期 is null
      group by 读者表.读者编号, 姓名
      having cnt >= 3) 在借数量大于三
where 借阅表.读者编号 = 读者表.读者编号
  and 在借数量大于三.读者编号 = 借阅表.读者编号
  and 图书表.图书编号 = 借阅表.图书编号
  and 读者表.姓名 = 在借数量大于三.姓名
order by 读者编号, 借阅日期 desc
