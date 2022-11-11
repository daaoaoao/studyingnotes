# CNC测试



测试上次cf卡

大文件小文件

子程序的效率  1000遍

上传一个大文件的时间对比多个小文件上传速度

文件存储路径：

\\nas\nas\6 临时存放不定期清理\RuntimeTest\文件上传测试



## 命令

```
"G:\\workSpace_G\\CNCTest\\文件上传测试\Prog\\LD6911.nc"
"G:\\workSpace_G\\CNCTest\Prog\\FZ1994-001.NC"

{
    "Addr": "1",
    "AddrType": "R",
    "Bit": "0",
    "CNC": "CNC_1",
    "Command": "ReadPlc",
    "Timeout": "20"
}



{
    "CNC": "CNC_1",
    "CNCFile": "O1234",
    "CNCPath": "//M_CARD/",
    "Command": "SendFile",
    "LocalFile":"G:\\workSpace_G\\CNCTest\\TestTemp\\Prog\\fz1994",
    "Timeout": "200"
}


{
    "CNC": "CNC_1",
    "CNCFile": "O1234",
    "CNCPath": "//M_CARD/",
    "Command": "SendFile",
    "LocalFile":"G:\\workSpace_G\\CNCTest\Prog\\FZ1994-001",
    "Timeout": "200"
}

{
    "CNC": "CNC_1",
    "CNCFile": "O1234",
    "CNCPath": "//M_CARD/",
    "Command": "SendFile",
    "LocalFile":"G:\\workSpace_G\\CNCTest\\TestTemp\\Prog\\O1234.NC",
    "Timeout": "200"
}
"G:\\workSpace_G\\CNCTest\\TestTemp\\Prog\4m"


S210270.NC

{
    "CNC": "CNC_1",
    "CNCFile": "O1",
    "CNCPath": "//M_CARD/",
    "Command": "SendFile",
    "LocalFile":"G:\\workSpace_G\\CNCTest\\TestTemp\\Prog\\o12.NC",
    "Timeout": "200"
}

{
    "CNC": "CNC_1",
    "CNCFile": "M2.NC",
    "CNCPath": "//M_CARD/",
    "Command": "SendFile",
    "LocalFile":"G:\\CNCTestProg\\test2\\M2.NC",
    "Timeout": "200"
}
```



下载文件

```
{
    "CNC": "CNC_1",
    "CNCFile": "O1234",
    "CNCPath": "//M_CARD/",
    "Command": "ReadFile",
    "LocalFile": "G:\\O6666",
    "Timeout": "20"
}

{
    "CNC": "CNC_1",
    "CNCFile": "O1234",
    "CNCPath": "//M_CARD/",
    "Command": "ReadFile",
    "LocalFile": "G:\\O1234.NC",
    "Timeout": "20"
}
```



## 测试过程

官方文件传输工具发送时的接受窗口和发送窗口如下图

