select 图书编号, 出版时间, 入库时间, 图书名称
from 图书表
where 入库时间 >= 2015
  and 入库时间 <= 2016
order by 入库时间 desc 