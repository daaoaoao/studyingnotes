# gcc和g++

- **使用 gcc 指令编译 C 代码**
- **使用 g++指令编译 C++ 代码**

## 编译过程

### 预处理

生成.i文件

```
# -E 选项指示编译器仅对输入文件进行预处理
g++  -E  test.cpp  -o  test.i    //.i文件
```

### **编译-Compiling             // .s文件**

```
# -S 编译选项告诉 g++ 在为 C++ 代码产生了汇编语言文件后停止编译
#  g++ 产生的汇编语言文件的缺省扩展名是 .s 
g++  -S  test.i  -o   test.s
```

### **汇编-Assembling          // .o文件**

```
# -c 选项告诉 g++ 仅把源代码编译为机器语言的目标代码
# 缺省时 g++ 建立的目标代码文件有一个 .o 的扩展名。
g++  -c  test.s  -o  test.o
```

### **链接-Linking            // bin文件**

```
# -o 编译选项来为将产生的可执行文件用指定的文件名
g++  test.o  -o  test
```

## g++重要编译参数

### -g 编译带调试信息的可执行文件

```
g++ -g test.cpp
```

### -O[n] 优化源代码

```
## 所谓优化，例如省略掉代码中从未使用过的变量、直接将常量表达式用结果值代替等等，这些操作会缩减目标文件所包含的代码量，提高最终生成的可执行文件的运行效率。
# -O 选项告诉 g++ 对源代码进行基本优化。这些优化在大多数情况下都会使程序执行的更快。 -O2 选项告诉 g++ 产生尽可能小和尽可能快的代码。 如-O2，-O3，-On（n 常为0–3）
# -O 同时减小代码的长度和执行时间，其效果等价于-O1
# -O0 表示不做优化
# -O1 为默认优化
# -O2 除了完成-O1的优化之外，还进行一些额外的调整工作，如指令调整等。
# -O3 则包括循环展开和其他一些与处理特性相关的优化工作。
# 选项将使编译的速度比使用 -O 时慢， 但通常产生的代码执行速度会更快。

# 使用 -O2优化源代码，并输出可执行文件
g++ -O2 test.cpp
```

### **-l  和  -L**   指定库文件  |  指定库文件路径

```
# -l参数(小写)就是用来指定程序要链接的库，-l参数紧接着就是库名
# 在/lib和/usr/lib和/usr/local/lib里的库直接用-l参数就能链接

# 链接glog库
g++ -lglog test.cpp

# 如果库文件没放在上面三个目录里，需要使用-L参数(大写)指定库文件所在目录
# -L参数跟着的是库文件所在的目录名

# 链接mytest库，libmytest.so在/home/bing/mytestlibfolder目录下
g++ -L/home/bing/mytestlibfolder -lmytest test.cpp
```

### **-I**   指定头文件搜索目录

```
# -I 
# /usr/include目录一般是不用指定的，gcc知道去那里找，但 是如果头文件不在/usr/icnclude里我们就要用-I参数指定了，比如头文件放在/myinclude目录里，那编译命令行就要加上-I/myinclude 参数了，如果不加你会得到一个”xxxx.h: No such file or directory”的错误。-I参数可以用相对路径，比如头文件在当前 目录，可以用-I.来指定。上面我们提到的–cflags参数就是用来生成-I参数的。

g++ -I/myinclude test.cpp
```



### **-Wall**   打印警告信息

```
# 打印出gcc提供的警告信息
g++ -Wall test.cpp
```



### **-w**   关闭警告信息

```
1# 关闭所有警告信息
2g++ -w test.cpp
```



### **-std=c++11**   设置编译标准

```
# 使用 c++11 标准编译 test.cpp
g++ -std=c++11 test.cpp
```



### **-o**   指定输出文件名

```
# 指定即将产生的文件名

# 指定输出可执行文件名为test
g++ test.cpp -o test
```



### -D 定义宏

```
# 在使用gcc/g++编译的时候定义宏

# 常用场景：
# -DDEBUG 定义DEBUG宏，可能文件中有DEBUG宏部分的相关信息，用个DDEBUG来选择开启或关闭DEBUG
```



## 案例列举

案例目录结构

```c++
# 最初目录结构

├── include
│   └── Swap.h
├── main.cpp
└── src
   └── Swap.cpp

2 directories, 3 files
```

### 直接编译

**最简单的编译，并运行**

```
# 将 main.cpp src/Swap.cpp 编译为可执行文件
g++ main.cpp src/Swap.cpp -Iinclude
# 运行a.out
./a.out
```

**增加参数编译，并运行**

