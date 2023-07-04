# c++中的类型推导规则
C++ 中的类型推导是编译器根据上下文和初始化表达式来确定变量或表达式的类型的过程。以下是 C++ 中的几种类型推导规则：

1. `auto` 类型推导规则：
   - 如果初始化表达式是一个引用或顶层 `const`/`volatile` 限定符，`auto` 推导为相应的引用类型或 `const`/`volatile` 限定符的类型。
   - 如果初始化表达式是一个数组或函数类型，`auto` 推导为相应的指针类型。
   - 对于其他类型的初始化表达式，`auto` 推导为初始化表达式的类型的非引用部分。

2. `decltype` 类型推导规则：
   - 如果表达式是一个标识符或成员访问表达式，`decltype` 推导为该标识符或成员的类型。
   - 如果表达式是一个函数调用或运算符重载表达式，`decltype` 推导为函数或运算符的返回类型。
   - 如果表达式是一个具有重载的函数调用，需要使用额外的括号 `( )` 来指定具体的函数调用。

3. `decltype(auto)` 类型推导规则：
   - 如果初始化表达式是一个引用，`decltype(auto)` 推导为相应的引用类型。
   - 如果初始化表达式是一个数组或函数类型，`decltype(auto)` 推导为相应的指针类型。
   - 对于其他类型的初始化表达式，`decltype(auto)` 推导为初始化表达式的精确类型，包括保留引用性质和 `const`/`volatile` 限定符。

4. 模板类型推导规则：
   - 模板类型推导是根据函数调用或对象创建时的实际参数来确定模板参数的类型。
   - 模板类型推导根据实参类型匹配模板参数类型，并进行隐式类型转换。
   - 对于函数模板，还会考虑函数重载和模板参数的默认类型推导。

需要注意的是，类型推导是在编译时进行的，根据代码上下文进行推导，具体的规则和行为可能会受到 C++ 标准和编译器的实现细节的影响。在使用类型推导时，建议仔细阅读相关的标准文档，并根据实际情况进行测试和验证。

当涉及类型推导时，C++中有一些特殊情况和规则需要注意。以下是一些额外的细节：

1. 推导失败：
   - 在某些情况下，类型推导可能无法成功，导致编译器错误。这通常发生在推导过程中出现二义性、无法确定最佳匹配或存在无效的类型组合等情况下。

2. 引用折叠：
   - 在类型推导中，引用折叠规则适用。当使用 `auto&` 推导引用类型时，如果初始化表达式是一个左值，推导结果将是左值引用类型。当使用 `auto&&` 推导引用类型时，推导结果将是根据初始化表达式是否为左值或右值引用类型来确定的。

3. const 和 volatile 限定符：
   - `auto` 推导会忽略顶层 `const` 和 `volatile` 限定符，即 `auto` 推导的变量类型不会包含顶层的 `const` 和 `volatile` 修饰符。
   - `decltype(auto)` 推导会保留顶层 `const` 和 `volatile` 限定符，即 `decltype(auto)` 推导的变量类型会包含初始化表达式的顶层 `const` 和 `volatile` 修饰符。

4. 初始化列表和推导：
   - 当使用 `auto` 进行类型推导时，对于初始化列表（如 `auto x = {1, 2, 3};`），推导结果将是一个 `std::initializer_list` 对象。
   - 当使用 `decltype(auto)` 进行类型推导时，对于初始化列表，推导结果将是初始化列表中的第一个元素的类型。

5. 函数返回类型推导：
   - C++14 引入了函数返回类型推导，允许在函数定义中使用 `auto` 或 `decltype(auto)` 来推导函数返回类型。例如：`auto func() { return 42; }`。
   - C++14 之前的版本不支持函数返回类型推导，需要显式指定函数的返回类型。

请记住，类型推导是一项强大而灵活的功能，但也容易导致代码可读性的降低。在使用类型推导时，建议保持代码的清晰和易于理解，可以适当注释和命名以增加代码的可读性。


