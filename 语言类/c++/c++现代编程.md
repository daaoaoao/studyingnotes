# c11

nullptr代替NULL

auto和decltype关键字实现类型推导

基于范围的for循环for（auto&i:res){}

类和结构体的初始化

Lambda表达式

std::forward_list（单向列表）

右值引用和move语义

`unique_ptr` 只保存了类型指针 ptr 和这个指针的析构方法，调用 delete ptr，就需要ptr的完整类型，为了防止这个问题出现，直接通过 assert sizeof 排除掉了这种风险。**`unique_ptr` 相当于在编译时绑定了删除器**。

`shared_ptr` 保存的是一个控制块的指针。控制块包含的就是一个引用计数和一个原来对象的裸指针。控制块中初始化的指针是 `nullptr`，在运行时为其赋值，也可以通过 `reset` 修改。类似于虚函数，**`shared_ptr` 相当于在运行时绑定了删除器**。

## 智能指针的原理，常用的智能指针及实现

### 原理

智能指针是一个类，用来存储动态分配对象的指针，负责自动释放动态分配的对象，防止堆内存的泄露。动态分配的资源，交给类对象去管理，当类对象声明周期结束时，自动调用析构函数释放资源

### 常用的智能指针

#### shared_ptr

实现原理：采用引用计数器的方法，允许多个智能指针指向同一个对象，每当多一个指针指向该对象，指向该该对象的所有智能指针内部的引用计数加1，每当减少一个智能指针指向对象时，引用计数会减一，当计数为0的时候会自动释放动态分配的资源

- 智能指针将一个计数器与类指向的对象相关联，引用计数器跟踪共有多少个类对象共享同一指针
- 每次创建类的新对象时，初始化指针并将引用计数置为1
- 当对象作为另一对象的副本而创建时，拷贝构造函数拷贝指针并增加与之相应的引用计数
- 对一个对象进行赋值时，赋值操作符减少左操作数所指对象的引用计数（如果引用计数为减至0，则删除对象），并增加右操作数所指对象的引用计数
- 调用析构函数时，构造函数减少引用计数（如果引用计数减至0，则删除基础对象）

#### unique_ptr

unique_ptr采用的是独享所有权语义，一个非空的unique_ptr总是拥有它所指向的资源。转移一个unique_ptr将会把所有权全部从源指针转移给目标指针，源指针被置空；所以unique_ptr不支持普通的拷贝和赋值操作，不能用在STL标准容器中；局部变量的返回值除外（因为编译器知道要返回的对象将要被销毁）；如果你拷贝一个unique_ptr，那么拷贝结束后，这两个unique_ptr都会指向相同的资源，造成在结束时对同一内存指针多次释放而导致程序崩溃。

#### weak_ptr

weak_ptr：弱引用。 引用计数有一个问题就是互相引用形成环（环形引用），这样两个指针指向的内存都无法释放。需要使用weak_ptr打破环形引用。weak_ptr是一个弱引用，它是为了配合shared_ptr而引入的一种智能指针，它指向一个由shared_ptr管理的对象而不影响所指对象的生命周期，也就是说，它只引用，不计数。如果一块内存被shared_ptr和weak_ptr同时引用，当所有shared_ptr析构了之后，不管还有没有weak_ptr引用该内存，内存也会被释放。所以weak_ptr不保证它指向的内存一定是有效的，在使用之前使用函数lock()检查weak_ptr是否为空指针。

#### auto_ptr

主要是为了解决“有异常抛出时发生内存泄漏”的问题 。因为发生异常而无法正常释放内存。

auto_ptr有拷贝语义，拷贝后源对象变得无效，这可能引发很严重的问题；而unique_ptr则无拷贝语义，但提供了移动语义，这样的错误不再可能发生，因为很明显必须使用std::move()进行转移。

auto_ptr不支持拷贝和赋值操作，不能用在STL标准容器中。STL容器中的元素经常要支持拷贝、赋值操作，在这过程中auto_ptr会传递所有权，所以不能在STL中使用。

## 新增容器

std::array

std::array 保存在栈内存中，相比堆内存中的 std::vector，我们能够灵活的访问这里面的元素，从而获得更高的性能。

std::array 会在编译时创建一个固定大小的数组，std::array 不能够被隐式的转换成指针，使用 std::array只需指定其类型和大小即可：

