[TOC]



c++中的拷贝构造函数调用时机通常有三种情况

使用一个已经创建完毕的对象来初始化一个新对象

值传递的方式给函数参数传值

以值方式返回局部对象



构造函数调用规则

默认情况下，c++编译器至少给出一个类添加三个函数

默认构造函数（无参，函数体为空）

默认析构函数（无参，函数体为空）

默认拷贝构造函数，对属性进行值拷贝



构造函数调用规则如下

有用户定义有参构造函数，c++不在提供默认无参构造，但是会提供默认拷贝构造

用户定义拷贝构造函数，c++不会提供其它构造函数



浅拷贝：简单的赋值拷贝操作

深拷贝：在堆区重新申请空间，进行拷贝操作



this指针

c++通过提供特殊的对象指针，this指针

this指针指向被调用的成员函数所属的的对象，this指针式隐含每一个非静态成员函数内的一种指针

this指针不需要定义，直接使用即可

this指针用途：

当形参和成员变量同名是，可以用this指针来去区分

在类的非静态成员函数中返回对象本身，可以使用return *this、













使用好的库 符合编码的

减少内存分配和复制

移除计算

使用更好的数据结构

提高并发性

优化内存管理



内存访问并非以字节为单位

当C++获取一个多字节类型的数据，构成数据的字节可能跨越了两个物理内存字，非对齐的内存访问



内存字分为大端和小端

字节序只是 C++ 不能指定 int 中位的存储方式或是设置联合体中的一个字 段会如何影响其他字段的原因之一。所编写的程序可以工作于一类计算机上，却在另一类 计算机上崩溃，原因也在于字节序



内存容量有限



在处理器中，访问内存的性能开销远比其他操作的性能开销大。 

非对齐访问所需的时间是所有字节都在同一个字中时的两倍。 

访问频繁使用的内存地址的速度比访问非频繁使用的内存地址的速度快。 

 访问相邻地址的内存的速度比访问互相远隔的地址的内存快。 

 由于高速缓存的存在，一个函数运行于整个程序的上下文中时的执行速度可能比运行于 测试套件中时更慢。 

 访问线程间共享的数据比访问非共享的数据要慢很多。 

计算比做决定快。 

每个程序都会与其他程序竞争计算机资源。 

 如果一个程序必须在启动时执行或是在负载高峰期时执行，那么在测量性能时必须加载 负载。 

 每一次赋值、函数参数的初始化和函数返回值都会调用一次构造函数，这个函数可能隐 藏了大量的未知代码。 

 有些语句隐藏了大量的计算。从语句的外表上看不出语句的性能开销会有多大。 • 当并发线程共享数据时，同步代码降低了并发量



测量性能

做出可测试的预测并记录预测

记录代码修改

可以计算一条c++语句对内存的读写次数，可以估算出一条c++语句的性能开销



字符串是动态分配的，动态分配内存耗时耗力









编译器对模板做了特殊处理，如果函数不是内联函数，那可以有两种处理方式：

1. 链接时随机选择一个定义，其它的丢弃掉
2. 编译器会把函数的定义单独提出来，提到单独一个文件中，对此文件单独编译，就不会出现重复定义的问题。







# 编程范式的简单思考

依赖注入

面向对象需要借助接口和继承（紧耦合）

函数式 高阶函数特性就能原生支持（松耦合）

使用函数式的方法，实现面向对象的内部迭代（类似访问者模式）属于迭代器模式

函数式 数据是有状态的，而计算是无状态的，需要将数据绑定到函数上，得到有状态的函数，即闭包

通过构造，传递，调用闭包，实现复杂的功能组合



面向对象时

事件的发送者发送Run消息给Command，对于不同类型的Command对象，会执行不同的操作，从而实现动态选择行为

事件的发送者不依赖事件的接受者--按钮不关心自己被点击之后什么操作



函数式

与面向对象方法的区别在于：

面向对象把数据和操作放到对象里，函数式把数据和计算放到闭包里

对于c++来说本质是面向对象实现的：

