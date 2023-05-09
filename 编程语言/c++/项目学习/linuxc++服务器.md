[TOC]





# Socket初步

网络通信接口（本质文件描述符）

socket 调用系统接口

`#include <sys/socket.h>`

书写程序时候要明白是c还是c++



## 错误解决

别让异常逃离析构函数

对于Linux系统调用，常见系统错误提示方式是使用返回值和设置errno来说明错误类型



封装错误函数

方便在调用是进行输出或者日志记录



建立socket连接后，使用<unistd.h>头文件中的read和write来进行网络接口的数据读写。

UDP是使用sendto和recvfrom 



Linux系统中的文件描述符理论上有限的，在使用完一个fd后，需要使用头文件<unistd.h>中的close关闭



## epoll

IO复用与多线程类似，但是不是一个概念

IO复用针对IO接口，多线程针对CPU



IO复用的基本思想是事件驱动，服务器同时保持多个客户端IO连接，当这个IO有可读或者可写事件时，表示这个IO对应的客户端在请求服务器的某项服务



在Linux系统中，IO复用使用select, poll和epoll来实现。epoll改进了前两者，更加高效、性能更好，是目前几乎所有高并发服务器的基石。



[epoll高效运行原理](./epoll高效运行原理.md)



# 参考链接

[ZLToolKit/src at master · ZLMediaKit/ZLToolKit (github.com)](https://github.com/ZLMediaKit/ZLToolKit/tree/master/src)









