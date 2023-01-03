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

库提供一个设置宏

`#define hevent_set_priority(ev,prio)  ((hevent_t*)(ev))->priority=prio`

在hloop_test.c测试文件中有使用例子

在hloop_process_events接口中，处理各种事件，其中定时器是具有最高优先级的，在libhv中，如果存在定时器任务，会优先处理定时器任务

各种事件都会使用EVENT_PENDING宏，将事件加入到待处理事件中，优先功能实现的核心

`hevent_t* pendings[HEVENT_PRIORITYJ_SIZE]; `

放不同的优先级的待处理事件，数组的每一个成员指针都指向对应优先级的一个链表



# IO事件

hloop_new创建loop,libhv是one loop per thread模型，网络库的核心

```
hloop_t* hloop_new(int flags)
{
	hoolp_t* loop;
	HV_ALLOC_SIZEOF(loop); 	
	hloop_init(loop);
	loop->flags |=flag;
	return loop;
}

```

hloop_init(hloop_t* loop)

源码参考

```c++
static void hloop_init(hloop_t* loop) {
    loop->status = HLOOP_STATUS_STOP;
    loop->pid = hv_getpid(); //获取进程ID
    loop->tid = hv_gettid(); //获取线程ID，注意，此线程ID非pthread_self的那个pthread_t类型的线程id
 
    // idles
    list_init(&loop->idles); //初始化空闲事件列表
 
    // timers
    heap_init(&loop->timers, timers_compare); //初始化定时器堆
 
    // ios
    io_array_init(&loop->ios, IO_ARRAY_INIT_SIZE); //初始化io事件集合
 
    // readbuf
    loop->readbuf.len = HLOOP_READ_BUFSIZE;
    HV_ALLOC(loop->readbuf.base, loop->readbuf.len); //初始化读缓冲区
 
    // iowatcher
    iowatcher_init(loop); //初始化io事件监视器
 
    // custom_events
    //下面是与custom事件相关的初始化
    hmutex_init(&loop->custom_events_mutex);
    event_queue_init(&loop->custom_events, CUSTOM_EVENT_QUEUE_INIT_SIZE);
    loop->sockpair[0] = loop->sockpair[1] = -1;
    if (Socketpair(AF_INET, SOCK_STREAM, 0, loop->sockpair) != 0) {
        hloge("socketpair create failed!");
    }
 
    // NOTE: init start_time here, because htimer_add use it.
    //设置开始时间，这个时间是从Epoch开始的时间，但实际上该时间是可以通过修改系统时间修改的，这就是为什么需要下面的时间
    loop->start_ms = gettimeofday_ms();
    //这个时间是无法被修改的相对时间，通过这个无法被修改的相对时间，就可以调整上面的开始时间
    loop->start_hrtime = loop->cur_hrtime = gethrtime_us();
}
```

初始化之后 libhv提供简单的创建服务端的接口  hloop_create_tcp_server

`HV_EXPORT hio_t* hloop_create_tcp_server (hloop_t* loop, const char* host, int port, haccept_cb accept_cb);`

接口封装类socket，bind，listen，接受客户端accept回调等整个服务端创建流程
```
hio_t* hloop_create_tcp_server (hloop_t* loop, const char* host, int port, haccept_cb accept_cb) {
    int listenfd = Listen(port, host);
    if (listenfd < 0) {
        return NULL;
    }
    hio_t* io = haccept(loop, listenfd, accept_cb);
    if (io == NULL) {
        closesocket(listenfd);
    }
    return io;
}
```

listen接口创建监听套接字的描述符，基本流程socket bind listen

接受端口haccept

```
hio_t* haccept(hloop_t* loop, int listenfd, haccept_cb accept_cb) {
    hio_t* io = hio_get(loop, listenfd);
    assert(io != NULL);
    if (accept_cb) {
        io->accept_cb = accept_cb;
    }
    hio_accept(io);
    return io;
}
```



hio_get