```
std::array<int, 4> arr= {1,2,3,4};

int len = 4;
std::array<int, len> arr = {1,2,3,4}; // 非法, 数组大小参数必须是常量表达式
```

当我们开始用上了 std::array 时，难免会遇到要将其兼容 C 风格的接口，这里有三种做法：

```
void foo(int *p, int len) {
    return;
}

std::array<int 4> arr = {1,2,3,4};

// C 风格接口传参
// foo(arr, arr.size());           // 非法, 无法隐式转换
foo(&arr[0], arr.size());
foo(arr.data(), arr.size());

// 使用 `std::sort`
std::sort(arr.begin(), arr.end());
```

### std::forward_list

std::forward_list 是一个列表容器，使用方法和 std::list 基本类似。

和 std::list 的双向链表的实现不同，std::forward_list 使用单向链表进行实现，提供了 O(1) 复杂度的元素插入，不支持快速随机访问（这也是链表的特点），也是标准库容器中唯一一个不提供 size() 方法的容器。当不需要双向迭代时，具有比 std::list 更高的空间利用率。

### 无序容器

C++11 引入了两组无序容器： `std::unordered_map/std::unordered_multimap`和 `std::unordered_set/std::unordered_multiset`。

无序容器中的元素是不进行排序的，内部通过 Hash 表实现，插入和搜索元素的平均复杂度为 O(constant)。

### 元组 std::tuple

元组的使用有三个核心的函数：

`std::make_tuple`: 构造元组 `std::get`: 获得元组某个位置的值 `std::tie`: 元组拆包

```c++
#include <tuple>
#include <iostream>

auto get_student(int id)
{
    // 返回类型被推断为 std::tuple<double, char, std::string>
    if (id == 0)
        return std::make_tuple(3.8, 'A', "张三");
    if (id == 1)
        return std::make_tuple(2.9, 'C', "李四");
    if (id == 2)
        return std::make_tuple(1.7, 'D', "王五");
    return std::make_tuple(0.0, 'D', "null");   
    // 如果只写 0 会出现推断错误, 编译失败
}

int main()
{
    auto student = get_student(0);
    std::cout << "ID: 0, "
    << "GPA: " << std::get<0>(student) << ", "
    << "成绩: " << std::get<1>(student) << ", "
    << "姓名: " << std::get<2>(student) << '\n';

    double gpa;
    char grade;
    std::string name;
    
    // 元组进行拆包
    std::tie(gpa, grade, name) = get_student(1);
    std::cout << "ID: 1, "
    << "GPA: " << gpa << ", "
    << "成绩: " << grade << ", "
    << "姓名: " << name << '\n';

}
```

合并两个元组，可以通过 std::tuple_cat 来实现。

```c++
auto new_tuple = std::tuple_cat(get_student(1), std::move(t));
```



## 正则表达式

正则表达式描述了一种字符串匹配的模式。一般使用正则表达式主要是实现下面三个需求：

1. 检查一个串是否包含某种形式的子串；
2. 将匹配的子串替换；
3. 从某个串中取出符合条件的子串。

C++11 提供的正则表达式库操作 std::string 对象，对模式 std::regex (本质是 std::basic_regex)进行初始化，通过 std::regex_match 进行匹配，从而产生 std::smatch （本质是 std::match_results 对象）。

我们通过一个简单的例子来简单介绍这个库的使用。考虑下面的正则表达式：

[a-z]+.txt: 在这个正则表达式中, [a-z] 表示匹配一个小写字母, + 可以使前面的表达式匹配多次，因此 [a-z]+ 能够匹配一个及以上小写字母组成的字符串。在正则表达式中一个 . 表示匹配任意字符，而 . 转义后则表示匹配字符 . ，最后的 txt 表示严格匹配 txt 这三个字母。因此这个正则表达式的所要匹配的内容就是文件名为纯小写字母的文本文件。 std::regex_match 用于匹配字符串和正则表达式，有很多不同的重载形式。最简单的一个形式就是传入std::string 以及一个 std::regex 进行匹配，当匹配成功时，会返回 true，否则返回 false。例如：

