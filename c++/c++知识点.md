# 一些函数

isdigit() 判断char是否是数字

stoi()字符串变换为数字

## find()函数



# GUN的c/c++b编译器

```
gcc main.cpp -lstdc++ -o main
```

linux下简单的编译方式

g++ hel.cpp -o hel

hel为可执行文件

多个文件：g++ one.cpp two.cpp -o together

# cout与cin

### 以不同进制输出数字

`cout` 在输出数字时，默认是十进制的方式，还可以使用 `hex` 、`oct` 、`dec` 来控制输出的进制，这三个控制符都包含在 `<iostream>` 库中。例如：

```cpp
using namespace std;
auto i = 65534;
cout.setf(ios::uppercase); //输出为大写字母
cout << hex << i << endl; //十六进制输出（默认为小写字母）
cout << oct << i << endl; //八进制输出
cout << dec << i << endl; //十进制输出
cout << setbase(16) << i << endl; //以16进制输出
```

其中的 `setiosflags(ios::uppercase)` 表示以大写字母输出（默认是 `ios::lowercase`）， `setbase(n)` 方法表示以 n 进制输出，其中的 n 取值为 8、10 或者 16，其余值无输出。这两个函数都包含在库 `<iomanip>` 中。
使用 `setiosflags()` 时，可以使用 `|` 来同时设置多个位，例如：

```cpp
cout << setiosflags(ios::scientific | ios::showpos) << 12.01 << endl;
```

### 控制浮点数的输出

可以通过 `setprecision(n)` 、`setiosflags(ios::fixed)` 或 `fixed` 来对 `cout` 输出的精度进行控制。这几个控制符都包含在库 `<iomanip>` 库的 `std` 命名空间中。

```cpp
#include <iostream>
#include <climits>
#include <iomanip>

int main(void)
{
    using namespace std;
    system("chcp 65001");
    system("cls");

    double p = 1233.141592653;
    cout << p << endl;
    cout << setprecision(3) << p << endl; //保留两位小数
    cout << setprecision(15) << p << endl;
    cout << setiosflags(ios::fixed);
    cout << p << endl;
    cout << fixed << p << endl;
    return 0;
}
```

运行结果如下：

```plaintext
1233.14
1.23e+03
1233.141592653
1233.141592653000089
1233.141592653000089
```

### 显示小数点和正负号

此外，还可以使用 `setiosflags(ios::showpoint)` 来显示小数点，使用 `setiosflags(ios::showpos)` 来显示正负号。例如：

```cpp
double i2 = 100;
double d2 = -3.14;
cout << setprecision(4);
cout << setiosflags(ios::showpoint); //显示小数点
cout << i2 << endl;
cout << setiosflags(ios::showpos); //显示正负号
cout << d2 << "\t" << i2 << endl;
```

输出结果如下：

```plaintext
100.0000
-3.1400   +100.0000
```

默认显示6个有效位数。

### 设置宽度和对齐方式

可以通过 `setw(n)` 函数来设置输出的宽度，当不足宽度的时候，以空格填充剩余的空间，如果超出宽度，则忽略设置的宽度；使用 `setiosflags(ios::left|ios::right)` 来设置对齐方式。这些都定义在 `<iomanip>` 库中的 `std` 命名空间中。例如：

```cpp
cout.fill(' ');
cout << setw(10) << 100 << setw(10) << 100 << endl;
cout << setiosflags(ios::left) << setw(10) << 100 << setw(10) << 100 << endl;
cout << setiosflags(ios::right) << setw(10) << 100 << setw(10) << 100 << endl;
```

输出结果为：

```plaintext
       100       100
100       100
       100       100
```

输出的结果默认为右对齐。

### 设置填充字符

在宽度大于字符数量时，`cout` 默认使用空格填充剩余的空间，可以使用 `setfill('*')` 来设置为其他的填充字符。例如：

```cpp
cout << setfill('*') << setiosflags(ios::right) << setw(10) << 100 << setw(10) << 100 << endl;
```

### 使用 cout 的成员函数

`ostream` 类还有一些成员函数，通过 `cout` 来调用它们也可以控制格式输出。和前面的控制符不同的是，使用成员函数会影响后面所有使用默认格式的输出。如下表：