```
hio_t* hio_get(hloop_t* loop, int fd) {
    //因为fd是io array的下标，所以要确保下标是有效的
    if (fd >= loop->ios.maxsize) { 
        int newsize = ceil2e(fd);
        io_array_resize(&loop->ios, newsize > fd ? newsize : 2*fd);
    }
 
    hio_t* io = loop->ios.ptr[fd];
    //判断下标为fd的io结构体指针是否有效，如果为NULL，创建一个新的io结构体
    if (io == NULL) {
        HV_ALLOC_SIZEOF(io);  //申请内存
        hio_init(io);  //初始化结构体，实际上目前该接口为空
        io->event_type = HEVENT_TYPE_IO; //设置事件类型为IO
        io->loop = loop;   //设置该io结构体所属loop
        io->fd = fd;      //该io结构体代表的fd
        loop->ios.ptr[fd] = io;     //将新创建的io结构体加入loop的管理
    }
 
    if (!io->ready) {
        hio_ready(io); 
    }
 
    return io;
}
```

每一个io结构体都代表一个描述符，描述符的值就是该io结构体在loop的io array中的位置。刚初始化后ready为0，所以调用hio_ready：

```
void hio_ready(hio_t* io) {
    if (io->ready) return;
    // flags
    io->ready = 1;
    io->closed = 0;
    io->accept = io->connect = io->connectex = 0;
    io->recv = io->send = 0;
    io->recvfrom = io->sendto = 0;
    io->close = 0;
    // public:
    io->io_type = HIO_TYPE_UNKNOWN;
    io->error = 0;
    io->events = io->revents = 0;
    // callbacks
    io->read_cb = NULL;
    io->write_cb = NULL;
    io->close_cb = NULL;
    io->accept_cb = NULL;
    io->connect_cb = NULL;
    // timers
    io->connect_timeout = 0;
    io->connect_timer = NULL;
    io->close_timeout = 0;
    io->close_timer = NULL;
    io->keepalive_timeout = 0;
    io->keepalive_timer = NULL;
    io->heartbeat_interval = 0;
    io->heartbeat_fn = NULL;
    io->heartbeat_timer = NULL;
    // private:
    io->event_index[0] = io->event_index[1] = -1;
    io->hovlp = NULL;
    io->ssl = NULL;
 
    // io_type
    fill_io_type(io);
    if (io->io_type & HIO_TYPE_SOCKET) {
        hio_socket_init(io);
    }
}
```

设置io类型的fill_io_type接口：



通过getsockopt获取io类型，设置完io类型后，在hio_ready接口的最后会判断是不是socket io，如果是socket io，需要调用hio_socket_init进一步设置：



该接口的重点是设置非阻塞属性，libhv库的所有的socket io都会调用该接口，设置为非阻塞的，因为one loop per thread模型，只能阻塞在loop等待事件，读写本身不应该阻塞。

再回到上面的haccept接口，通过hio_get获取了listenfd描述符对应的io结构体后，设置accept的回调，之后调用hio_accept





hio_add就是将io加入到io事件监视器中，并指定自己需要关注的事件类型是HV_READ可读属性。因为当客户端连接服务器时，会令监听套接字成为可读的。当监听套接字的可读事件触发时，会调用hio_handle_events函数。

```c++
int hio_add(hio_t* io, hio_cb cb, int events) {
    printd("hio_add fd=%d events=%d\n", io->fd, events);
#ifdef OS_WIN
    // Windows iowatcher not work on stdio
    if (io->fd < 3) return -1;
#endif
    hloop_t* loop = io->loop;
    if (!io->active) {
        EVENT_ADD(loop, io, cb);
        //loop的io个数加1
        loop->nios++;
    }
    
    if (!io->ready) {
        hio_ready(io);
    }
    
    if (cb) {
        io->cb = (hevent_cb)cb;
    }
    //加入io事件监视器
    iowatcher_add_event(loop, io->fd, events);
    io->events |= events;
    return 0;
}
```

EVENT_ADD宏：

```
#define EVENT_ADD(loop, ev, cb) \
    do {\
        ev->loop = loop;\
        //设置事件ID
        ev->event_id = ++loop->event_counter;\
        //设置事件回调函数
        ev->cb = (hevent_cb)cb;\
        //将该io设置为活跃状态
        EVENT_ACTIVE(ev);\
    } while(0)
 
#define EVENT_ACTIVE(ev) \
    if (!ev->active) {\
        ev->active = 1;\
        //loop的活跃事件加1
        ev->loop->nactives++;\
    }\
```