```c++
#include <iostream>
#include <string>
#include <regex>

int main() {
    std::string fnames[] = {"foo.txt", "bar.txt", "test", "a0.txt", "AAA.txt"};
    // 在 C++ 中 `\` 会被作为字符串内的转义符，为使 `\.` 作为正则表达式传递进去生效，需要对 `\` 进行二次转义，从而有 `\\.`
    std::regex txt_regex("[a-z]+\\.txt");
    for (const auto &fname: fnames)
        std::cout << fname << ": " << std::regex_match(fname, txt_regex) << std::endl;
}
```

另一种常用的形式就是依次传入 std::string/std::smatch/std::regex 三个参数，其中 std::smatch 的本质其实是 std::match_results，在标准库中， std::smatch 被定义为了 std::match_results，也就是一个子串迭代器类型的 match_results。使用 std::smatch 可以方便的对匹配的结果进行获取，例如：

```c++
std::regex base_regex("([a-z]+)\\.txt");
std::smatch base_match;
for(const auto &fname: fnames) {
    if (std::regex_match(fname, base_match, base_regex)) {
        // sub_match 的第一个元素匹配整个字符串
        // sub_match 的第二个元素匹配了第一个括号表达式
        if (base_match.size() == 2) {
            std::string base = base_match[1].str();
            std::cout << "sub-match[0]: " << base_match[0].str() << std::endl;
            std::cout << fname << " sub-match[1]: " << base << std::endl;
        }
    }
}
```



## 内联命名空间的定义和使用

命名空间中添加内联inline 外部命名空间中只能有一个inline

```c++
#include <iostream>
namespace Test{
    namespace V1{
        void test(){
            std::cout<<"v1 test"<<std::endl;
        }
    }
    inline namespace V2{
         void test(){
            std::cout<<"v2 test"<<std::endl;
        }
    }
}
int main(){
    Test::test();
    Test::V1::test();
}

/*
v2 test
v1 test
*/
```







# c14

函数可以通过返回值进行推导

```c++
auto func()
{
	return 0;
}
```

返回值类型推导也可以用在模板中：

```c++
#include <iostream>
using namespace std;

template<typename T> auto func(T t) { return t; }

int main() {
   cout << func(4) << endl;
   cout << func(3.4) << endl;
   return 0;
}
```

**attention:**

1.函数内多个return语句必须返回相同类型，否则编译失败

2.如果return语句返回初始化列表，返回值类型推导也会失败

3.如果函数是虚函数，不能使用返回值类型推导

4.返回类型推导可以用在前向声明中，但是在使用之前，翻译单元中必须能够得到函数定义

5.返回类型推导可以用在递归函数中，但是递归函数调用必须以至少一个返回语句作为先导，以便编译器推导出返回类型



## lambda参数auto

lanbda表达式的参数可以直接说auto



## 变量模板

变量模板

```
template<class T>
constexpr T pi = T(3.1415926535897932385L);
int main() {
   cout << pi<int> << endl; // 3
   cout << pi<double> << endl; // 3.14159
   return 0;
}
```



## 别名模板

```c++
template<typename T, typename U>
struct A {
   T t;
   U u;
};

template<typename T>
using B = A<T, int>;

int main() {
   B<double> b;
   b.t = 10;
   b.u = 20;
   cout << b.t << endl;
   cout << b.u << endl;
   return 0;
}
```



## Constexpr的限制

```c++
constexpr int factorial(int n) { // C++11中不可，C++14中可以
   int ret = 0;
   for (int i = 0; i < n; ++i) {
       ret += i;
  }
   return ret;
} 
```

C++11中constexpr函数必须必须把所有东西都放在一个单独的return语句中，而constexpr则无此限制

```
constexpr int func(bool flag) { // C++14 和 C++11均可
   return 0;
}

constexpr int func(bool flag) { // C++11中不可，C++14中可以
   if (flag) return 1;
   else return 0;
}
```



二进制字面量与整形字面量分隔符

```
int a = 0b0001'0110'1001;
	std::cout << a << std::endl;
	
//结果为361
```



## std::make_unique

c11只有std::make_shared



## std::shared_timed_mutex与std::shared_lock

C++14通过std::shared_timed_mutex和std::shared_lock来实现读写锁，保证多个线程可以同时读，但是写线程必须独立运行，写操作不可以同时和读操作一起进行。

