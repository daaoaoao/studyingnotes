`libhv`是一个比`libevent、libev、libuv`更易用的跨平台`c/c++`国产网络库，用来开发`TCP/UDP/SSL/HTTP/WebSocket/MQTT`客户端/服务端。





# 事件循环

## 简介

长时间运行的程序都会存在主循环。

`SendMessage`和`PostMessage`都是windows提供的用来向窗口线程发送消息的API。

不同之处是`SendMessage`是同步的，如果`SendMessage`调用线程和窗口线程位于同一线程，则直接调用窗口过程处理此消息；如果不是同一线程，则会阻塞等待窗口线程处理完此消息再返回。
`PostMessage`是异步的，将消息投递到窗口消息队列中就返回了，所以使用`PostMessage`传递参数时需要注意不能使用栈上的局部变量。



## IO多路复用

阻塞IO和非阻塞NIO

libhv头文件`hsocket.h`跨平台设置两种方法`blocking(int sockfd)`和`nonblocking(int sockfd)`

最早期的`select`、后来的`poll`，`linux`的`epoll`、`windows`的`iocp`、`bsd`的`kqueue`、`solaris`的`port`等，都属于IO多路复用机制。`非阻塞NIO搭配IO多路复用机制就是高并发的钥匙`。

select,poll,epoll区别见

>

libhv event模块封装类多种平台的io多路复用的机制，提供统一的事件接口，核心模块

lib事件种包括IO事件，timer定时器事件，idle空闲事件，自定义事件（见`hloop_post_event`接口，作用类似于windows窗口消息机制的`PostMessage`）



## libhv的事件循环

定时器测试代码：

[libhv/TimerThread_test.cpp at master · ithewei/libhv (github.com)](https://github.com/ithewei/libhv/blob/master/evpp/TimerThread_test.cpp)

事件循环代码：

[libhv/EventLoop_test.cpp at master · ithewei/libhv (github.com)](https://github.com/ithewei/libhv/blob/master/evpp/EventLoop_test.cpp)

事件线程循环测试

[libhv/EventLoopThread_test.cpp at master · ithewei/libhv (github.com)](https://github.com/ithewei/libhv/blob/master/evpp/EventLoopThread_test.cpp)



`TcpServer、TcpClient、UdpServer、UdpClient、HttpServer、WebSocketServer、WebSocketClient`等底层都是基于`EventLoop`的，在它们的事件回调里就可以直接调用`setInterval/setTimeout`来起定时器，和`javascript`一样的便利，当然你也可以通过`currentThreadEventLoop`宏获取到当前所在线程的事件循环对象，来做更多的事情。

evpp模块只包含头文件，不参与编译

```
├── Buffer.h                缓存类
├── Channel.h               通道类，封装了hio_t
├── Event.h                 事件类，封装了hevent_t、htimer_t
├── EventLoop.h             事件循环类，封装了hloop_t
├── EventLoopThread.h       事件循环线程类，组合了EventLoop和thread
├── EventLoopThreadPool.h   事件循环线程池类，组合了EventLoop和ThreadPool
├── TcpClient.h             TCP客户端类
├── TcpServer.h             TCP服务端类
├── UdpClient.h             UDP客户端类
└── UdpServer.h             UDP服务端类
```

EventLoop中实现了muduo的两个接口，runInloop和queueInLoop 前者对应SendMessage,后者对应PostMessage

EventLoopThreadPool核心是想就是one loop per thread



## 水平触发和边缘触发



# 事件的定义以及数据机构介绍



IO事件，timer定时器事件，idle事件，自定义事件

都是继承自公共的基类hevent_t 便于放入事件队列统一调度

`事件结构体hevent_t`定义在事件循环模块对外头文件 [hloop.h](https://github.com/ithewei/libhv/blob/master/event/hloop.h) 里：

```
struct hevent_s {
    hloop_t*            loop;           // 事件所属的事件循环
    hevent_type_e       event_type;     // 事件类型
    uint64_t            event_id;       // 事件ID
    hevent_cb           cb;             // 事件回调
    void*               userdata;       // 事件用户数据
    void*               privdata;       // 事件私有数据
    struct hevent_s*    pending_next;   // 下一个事件（用于实现事件队列）
    int                 priority;       // 事件优先级
};
```



`事件循环结构体hloop_t`定义在内部 [hevent.h](https://github.com/ithewei/libhv/blob/master/event/hevent.h) 头文件里：

```
struct hloop_s {
    uint32_t    flags;			// 事件循环flags
    hloop_status_e status; 		// 状态：running、stop、pause
    uint64_t    start_ms;       // 开始时间（现实时间realtime）
    uint64_t    start_hrtime;   // 开始时间（线性时间，不受系统时间调整影响）
    uint64_t    end_hrtime;   	// 结束时间
    uint64_t    cur_hrtime;		// 当前时间
    uint64_t    loop_cnt;		// 循环计数
    long        pid;			// 进程ID
    long        tid;			// 线程ID
    void*       userdata;		// 用户数据
//private:
    // events
    uint32_t                    intern_nevents;	// 内部激活事件数
    uint32_t                    nactives;	// 激活事件数
    uint32_t                    npendings;	// 行将发生事件数
    // pendings: with priority as array.index
    hevent_t*                   pendings[HEVENT_PRIORITY_SIZE]; // 事件优先级队列
    // idles
    struct list_head            idles;	// 空闲事件链表
    uint32_t                    nidles;	// 空闲事件数
    // timers
    struct heap                 timers;  // 定时器事件堆
    uint32_t                    ntimers; // 定时器事件数
    // ios: with fd as array.index
    struct io_array             ios; 	// IO事件数组
    uint32_t                    nios;	// IO事件数
    // one loop per thread, so one readbuf per loop is OK.
    hbuf_t                      readbuf;	// 读缓存
    void*                       iowatcher;	// IO事件监视器
    // custom_events
    int                         eventfds[2]; 	// 事件FD，用于唤醒事件循环
    event_queue                 custom_events;  // 自定义事件队列
    hmutex_t                    custom_events_mutex; // 互斥锁，用于自定义事件队列的线程安全性
};
```

io事件使用数组，使用fd作为数组的索引，便于随机访问

空闲事件使用链表，添加删除的复杂度为O(1)，遍历访问 https://blog.csdn.net/qu1993/article/details/110731150

定时器事件使用大小堆，查询最小的超时时间复杂度为O(1) 添加删除的复杂度为o(lgn)https://blog.csdn.net/qu1993/article/details/110855013

自定义事件使用队列，先进先出



# 事件优先级机制

可以对各种事件设置不同优先级，库提供一个设置宏，可以简单设置











