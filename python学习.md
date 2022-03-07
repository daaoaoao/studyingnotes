# 创建虚拟环境

通过执行venv指令来创建

```pyth
python -m venv /path/to/new/virtual/environment
```

启动虚拟环境

```python
.\Scripts\activate
//退出虚拟环境
.\Scripts\deactivate
```

# 数据精度问题
python中的浮点数可能影响精度问题，因为浮点数运算快，精度不够
eg.2/3=0   2.0/3=0.66666666666666

```python
from decimal import getcontext,Decimal
getcontext().prec=1
print (Decimal(0.1)+Decimal(0.2)
```
从decimal 模块中导入getcontext 和Decimal。
将舍入精度设定为一位小数。decimal 模块将大部分的舍入和精度设置保存在默认的上
下文（context）中。本行代码将上下文的精度改成只保留一位小数。
对两个小数（一个值为0.1，一个值为0.2）求和。
## 字符串
.upper（）；大写
.strip();去除末尾空格
## 内置函数
type（）
dir() 
细节查看，帮助记忆![运行图](https://img-blog.csdnimg.cn/2019080917551925.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxNTI4NjUw,size_16,color_FFFFFF,t_70)
help（）

# 数据学习
CSV 文件（简称为CSV）是指将数据列用逗号分隔的文件。文件的扩展名是.csv。
作制表符分隔值（tab-separated values，TSV）数据，有时也与CSV归为一类。TSV 与CSV 唯一的不同之处在于，数据列之间的分隔符是制表符（tab），而不是逗号。文件的扩展名通常是.tsv，但有时也用.csv 作为扩展名。从本质上来看，.tsv 文件与.csv 文件在Python 中的作用是相同的。如果文件的扩展名是.tsv，那么里面包含的很可能是TSV 数据。如果文件的
扩展名是.csv，那么里面包含的可能是CSV 数据，但也可能是TSV 数据。
一定要打开文件查看一下，这样你可以在导入数据之前就明确所处理的数据
类型。
