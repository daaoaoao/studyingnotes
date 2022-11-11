Windows API函数

基本服务Base Services

提供对Windows系统可用的基础资源的访问接口。比如象：文件系统（file system）、外部设备（device）、，进程（process）、线程（thread）以及访问注册表（Windows registry）和错误处理机制（error handling）。这些功能接口位于，16位Windows下的kernel.exe、krnl286.exe或krnl386.exe系统文档中；以及32位Windows下的 kernel32.dll和advapi32.dll中。



图形设备接口GDI

提供功能为：输出图形内容到显示器、打印机以及其他外部输出设备。它位于16位Windows下的gdi.exe；以及32位Windows下的gdi32.dll。



图形化用户界面GUI

 提供的功能有创建和管理屏幕和大多数基本控件（control），比如按钮和滚动条。接收鼠标和键盘输入，以及其他与GUI有关的功能。这些调用接口位于：16位Windows下的user.exe，以及32位Windows下的user32.dll。从Windows XP版本之后，基本控件和通用对话框控件（Common Control Library）的调用接口放在comctl32.dll中。

通用对话框链接库（Common Dialog Box Library）

为应用程序提供标准对话框，比如打开/保存文档对话框、颜色对话框和字体对话框等等。这个链接库位于：16位Windows下的commdlg.dll中，以及32位Windows下comdlg32.dll中。它被归类为User Interface API之下。

通用控件链接库（Common Control Library）

为应用程序提供接口来访问操作系统提供的一些高级控件。比如像：状态栏（status bar）、进度条（progress bars）、工具栏（toolbar）和标签（tab）。这个链接库位于：16位Windows下的commctrl.dll中，以及32位Windows下comctl32.dll中。它被归类为User Interface API之下。 

Windows外壳（Windows Shell）

作为Windows API的组成部分，不仅允许应用程序访问Windows外壳提供的功能，还对之有所改进和增强。它位于16位Windows下的shell.dll中，以及32位Windows下的shell32.dll中（Windows 95则在 shlwapi.dll中）。 它被归类为User Interface API之下。 

网络服务（Network Services）

为访问操作系统提供的多种网络 功能提供接口。它包括NetBIOS、Winsock、NetDDE及RPC等。



参考

[Windows API函数大全（Windows编程参考手册）_花小杰的博客-CSDN博客_windows编程手册](https://blog.csdn.net/qq_34427125/article/details/124099319)**