# decltype
decltype is used to determine the type of an expression at compile time.
编译期间确定表达式的类型
尾置返回类型
c14 允许自动推导所有lambda表达式的返回类型

现代c++ 最好使用std::array 来替代c风格数组

decltype 总是不加修改的产生变量或者表达式的类型，包括顶层const和引用
对于T类型的不是单纯的变量名的左值表达式，decltype(T)和decltype((T))的结果是不一样的一个是T，一个是T&
c++14中支持decltype(auto) 用于推导返回类型，但是它使用的是decltype的规则，所以decltype(auto)和auto的区别是，decltype(auto)会保留顶层const和引用
`int i=1;decltype(auto) x=i`x的类型为int&,而`int i=1;auto x=i`x的类型为int
decltype(auto) 相比于 auto 在类型推断方面更加准确，尤其在处理引用类型和保留表达式信息时更为灵活。它可以用于从初始化表达式中准确地获取变量的类型，并保留引用性质和具体值信息。

# 函数实参
在C++中函数参数中数组会退化为指针，所以在函数中无法得知数组的长度，所以在函数中使用数组时，必须传入数组的长度。
函数类型也会退化为指针类型

在模板类型推导时，有引用的实参会被视为非引用类型，所以在模板中使用引用类型的实参时，必须显式指定模板参数类型。
对于通用引用的推导，左值实参会被特殊处理，推导出的类型是左值引用类型，而非通用引用类型。
对于传值类型推导，const和volatile限定符会被忽略
在模板类型推导时，数组名或者函数名实参会退化为指针，除非它们用于初始化引用。

# auto
当使用{}来初始化变量时，编译器会根据等号右边的表达式来推导变量的类型，这种推导方式称为列表初始化。
你会得到一个std::initializer_list对象，它是一个模板类，它的模板参数是初始化列表中元素的类型。

std::vector<int> v;
v.size()返回类型为std::vector<int>::size_type，在32位系统中，它是一个无符号整数，而在64位系统中，它是一个无符号长整数。

不可见的代理类可能会使auto从表达式中推导出错误的类型
显式指定auto的类型，可以避免这种问题

# 类型推导结果
typeid 和std::type_info::name

# 现代c++

## const 和constexpr区别

const是对变量的一个修饰，只能被初始化，而不能修改

constexpr 可以用来修饰变量，函数和构造函数

编译器在编译程序时可以顺带将其结果计算出来，而无需等到程序运行阶段，这样的优化极大地提高了程序的执行效率。

## 尽可能使用const

const定义一个变量和修饰类的成员变量

const在修饰变量时，对于普通变量其含义很简单就是常量。而对于指针的话根据const修饰的位置分为顶层const和底层const，具体使用哪种可以根据实际需求而定。
  const修饰成员函数时，其表示该成员函数可作用于const对象上并且返回的对象是const，这对有些场景很重要（有些场景用户需要明确调用函数之后不会改变对象本身的状态）。但同时带来一个问题，如何定义对象的状态不变，可能的概念有：

- bitwise constness（physical constness）：不修改对象本身的每一块内存，即不修改对象的每个成员变量即可。但是有时也会出现符合bitwise constness但是对象的行为确实非const的情况。比如对象拥有一个指向上下文环境对象的指针，
- logical constness（conceptual constness）：可以修改对象的内容，但是只有使用类的端检测不出该情况时才如此。

  一般比较好的做法是实现const和non-const的成员函数，但是这样又会造成代码重复，可以在non-const中调用const的实现减少代码重复，但是需要对传入的对象进行const化，并将const实现的返回值const化。

## 区别()和{}创建对象
不可拷贝对象可以使用花括号初始化或者圆括号初始化，但是不能使用`=`

## 优先使用nullptr而非0和NULL
nullptr是一个特殊的类型，它可以隐式转换为任意指针类型，但是不能转换为整数类型，也不能转换为布尔类型。
避免重载指针和整型