| 成员函数     | 控制符              | 说明                                            |
| ------------ | ------------------- | ----------------------------------------------- |
| precision(n) | setprecision(n)     | 设置输出浮点数的精度为n                         |
| width(w)     | setw(w)             | 指定输出宽度为w个字符                           |
| fill(c)      | setfill(c)          | 在指定输出宽度的情况下，多余的空白使用字符c填充 |
| setf(flag)   | setiosflags(flag)   | 将摸个输出格式标志设置为1                       |
| unset(flag)  | resetiosflags(flag) | 将某个输出格式标志设置为0                       |

```cpp
cout.precision(5);
double x = 1123.23456;
cout << x << endl;

cout.width(20);
cout.fill('*');
cout << x << endl;
```

## cin 常用的读取方法

当使用 `cin` 从标准输入读取数据时，通常用到的方法有 `cin >>` 、`cin.get()` 、`cin.getline()` 。

### cin >>

`cin >>` 可以连续的从键盘读取数据，以空格、Tab 键或者换行符作为分隔符或者结束符。
当从缓冲区读取数据时，如果第一个字符是空白字符，`cin>>` 会忽略并将其清除，继续读取下一个字符，如果缓冲区为空，则继续等待。如果读取成功，字符后面的分隔符都是残留在缓冲区内的，`cin >>` 不做处理。

```cpp
int a, b, c;
cin >> a >> b >> c;
cout << a << b << c << endl;
```

上面的代码，将会要求我们输入三个数，并以空白分隔，输出才算完成。
`cin>>` 等价于 `cin.operator>>()`，即调用成员函数 `operator>>()` 进行读取数据。
如果不想略过开头的空白字符，那就使用 `noskipws` 流控制符。如下：

```cpp
cin >> noskipws >> a;
```

### cin.get()

这个函数有多个版本的重载。如下：

```cpp
int cin.get(); 
istream& cin.get(char& var);
istream& get(char* s, streamsize n);
istream& get(char* s, streamsize n, char delim);
```

其中的 `streamsize` 被定义为 `long long` 类型。

#### int cin.get() 和 istream& cin.get(char& var)

这两种版本都是一次读取一个字符。
例如下面的代码：

```cpp
char c1, c2;
c1 = cin.get();
cin.get(c2);
cout << c1 << '\t' << (int)c2 << endl;
```

运行，输入 a，然后回车，输出如下：

```plaintext
a
a
```

如上面的代码：

- `cin.get()` 从缓冲区读取单个字符时不忽略空白，直接将其读取，所以变量 `c2` 保存的是一个空行 `\r`。它的返回值是 `int` 类型，成功则返回读取字符的 ASCII 码值，遇到文件结束符时，返回 `EOF`，即 `-1` 。在 Windows 中，可以使用 Ctrl+Z 来输入文件结束符。
- `cin.get(char var)` 如果成功返回的是 `cin` 对象，所以可以支持链式操作，比如 `cin.get(a).get(c)` 。
- 可以使用 `cin.get()` 来删除缓冲区上一次遗留下来的换行符。

#### 使用 cin.get() 读取一行

`cin.get()` 的后面两种重载形式，

```cpp
istream& get(char* s, streamsize n);
istream& get(char* s, streamsize n, char delim);
```

可以用来读取一行。这两个版本的区别是，前者默认以换行符结束，后者可以指定结束符。参数里的 `n` 表示目标空间的大小。
例如下面的代码：

```cpp
#include <iostream>

int main(void)
{
    using namespace std;
    system("chcp 65001");
    system("cls");

    char arr1[100] = {NULL};
    cin.get(arr1, 100);
    char a;
    cin.get(a);
    cout << arr1 << " " << (int)a << endl;

    system("pause");
    return 0;
}
```

运行的结果：

```plaintext
hello world  //输入
hello world 10
```

从上面的代码中，可以看出：

- 读取一行时，遇到换行符时停止读取，但是对换行符不做处理，换行符依然残留在输入缓冲区。
- 第二次使用 `cin.get(a)` 将换行符读入变量 `a` ，输出的 ASCII 码值为 10 。就是上一次残留的换行符。
- 这种方法读取一行时，只能将字符串读入 C 风格的字符串中，即 `char*` ，使用 C++ 的 `getline()` 函数可以将字符串读入 `string` 类型。

