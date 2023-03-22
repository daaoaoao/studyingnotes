# 简介

epoll  io事件通知机制，是linux内核实现io多路复用的一个实现

IO多路复用指，在一个操作里面同时监听多个输入输出源，在其中一个或多个输入输出源可用的时候返回，然后对其的进行读写操作。



# IO

输入输出对象可以是文件， 网络（socket） ，进程之间的管道（pipe）

在linux系统中，都用文件描述符（fd)来表示



# 事件

可读事件，当文件描述符关联的内核读缓冲区可读，则触发可读事件

（可读：内核缓冲区非空，有数据可以读取）

可写事件，当文件描述符关联的内核写缓冲区可写，则触发可写事件。

（可写：内核缓冲区不满，用空间空间可以写入）



# 通知机制

当事件发生的时候，则主动通知

反面代表  轮询机制



epoll简略解释：一种当文件描述符的内核缓冲区非空时候，发出可读信号进行通知，当写缓冲区不满的时候，发出可写信号通知的机制。



# API详解

核心数据结构就是：一个红黑树，一个链表



## int epoll_create(int size)

内核产生一个epoll实际数据结构并返回一个文件描述符，描述符就是epoll的实例句柄

## int epoll_ctl(int epfd， int op， int fd， struct epoll_event *event)

将被监听的描述符添加到红黑树或者从红黑树中删除或者对监听事件进行修改。

```cpp
typedef union epoll_data {
    void *ptr; /* 指向用户自定义数据 */
    int fd; /* 注册的文件描述符 */
    uint32_t u32; /* 32-bit integer */
    uint64_t u64; /* 64-bit integer */
} epoll_data_t;

struct epoll_event {
    uint32_t events; /* 描述epoll事件 */
    epoll_data_t data; /* 见上面的结构体 */
};
```

对于需要监视的文件描述符集合，epoll_ctl对红黑色进行管理，红黑树中每个成员由描述符值和所要监控的文件描述符指向的文件表项的引用等组成、

op参数说明操作类型：

- EPOLL_CTL_ADD：向interest list添加一个需要监视的描述符
- EPOLL_CTL_DEL：从interest list中删除一个描述符
- EPOLL_CTL_MOD：修改interest list中一个描述符



struct epoll_event结构描述一个文件描述符的epoll行为。在使用epoll_wait函数返回处于ready状态的描述符列表时，

- data域是唯一能给出描述符信息的字段，所以在调用epoll_ctl加入一个需要监测的描述符时，一定要在此域写入描述符相关信息
- events域是bit mask，描述一组epoll事件，在epoll_ctl调用中解释为：描述符所期望的epoll事件，可多选。





常用的epoll事件描述如下：

- EPOLLIN：描述符处于可读状态
- EPOLLOUT：描述符处于可写状态
- EPOLLET：将epoll event通知模式设置成edge triggered
- EPOLLONESHOT：第一次进行通知，之后不再监测
- EPOLLHUP：本端描述符产生一个挂断事件，默认监测事件
- EPOLLRDHUP：对端描述符产生一个挂断事件
- EPOLLPRI：由带外数据触发
- EPOLLERR：描述符产生错误时触发，默认检测事件



## int epoll_wait