## 优先考虑别名声明而非typedef
typedef只能定义类型别名，而using可以定义类型别名，也可以定义模板别名。
```c++
typedef void (*func)(int,int);
using func = void (*)(int,int);
```
c++中提供类型特征type traits，头文件type_traits
在 C++ 的 `<type_traits>` 头文件中，有许多有用的类型转换和类型检查的工具，以下是一些常用的 `type_traits` 函数：
1. `std::is_same<T, U>`：
   - 用于检查类型 `T` 是否与类型 `U` 相同。
   - 例如：`std::is_same<int, float>::value` 结果为 `false`。
2. `std::is_integral<T>`：
   - 用于检查类型 `T` 是否为整数类型（包括有符号和无符号整数）。
   - 例如：`std::is_integral<int>::value` 结果为 `true`。
3. `std::is_floating_point<T>`：
   - 用于检查类型 `T` 是否为浮点类型。
   - 例如：`std::is_floating_point<double>::value` 结果为 `true`。
4. `std::is_pointer<T>`：
   - 用于检查类型 `T` 是否为指针类型。
   - 例如：`std::is_pointer<int*>::value` 结果为 `true`。
5. `std::is_reference<T>`：
   - 用于检查类型 `T` 是否为引用类型。
   - 例如：`std::is_reference<int&>::value` 结果为 `true`。
6. `std::is_array<T>`：
   - 用于检查类型 `T` 是否为数组类型。
   - 例如：`std::is_array<int[5]>::value` 结果为 `true`。
7. `std::is_enum<T>`：
   - 用于检查类型 `T` 是否为枚举类型。
   - 例如：`std::is_enum<MyEnum>::value` 结果为 `true`。
8. `std::is_class<T>`：
   - 用于检查类型 `T` 是否为类类型（即类、结构体或联合体类型，但不包括函数类型）。
   - 例如：`std::is_class<MyClass>::value` 结果为 `true`。
9. `std::is_function<T>`：
   - 用于检查类型 `T` 是否为函数类型。
   - 例如：`std::is_function<int(int)>::value` 结果为 `true`。
   这只是一小部分 `type_traits` 中可用的函数。`type_traits` 提供了更多用于类型转换、类型特性检查和类型组合的函数，可以根据具体需求选择合适的函数。
   在 C++ 的 `<type_traits>` 头文件中，提供了一些类型转换的函数，以下是其中的一些常用函数：
1. `std::decay<T>`：
   - 用于将类型 `T` 转换为对应的不带引用、不带顶层 `const`/`volatile` 限定符的类型。
   - 例如：`std::decay<const int&>::type` 的结果是 `int`。
2. `std::remove_reference<T>`：
   - 用于将类型 `T` 转换为对应的不带引用的类型。
   - 例如：`std::remove_reference<int&>::type` 的结果是 `int`。
3. `std::remove_const<T>`：
   - 用于将类型 `T` 转换为对应的不带顶层 `const` 限定符的类型。
   - 例如：`std::remove_const<const int>::type` 的结果是 `int`。
4. `std::remove_volatile<T>`：
   - 用于将类型 `T` 转换为对应的不带顶层 `volatile` 限定符的类型。
   - 例如：`std::remove_volatile<volatile int>::type` 的结果是 `int`。
5. `std::add_lvalue_reference<T>`：
   - 用于将类型 `T` 转换为对应的左值引用类型。
   - 例如：`std::add_lvalue_reference<int>::type` 的结果是 `int&`。
6. `std::add_rvalue_reference<T>`：
   - 用于将类型 `T` 转换为对应的右值引用类型。
   - 例如：`std::add_rvalue_reference<int>::type` 的结果是 `int&&`。
7. `std::remove_pointer<T>`：
   - 用于将类型 `T` 转换为对应的不带指针的类型。
   - 例如：`std::remove_pointer<int*>::type` 的结果是 `int`。
