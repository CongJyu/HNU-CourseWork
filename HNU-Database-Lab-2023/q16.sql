select distinct 读者表.读者编号, 姓名, 工作单位
from (select 图书表.图书编号
      from 图书表,
           借阅表,
           读者表
      where 姓名 = '张小娟'
        and 图书表.图书编号 = 借阅表.图书编号) 张小娟借过的书,
     读者表,
     借阅表
where 借阅表.图书编号 in (张小娟借过的书.图书编号)
