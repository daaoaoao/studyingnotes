# 简介

c++单元测试框架

提供丰富的断言，致命和非致命判断，参数化，死亡测试



# 单元测试

在测试函数中，gtest提供了`EXPECT_* `和`ASSERT_*`两种风格的断言



ASSERT_*

执行失败会当前测试函数立即返回

 8 个`ASSERT_*`断言，分别是`ASSERT_TRUE()`、`ASSERT_FALSE()`、`ASSERT_EQ()`、`ASSERT_NE()`、`ASSERT_LT()`、`ASSERT_LE()`、`ASSERT_GT()`和`ASSERT_GE()`。



`EXPECT_* `

执行失败不会导致测试函数返回

`EXPECT_EQ()`、`EXPECT_NE()`、`EXPECT_LT()`、`EXPECT_LE()`、`EXPECT_GT()`和`EXPECT_GE()`。





```
----- 布尔类型
ASSERT_TRUE(arg);     // 预期结果为true
ASSERT_FALSE(arg);    // 预期结果为false

----- 数值型数据检查
ASSERT_EQ(arg1, arg2); // equal         预期两个值相等
ASSERT_NE(arg1, arg2); // not equal     预期两个值不等
ASSERT_LT(arg1, arg2); // less than     预期arg1小于arg2
ASSERT_GT(arg1, arg2); // greater than  预期arg1大于arg2
ASSERT_LE(arg1, arg2); // less equal    预期arg1小于等于arg2
ASSERT_GE(arg1, arg2); // greater equal 预期arg1大于等于arg2

----- 字符串检查
ASSERT_STREQ(arg1, arg2);     // 预期字符串相等，区分大小写
ASSERT_STRNE(arg1, arg2);     // 预期字符串不等，区分大小写
ASSERT_STRCASEEQ(arg1, arg2); // 预期字符串相等，忽略大小写
ASSERT_STRCASENE(arg1, arg2); // 预期字符串不等，忽略大小写s
```





构造一部分测试用的数据或者多个测试用例需要使用相同的数据， 在测试用例执行前创建，执行结束后清理，GTest提供接口，需要依赖类来实现。



## 事件机制

### Global

创建一个继承testing::Environment的类，并实现其中的SetUp()和TearDown()两种方法，最后在main()函数中通过testing::AddGlobalTestEnvironment()进行注册



### TestSuite

需要创建一个与test_suite_name名称相同的类，同时需要继承testing::Test类，并实现其中的两个静态方法SetUpTestCase()以及TearDownTestCase()，分别会在第一个用例前以及最后一个用例后执行



### TestCase

与 TestSuite 级别使用相同的类，但是需要实现的方法不同，需要实现 `SetUp()` 以及 `TearDown()` 两个函数，分别在每个测试用例的前后执行。注意，在两个测试用例中执行的内容是不会相互影响的。



## GTest的断言

### 布尔值检验

| Fatal assertion            | Nonfatal assertion         | Verifies             |
| :------------------------- | :------------------------- | :------------------- |
| ASSERT_TRUE(*condition*);  | EXPECT_TRUE(*condition*);  | *condition* is true  |
| ASSERT_FALSE(*condition*); | EXPECT_FALSE(*condition*); | *condition* is false |

### 数值型数据检验

| Fatal assertion                  | Nonfatal assertion               | Verifies               |
| :------------------------------- | :------------------------------- | :--------------------- |
| ASSERT_EQ(*expected*, *actual*); | EXPECT_EQ(*expected*, *actual*); | *expected* == *actual* |
| ASSERT_NE(*val1*, *val2*);       | EXPECT_NE(*val1*, *val2*);       | *val1* != *val2*       |
| ASSERT_LT(*val1*, *val2*);       | EXPECT_LT(*val1*, *val2*);       | *val1* < *val2*        |
| ASSERT_LE(*val1*, *val2*);       | EXPECT_LE(*val1*, *val2*);       | *val1* <= *val2*       |
| ASSERT_GT(*val1*, *val2*);       | EXPECT_GT(*val1*, *val2*);       | *val1* > *val2*        |
| ASSERT_GE(*val1*, *val2*);       | EXPECT_GE(*val1*, *val2*);       | *val1* >= *val2*       |

### 字符串比较

| Fatal assertion                                 | Nonfatal assertion                              | Verifies                            |
| :---------------------------------------------- | :---------------------------------------------- | :---------------------------------- |
| ASSERT_STREQ(*expected_str*, *actual_str*);     | EXPECT_STREQ(*expected_str*, *actual_str*);     | 两个C字符串有相同的内容             |
| ASSERT_STRNE(*str1*, *str2*);                   | EXPECT_STRNE(*str1*, *str2*);                   | 两个C字符串有不同的内容             |
| ASSERT_STRCASEEQ(*expected_str*, *actual_str*); | EXPECT_STRCASEEQ(*expected_str*, *actual_str*); | 两个C字符串有相同的内容，忽略大小写 |
| ASSERT_STRCASENE(*str1*, *str2*);               | EXPECT_STRCASENE(*str1*, *str2*);               | 两个C字符串有不同的内容，忽略大小写 |

