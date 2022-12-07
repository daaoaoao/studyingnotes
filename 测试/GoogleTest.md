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

`ASSERT_TRUE()`、`ASSERT_FALSE()`、`EXPECT_EQ()`、`EXPECT_NE()`、`EXPECT_LT()`、`EXPECT_LE()`、`EXPECT_GT()`和`EXPECT_GE()`。





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



## Global

创建一个继承testing::Environment的类，并实现其中的SetUp()和TearDown()两种方法，最后在main()函数中通过testing::AddGlobalTestEnvironment()进行注册



## TestSuite

需要创建一个与test_suite_name名称相同的类，同时需要继承testing::Test类，并实现其中的两个静态方法SetUpTestCase()以及TearDownTestCase()，分别会在第一个用例前以及最后一个用例后执行



## TestCase

与 TestSuite 级别使用相同的类，但是需要实现的方法不同，需要实现 `SetUp()` 以及 `TearDown()` 两个函数，分别在每个测试用例的前后执行。注意，在两个测试用例中执行的内容是不会相互影响的。





# 相关开源项目

[GTest Runner](https://github.com/nholthaus/gtest-runner)是一个基于 Qt5 的自动化测试运行器和图形用户界面，具有适用于 Windows 和 Linux 平台的强大功能。

[GoogleTest UI](https://github.com/ospector/gtest-gbar)是一个测试运行器，它运行您的测试二进制文件，允许您通过进度条跟踪其进度，并显示测试失败列表。单击一个显示失败文本。GoogleTest UI 是用 C# 编写的。

[GTest TAP Listener](https://github.com/kinow/gtest-tap-listener)是[GoogleTest ](https://github.com/kinow/gtest-tap-listener)的一个事件监听器，它实现了测试结果输出的 [TAP 协议](https://en.wikipedia.org/wiki/Test_Anything_Protocol)。如果您的测试运行器了解 TAP，您可能会发现它很有用。

[gtest-parallel](https://github.com/google/gtest-parallel)是一个测试运行器，它并行运行来自二进制文件的测试以提供显着的加速。

[GoogleTest Adapter ](https://marketplace.visualstudio.com/items?itemName=DavidSchuldenfrei.gtest-adapter)是一个 VS Code 扩展，允许在树视图中查看 GoogleTest，并运行/调试您的测试。

[C++ TestMate](https://github.com/matepek/vscode-catch2-test-adapter)是一个 VS Code 扩展，允许在树视图中查看 GoogleTest，并运行/调试您的测试。

[Cornichon](https://pypi.org/project/cornichon/)是一个小型 Gherkin DSL 解析器，可为 GoogleTest 生成存根代码。