### cin.getline 读取一行

这个函数可以从键盘读取一个字符串，还可以以指定的结束符结束。它不会将换行符残留在缓冲区。函数有两个重载的版本，如下：

```cpp
istream& getline(char* s, streamsize count); //默认的换行符结束
istream& getline(char* s, streamsize count, char delim); //delim 指定结束符
```

例如下面的代码：

```cpp
#include <iostream>

int main(void)
{
    using namespace std;

    char arr1[100] {0};
    cin.getline(arr1, 100);
    cout << arr1 << endl;

    system("pause");
    return 0;
}
```

## cin 的条件状态

使用 `cin` 读取键盘输入时，一旦出错，`cin` 将设置条件状态(condition state)。条件状态定义如下：

- goodbit ：无错误
- eofbit ：已经到达文件尾
- failbit ：非致命的输入/输出错误，可挽回
- badbit ：致命的输入/输出错误，无法挽回

这些条件状态都有对应的成员函数，可以用来设置、读取当前的条件状态。这些成员函数如下：

| 函数                  | 说明                                                         |
| --------------------- | ------------------------------------------------------------ |
| `cin.eof()`           | 如果流 cin 的 eofbit 为1，则返回 true                        |
| `cin.fail()`          | 如果流 cin 的 failbit 位为1，则返回 true                     |
| `cin.bad()`           | 如果流 cin 的 badbit 位为1，则返回 true                      |
| `cin.good()`          | 如果流 cin 的 goodbit 位为1，则返回 true                     |
| `cin.clear(flags)`    | 清空状态标志位，将给定的标志位 flags 设置为0，无返回值，如果不带参数，那么则是将清除所有的非good状态 |
| `cin.setstate(flags)` | 将对应的 flags 设置为1，无返回值                             |
| `cin.rdstate()`       | 返回当前状态。返回值类型为 iostate                           |
| `cin.ignore()`        | 它有两个参数，第一个是整型，第二个是 char 类型。它表示从输入流 cin 中提取第一个参数指定的字符数量，然后将这些字符忽略，如果提取的数量达到指定值或者字符等于第二个参数指定的字符时，该函数将终止。否则，继续等待，直到两个条件之一满足。第二个参数默认值为 EOF |

例如下面的代码：

```cpp
#include <iostream>

int main(void)
{
    using namespace std;
    system("chcp 65001");
    system("cls");
    
    int a;
    while(true)
    {
        cin >> a;
        cout << "位状态：good=" << cin.good() << ", eof=" << cin.eof() << ", bad=" << cin.bad() << ", fail=" << cin.fail() << endl;
        //文件尾，可以使用Ctrl+Z
        if(cin.eof())
        {
            cout << "文件尾命令" << endl;
            exit(1);
        }
        if(cin.fail())
        {
            cout << "输入的非数字。" << endl;
            cin.clear();
            cin.ignore(1000,'\n'); //忽略后面的所有内容
            continue;
        }
    }
    system("pause");
    return 0;
}
```

运行结果：

```plaintext
1
位状态：good=1, eof=0, bad=0, fail=0
a
位状态：good=0, eof=0, bad=0, fail=1
输入的非数字。
^Z
位状态：good=0, eof=1, bad=0, fail=1
文件尾命令
```

我们可以看到，在输入正确的类型（int）后，good 位标志为1。输入非数字时，fail 位被设置。当使用 clear() 函数进行清除状态后，除 good 位外所有的位都被设置为0。

## 其他用于读取的函数

这些函数不是 `cin` 的成员函数，但也可以用于读取输入。

### gets() 函数

`gets()` 函数可以一直读取，直到遇到换行符或者文件尾，它的读取不设上限，所以必须保证缓冲区足够大。它不会让换行符残留在缓冲区。它是 C 语言的库函数。使用如下：

```cpp
#include <iostream>

int main(void)
{
    using namespace std;

    char arr1[100] {0};
    gets(arr1);
    cout << arr1 << endl;

    system("pause");
    return 0;
}
```

### getchar() 函数

`getchar()` 读取一个字符并返回，可以读取空白，遇到换行符停止。也会处理结尾的换行符。

```cpp
#include <iostream>

int main(void)
{
    using namespace std;

    char c;
    c = getchar();
    cout << c << endl;

    system("pause");
    return 0;
}
```

