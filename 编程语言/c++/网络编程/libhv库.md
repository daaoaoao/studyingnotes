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

读就绪条件

- 该套接字接收缓冲区中的数据字节数大于等于套接字接收缓冲区低水位标记的当前大小。对这样的套接字执行读操作不会阻塞并将返回一个大于0的值（也就是返回准备好读入的数据）。我们可以使用SO_RCVLOWAT套接字选项设置该套接字的低水位标记。对于TCP和UDP套接字而言，其默认值为1（所以只要有数据就会触发读）。简单的说，就是只要本端收到数据，即使只有一字节，也会触发读事件。
- 该连接的读半部关闭（也就是接收了FIN的TCP连接）。对这样的套接字的读操作将不阻塞并返回0（也就是返回EOF）。当对端关闭连接，本端会触发读事件，并且调用read会返回0。这里举个muduo的关闭例子，在muduo库中，不会主动调用close关闭连接，而是调用shutdown关闭写端，这样对端会触发读事件， read返回0后对端关闭连接，等对端关闭了连接，本端也会触发读事件，read返回0，本端关闭连接。好处是本端只关闭了写端，仍然可以读，假设仍然有数据需要接收，那么不会丢失这部分数据。
- 该套接字是一个监听套接字且已完成的连接数不为0。对这样的套接字的accept通常不会阻塞。例如，当一个客户端调用connect连接服务端时，服务端收到客户端的连接请求，这时候监听套接字就会成为可读的。
- 其上有一个套接字错误待处理。对该套接字的读操作将不阻塞并返回-1（也就是返回一个错误），同时把errno设置成确切的错误条件。这些待处理错误也可以通过指定SO_ERROR套接字选项调用getsockopt获取并清除。实际上当错误发生时，不仅读会就绪， 写也会处于就绪状态。

写就绪条件

- 该套接字发送缓冲区中的可用空间字节数大于等于套接字发送缓冲区低水位标记的当前大小，并且或者该套接字已连接，或者该套接字不需要连接（如UDP套接字）。这意味着如果我们把这样的套接字设置成非阻塞，写操作将不阻塞并返回一个正值（如有传输层接受的字节数）。我们可以使用SO_SNDLOWAT套接字来设置该套接字的低水位标记。对于TCP和UDP套接字而言，其默认值通常为2048。（在我使用的服务器上，默认SO_SNDLOWAT是1字节，表示发送缓冲区只要有空间可写，哪怕只有一字节的空间，也是可写的）。之前说写比读复杂，一个很重要的原因是写的触发条件是写缓冲区有空间，而正常情况下该条件是一直成立的，所以在注册事件时，一般只注册读类型的事件，如果注册了写，会造成loop-busy，不过有个特例是connect事件
- 该连接的写半部关闭，对这样的套接字的写操作将产生SIGPIPE信号，该信号默认会终止程序，一般网络程序会忽略该信号。
- 使用非阻塞式connect的套接字已建立连接，或者connect已经以失败告终。
- 其上有一个套接字错误待处理。跟读类似。。。

**水平触发**

文件描述符可以非阻塞地执行IO系统的调用，就绪

《UNIX网络编程》中介绍IO复用函数都是水平触发的

**边缘触发**

文件描述符自上次状态检查以来用新的IO活动（例如输入）,需要触发通知，就绪条件对边缘触发基本也是有效的

边缘触发和水平触发最大的区别在于水平触发是只要上面的条件满足就会一直触发，而边缘触发只发生新的io活动时才会触发

eg:

1. 本端调用epoll_wait()等待读就绪
2. 套接字上有输入到来，epoll_wait返回，告知我们套接字已经处于就绪态了
3. 再次调用epoll_wait()（注意这里没有读数据，直接再次调用epoll_wait）

水平触发情况下，第二个epoll_wait()告诉套接字处于就绪态，没有从缓冲区读取数据，接受缓冲区依旧存在数据

边缘触发情况下，第二个epollJ_wait()将阻塞，因为无新的输入到来