```
# 将 main.cpp src/Swap.cpp 编译为可执行文件 附带一堆参数
g++ main.cpp src/Swap.cpp -Iinclude -std=c++11 -O2 -Wall -o b.out
# 运行 b.out
./b.out
```

### 生成库文件并编译

链接**静态库**生成可执行文件①：

```
## 进入src目录下
$cd src

# 汇编，生成Swap.o文件
g++ Swap.cpp -c -I../include
# 生成静态库libSwap.a
ar rs libSwap.a Swap.o

## 回到上级目录
$cd ..

# 链接，生成可执行文件:staticmain
g++ main.cpp -Iinclude -Lsrc -lSwap -o staticmain
```



链接**动态库**生成可执行文件②：

```
## 进入src目录下
$cd src
 
# 生成动态库libSwap.so
g++ Swap.cpp -I../include -fPIC -shared -o libSwap.so
## 上面命令等价于以下两条命令
# gcc Swap.cpp -I../include -c -fPIC
# gcc -shared -o libSwap.so Swap.o

## 回到上级目录
$cd ..

# 链接，生成可执行文件:sharemain
g++ main.cpp -Iinclude -Lsrc -lSwap -o sharemain
```



**编译完成后的目录结构**

最终目录结构：2 directories, 8 files

```
# 最终目录结构

├── include
│   └── Swap.h
├── main.cpp
├── sharemain
├── src
│   ├── libSwap.a
│   ├── libSwap.so
│   ├── Swap.cpp
│   └── Swap.o
└── staticmain

2 directories, 8 files
```

####  运行可执行文件

运行可执行文件①

```
# 运行可执行文件
./staticmain
```

运行可执行文件②

```
# 运行可执行文件
LD_LIBRARY_PATH=src ./sharemain
```



# gdb

GDB是Linux下非常好用且强大的调试工具。GDB可以调试C、C++、Go、java、 objective-c、PHP等语言。

[(6条消息) GDB调试指南(入门，看这篇够了)_程序猿编码的博客-CSDN博客_gdb调试](https://blog.csdn.net/chen1415886044/article/details/105094688)

## 简介

1、按照自定义的方式启动运行需要调试的程序。
2、可以使用指定位置和条件表达式的方式来设置断点。
3、程序暂停时的值的监视。
4、动态改变程序的执行环境。



![image-20220420212042664](../img/image-20220420212042664.png)

调试开始：执行**gdb [exefilename]** ，进入gdb调试程序，其中exefilename为要调试的可执行文件名

![image-20220427084803427](../img/image-20220427084803427.png)





**判断文件是否带有调试信息**

要调试C/C++的程序，首先在编译时，要使用gdb调试程序，在使用gcc编译源代码时必须加上“-g”参数。保留调试信息，否则不能使用GDB进行调试。

使用命令readlef查看可执行文件是否带有调试功能

readelf -S main|grep debug





 gdb 常见的调试命令如下：

 启动和退出：gdb 

可执行程序 quit/q 

给程序设置参数/获取设置参数：set args 10 20 show args

 GDB 使用帮助：help 

查看当前文件代码：list/l （从默认位置显示）list/l 行号 （从指定的行显示）list/l 函数名（从指定的函数显示） 

查看非当前文件代码：list/l 文件名:行号 list/l 文件名:函数名 

设置显示的行数：show list/listsize set list/listsize 行数 

设置断点：b/break 行号 b/break 函数名 b/break 文件名:行号 b/break 文件名:函数 

查看断点：i/info b/break 

删除断点：d/del/delete

 断点编号 设置断点无效：dis/disable 

断点编号 设置断点生效：ena/enable

 断点编号 设置条件断点（一般用在循环的位置） b/break 10 if i==5

 运行GDB程序：start（程序停在第一行） run（遇到断点才停） 

继续运行，到下一个断点停：c/continue 

向下执行一行代码（不会进入函数体）：n/next

 变量操作：p/print 变量名（打印变量值） ptype 变量名（打印变量类型） 

向下单步调试（遇到函数进入函数体）：s/step finish（跳出函数体） 

自动变量操作：display 变量名（自动打印指定变量的值） i/info display undisplay 编号 

查看 follow-fork-mode mode 选项的值：show follow-fork-mode 查

看 detach-on-fork 选项的值：show detach-on-fork 

设置 follow-fork-mode mode 选项的值：set follow-fork-mode [parent \ child] 

设置 detach-on-fork 选项的值：show detach-on-fork [on \ off] 

查看当前调试环境中有多少个进程：info inferiors 

切换到指定 ID 编号的进程对其进行调试：inferior id 

其它操作：set var 变量名=变量值 （循环中用的较多） until （跳出循环）