![image-20221101101212511](https://cdn.jsdelivr.net/gh/smartdoublej/note-img/抓包.png)



![image-20221101102130681](https://cdn.jsdelivr.net/gh/smartdoublej/note-img/接受窗口.png)



当使用cmm服务进行连接的传送文件的时候，如下图

开始传输时：

![image-20221101103214278](https://cdn.jsdelivr.net/gh/smartdoublej/note-img/cmm%E6%9C%8D%E5%8A%A1%E4%BC%A0%E9%80%81%E6%96%87%E4%BB%B6.png)



文件传输过程中出现

TCP Window Full  服务端向客户端发送的一种窗口警告，已经发送到数据接收端的极限



[TCP Window Update]：缓冲区已释放为所示的大小，因此请恢复传输。

 [Zero Window] ：客户端向服务端发送的一种窗口警告，告诉发送者你的接收窗口已满，暂时停止发送。

可能情况是

1. 接收端比发送端数据处理要慢，导致数据堆积。
2. 接收端控制了接收速度。

![image-20221101103523880](https://cdn.jsdelivr.net/gh/smartdoublej/note-img/tcp%20windows%20full.png)



再次出现接受窗口满，出现 堵塞，开始流量控制tcp窗口变小，拥塞避免

![image-20221101104543501](https://cdn.jsdelivr.net/gh/smartdoublej/note-img/tcp%E7%AA%97%E5%8F%A3%E6%8E%A7%E5%88%B6.png)



后续多次出现服务端处理数据慢

多次阻塞



官方工具的发送窗口大小极小于服务窗口



![image-20221101105320448](https://cdn.jsdelivr.net/gh/smartdoublej/note-img/%E5%A4%A7%E6%96%87%E4%BB%B6.png)







# 条件测试

## CNC服务上传

| 包大小 | 文件大小（单位mb） | 设置堵塞时间（单位毫秒） | 速度（单位秒） |
| ------ | ------------------ | ------------------------ | -------------- |
| 1460   | 3.8m               | 0                        | 84             |
| 1460   | 3.8                | 0                        | 81             |
| 1460   | 16                 | 0                        | 354            |
| 1460   | 16                 | 0                        | 355            |
| 1460   | 16                 | 1000                     | 356            |
| 1460   | 3.8                | 1000                     | 80             |
| 1024   | 16                 | 0                        | 365(上传失败)  |
| 266    | 3.8m               | 0                        | 209            |
| 266    | 3.9m               | 0                        | 209            |
| 300    | 16                 | 0                        | 452            |
|        |                    |                          |                |

连续循环测试

1-5m记录

| 包大小 | 文件大小 | 阻塞时间 | 速度 |
| ------ | -------- | -------- | ---- |
|        | 1m       | 1s       | 22s  |
|        | 2m       | 1s       | 44s  |
|        | 3m       |          |      |
|        | 4m       |          | 89   |
|        | 5m       |          |      |
|        |          |          |      |
|        | 1.7m     |          | 37   |
|        | 16m      |          | 360s |
|        |          |          |      |
|        |          |          |      |

服务连续五次上传

```
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 1.4718317985534668
b'{"SetCommParam_Ret":"0"}'
{"SendFile_Ret":"0"} 44.29208493232727
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 11.232774496078491
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 4.038023948669434

D:\workstudy\code\python\study>python -u "d:\workstudy\code\python\study\cycleTest.py"
b'{"SetCommParam_Ret":"0"}'
{"SendFile_Ret":"0"} 22.386037349700928
b'{"SetCommParam_Ret":"0"}'
{"SendFile_Ret":"0"} 44.0541205406189
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 6.3900063037872314
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 4.0293731689453125



b'{"SetCommParam_Ret":"0"}'
{"SendFile_Ret":"0"} 0.22801446914672852
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 30.66180968284607
b'{"SetCommParam_Ret":"0"}'
{"Ret_Err":"上传文件失败, 套接字错误（仅限以太网版本）","SendFile_Ret":"1"} 4.028705835342407
b'{"SetCommParam_Ret":"0"}'
{"SendFile_Ret":"0"} 360.0481073856354


```





在cf卡中有程序，但是都是传输部分的程序





## 工具上传

| 包大小 | 文件大小 | 设置堵塞时间 | 速度 |
| ------ | -------- | ------------ | ---- |
| 1460   | 16       | 0            | 364  |
| 1460   | 3.8      | 0            | 70   |
| 292    | 1k       | 0            | 4    |
| 1460   | 2m       | 0            | 32   |
| 1460   | 3m       | 0            | 56   |
| 1460   | 4m       | 0            | 71   |
|        | 5m       |              | 85   |

窗口1460  文件大小3.8m  速度80s       不设置延迟





##  出现问题



### 工具

大文件容易失败，机床直接出现问题

多次上传也会出现



### 服务

CNC文件上传服务

卡顿在关闭文件指针

测试上传文件时间大小分块



一般就是在文件上传以后，中途断开，机床出现问题后续无法继续上传。





