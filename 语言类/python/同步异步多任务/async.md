# 库和知识点

## 多进程

win下的multiprocessing库实现跨平台多进程

创建子进程时，只需要传入一个执行函数和函数的参数，创建一个Process实例，用start()方法启动

join()方法可以等待子进程结束后再继续往下运行，通常用于进程间的同步



如果需要启动大量的子进程，可以使用进程池的方式批量创建子进程



对Pool对象调用join()方法会等待所有子进程执行完毕，调用join()之前必须先调用close() ，调用close()之后就不能继续添加新的Process了

pool的默认大小是CPU的核心数

apply_async() 非阻塞异步的，不会等待子进程执行完毕，主进程会继续执行，会根据系统调度来进行进程切换

apply() 阻塞主进程，并且一个一个按顺序地执行子进程，等到全部子进程都执行完毕后，继续执行apply()后面的代码



使用apply_async()后必须调用close()和join()



## 进程间的通信

可以用到管道Pipe和Queue队列

```
eyJ2ZXJzaW9uIjoxLjMsImZlYXR1cmVzIjp7ImxvY2F0aW9uIjp7InJvb20iOnRydWUsIm91dHNpZGUiOnRydWV9fSwic3RvcmVzIjp7Indvb2QiOjQwOCwibWVhdCI6NDY0LjUsImJhaXQiOjE1OSwiZnVyIjoxMzQuNSwidGVldGgiOjEwMywic2NhbGVzIjo0OCwiY2xvdGgiOjM2LCJjaGFybSI6NCwibGVhdGhlciI6NTYsImN1cmVkIG1lYXQiOjM2LCJ0b3JjaCI6MX0sImNoYXJhY3RlciI6e30sImluY29tZSI6eyJnYXRoZXJlciI6eyJkZWxheSI6MTAsInN0b3JlcyI6eyJ3b29kIjoyMX0sInRpbWVMZWZ0Ijo1fSwiYnVpbGRlciI6eyJkZWxheSI6MTAsInN0b3JlcyI6eyJ3b29kIjoyfSwidGltZUxlZnQiOjEwfSwiaHVudGVyIjp7ImRlbGF5IjoxMCwic3RvcmVzIjp7ImZ1ciI6MiwibWVhdCI6Mn0sInRpbWVMZWZ0IjoxfSwidHJhcHBlciI6eyJkZWxheSI6MTAsInN0b3JlcyI6eyJtZWF0IjotMSwiYmFpdCI6MX0sInRpbWVMZWZ0IjoxfSwidGFubmVyIjp7ImRlbGF5IjoxMCwic3RvcmVzIjp7ImZ1ciI6LTUsImxlYXRoZXIiOjF9LCJ0aW1lTGVmdCI6Mn0sImNoYXJjdXRpZXIiOnsiZGVsYXkiOjEwLCJzdG9yZXMiOnsibWVhdCI6LTUsIndvb2QiOi01LCJjdXJlZCBtZWF0IjoxfSwidGltZUxlZnQiOjF9fSwidGltZXJzIjp7fSwiZ2FtZSI6eyJidWlsZGVyIjp7ImxldmVsIjo0fSwiYnVpbGRpbmdzIjp7InRyYXAiOjYsImNhcnQiOjEsImh1dCI6NywibG9kZ2UiOjEsInRhbm5lcnkiOjEsInRyYWRpbmcgcG9zdCI6MSwic21va2Vob3VzZSI6MSwid29ya3Nob3AiOjF9LCJwb3B1bGF0aW9uIjoyOCwid29ya2VycyI6eyJodW50ZXIiOjQsInRyYXBwZXIiOjEsInRhbm5lciI6MSwiY2hhcmN1dGllciI6MX0sIm91dHNpZGUiOnsic2VlbkZvcmVzdCI6dHJ1ZX19LCJwbGF5U3RhdHMiOnt9LCJwcmV2aW91cyI6e319
```











# multiprocessing与multiprocessing.dummy和threading区别

第一个是多进程

第二个是多线程

第三个也是多线程









[Python实战异步爬虫(协程)+分布式爬虫(多进程)_SL_World的博客-CSDN博客](https://blog.csdn.net/SL_World/article/details/86633611)

[python异步IO完全指南 - Peter Griffin's杂货店 (flyingbyte.cc)](https://flyingbyte.cc/post/async_io/#python异步io完全指南)

[asyncio+aiohttp出现Exception ignored：RuntimeError('Event loop is closed') - 华水骚年 - 博客园 (cnblogs.com)](https://www.cnblogs.com/ikunn/p/16414402.html)

[Python学习——进程与线程 - wanf3ng's blog](https://wanf3ng.github.io/2021/02/13/Python学习——进程与线程/#队列Queue)[Python 进程池和线程池的简单使用 - 感受北方工大 (feelncut.com)](https://feelncut.com/2018/05/14/150.html)

[Python 多进程 multiprocessing.Pool类详解_全力以赴的自己的博客-CSDN博客_multiprocessing pool](https://blog.csdn.net/SeeTheWorld518/article/details/49639651?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2~default~CTRLIST~Rate-1-49639651-blog-119404183.pc_relevant_multi_platform_whitelistv6&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2~default~CTRLIST~Rate-1-49639651-blog-119404183.pc_relevant_multi_platform_whitelistv6&utm_relevant_index=1)

[Python--使用消息队列实现进程间通信-爱代码爱编程 (icode.best)](https://icode.best/i/07475040506733)
