# c11新特性

nullptr代替NULL

auto和decltype关键字实现类型推导

基于范围的for循环for（auto&i:res){}

类和结构体的初始化

Lambda表达式

std::forward_list（单向列表）

右值引用和move语义

# auto，decltype和decltype（auto）的用法

### auto

C++11新标准引入了auto类型说明符，用它就能让编译器替我们去分析表达式所属的类型。和原来那些只对应某种特定的类型说明符(例如 int)不同，

**auto 让编译器通过初始值来进行类型推演。从而获得定义变量的类型，所以说 auto 定义的变量必须有初始值。**