### getline() 函数

`getline()` 函数读取一整行，它是在 `std` 命名空间中的全局函数，这个函数的参数使用了 `string` 类型，所以声明在了 `<string>` 头文件中。
`getline()` 从标准输入设备中读取一行，当遇到下面三种情况之一会结束读取：

1. 文件结束 EOF。
2. 遇到行分隔符。
3. 输入达到最大的限度。

这个函数有两个重载的版本：

```cpp
istream& getline(istream& is, string& str); //默认以换行符 \n 分隔行
istream& getline(istream& is, string& str, char delim); //指定分隔符
```

例如下面的代码：

```cpp
#include <iostream>

int main(void)
{
    using namespace std;
    
    while(true)
    {
        string str;
        getline(cin, str);
        cout << str << endl;
    }
    system("pause");
    return 0;
}
```

`getline()` 函数遇到结束符时，会将结束符一并读入指定的 string 中，再将结束符替换为空字符。

# C++字符串操作

C++ 中有大量的函数用来操作以 null 结尾的字符串:

| 序号 | 函数 & 目的                                                  |
| :--- | :----------------------------------------------------------- |
| 1    | **strcpy(s1, s2);** 复制字符串 s2 到字符串 s1。              |
| 2    | **strcat(s1, s2);** 连接字符串 s2 到字符串 s1 的末尾。连接字符串也可以用 **+** 号，例如: `string str1 = "runoob"; string str2 = "google"; string str = str1 + str2;` |
| 3    | **strlen(s1);** 返回字符串 s1 的长度。                       |
| 4    | **strcmp(s1, s2);** 如果 s1 和 s2 是相同的，则返回 0；如果 s1<s2 则返回值小于 0；如果 s1>s2 则返回值大于 0。 |
| 5    | **strchr(s1, ch);** 返回一个指针，指向字符串 s1 中字符 ch 的第一次出现的位置。 |
| 6    | **strstr(s1, s2);** 返回一个指针，指向字符串 s1 中字符串 s2 的第一次出现的位置。 |

## string的子串：

```
string substr(int pos = 0,int n = npos) const;//返回pos开始的n个字符组成的字符串
```

## C++ string append()

添加文本
使用append()添加文本常用方法:
直接添加另一个完整的字符串:
如str1.append(str2);
添加另一个字符串的某一段子串:
如str1.append(str2, 11, 7);
添加几个相同的字符:
如str1.append(5, ‘.’);
注意,个数在前字符在后.上面的代码意思为在str1后面添加5个".".

## substr()详解

**s.substr(pos, n)：**
返回一个string，包含s中从pos开始的n个字符的拷贝（pos的默认值是0，n的默认值是s.size() - pos，即不加参数会默认拷贝整个s）

若pos的值超过了string的大小，则substr函数会抛出一个out_of_range异常；若pos+n的值超过了string的大小，则substr会调整n的值，只拷贝到string的末尾。

# lambda表达式

语法定义

```c++
[cpature list](paramters list) mutable exception-> return type{function body}
```

1. **capture list**，捕获外部变量列表；
2. **paramters list**，形参列表；
3. **mutable**，用来说明是否可以修改捕获的外部变量；
4. **exception**，抛出异常；
5. **return type**，返回类型；
6. **function body**，函数体。

除此之外，还可以缺省部分声明构成不完整的Lambda表达式，常见的有以下几种——

| 序号 | 格式                                                        |
| :--- | :---------------------------------------------------------- |
| 1    | [capture list] (params list) -> return type {function body} |
| 2    | [capture list] (params list) {function body}                |
| 3    | [capture list] {function body}                              |

其中——

1. 格式1省略了mutable关键字和exception，声明的是一个const类型的表达式，这种表达式不能修改捕获列表中的值；
2. 格式2 省略了返回类型return type，但是编译器可以根据functionbody中的return语句推断出Lambda表达式的返回类型，如果没有return语句，默认为void类型；
3. 格式3中省略了参数列表，即无参的Lambda表达式。

```c++
#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;
int main(){
	vector<int> v{12,52,67,87,34,95,16,48};
	//使用格式3的Lambda表达式定义sort排序规则
	sort(v.begin(),v.end(),
		[](int&a,int&b){return a<b;});
	for(auto&elem:v){
		cout<<elem<<" ";
	}
	return 0;
}
```