```c++
struct ThreadSafe {
    mutable std::shared_timed_mutex mutex_;
    int value_;

    ThreadSafe() {
        value_ = 0;
    }

    int get() const {
        std::shared_lock<std::shared_timed_mutex> loc(mutex_);
        return value_;
    }

    void increase() {
        std::unique_lock<std::shared_timed_mutex> lock(mutex_);
        value_ += 1;
    }
};
```



## **std::integer_sequence**

```c++
template<typename T, T... ints>
void print_sequence(std::integer_sequence<T, ints...> int_seq)
{
    std::cout << "The sequence of size " << int_seq.size() << ": ";
    ((std::cout << ints << ' '), ...);
    std::cout << '\n';
}

int main() {
    print_sequence(std::integer_sequence<int, 9, 2, 5, 1, 9, 1, 6>{});
    return 0;
}

//输出：7 9 2 5 1 9 1 6
```

std::integer_sequence和std::tuple的配合使用：

```c++
template <std::size_t... Is, typename F, typename T>
auto map_filter_tuple(F f, T& t) {
    return std::make_tuple(f(std::get<Is>(t))...);
}

template <std::size_t... Is, typename F, typename T>
auto map_filter_tuple(std::index_sequence<Is...>, F f, T& t) {
    return std::make_tuple(f(std::get<Is>(t))...);
}

template <typename S, typename F, typename T>
auto map_filter_tuple(F&& f, T& t) {
    return map_filter_tuple(S{}, std::forward<F>(f), t);
}
```

## std::exchange

不要使用exchange来执行swap

exchange是吧new_value的值给obj,而没有对new_value赋值

## std::quoted

给字符串添加双引号