### 异常检查

| Fatal assertion                              | Nonfatal assertion                           | Verifies                                          |
| :------------------------------------------- | :------------------------------------------- | :------------------------------------------------ |
| ASSERT_THROW(*statement*, *exception_type*); | EXPECT_THROW(*statement*, *exception_type*); | *statement* throws an exception of the given type |
| ASSERT_ANY_THROW(*statement*);               | EXPECT_ANY_THROW(*statement*);               | *statement* throws an exception of any type       |
| ASSERT_NO_THROW(*statement*);                | EXPECT_NO_THROW(*statement*);                | *statement* doesn't throw any exception           |

### 浮点型检查

| Fatal assertion                       | Nonfatal assertion                    | Verifies                               |
| :------------------------------------ | :------------------------------------ | :------------------------------------- |
| ASSERT_FLOAT_EQ(*expected, actual*);  | EXPECT_FLOAT_EQ(*expected, actual*);  | the two float values are almost equal  |
| ASSERT_DOUBLE_EQ(*expected, actual*); | EXPECT_DOUBLE_EQ(*expected, actual*); | the two double values are almost equal |



| Fatal assertion                       | Nonfatal assertion                    | Verifies                                                     |
| :------------------------------------ | :------------------------------------ | :----------------------------------------------------------- |
| ASSERT_NEAR(*val1, val2, abs_error*); | EXPECT_NEAR*(val1, val2, abs_error*); | the difference between *val1* and *val2* doesn't exceed the given absolute error |



### other

类型检查和谓词检查





# TEST,TEST_F,TEST_P的区别

## TEST

适合给static或者全局函数或者简单类编写单元测试

## TEST_F

测试夹具：对多个测试使用相同的数据配置。多个测试来操作类似的数据，可以使用测试夹具，允许为几个不同的测试重复使用相同的对象配置

可以编写默认构造函数或者setUP()来为测试准备共同对象

如果需要，写一个析构函数或TearDown（）函数来释放你在SetUp（）中分配的任何资源。



## TEST_P

当您想使用参数编写测试时，TEST_P（）非常有用。您可以使用test_P（）编写一个测试，而不是使用不同的参数值编写多个测试，test_P（）使用GetParam（）并可以使用INSTANTIATE_test_SUITE_P（）进行实例化。示例测试. [ Example test](https://github.com/google/googletest/blob/eafd2a91bb0c4fd626aae63ae852812fbd4999f2/googletest/test/googletest-param-test-test.cc#L679)

[ googletest - What is the difference between TEST, TEST_F and TEST_P? - Stack Overflow](https://stackoverflow.com/questions/58600728/what-is-the-difference-between-test-test-f-and-test-p)

TEST_F与TEST的区别是，TEST_F提供了一个初始化函数（SetUp）和一个清理函数(TearDown)，在TEST_F中使用的变量可以在初始化函数SetUp中初始化，在TearDown中销毁，并且所有的TEST_F是互相独立的，都是在初始化以后的状态开始运行，一个TEST_F不会影响另一个TEST_F所使用的数据







# 使用过程

cmake进行编译

windows平台下进行 .h .lib .dll文件就可以配置使用

在编译时注意mt md 多线程区别

> [windows下编译使用googletest - 简书 (jianshu.com)](https://www.jianshu.com/p/e828b0d48ad3)







# 相关开源项目

[GTest Runner](https://github.com/nholthaus/gtest-runner)是一个基于 Qt5 的自动化测试运行器和图形用户界面，具有适用于 Windows 和 Linux 平台的强大功能。

[GoogleTest UI](https://github.com/ospector/gtest-gbar)是一个测试运行器，它运行您的测试二进制文件，允许您通过进度条跟踪其进度，并显示测试失败列表。单击一个显示失败文本。GoogleTest UI 是用 C# 编写的。

[GTest TAP Listener](https://github.com/kinow/gtest-tap-listener)是[GoogleTest ](https://github.com/kinow/gtest-tap-listener)的一个事件监听器，它实现了测试结果输出的 [TAP 协议](https://en.wikipedia.org/wiki/Test_Anything_Protocol)。如果您的测试运行器了解 TAP，您可能会发现它很有用。

[gtest-parallel](https://github.com/google/gtest-parallel)是一个测试运行器，它并行运行来自二进制文件的测试以提供显着的加速。

[GoogleTest Adapter ](https://marketplace.visualstudio.com/items?itemName=DavidSchuldenfrei.gtest-adapter)是一个 VS Code 扩展，允许在树视图中查看 GoogleTest，并运行/调试您的测试。

[C++ TestMate](https://github.com/matepek/vscode-catch2-test-adapter)是一个 VS Code 扩展，允许在树视图中查看 GoogleTest，并运行/调试您的测试。

[Cornichon](https://pypi.org/project/cornichon/)是一个小型 Gherkin DSL 解析器，可为 GoogleTest 生成存根代码。