## Lambda捕获外部参数

Lambda表达式可以使用其可见范围内的外部变量，但必须明确声明。主要通过中括号[]来捕获外部变量，比如——

```c++
#include<iostream>
using namespace std;
int main(){
	int a = 100;
	auto f = [a]{cout<<a<<endl;};
	f();// f相当于一个无参的函数调用
	return 0;
}
```

这种方式有别于传统的函数参数，增加了语言使用的灵活性。
Lambda表达式的外部变量捕获有4种方式：**值捕获、引用捕获、隐式捕获和混合捕获**。

### 值捕获

值捕获与函数传参数相似，都是按值传递，外部变量的改变不会影响表达式已捕获变量的值

```c++
#include<iostream>
using namespace std;
int main(){
	int a = 100;
	auto f = [a]{cout<<a<<endl;};
	a = 200;// 此时改变a的值
	f();// 依旧输出100，而不是200
	return 0;
}
//输出结果为100
```

需要注意的是，捕获的外部变量是const的，无法修改。
如果需要修改，需添加mutable关键字，括号也不能省略，比如说

```c++
#include<iostream>
using namespace std;
int main(){
	int a = 100;
	auto f = [a]()mutable{cout<<++a<<endl;};
	a = 200;// 
	f();
	return 0;
}
//输出结果为101
```

### 引用捕获

顾名思义，就是捕获一个外部变量的引用，只需要在捕获的外部变量前面加上一个&即可

```c++
#include<iostream>
using namespace std;
int main(){
	int a = 100;
	auto f = [&a]{cout<<a<<endl;};
	a = 200;// 此时改变a的值
	f();// 输出200
	a = 300；
	f();//输出300
	return 0;
}
//传进来的是引用此时变量值发生改变就会调用f()发生改变
```

### 隐式捕获

有时候，捕获的变量比较多的情况，一一书写变量名，可能就会很麻烦。
针对这种情况，**Lambda提供了一种隐式捕获的方法，让编译器自行推断需要捕获哪些变量。
我们只需要定义捕获的方式是值捕获还是引用捕获，这就是隐式捕获**。
具体使用方法，举例如下——

```c++
#include<iostream>
using namespace std;
int main(){
	int a = 100;
	int b = 200;
	int c = 300;
	int d = 400;
	auto f = [=]{
		cout<<"a = "<<a<<endl
		<<"b = "<<b<<endl
		<<"c = "<<c<<endl
		<<"d = "<<d <<endl;};// 值捕获 
	f();
	return 0;
}
```

只需要把`=`改成`&`，就变成引用捕获了

### 混合方式

Lambda还支持以上几种方式的混合使用，具体语法，总结如下——

| 序号 | 语法     | 作用                                                        |
| :--- | :------- | :---------------------------------------------------------- |
| 1    | []       | 不捕获任何外部变量                                          |
| 2    | [args …] | 默认是值捕获的方式，如果需要引用捕获，需要单独在变量名前加& |
| 3    | [this]   | 以值捕获的形式捕获this指针                                  |
| 4    | [=]      | 以值捕获的形式捕获所有外部变量                              |
| 5    | [&]      | 以引用捕获的方式捕获所有的外部变量                          |
| 6    | [=,&x]   | 变量x以引用捕获，其余值捕获                                 |
| 7    | [&,x]    | 变量x值捕获，其余引用捕获                                   |

## Lambda参数列表

Lambda表达式的参数列表和函数的参数列表类似，但是又有所不同，具体表现为——

1. 不支持默认参数列表
2. 不支持可变参数列表
3. 所有参数必须有参数名

相同之处在于，Lambda表达式的参数列表同样可以作为局部变量看待，能够覆盖同名的全局变量。

### 参数绑定



# 函数调用运算符

### 重载operator()运算符

函数调用运算符必须定义为成员函数。一个类可以定义多个不同版本的调用运算符，相互之间必须在参数数量或类型上有所区别。该类也可以称为可调用对象，或函数对象。