8. `std::add_pointer<T>`：
   - 用于将类型 `T` 转换为对应的指针类型。
   - 例如：`std::add_pointer<int>::type` 的结果是 `int*`。
   这些函数提供了在类型转换过程中常用的工具，可以根据需要选择适合的函数。值得注意的是，这些函数返回的结果都是类型，可以使用 `typename` 关键字来获取其类型。例如：`typename std::decay<const int&>::type`。

## 使用限制域枚举而非不限制域枚举
限制域枚举是指在枚举类型名后面加上`class`或者`struct`，不限制域枚举是指不加`class`或者`struct`。
```c++
enum class open_modes{input,output,append};
enum color{red,green,blue};
```
限制域枚举的优点：
1. 限制域枚举的作用域不会被枚举成员污染，不限制域枚举的作用域会被枚举成员污染。
2. 限制域枚举的枚举成员不会被隐式转换为整型，不限制域枚举的枚举成员会被隐式转换为整型。
3. 限制域枚举的枚举成员不会被隐式转换为其他枚举类型，不限制域枚举的枚举成员会被隐式转换为其他枚举类型。
限域enum总是可以前置声明，不限域enum只有在定义后才能使用。

## 优先使用delete函数而非private函数
```c++
class A{
public:
    A()=default;
    A(const A&)=delete;
    A& operator=(const A&)=delete;
    ~A()=default;
};
```
使用delete函数的优点：
1. delete函数可以在编译期间检查出错误，private函数只能在运行期间检查出错误。
2. delete函数可以阻止隐式转换，private函数不能阻止隐式转换。
3. delete函数可以阻止模板实例化，private函数不能阻止模板实例化。
4. delete函数可以阻止函数重载，private函数不能阻止函数重载。
任何函数都可以使用delete函数，包括非成员函数和模板实例，但是只有特殊成员函数和运算符才能使用private函数。

## 使用override声明重写的虚函数
重写函数必须满足
基类函数是虚函数
重写函数和基类函数的名字相同
重写函数和基类函数的参数列表相同
基类和派生类的函数常量性相同
基类和派生类的函数返回类型相同
函数的引用限定符相同
```c++
class A{
public:
    virtual void f1(int) const;
    virtual void f2();
    virtual void f3() &;
    virtual void f4() &&;
    virtual void f5() const;
    virtual void f6() const &;
    virtual void f7() const &&;
};
class B:public A{
public:
    void f1(int) const override;
    void f2() override;
    void f3() & override;
    void f4() && override;
    void f5() override;
    void f6() const & override;
    void f7() const && override;
};
```
## 优先使用const_iterator而非iterator
```c++
vector<int> v;
const vector<int> cv;
auto it1=v.begin();
auto it2=cv.begin();
```
前者不修改容器，后者修改容器

## 函数不抛出异常时使用noexcept
```c++
void f1() noexcept;
void f2() noexcept(true);
void f3() noexcept(false);
```
noexcept 是函数接口一部分
noexcept(true)表示函数不抛出异常
noexcept 函数较之于non-noexcept函数更容易优化

## 尽可能使用constexpr而非const
```c++
const int a=1;
constexpr int b=1;
```
const 只能修饰变量，constexpr 既可以修饰变量也可以修饰函数
const 变量的值可以在运行期间确定，constexpr 变量的值必须在编译期间确定
constexpr函数用于需求编译期常量的上下文中，constexpr函数的返回值必须是字面值类型，constexpr函数的参数必须是字面值类型



## new和make_shared区别

先new然后赋值的方式，会导致内存碎片化

make_shared的方法分配内存，不会导致内存产生过多的碎片

通过①的方式，是先在堆上分配一块内存，然后在堆上再建一个智能指针控制块，这两个东西是不连续的，会造成内存碎片化

通过②的方式，是直接在堆上新建一块足够大的内存，其中包含两部分，上面是内存（用来使用），下面是控制块（包含引用计数），然后用A的构造函数去初始化分配的内存（分配一块内存的步骤：先分配内存，再进分配的内存调用构造函数进行构造，构造完毕才能使用）