- [`std::function`](https://en.cppreference.com/w/cpp/utility/functional/function) 是基于带有 `operator()(...)` 抽象类，在构造时利用泛型技巧，抹除传入的 [可调用 *(callable)*](https://en.cppreference.com/w/cpp/concept/Callable) 对象的类型，仅保留调用的签名（[原理](https://shaharmike.com/cpp/naive-std-function/) / [代码](https://bot-man-jl.github.io/articles/2017/Callback-vs-Interface/std_function.cpp)）
- [lambda 表达式](https://en.cppreference.com/w/cpp/language/lambda) 会被编译为带有 `operator()(...)` 的类，并构造时捕获当前的上下文（类似前面的 `NewCommand`）；可以传入 `std::function` 封装为更抽象的可调用对象



# 回调VS接口

同一套数据模型在多处展示，某一处对数据修改，需要同步到其它地方

- 把原来的自治 view 模式转换成了MVC 模式
  - 原来是 view 直接修改 model，并修改展示的内容
  - 现在是 view 通过 controller 修改 model，model 的更新通知 view 修改展示的内容
- 使用了观察者模式
  - 避免了 model 对 view 的直接依赖
  - model 只有一个，而未来可能有更多的 view 加入，不能耦合

解决1：接口

> [回调 vs 接口 | BOT Man JL (bot-man-jl.github.io)](https://bot-man-jl.github.io/articles/?post=2017/Callback-vs-Interface)

首先，定义 `IObserver` 和 `IObservable` 接口：

```cpp
class IObserver {
public:
    virtual void OnNotified () = 0;
};

class IObservable {
public:
    virtual void Register (IObserver *observer) = 0;
    virtual void Unregister (IObserver *observer) = 0;
    virtual void NofityAll () = 0;
};
```

然后，改造 model，继承 `IObservable`，并实现注册、通知相关函数：

```cpp
class Model : public IObservable {
public:
    void Register (IObserver *observer) override;
    void Unregister (IObserver *observer) override;
    void NofityAll () override;
};
```

对于 view 有两种实现方法：

**a) 继承 `IObserver`**

- 改造原有的 view，继承 `IObserver`，并实现接收到 model 通知的处理逻辑
- 注册到 model (`IObservable`) 上，然后 model 回调 `OnNotified`

```cpp
class View : public IObserver {
    Model *_model;
public:
    View (Model *model) : _model (model) {
        _model->Register (this);
    }
    ~View () {
        _model->Unregister (this);
    }
    void OnNotified () override {
        // handle model update
    }
};
```

**b) 组合 `IObserver`**

- 针对每个 view 定义独立的继承 `IObserver` 的类
- 把这个类的对象，作为成员变量，组合到 view 中
- 从而避免把 `IObserver` 耦合到已有的 view 类上

```cpp
class ObserverForView : public IObserver {
    View *_view;
public:
    ObserverForView (View *view)
        : _view (view) {}
    void OnNotified () override {
        // handle model update using _view
    }
};

class View {
    std::unique_ptr<ObserverForView> _observer;
public:
    View () : _observer (new ObserverForView { this }) {}

    // register/unregister _observer at ctor/dtor
};
```



解决2：回调

- 首先，定义 `ModelObserver` 为 `std::function`
- 并为 model 加入 `IObservable` 相关的操作

```cpp
using ModelObserver = std::function<void ()>;

class Model {
public:
    void Register (ModelObserver *observer);
    void Unregister (ModelObserver *observer);
    void NofityAll ();
};
```

而 view 需要给 model 注册一个 `std::function` 对象，在对象内处理 model 的通知。

绑定成员函数

- 利用 `std::bind` 绑定成员函数得到 `std::function` 对象
- 将具体的处理逻辑委托到成员函数 `OnNotified` 内实现

```cpp
class View {
    std::unique_ptr<ModelObserver> _observer;
public:
    View () : _observer (new ModelObserver {
        std::bind (&View::OnNotified, this) }) {}

    // register/unregister _observer at ctor/dtor

    void OnNotified () {
        // handle model update using _view
    }
};
```

构造闭包

- 如果不希望引入新的成员函数，可以使用 lambda 表达式构造[闭包 *(closure)*](https://en.wikipedia.org/wiki/Closure_(computer_programming))
- 闭包内捕获 view 的本身，并在回调过程中使用 view 相关的数据

```cpp
void View::SetObserver() {
    auto onNotified = [this] {
        // handle model update using _view
    };
    _observer.reset (new ModelObserver { onNotified });
}
```



使用接口最大问题在于：需要定义IObservable/IObserver接口，并把原来的 类层次结构耦合到新增的接口里面去

使用回调借助std::function可以装载全局函数，成员函数，函数对象，匿名函数对象，避免了各种破坏原有结构接口

接口：实现了不同接口的可调用实体之间不能相互转换





|            | 动态反射                                                     | 静态反射                                                     |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 使用难度   | （难）需要 **编写注册代码**，调用 `RegisterField` 动态绑定字段信息 | （易）可以通过 **声明式** 的方法，静态定义字段信息           |
| 运行时开销 | （有）需要动态构造 `converter` 对象，需要通过 **虚函数表** *(virtual table)* 实现面向对象的多态 | （无）**编译时** 静态展开代码，和直接手写一样                |
| 可复用性   | （差）每个 `converter` 对象绑定了各个 **字段类型** 的具体 **映射方法**；如果需要进行不同转换操作，则需要另外创建 `converter` 对象 | （好）在调用 `ForEachField` 时，**映射方法** 作为参数传入；利用 **编译时多态** 的机制，为不同的 **字段类型** 选择合适的操作 |



# c++回调

利用依赖注入实现控制反转和依赖倒置，将控制权发给回调函数。

构造和存储可调用实体

构造可调用实体时，需要捕获并存储一些上下文变量（构成闭包）:拥有这些变量的所有权，确保他们的生命周期持续到回调时刻，没有这些变量的所有权，如果在回调时刻已经失效，能被检查出来

不可的可调用实体往往有不同的类型，而且不能相互转换，难以使用一个特定类型的变量存储



在面向对象语言中，一等公民是对象，而不是函数；所以在实现上：

- **闭包** 一般通过 **对象** 实现（例如 `std::function`）
- **上下文** 一般作为闭包对象的 **数据成员**，和闭包属于 [关联/组合/聚合](https://en.wikipedia.org/wiki/Class_diagram#Instance-level_relationships) 的关系

从对象所有权的角度看，上下文进一步分为：

- **不变**(immutable) 上下文

- - 数值/字符串/结构体 等基本类型，永远 **不会失效**
  - 使用时，一般 **不需要考虑** 生命周期问题

- **弱引用***(weak reference)* 上下文（**可变***(mutable)* 上下文）

- - 闭包 **不拥有** 上下文，所以回调执行时 **上下文可能失效**
  - 如果使用前没有检查，可能会导致 **崩溃**

- **强引用**(strong reference) 上下文（**可变**(mutable)* 上下文）

- - 闭包 **拥有** 上下文，能保证回调执行时 **上下文一直有效**
  - 如果使用后忘记释放，可能会导致 **泄漏**





- `std::function`
  - 装载不同类型的 **可调用实体** 全局函数 *(global function)*、成员函数 *(member function)*、函数对象 *(function object, functor)*、匿名函数 *(anonymous function, lambda)* 等，把它们 **适配到统一的接口上**
  - 对装载的实体 **类型擦除** *(type erasure)*，抹去实体原本的实际类型，仅 **保留** **函数签名** *(function signature)*
- `std::bind` 通过绑定参数，实现函数参数的 **[部分应用](https://en.wikipedia.org/wiki/Partial_application)**，从而 **修改** 函数签名
- `std::mem_fn` 将 **类成员函数** 转换为以类对象为第一个参数的 **普通函数**，也 **修改了** 函数签名

## 同步回调

在构造闭包的调用栈（call stack）里面局部执行





## 异步回调

在构造后存储起来，在未来某个时刻（不同的调用栈里）非局部执行



## 不同

同步方式：

通过参数传递回调函数

调用者立即调用回调函数（调用时刻在函数返回前）

调用栈相同



异步方式：

通过注册设置回调函数 （signal）

调用者先存储回调函数，在未来的某个调用时刻，取出并调用回调函数

调用栈不相同

> [深入 C++ 回调 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/88434924)



# 资源管理



# 强引用和弱引用











破釜沉舟

Burn one's own boat to cut off all means of retreat