```c++
class PrintString
{
public:
    PrintString(ostream &o = cout, char c = ' '):
        os(o), sep(c) { }
    void operator()(const string &s) const
    {
        os << s << sep;
    }

private:
    ostream &os;   // 用于写入的目的流
    char sep;      // 用于将不同输出隔开的字符
};

PrintString printer;  // uses the defaults; prints to cout
printer(s);     // prints s followed by a space on cout
```

如果类定义了调用运算符，则该类的对象被称作函数对象（function object），函数对象常常作为泛型算法的实参。

```c++
for_each(vs.begin(), vs.end(), PrintString(cerr, '\n'));
```

# 虚函数

[完整介绍](https://xiaomaweifu.blog.csdn.net/article/details/81326699?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ELandingCtr%7ERate-1.queryctrv4&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ELandingCtr%7ERate-1.queryctrv4&utm_relevant_index=2)

虚函数的作用和实现原理，什么是虚函数,有什么作用?

```
C++的多态分为静态多态（编译时多态）和动态多态（运行时多态）两大类。静态多态通过重载、模板来实现；动态多态就是通过本文的主角虚函数来体现的。	
	
虚函数实现原理:包括虚函数表、虚函数指针等 

虚函数的作用说白了就是：当调用一个虚函数时，被执行的代码必须和调用函数的对象的动态类型相一致。编译器需要做的就是如何高效的实现提供这种特性。不同编译器实现细节也不相同。大多数编译器通过vtbl（virtual table）和vptr（virtual table pointer）来实现的。 当一个类声明了虚函数或者继承了虚函数，这个类就会有自己的vtbl。vtbl实际上就是一个函数指针数组，有的编译器用的是链表，不过方法都是差不多。vtbl数组中的每一个元素对应一个函数指针指向该类的一个虚函数，同时该类的每一个对象都会包含一个vptr，vptr指向该vtbl的地址。
```



结论：

```
每个声明了虚函数或者继承了虚函数的类，都会有一个自己的vtbl
同时该类的每个对象都会包含一个vptr去指向该vtbl
虚函数按照其声明顺序放于vtbl表中, vtbl数组中的每一个元素对应一个函数指针指向该类的虚函数
如果子类覆盖了父类的虚函数，将被放到了虚表中原来父类虚函数的位置
在多继承的情况下，每个父类都有自己的虚表。子类的成员函数被放到了第一个父类的表中
```



衍生问题:为什么 C++里访问虚函数比访问普通函数慢?

```
单继承时性能差不多，多继承的时候会慢
```

# STL 教程

C++ 标准模板库的核心包括以下三个组件：

| 组件                | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| 容器（Containers）  | 容器是用来管理某一类对象的集合。C++ 提供了各种不同类型的容器，比如 deque、list、vector、map 等。 |
| 算法（Algorithms）  | 算法作用于容器。它们提供了执行各种操作的方式，包括对容器内容执行初始化、排序、搜索和转换等操作。 |
| 迭代器（iterators） | 迭代器用于遍历对象集合的元素。这些集合可能是容器，也可能是容器的子集。 |



- push_back( ) 成员函数在向量的末尾插入值，如果有必要会扩展向量的大小。
- size( ) 函数显示向量的大小。
- begin( ) 函数返回一个指向向量开头的迭代器。
- end( ) 函数返回一个指向向量末尾的迭代器。

# pair

![img](img/092204364017544-16467461903072.jpg)



```c++
//例题代码
pair<string, int>p;
	typedef vector< pair<string, int> > VP;
	VP vp;
	for (int i = 0; i < 5; i++) {
		cin >> p.first >> p.second;
		vp.push_back(make_pair(p.first, p.second));
	}
	VP::iterator it;
	for (it = vp.begin(); it != vp.end(); it++)
		cout << it->first << "," << it->second << endl;
```



# C++ 标准库

C++ 标准库可以分为两部分：

- **标准函数库：** 这个库是由通用的、独立的、不属于任何类的函数组成的。函数库继承自 C 语言。
- **面向对象类库：** 这个库是类及其相关函数的集合。

C++ 标准库包含了所有的 C 标准库，为了支持类型安全，做了一定的添加和修改。

## 标准函数库

标准函数库分为以下几类：

- 输入/输出 I/O
- 字符串和字符处理
- 数学
- 时间、日期和本地化
- 动态分配
- 其他
- 宽字符函数

## 面向对象类库

标准的 C++ 面向对象类库定义了大量支持一些常见操作的类，比如输入/输出 I/O、字符串处理、数值处理。面向对象类库包含以下内容：

- 标准的 C++ I/O 类
- String 类
- 数值类
- STL 容器类
- STL 算法
- STL 函数对象
- STL 迭代器
- STL 分配器
- 本地化库
- 异常处理类
- 杂项支持库

# 多线程

- 基于进程的多任务处理是程序的并发执行。
- 基于线程的多任务处理是同一程序的片段的并发执行

```c++
#include<pthread.h>
//创建POSIX线程
pthread_create(thread, att ,start_routin,arg)
//终止线程
pthread_exit(status)
```

thread 指向线程标识符指针。
attr	一个不透明的属性对象，可以被用来设置线程属性。您可以指定线程属性对象，也可以使用默认值 NULL。
start_routine	线程运行函数起始地址，一旦线程被创建就会执行。
arg	运行函数的参数。它必须通过把引用作为指针强制转换为 void 类型进行传递。如果没有传递参数，则使用 NULL。

**pthread_exit** 用于显式地退出一个线程。通常情况下，pthread_exit() 函数是在线程完成工作后无需继续存在时被调用。

如果 main() 是在它所创建的线程之前结束，并通过 pthread_exit() 退出，那么其他线程将继续执行。否则，它们将在 main() 结束时自动被终止。

向线程传递参数

```c++
rc = pthread_create(&threads[i], NULL,
                          PrintHello, (void *)&td[i]);
// 对传入的参数进行强制类型转换，由无类型指针变为整形数指针，然后再读取
// 传入的时候必须强制转换为void* 类型，即无类型指针 
```

## 连接和分离线程

```c++
pthread_join (threadid, status) 
pthread_detach (threadid) 
    pthread_attr_t attr;
    // 初始化并设置线程为可连接的（joinable）
   pthread_attr_init(&attr);
   pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
// 删除属性，并等待其他线程
   pthread_attr_destroy(&attr);
```

pthread_join() 子程序阻碍调用程序，直到指定的 threadid 线程终止为止。当创建一个线程时，它的某个属性会定义它是否是可连接的（joinable）或可分离的（detached）。只有创建时定义为可连接的线程才可以被连接。如果线程创建时被定义为可分离的，则它永远也不能被连接。

c++11之后新的线程标准库std::thread

std::thread thread_object(callable)

可调用对象可以是函数指针，函数对象，lambda表达式，定义callable后，将其传递给std::thread 的构造函数

```c++
// 演示多线程的CPP程序
// 使用三个不同的可调用对象
#include <iostream>
#include <thread>
using namespace std;
// 一个虚拟函数
void foo(int Z)
{
    for (int i = 0; i < Z; i++) {
        cout << "线程使用函数指针作为可调用参数\n";
    }
}
// 可调用对象
class thread_obj {
public:
    void operator()(int x)
    {
        for (int i = 0; i < x; i++)
            cout << "线程使用函数对象作为可调用参数\n";
    }
};
int main()
{
    cout << "线程 1 、2 、3 "
         "独立运行" << endl;
    // 函数指针
    thread th1(foo, 3);
    // 函数对象
    thread th2(thread_obj(), 3);
    // 定义 Lambda 表达式
    auto f = [](int x) {
        for (int i = 0; i < x; i++)
            cout << "线程使用 lambda 表达式作为可调用参数\n";
    };
    // 线程通过使用 lambda 表达式作为可调用的参数
    thread th3(f, 3);
    // 等待线程完成
    // 等待线程 t1 完成
    th1.join();
    // 等待线程 t2 完成
    th2.join();
    // 等待线程 t3 完成
    th3.join();
    return 0;
}
g++ -std=c++11 test.cpp  使用参数来进行编译
```

# c++ 11新语法

自动类型推导auto

```c++
auto i = 0;
auto c = 'c';
auto s = "hello"

for(auto its = v.begin();its!=v.end();its++)
{
    cout<<*its<<endl;
}

```

lambda表达式

Range-based for-loop

支持数组和迭代器的遍历

```c++
int p[8]={2,3,4,56,6,7,7,7};
    for(auto &x : p)
    {
        cout<<x;
    }
```