> 参考
>
> [C++14新特性的所有知识点全在这儿啦！ (qq.com)](https://mp.weixin.qq.com/s?__biz=MzkyODE5NjU2Mw==&mid=2247484757&idx=1&sn=523a55fcf636113e678f1de297ec4691&chksm=c21d37e9f56abeffca414c0d43d55b36396956735e3cff1c13e1a229a3d21336371a54da84ce&scene=21#wechat_redirect)



# c++17

## 构造函数模板推导

17前构造一个模板需要指明类型，17不需要

```
before
pair<int,double> p(1,2.2)

after:
pair p (1,2.2)
vector v = {1,2,3}
```



## 结构化绑定

通过结构化绑定，对于tuple、map等类型，获取相应值会方便很多

```
std::tuple<int, double> func() {
   return std::tuple(1, 2.2);
}

int main() {
   auto[i, d] = func(); //是C++11的tie吗？更高级
   cout << i << endl;
   cout << d << endl;
}

//==========================
void f() {
   map<int, string> m = {
    {0, "a"},
    {1, "b"},  
  };
   for (const auto &[i, s] : m) {
       cout << i << " " << s << endl;
  }
}

// ====================
int main() {
   std::pair a(1, 2.3f);
   auto[i, f] = a;
   cout << i << endl; // 1
   cout << f << endl; // 2.3f
   return 0;
}
```



```
// 进化，可以通过结构化绑定改变对象的值
int main() {
   std::pair a(1, 2.3f);
   auto& [i, f] = a;
   i = 2;
   cout << a.first << endl; // 2
}
```



*注意结构化绑定不能应用于constexpr*

`constexpr auto[x, y] = std::pair(1, 2.3f); // compile error, C++20可以`

结构化绑定不止可以绑定pair和tuple，还可以绑定数组和结构体等。

```
int array[3] = {1, 2, 3};
auto [a, b, c] = array;
cout << a << " " << b << " " << c << endl;

// 注意这里的struct的成员一定要是public的
struct Point {
   int x;
   int y;
};
Point func() {
   return {1, 2};
}
const auto [x, y] = func();
```

这里其实可以实现自定义类的结构化绑定

```c++
// 需要实现相关的tuple_size和tuple_element和get<N>方法。
class Entry {
public:
   void Init() {
       name_ = "name";
       age_ = 10;
  }

   std::string GetName() const { return name_; }
   int GetAge() const { return age_; }
private:
   std::string name_;
   int age_;
};

template <size_t I>
auto get(const Entry& e) {
   if constexpr (I == 0) return e.GetName();
   else if constexpr (I == 1) return e.GetAge();
}

namespace std {
   template<> struct tuple_size<Entry> : integral_constant<size_t, 2> {};
   template<> struct tuple_element<0, Entry> { using type = std::string; };
   template<> struct tuple_element<1, Entry> { using type = int; };
}

int main() {
   Entry e;
   e.Init();
   auto [name, age] = e;
   cout << name << " " << age << endl; // name 10
   return 0;
}
```

## if-switch语句初始化

```
// if (init; condition)

if (int a = GetValue()); a < 101) {
   cout << a;
}

string str = "Hi World";
if (auto [pos, size] = pair(str.find("Hi"), str.size()); pos != string::npos) {
   std::cout << pos << " Hello, size is " << size;
}
```

## **内联变量**

C++17前只有内联函数，现在有了内联变量，我们印象中C++类的静态成员变量在头文件中是不能初始化的，但是有了内联变量，就可以达到此目的：

```
// header file
struct A {
   static const int value;  
};
inline int const A::value = 10;

// ==========或者========
struct A {
   inline static const int value = 10;
}
```

## 折叠表达式

方便可变参数模板

```
// header file
struct A {
   static const int value;  
};
inline int const A::value = 10;

// ==========或者========
struct A {
   inline static const int value = 10;
}
```

## constexpr lambda表达式

C++17前lambda表达式只能在运行时使用，C++17引入了constexpr lambda表达式，可以用于在编译期进行计算。



增加新特性，捕获*this，不再持有this指针,而是持有对象的拷贝



## 新增Attribute

具体google，百度



## 字符串转换

新增from_chars函数和to_chars函数

```c++
#include <charconv>

int main() {
    const std::string str{"123456098"};
    int value = 0;
    const auto res = std::from_chars(str.data(), str.data() + 4, value);
    if (res.ec == std::errc()) {
        cout << value << ", distance " << res.ptr - str.data() << endl;
    } else if (res.ec == std::errc::invalid_argument) {
        cout << "invalid" << endl;
    }
    str = std::string("12.34");
    double val = 0;
    const auto format = std::chars_format::general;
    res = std::from_chars(str.data(), str.data() + str.size(), value, format);

    str = std::string("xxxxxxxx");
    const int v = 1234;
    res = std::to_chars(str.data(), str.data() + str.size(), v);
    cout << str << ", filled " << res.ptr - str.data() << " characters \n";
    // 1234xxxx, filled 4 characters
}
```

## std::variant

是一种新的多态类型，存储不同类型的值，并且可以在运行时动态地改变其存储的值的类型

通过函数`std::get<int>(v)` 等获取v里面的值，v里面就一个值，动态的变化

使用std::holds_alternative函数检查variant中存储的值的类型：

C++17增加std::variant实现类似union的功能，但却比union更高级，举个例子union里面不能有string这种类型，但std::variant却可以，还可以支持更多复杂类型

```c++
int main() { // c++17可编译
    std::variant<int, std::string> var("hello");
    cout << var.index() << endl;
    var = 123;
    cout << var.index() << endl;

    try {
        var = "world";
        std::string str = std::get<std::string>(var); // 通过类型获取值
        var = 3;
        int i = std::get<0>(var); // 通过index获取对应值
        cout << str << endl;
        cout << i << endl;
    } catch(...) {
        // xxx;
    }
    return 0;
}
```





## std::optional

函数返回对象

有一种办法是返回对象指针，异常情况下就可以返回nullptr啦，但是这就涉及到了内存管理，也许你会使用智能指针，但这里其实有更方便的办法就是std::optional

has_value()来判断对应的optional是否处于设置值的状态



## std::any

C++17引入了any可以存储任何类型的单个值

```c++
int main() { // c++17可编译
    std::any a = 1;
    cout << a.type().name() << " " << std::any_cast<int>(a) << endl;
    a = 2.2f;
    cout << a.type().name() << " " << std::any_cast<float>(a) << endl;
    if (a.has_value()) {
        cout << a.type().name();
    }
    a.reset();
    if (a.has_value()) {
        cout << a.type().name();
    }
    a = std::string("a");
    cout << a.type().name() << " " << std::any_cast<std::string>(a) << endl;
    return 0;
}
```

## std::apply

使用std::apply可以将tuple展开作为函数的参数传入

```c++
int add(int first, int second) { return first + second; }

auto add_lambda = [](auto first, auto second) { return first + second; };

int main() {
    std::cout << std::apply(add, std::pair(1, 2)) << '\n';
    std::cout << add(std::pair(1, 2)) << "\n"; // error
    std::cout << std::apply(add_lambda, std::tuple(2.0f, 3.0f)) << '\n';
}
```

## std::make_from_tuple

使用make_from_tuple可以将tuple展开作为构造函数参数

```c++
struct Foo {
    Foo(int first, float second, int third) {
        std::cout << first << ", " << second << ", " << third << "\n";
    }
};
int main() {
   auto tuple = std::make_tuple(42, 3.14f, 0);
   std::make_from_tuple<Foo>(std::move(tuple));
}
```

## std::string_view

通常我们传递一个string时会触发对象的拷贝操作，大字符串的拷贝赋值操作会触发堆内存分配，很影响运行效率，有了string_view就可以避免拷贝操作，平时传递过程中传递string_view即可。

```c++
void func(std::string_view stv) { cout << stv << endl; }
int main(void) {
    std::string str = "Hello World";
    std::cout << str << std::endl;

    std::string_view stv(str.c_str(), str.size());
    cout << stv << endl;
    func(stv);
    return 0;
}
```

## as_const

C++17使用as_const可以将左值转成const类型

## file_system

C++17正式将file_system纳入标准中，提供了关于文件的大多数功能，基本上应有尽有

[标准库头文件  - cppreference.com](https://zh.cppreference.com/w/cpp/header/filesystem)

主要就是文件操作

列举一些例子

```c++
	namespace fs = std::filesystem;
	std::cout << fs::current_path() << std::endl;
	fs::path path1("D:\\ATest\\one");
	fs::create_directory(path1);
	//创建txt文件
	fs::path path2 = path1 / "test.txt";
	std::ofstream ofs(path2);
	ofs << "hello world" << std::endl;
	ofs.close();
	//删除文件
	fs::remove(path2);
	std::cout << fs::current_path() << std::endl;
```



# c++20

## 比较运算<=>

对于 (a <=> b)，如果a > b ，则运算结果>0，如果a < b，则运算结果<0，如果a==b，则运算结果等于0，注意下，运算符的结果类型会根据a和b的类型来决定，所以我们平时使用时候最好直接用auto，方便快捷。

```c++
#include <compare>
#include <iostream> 
int main() {
    double foo = 0.0;
    double bar = 1.0;
 
    auto res = foo <=> bar;
 
    if (res < 0)
        std::cout << "foo is less than bar";
    else if (res == 0)
        std::cout << "foo and bar are equal";
    else if (res > 0)
        std::cout << "foo is greater than bar";
}
```

## for循环括号里可以初始化



**多了一个char8_t**类型，和普通的char没区别，就是容易区分出具体大小而已，就像int32_t与int一样。

[[no_unique_address]]：看着貌似没啥用，没具体关注...

[[likely]]和[[unlikely]]：在分支预测时，用于告诉编译器哪个分支更容易被执行，哪个不容易执行，方便编译器做优化。

```c++
constexpr long long fact(long long n) noexcept {
    if (n > 1) [[likely]]
        return n * fact(n - 1);
    else [[unlikely]]
        return 1;
}
```



## lambda

lambda表达式的捕获

C++20之前[=]会隐式捕获this，而C++20需要显式捕获，这样[=, this]

```c++
struct S2 { void f(int i); };
void S2::f(int i)
{
    [=]{};          // OK: by-copy capture default
    [=, &i]{};      // OK: by-copy capture, except i is captured by reference
    [=, *this]{};   // until C++17: Error: invalid syntax
                    // since c++17: OK: captures the enclosing S2 by copy
    [=, this] {};   // until C++20: Error: this when = is the default
                    // since C++20: OK, same as [=]
}
```

lambda表达式可以使用模板：

```c++
// generic lambda, operator() is a template with two parameters
auto glambda = []<class T>(T a, auto&& b) { return a < b; };
 
// generic lambda, operator() is a template with one parameter pack
auto f = []<typename ...Ts>(Ts&& ...ts) {
   return foo(std::forward<Ts>(ts)...);
};
```



consteval

consteval修饰的函数只会在编译期间执行，如果不能编译期间执行，则编译失败。



constint

断言一个变量有静态初始化，即零初始化和常量初始化，否则程序是有问题的。



## std::format系列



std::format可用于替代printf，它的目的是补充现有的c++ I/O流库，并重用它的一些基础设施，如用户定义类型的重载插入操作符。

```c++
std::string s = std::format("one test {},two{}", 0,2);
	std::cout << s << std::endl;
	std::string one = "one";
	std::string two = "two";
	std::cout << std::format("is test{0},{1}", one, two);
```



## 增加日历和时区的支持

[日期和时间工具 - cppreference.com](https://zh.cppreference.com/w/cpp/chrono#.E6.97.A5.E5.8E.86)

[C++ - 开发者手册 - 云+社区 - 腾讯云 (tencent.com)](https://cloud.tencent.com/developer/doc/1024)

```c++
std::chrono::system_clock::time_point now = std::chrono::system_clock::now();
    std::time_t now_c = std::chrono::system_clock::to_time_t(now);
    char str[26];
	ctime_s(str, sizeof str, &now_c);
	std::string time_str(str);
	std::cout << time_str << std::endl;
	std::string time_str_2 = time_str.substr(0, time_str.size() - 1);
	std::cout << time_str_2 << std::endl;
```



## 未分类

std::atomic 智能指针线程更安全



source_location：可作为_\_LINE__ 、\_\_func__这些宏的替代：



endian获取当前平台上大端序还是小端序

```c++
#include <bit>
#include <iostream>
 
int main() {
 
    if constexpr (std::endian::native == std::endian::big) {
        std::cout << "big-endian" << '\n';
    }
    else if constexpr (std::endian::native == std::endian::little) {
        std::cout << "little-endian"  << '\n';
    }
    else {
        std::cout << "mixed-endian"  << '\n';
    }
 
}
```

std::to_address：获得由p表示的地址，而不形成对p所指向的对象的引用

线程同步：

- barrier：屏障
- latch：CountDownLatch
- counting_semaphore：信号量

std::jthread：之前的std::thread在析构时如果没有join或者detach会crash，而jthread在析构时会自动join。jthread也可以取消线程：request_stop()。

C++20也引进了一些中断线程执行的相关类：

- stop_token：查询线程是否中断
- stop_source：请求线程停止运行
- stop_callback：stop_token执行时，可以触发的回调函数

basic_osyncstream：它是对std::basic_syncbuf的再包装，直接使用std::cout多线程下可能出现数据交叉，osyncstream不会发生这种情况。

string的系列操作

- string::starts_with
- string::ends_with
- string_view::starts_with
- string::view::ends_with



Ranges库：ranges库提供了用于处理元素范围的组件，包括各种视图适配器。表示连续元素或者连续元素的片段。

std::is_bounded_array：检查数组是不是有界

std::is_unbounded_array

c++ 20

std::jthread 基于已经存在的std::thread ，一个包装器

它拥有同 std::thread 的行为外，主要增加了以下两个功能：

(1) std::jthread 对象被 destruct 时，会自动调用 join，等待其所表示的执行流结束。

(2) 支持外部请求中止（通过 get_stop_source、get_stop_token 和 request_stop ）。



jthread是可协作中断的

该名称表明新的`jthread`是可中断的，即有一种方法可以阻止来自外部的线程。与C ++不同，在其他一些语言中，*线程*类具有*abort（）*，*stop（）*或*interrupt（）*函数，而且大部分都不是用户可能期望的，即kill开关。有些人可能会认为我们没有这样的东西是如此糟糕，`std::thread`而且现在`std::jthread`我们终于拥有了它。但它可以**协作**中断，理解这一点的最好方法是看一下它的功能：`request_stop()`



代码参考

[programStdudy/c++ at main · smartdoublej/programStdudy (github.com)](https://github.com/smartdoublej/programStdudy/tree/main/c%2B%2B)



## std::function

类模版`std::function`是一种通用、多态的函数封装。`std::function`的实例可以对任何可以调用的目标实体进行存储、复制、和调用操作，这些目标实体包括普通函数、Lambda表达式、函数指针、以及其它函数对象等。`std::function`对象是对C++中现有的可调用实体的一种类型安全的包裹（我们知道像函数指针这类可调用实体，是类型不安全的）。

通常std::function是一个函数对象类，它包装其它任意的函数对象，被包装的函数对象具有类型为T1, …,TN的N个参数，并且返回一个可转换到R类型的值。`std::function`使用 模板转换构造函数接收被包装的函数对象；特别是，闭包类型可以隐式地转换为`std::function`。