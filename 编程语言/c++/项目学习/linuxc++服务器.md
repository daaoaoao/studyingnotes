# Socket初步

网络通信接口（本质文件描述符）

socket 调用系统接口

`#include <sys/socket.h>`

书写程序时候要明白是c还是c++



## 错误解决

别让异常逃离析构函数

对于Linux系统调用，常见系统错误提示方式是使用返回值和设置errno来说明错误类型