> [水平触发和边缘触发_不闻窗外事的博客-CSDN博客_边缘触发和水平触发](https://blog.csdn.net/qu1993/article/details/111550425)



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



# 多线程/多进程模式

每一个连接一个线程

读写都是阻塞的，一个io线程只能处理一个fd，对于客户端尚可接受，对于服务端来说，每一个accept一个连接，就去创建一个io线程去读写套接字，并发高了线程的上下文切换开销将系统占满



每个线程一个事件循环

因为`BIO`（阻塞IO）的局限性，所以IO多路复用机制应运而生，如最早期的`select`、后来的`poll`，`linux的epoll`、`windows的iocp`、`bsd的kqueue`、`solaris的port`等，都属于IO多路复用机制。`非阻塞NIO搭配IO多路复用机制就是高并发的钥匙`。

每个线程里运行一个事件循环，每个事件循环里通过IO多路复用机制（即`select、poll、epoll、kqueue`等）监听读写事件，这正是`libevent、libev、libuv、libhv`这类事件循环库的核心思想。

伪代码

```
void event_loop_run() {
	while (1) {
	    int nselect = select(max_fd+1, &readfds, &writefds, &exceptfds, timeout);
	    if (nselect == 0) continue;
	    for (int fd = 0; fd <= max_fd; ++fd) {
	    	// 可读
	    	if (FD_ISSET(fd, &readfds)) {
	    		...
	    		read(fd, buf, len);
	    	}
	    	// 可写
	    	if (FD_ISSET(fd, &writefds)) {
	    		...
	    		write(fd, buf, len);
	    	}
	    }
	}
}
```

io多路复用机制，一个io线程可以同时监听多个fd，一个io线程即可处理几十万数量级别的io读写

libhv库给出常见的写法

>[libhv/examples/multi-thread at master · ithewei/libhv (github.com)](https://github.com/ithewei/libhv/tree/master/examples/multi-thread)



多accept进程模式

关键之处就是通过`hproc_spawn`（linux下就是调用`fork`）衍生子进程，每个进程里运行一个事件循环（`hloop_run`），`accept`请求，将连接上来的fd加入到IO多路复用中，监听读写事件。

多进程模式的好处就是父进程可以通过捕获`SIGCHLD`信号，即可知道子进程退出了（通常是异常崩溃了），然后重新`fork`一个子进程，也即是崩溃自动重启功能。而且因为进程空间的隔离，一个子进程的崩溃不会影响其它的子进程，导致所有服务进程都不可用，所以鲁棒性比较强，`nginx`就是采用的`多进程模式`。

libhv中提供了一个接口`master_workers_run`来实现这种带崩溃自动重启的`master-workers`多进程模式，具体示例可参考 [examples/hmain_test.cpp](https://github.com/ithewei/libhv/blob/master/examples/hmain_test.cpp)



多accept线程模式

调用了`hthread_create`（linux下就是`pthread_create`）创建线程而不是进程，然后每个线程里运行一个事件循环（`hloop_run`）。

多线程模式相对于多进程模式的好处就是共享进程空间，也即是共享数据，而不是每个进程一份资源，当然这也带来了多线程同步的麻烦。



一个accept线程和多worker线程

这种模式相对于上面`accept(listenfd, ...)`和`read/write(connfd, ...)`都在一个线程里，多了一个步骤，当accept线程接收到一个连接时，需要挑选一个worker_loop（示例里就是简单的`轮询`策略，实际应用里可能还有根据`最少连接数`、`IP hash`、`URL hash`等`负载均衡策略`)，然后通知该worker_loop有新的连接到来，libhv里是通过`hloop_post_event`这个接口来进行`事件循环间通信`的，这个接口是`多线程安全`的，内部实现是预先创建一对`socketpair`，向一个fd写入，监听另外一个fd可读，感兴趣的可以读下 [event/hloop.c](https://github.com/ithewei/libhv/blob/master/event/hloop.c) 源码。

这种连接分发模式其实是当下比较流行的模式，因为比较方便控制负载均衡，不会出现一部分线程饱和，一部分线程饥饿的现象，`memcached`即是使用`libevent`实现的这种模式，但是因为`libevent`并没有提供`hloop_post_event`类似接口，所以需要用户自己实现，而且`libevent`也没有集成`openssl`、也没有提供`拆包组包`等相关功能，所以`memcached`里网络编程的代码并不清晰好读，如果使用libhv，我想事情会变得超级简单。

实际掺合业务所涉及的多线程编程比这个更加复杂，`IO线程里是不允许做太多耗时操作的（一般只做接收/发送、轻量级的拆包/组包、序列化/反序列化操作）`，否则会影响线程里其他连接的读写，所以如果涉及CPU密集型计算，如音视频编解码、人脸识别、运动追踪等算法检测，则需要配合`队列`（根据业务可能叫`消息队列、请求队列、任务队列、帧缓存`等）+ `消费者线程/线程池` （如`请求处理线程、任务执行线程、编解码线程`等）使用。好在`libhv`里`hio_write`、`hio_close`都是多线程安全的，这可以让`网络IO事件循环线程里接收数据、拆包组包、反序列化`后放入队列，`消费者线程从队列里取出数据、处理后发送响应和关闭连接`，变得更加简单。





# 接口使用