hio_add接口的ready判断，因为前面已经设置过了，所以这里ready为1。重点是iowatcher_add_event，这个接口将监听套接字加入到io事件监视器中。因为这里具体的监视器涉及到许多不同的实现方式，而且比较容易理解，就不再分析。

到这里hloop_create_tcp_server整个接口就分析完了，我们关心的监听功能的io已经加入到io事件监视器中，剩下的就交给loop的主循环loop_run了。

```c++
int hloop_run(hloop_t* loop) {
    loop->pid = hv_getpid();
    loop->tid = hv_gettid();
 
    // intern events
    int intern_events = 0;
    if (loop->sockpair[0] != -1 && loop->sockpair[1] != -1) {
        hread(loop, loop->sockpair[SOCKPAIR_READ_INDEX], loop->readbuf.base, loop->readbuf.len, sockpair_read_cb);
        ++intern_events;
    }
#ifdef DEBUG
    htimer_add(loop, hloop_stat_timer_cb, HLOOP_STAT_TIMEOUT, INFINITE);
    ++intern_events;
#endif
    //设置loop状态
    loop->status = HLOOP_STATUS_RUNNING;
    //可以通过设置loop状态对其进行控制
    while (loop->status != HLOOP_STATUS_STOP) {
        if (loop->status == HLOOP_STATUS_PAUSE) {
            msleep(HLOOP_PAUSE_TIME);
            hloop_update_time(loop);
            continue;
        }
        ++loop->loop_cnt;
        //判断是否设置了当没有事件时，主动退出标志
        if (loop->nactives <= intern_events && loop->flags & HLOOP_FLAG_QUIT_WHEN_NO_ACTIVE_EVENTS) {
            break;
        }
        //处理事件
        hloop_process_events(loop);
        if (loop->flags & HLOOP_FLAG_RUN_ONCE) {
            break;
        }
    }
    loop->status = HLOOP_STATUS_STOP;
    loop->end_hrtime = gethrtime_us();
 
    if (loop->flags & HLOOP_FLAG_AUTO_FREE) {
        hloop_cleanup(loop);
        HV_FREE(loop);
    }
    return 0;
}
```

开始的sockpair在custom事件博客中分析过了，还有上面的判断flag是否包含HLOOP_FLAG_QUIT_WHEN_NO_ACTIVE_EVENTS，如果设置了HLOOP_FLAG_QUIT_WHEN_NO_ACTIVE_EVENTS，当没有事件时loop会自动退出。这个标志就是博客开始提到的可以在调用hloop_new时设置的，这个标志正常服务器程序不应该设置。hloop_process_events是本接口的核心，之前也提到过该接口，hloop_process_events就是处理所有的事件的，不管是定时器、idle还是io事件。





未完待续





# 心跳和保活机制

libhv提供设置心跳和保活机制的接口

```c++
HV_EXPORT void hio_set_heartbeat(hio_t* io, int interval_ms, hio_send_heartbeat_fn fn);
HV_EXPORT void hio_set_keepalive_timeout(hio_t* io, int timeout_ms DEFAULT(HIO_DEFAULT_KEEPALIVE_TIMEOUT));
```

**通过检测心跳可以处理以下这些情况**

- 如果操作系统崩溃导致机器重启，没有机会发送FIN分节
- 服务器硬件故障导致机器重启，也没有机会发送FIN分节
- 并发连接数很高时，操作系统或进程如果重启，可能没有机会断开全部连接。换句话说，FIN分节可能出现丢包，但这时没有机会重试
- 网络故障，连接双方得知这个情况的唯一方案是检测心跳超时



> [heartbeat和keepalive_不闻窗外事的博客-CSDN博客_htimer_add](https://blog.csdn.net/qu1993/article/details/111246515)



# TCP经典操作 回显，聊天，代理

[TCP服务入门篇：回显、聊天、代理三种经典服务实现详解_ithewei的博客-CSDN博客_tcp回显以enter为](https://hewei.blog.csdn.net/article/details/115332093)

## 回显

回调函数

关闭时的回调

收到消息时的回调 包括读取消息时的回调

主函数是 创建事件循环，创建tcp服务，设置accept回调，运行事件循环，释放事件循环



## 聊天

创建多连接的服务



## 代理

接受消息的设置tcp转发

hio_setup_tcp_upstream()









