# 模板

```python
def timenow(request):
    import datetime
    now =datetime.datetime.now()
    return render(request,"time.html",{"time":now})
```

返回时间

前端页面接受

```html
{{ time|date:"Y-m-d"}}
//上面会显示时间

//会截取view_str的前两位字符，截断的字符串将以 ... 结尾。
{{view_str|truncatechars:2}}

safe
将字符串标记为安全，不需要转义。
要保证 views.py 传过来的数据绝对安全，才能用 safe。
和后端 views.py 的 mark_safe 效果相同。
Django 会自动对 views.py 传到HTML文件中的标签语法进行转义，令其语义失效。加 safe 过滤器是告诉 Django 该数据是安全的，不必对其进行转义，可以让该数据语义生效。
{{ views_str|safe }}
```

### if/else 标签

基本语法格式如下：

```
{% if condition %}
     ... display
{% endif %}
```

或者：

```
{% if condition1 %}
   ... display 1
{% elif condition2 %}
   ... display 2
{% else %}
   ... display 3
{% endif %}
```

根据条件判断是否输出。if/else 支持嵌套。

{% if %} 标签接受 and ， or 或者 not 关键字来对多个变量做判断 ，或者对变量取反（ not )，例如：

```
{% if athlete_list and coach_list %}
     athletes 和 coaches 变量都是可用的。
{% endif %}
```

### for 标签

{% for %} 允许我们在一个序列上迭代。

与 Python 的 for 语句的情形类似，循环语法是 for X in Y ，Y 是要迭代的序列而 X 是在每一个特定的循环中使用的变量名称。

每一次循环中，模板系统会渲染在 **{% for %}** 和 **{% endfor %}** 之间的所有内容。例如，给定一个运动员列表 athlete_list 变量，我们可以使用下面的代码来显示这个列表：

```
<ul>
{% for athlete in athlete_list %}
    <li>{{ athlete.name }}</li>
{% endfor %}
</ul>

{% for athlete in athlete_list reversed %}
...
{% endfor %}
//加上reversed使得该列表反向迭代
```

**遍历字典**: 可以直接用字典 **.items** 方法，用变量的解包分别获取键和值。

```
{% for i,j in views_dict.items %}
{{ i }}---{{ j }}
{% endfor %}
```

在 {% for %} 标签里可以通过 {{forloop}} 变量获取循环序号。

- forloop.counter: 顺序获取循环序号，从 1 开始计算
- forloop.counter0: 顺序获取循环序号，从 0 开始计算
- forloop.revcounter: 倒序获取循环序号，结尾序号为 1
- forloop.revcounter0: 倒序获取循环序号，结尾序号为 0
- forloop.first（一般配合if标签使用）: 第一条数据返回 True，其他数据返回 False
- forloop.last（一般配合if标签使用）: 最后一条数据返回 True，其他数据返回 False

### ifequal/ifnotequal 标签

{% ifequal %} 标签比较两个值，当他们相等时，显示在 {% ifequal %} 和 {% endifequal %} 之中所有的值。

下面的例子比较两个模板变量 user 和 currentuser :

```
{% ifequal user currentuser %}
    <h1>Welcome!</h1>
{% endifequal %}
```

和 {% if %} 类似， {% ifequal %} 支持可选的 {% else%} 标签：8

```
{% ifequal section 'sitenews' %}
    <h1>Site News</h1>
{% else %}
    <h1>No News Here</h1>
{% endifequal %}
```

### 注释标签

Django 注释使用 {# #}。

```
{# 这是一个注释 #}
```

### include 标签

{% include %} 标签允许在模板中包含其它的模板的内容。

下面这个例子都包含了 nav.html 模板：

```
{% include "nav.html" %}
```

------

## csrf_token

csrf_token 用于form表单中，作用是跨站请求伪造保护。

如果不用｛% csrf_token %｝标签，在用 form 表单时，要再次跳转页面会报403权限错误。

用了｛% csrf_token %｝标签，在 form 表单提交数据时，才会成功。

**解析：**

首先，向服务器发送请求，获取登录页面，此时中间件 csrf 会自动生成一个隐藏input标签，该标签里的 value 属性的值是一个随机的字符串，用户获取到登录页面的同时也获取到了这个隐藏的input标签。

然后，等用户需要用到form表单提交数据的时候，会携带这个 input 标签一起提交给中间件 csrf，原因是 form 表单提交数据时，会包括所有的 input 标签，中间件 csrf 接收到数据时，会判断，这个随机字符串是不是第一次它发给用户的那个，如果是，则数据提交成功，如果不是，则返回403权限错误。

------

## 自定义标签和过滤器

1、在应用目录下创建 **templatetags** 目录(与 templates 目录同级，目录名只能是 templatetags)。

```
HelloWorld/
|-- HelloWorld
|   |-- __init__.py
|   |-- __init__.pyc
|   |-- settings.py
...
|-- manage.py
`-- templatetags
`-- templates
```

2、在 templatetags 目录下创建任意 py 文件，如：**my_tags.py**。

3、my_tags.py 文件代码如下：

```
from django import template

register = template.Library()   #register的名字是固定的,不可改变
```

修改 settings.py 文件的 TEMPLATES 选项配置，添加 libraries 配置：

settings.py 配置文件

```
TEMPLATES = [
  {
    'BACKEND': 'django.template.backends.django.DjangoTemplates',
    'DIRS': [BASE_DIR, "/templates",],
    'APP_DIRS': True,
    'OPTIONS': {
      'context_processors': [
        'django.template.context_processors.debug',
        'django.template.context_processors.request',
        'django.contrib.auth.context_processors.auth',
        'django.contrib.messages.context_processors.messages',
      ],
      "libraries":{              # 添加这边三行配置
        'my_tags':'templatetags.my_tags'  # 添加这边三行配置     
      }                    # 添加这边三行配置
    },
  },
]
```

4、利用装饰器 @register.filter 自定义过滤器。

**注意：**装饰器的参数最多只能有 2 个。

```
@register.filter
def my_filter(v1, v2):
    return v1 * v2
```

5、利用装饰器 @register.simple_tag 自定义标签。

```
@register.simple_tag
def my_tag1(v1, v2, v3):
    return v1 * v2 * v3
```

6、在使用自定义标签和过滤器前，要在 html 文件 body 的最上方中导入该 py 文件。

```
{% load my_tags %}
```

7、在 HTML 中使用自定义过滤器。

```
{{ 11|my_filter:22 }}
```

8、在 HTML 中使用自定义标签。

```
{% my_tag1 11 22 33 %}
```

9、语义化标签

在该 py 文件中导入 mark_safe。

```
from django.utils.safestring import mark_safe
```

定义标签时，用上 mark_safe 方法，令标签语义化，相当于 jQuery 中的 html() 方法。

和前端HTML文件中的过滤器 safe 效果一样。

```
@register.simple_tag
def my_html(v1, v2):
    temp_html = "<input type='text' id='%s' class='%s' />" %(v1, v2)
    return mark_safe(temp_html)
```

在HTML中使用该自定义标签，在页面中动态创建标签。

```
{% my_html "zzz" "xxx" %}
```

## 配置静态文件

1、在项目根目录下创建 statics 目录。

![image-20220307165555501](img/image-20220307165555501-16466433573362.png)

2、在 settings 文件的最下方配置添加以下配置：

![image-20220307165621724](img/image-20220307165621724-16466433827653.png)

3、在 statics 目录下创建 css 目录，js 目录，images 目录，plugins 目录， 分别放 css文件，js文件，图片，插件。

4、把 bootstrap 框架放入插件目录 plugins。

5、在 HTML 文件的 head 标签中引入 bootstrap。

**注意：**此时引用路径中的要用配置文件中的别名 static，而不是目录 statics。

## 模板继承

模板可以用继承的方式来实现复用，减少冗余内容。

网页的头部和尾部内容一般都是一致的，我们就可以通过模板继承来实现复用。

父模板用于放置可重复利用的内容，子模板继承父模板的内容，并放置自己的内容。

### 父模板

**标签 block...endblock:** 父模板中的预留区域，该区域留给子模板填充差异性的内容，不同预留区域名字不能相同。

```
{% block 名称 %} 
预留给子模板的区域，可以设置设置默认内容
{% endblock 名称 %}
```

### 子模板

子模板使用标签 extends 继承父模板：

```
{% extends "父模板路径"%} 
```

子模板如果没有设置父模板预留区域的内容，则使用在父模板设置的默认内容，当然也可以都不设置，就为空。

子模板设置父模板预留区域的内容：

```
{ % block 名称 % }
内容 
{% endblock 名称 %}
```

接下来我们先创建之前项目的 templates 目录中添加 base.html 文件，代码如下：

# Django模型

```
pip install pymysql
```

Django 模型使用自带的 ORM。

对象关系映射（Object Relational Mapping，简称 ORM ）用于实现面向对象编程语言里不同类型系统的数据之间的转换。

ORM 在业务逻辑层和数据库层之间充当了桥梁的作用。

ORM 是通过使用描述对象和数据库之间的映射的元数据，将程序中的对象自动持久化到数据库中。

![img](https://www.runoob.com/wp-content/uploads/2020/05/django-orm1.png)

使用 ORM 的好处：

- 提高开发效率。
- 不同数据库可以平滑切换。

使用 ORM 的缺点：

- ORM 代码转换为 SQL 语句时，需要花费一定的时间，执行效率会有所降低。
- 长期写 ORM 代码，会降低编写 SQL 语句的能力。

ORM 解析过程:

- 1、ORM 会将 Python 代码转成为 SQL 语句。
- 2、SQL 语句通过 pymysql 传送到数据库服务端。
- 3、在数据库中执行 SQL 语句并将结果返回。

ORM 对应关系表：

![img](https://www.runoob.com/wp-content/uploads/2020/05/orm-object.png)

## 数据库配置

### Django 如何使用 mysql 数据库

创建 MySQL 数据库( ORM 无法操作到数据库级别，只能操作到数据表)语法：

```sql
create database myblog defailt charset=utf8;
```

配置项目里面的setting.py对应的DATABASES

```python
DATABASES = { 
    'default': 
    { 
        'ENGINE': 'django.db.backends.mysql',    # 数据库引擎
        'NAME': 'runoob', # 数据库名称
        'HOST': '127.0.0.1', # 数据库地址，本机 ip 地址 127.0.0.1 
        'PORT': 3306, # 端口 
        'USER': 'root',  # 数据库用户名
        'PASSWORD': '123456', # 数据库密码
    }  
}
```

告诉 Django 使用 pymysql 模块连接 mysql 数据库：

实例在与 settings.py 同级目录下的 __init__.py 中引入模块和进行配置

```python
import pymysql
pymysql.install_as_MySQLdb()
```

## 定义模型

### 创建 APP

Django 规定，如果要使用模型，必须要创建一个 app。我们使用以下命令创建一个 TestModel 的 app:

```
django-admin startapp TestModel
```

目录结构如下：

```
HelloWorld
|-- HelloWorld
|-- manage.py
...
|-- TestModel
|   |-- __init__.py
|   |-- admin.py
|   |-- models.py
|   |-- tests.py
|   `-- views.py
```

我们修改 TestModel/models.py 文件，代码如下：

HelloWorld/TestModel/models.py: 文件代码：

```python
from django.db import models

# Create your models here.
class Test(models.Model):
    name = models.CharField(max_length=20)
    time =models.DateTimeField()
    age = models.IntegerField(default=0);
```



以上的类名代表了数据库表名，且继承了models.Model，类里面的字段代表数据表中的字段(name)，数据类型则由CharField（相当于varchar）、DateField（相当于datetime）， max_length 参数限定长度。

**可以参照官方文档来看**

接下来在 settings.py 中找到INSTALLED_APPS这一项，如下：

```
INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'TestModel',               # 添加此项
)
```

在命令行中运行：

```
$ python3 manage.py migrate   # 创建表结构

$ python3 manage.py makemigrations TestModel  # 让 Django 知道我们在我们的模型有一些变更
$ python3 manage.py migrate TestModel   # 创建表结构
```

看到几行 "Creating table…" 的字样，你的数据表就创建好了。

```
Creating tables ...
……
Creating table TestModel_test  #我们自定义的表
……
```

表名组成结构为：应用名_类名（如：TestModel_test）。

**注意：**尽管我们没有在 models 给表设置主键，但是 Django 会自动添加一个 id 作为主键。



## Django模型（Model）字段类型级参数详解

| 序号 | 字段类型（Filed Types） | 描述                                                         |
| ---- | ----------------------- | ------------------------------------------------------------ |
| 1    | AutoField               | 根据可用id自动递增的整数字段。通常不需要直接使用它;如果不指定[主键](https://so.csdn.net/so/search?q=主键&spm=1001.2101.3001.7020)字段，则会自动将主键字段添加到模型中。 |
| 2    | CharField               | 用来存储字符串，必须制定范围，如果存储大文本字符串，应当用TextField. |
| 3    | DateField               | 使用Python的datetime.date实例保存的日期。auto_now = True:每次保存对象时，自动设置该字段为当前时间;auto_now_add=True:对象第一次被创建时自动设置当前时间。需要注意的是，自动保存的时间的时区使用的是默认时区。 |
| 4    | DateTimeField           | 使用Python的datetime.datetime实例表示的日期和时间。          |
| 5    | TextField               | 存储大字符串                                                 |
| 6    | BigIntegerField         | 64位的整型数值，从 -2^63 (-9223372036854775808) 到 2^63-1(9223372036854775807) |
| 7    | BinaryField             | 存储二进制码的Field. 只支持bytes 赋值。                      |
| 8    | BooleanField            | 该字段的默认表单控件是CheckboxInput，如果你需要设置null 值，则使用NullBooleanField 来代替BooleanField。 |
| 9    | FloatField              | 用Python的一个float 实例来表示一个浮点数。                   |
| 10   | UUIDField               | 一个用来存储UUID的字段。使用Python的UUID类。                 |
| 11   | ForeignKey              | 多对一关系                                                   |
| 12   | ManyToManyField         | 多对多关联                                                   |
| 13   | OneToOneField           | 一对一关联关系                                               |

1、null=True   数据库中字段是否可以为空

2、blank=True     django的 Admin 中添加数据时是否可允许空值

3、primary_key = False

主键，对AutoField设置主键后，就会代替原来的自增 id 列

如果您没有为模型中的任何字段指定primary_key=True, Django将自动添加一个IntegerField来保存主键，所以您不需要在任何字段上设置primary_key=True，除非您想要覆盖默认的主键行为。有关更多信息，请参见自动主键字段。

主键字段是只读的。如果您更改现有对象上的主键值，然后保存它，就会在旧对象旁边创建一个新对象。

4、auto_now 和 auto_now_add

auto_now  自动创建---无论添加或修改，都是当前操作的时间

auto_now_add  自动创建---永远是创建时的时间

5、choices

```python
GENDER_CHOICE = (
        (u'M', u'Male'),
        (u'F', u'Female'),
    )
gender = models.CharField(max_length=2,choices = GENDER_CHOICE)
```

6、max_length   字符串最大长度

7、default    默认值

8、verbose_name Admin     中字段的显示名称

9、name|db_column　　数据库中的字段名称

10、unique=True　　

不允许重复，例如用户名注册时候是不允许重复的,在username字段里设置,不让重复

11、db_index = True　　数据库索引   

12、editable=True　　在Admin里是否可编辑

13、error_messages=None　　

错误提示  

把错误提示修改成你想要的报错,这里加个字典来完成 gender = models.CharField(max_length=2,choices = GENDER_CHOICE,error_messages={"错误类型":"错误原因"})

14、auto_created=False　　自动创建

15、help_text　　在Admin中提示帮助信息

16、validators=[]   提示区间,例如电话号码范围

17、upload-to  文件上传功能 在 FileField 里加入 例如: file = modles.FileField(upload-to = "./upload/"    指明上传的文件防止根目录下的/upload/文件夹下

## model操作增删改查

```python
from django.shortcuts import render
from django.shortcuts import HttpResponse
# Create your views here.
from TestModel.models import Test
import datetime
def testdb(request):
    test1 =Test(name="aaa",age=12)
    test1.save();
    return HttpResponse("ok")
# 数据库操作获取数据
def dataget(request):
    # 初始化
    response = ""
    response1 = ""
    # 通过objects这个模型管理器的all()获得所有数据行，相当于SQL中的SELECT * FROM
    list = Test.objects.all()
    # filter相当于SQL中的WHERE，可设置条件过滤结果
    response2 = Test.objects.filter(id=1)
    # 获取单个对象
    response3 = Test.objects.get(id=1)
    # 限制返回的数据 相当于 SQL 中的 OFFSET 0 LIMIT 2;
    Test.objects.order_by('name')[0:2]
    # 数据排序
    Test.objects.order_by("id")
    # 上面的方法可以连锁使用
    Test.objects.filter(name="aaa").order_by("id")
    # 输出所有数据
    for var in list:
        response1 += var.name + " "
    response = response1
    return HttpResponse("<p>" + response + "</p>")
def datachange(request):
    # 修改其中一个id=1的name字段，再save，相当于SQL中的UPDATE
    test1 = Test.objects.get(id=1)
    test1.name = 'Google'
    test1.save()
    # 另外一种方式
    # Test.objects.filter(id=1).update(name='Google')
    # 修改所有的列
    # Test.objects.all().update(name='Google')
    return HttpResponse("<p>修改成功</p>")
# 数据库操作
def datadel(request):
    # 删除id=1的数据
    test1 = Test.objects.get(id=1)
    test1.delete()
    # 另外一种方式
    # Test.objects.filter(id=1).delete()
    # 删除所有数据
    # Test.objects.all().delete()
    return HttpResponse("<p>删除成功</p>")
```

## 数据好后的流程

python manage.py makemigrations //存在子应用的migrations目录里面

python manage.py migrate 执行迁移

# Django表单

## HTTP 请求

HTTP协议以"请求－回复"的方式工作。客户发送请求时，可以在请求中附加数据。服务器通过解析请求，就可以获得客户传来的数据，并根据URL来提供特定的服务。

## form get获取请求

1、提交的步骤：

1）form表单通过action 确定提交的位置，不写或者为空代表提交到当前路由

2）form表单同method确认请求的方式，不写默认为空，或者代表get方式提交

3）form表单提交的时候，表单元素必须有name，且唯一

2、发起提交事件

![image-20220307155734345](C:\Users\15350\AppData\Roaming\Typora\typora-user-images\image-20220307155734345.png)

3、后端（views）处理数据

（1）接收数据

​        request.GET 可以接受前端传递过来的get请求的数据

​        request.GET 是一个类字典对象

（2）处理数据

​         对数据进行增删改查

（3）返回处理

​         locals（）

## form POST请求

CSRF（Cross-site-request-forgery）跨站请求伪造 . XSRF

默认的Django请求必须经过CSRF请求，否则，POST请求会被拒绝

解决办法：

Django post请求步骤：

  1、使用render方法进行返回

​      render方法 的第一个参数必须是request，其他地方和render_to_reponse方法相似。

 2、在form表单的最上层添加{% csrf-token % }

3、开始和get请求类似的接收数据和处理数据的步骤。

## Request 对象

每个视图函数的第一个参数是一个 HttpRequest 对象，就像下面这个 runoob() 函数:

```
from django.http import HttpResponse

def runoob(request):
    return HttpResponse("Hello world")
```

HttpRequest对象包含当前请求URL的一些信息：

| **属性**      | **描述**                                                     |
| ------------- | ------------------------------------------------------------ |
| path          | 请求页面的全路径,不包括域名—例如, "/hello/"。                |
| method        | 请求中使用的HTTP方法的字符串表示。全大写表示。例如:if request.method == 'GET':   do_something() elif request.method == 'POST':   do_something_else() |
| GET           | 包含所有HTTP GET参数的类字典对象。参见QueryDict 文档。       |
| POST          | 包含所有HTTP POST参数的类字典对象。参见QueryDict 文档。服务器收到空的POST请求的情况也是有可能发生的。也就是说，表单form通过HTTP POST方法提交请求，但是表单中可以没有数据。因此，不能使用语句if request.POST来判断是否使用HTTP POST方法；应该使用if request.method == "POST" (参见本表的method属性)。注意: POST不包括file-upload信息。参见FILES属性。 |
| REQUEST       | 为了方便，该属性是POST和GET属性的集合体，但是有特殊性，先查找POST属性，然后再查找GET属性。借鉴PHP's $_REQUEST。例如，如果GET = {"name": "john"} 和POST = {"age": '34'},则 REQUEST["name"] 的值是"john", REQUEST["age"]的值是"34".强烈建议使用GET and POST,因为这两个属性更加显式化，写出的代码也更易理解。 |
| COOKIES       | 包含所有cookies的标准Python字典对象。Keys和values都是字符串。 |
| FILES         | 包含所有上传文件的类字典对象。FILES中的每个Key都是<input type="file" name="" />标签中name属性的值. FILES中的每个value 同时也是一个标准Python字典对象，包含下面三个Keys:filename: 上传文件名,用Python字符串表示content-type: 上传文件的Content typecontent: 上传文件的原始内容注意：只有在请求方法是POST，并且请求页面中<form>有enctype="multipart/form-data"属性时FILES才拥有数据。否则，FILES 是一个空字典。 |
| META          | 包含所有可用HTTP头部信息的字典。 例如:CONTENT_LENGTHCONTENT_TYPEQUERY_STRING: 未解析的原始查询字符串REMOTE_ADDR: 客户端IP地址REMOTE_HOST: 客户端主机名SERVER_NAME: 服务器主机名SERVER_PORT: 服务器端口META 中这些头加上前缀 **HTTP_** 为 Key, 冒号(:)后面的为 Value， 例如:HTTP_ACCEPT_ENCODINGHTTP_ACCEPT_LANGUAGEHTTP_HOST: 客户发送的HTTP主机头信息HTTP_REFERER: referring页HTTP_USER_AGENT: 客户端的user-agent字符串HTTP_X_BENDER: X-Bender头信息 |
| user          | 是一个django.contrib.auth.models.User 对象，代表当前登录的用户。如果访问用户当前没有登录，user将被初始化为django.contrib.auth.models.AnonymousUser的实例。你可以通过user的is_authenticated()方法来辨别用户是否登录：`if request.user.is_authenticated():    # Do something for logged-in users. else:    # Do something for anonymous users.`只有激活Django中的AuthenticationMiddleware时该属性才可用 |
| session       | 唯一可读写的属性，代表当前会话的字典对象。只有激活Django中的session支持时该属性才可用。 |
| raw_post_data | 原始HTTP POST数据，未解析过。 高级处理时会有用处。           |

Request对象也有一些有用的方法：

| 方法              | 描述                                                         |
| :---------------- | :----------------------------------------------------------- |
| \__getitem__(key) | 返回GET/POST的键值,先取POST,后取GET。如果键不存在抛出 KeyError。 这是我们可以使用字典语法访问HttpRequest对象。 例如,request["foo"]等同于先request.POST["foo"] 然后 request.GET["foo"]的操作。 |
| has_key()         | 检查request.GET or request.POST中是否包含参数指定的Key。     |
| get_full_path()   | 返回包含查询字符串的请求路径。例如， "/music/bands/the_beatles/?print=true" |
| is_secure()       | 如果请求是安全的，返回True，就是说，发出的是HTTPS请求。      |

## QueryDict对象

在HttpRequest对象中, GET和POST属性是django.http.QueryDict类的实例。

QueryDict类似字典的自定义类，用来处理单键对应多值的情况。

QueryDict实现所有标准的词典方法。还包括一些特有的方法：

| **方法**     | **描述**                                                     |
| :----------- | :----------------------------------------------------------- |
| \__getitem__ | 和标准字典的处理有一点不同，就是，如果Key对应多个Value，__getitem__()返回最后一个value。 |
| \__setitem__ | 设置参数指定key的value列表(一个Python list)。注意：它只能在一个mutable QueryDict 对象上被调用(就是通过copy()产生的一个QueryDict对象的拷贝). |
| get()        | 如果key对应多个value，get()返回最后一个value。               |
| update()     | 参数可以是QueryDict，也可以是标准字典。和标准字典的update方法不同，该方法添加字典 items，而不是替换它们:`>>> q = QueryDict('a=1') >>> q = q.copy() # to make it mutable >>> q.update({'a': '2'}) >>> q.getlist('a')  ['1', '2'] >>> q['a'] # returns the last ['2']` |
| items()      | 和标准字典的items()方法有一点不同,该方法使用单值逻辑的__getitem__():`>>> q = QueryDict('a=1&a=2&a=3') >>> q.items() [('a', '3')]` |
| values()     | 和标准字典的values()方法有一点不同,该方法使用单值逻辑的__getitem__(): |

此外, QueryDict也有一些方法，如下表：

| **方法**                 | **描述**                                                     |
| :----------------------- | :----------------------------------------------------------- |
| copy()                   | 返回对象的拷贝，内部实现是用Python标准库的copy.deepcopy()。该拷贝是mutable(可更改的) — 就是说，可以更改该拷贝的值。 |
| getlist(key)             | 返回和参数key对应的所有值，作为一个Python list返回。如果key不存在，则返回空list。 It's guaranteed to return a list of some sort.. |
| setlist(key,list_)       | 设置key的值为list_ (unlike __setitem__()).                   |
| appendlist(key,item)     | 添加item到和key关联的内部list.                               |
| setlistdefault(key,list) | 和setdefault有一点不同，它接受list而不是单个value作为参数。  |
| lists()                  | 和items()有一点不同, 它会返回key的所有值，作为一个list, 例如:`>>> q = QueryDict('a=1&a=2&a=3') >>> q.lists() [('a', ['1', '2', '3'])] ` |
| urlencode()              | 返回一个以查询字符串格式进行格式化后的字符串(例如："a=2&b=3&b=5")。 |

# Django 视图

### 视图层

一个视图函数，简称视图，是一个简单的 Python 函数，它接受 Web 请求并且返回 Web 响应。

响应可以是一个 HTML 页面、一个 404 错误页面、重定向页面、XML 文档、或者一张图片...

无论视图本身包含什么逻辑，都要返回响应。代码写在哪里都可以，只要在 Python 目录下面，一般放在项目的 views.py 文件中。

每个视图函数都负责返回一个 HttpResponse 对象，对象中包含生成的响应。

视图层中有两个重要的对象：请求对象(request)与响应对象(HttpResponse)。

## 请求对象: HttpRequest 对象（简称 request 对象）

以下介绍几个常用的 request 属性。

### 1、GET

数据类型是 QueryDict，一个类似于字典的对象，包含 HTTP GET 的所有参数。

有相同的键，就把所有的值放到对应的列表里。

取值格式：**对象.方法**。

**get()**：返回字符串，如果该键对应有多个值，取出该键的最后一个值。

### 2、POST

数据类型是 QueryDict，一个类似于字典的对象，包含 HTTP POST 的所有参数。

常用于 form 表单，form 表单里的标签 name 属性对应参数的键，value 属性对应参数的值。

取值格式： **对象.方法**。

**get()**：返回字符串，如果该键对应有多个值，取出该键的最后一个值。

### 3、body

数据类型是二进制字节流，是原生请求体里的参数内容，在 HTTP 中用于 POST，因为 GET 没有请求体。

在 HTTP 中不常用，而在处理非 HTTP 形式的报文时非常有用，例如：二进制图片、XML、Json 等。

### 4、path

获取 URL 中的路径部分，数据类型是字符串。

### 5、method

获取当前请求的方式，数据类型是字符串，且结果为大写。

## 响应对象：HttpResponse 对象

响应对象主要有三种形式：HttpResponse()、render()、redirect()。

**HttpResponse():** 返回文本，参数为字符串，字符串中写文本内容。如果参数为字符串里含有 html 标签，也可以渲染。

**render():** 返回文本，第一个参数为 request，第二个参数为字符串（页面名称），第三个参数为字典（可选参数，向页面传递的参数：键为页面参数名，值为views参数名）。

**redirect()**：重定向，跳转新页面。参数为字符串，字符串中填写页面路径。一般用于 form 表单提交后，跳转到新页面。

# Django 路由

路由简单的来说就是根据用户请求的 URL 链接来判断对应的处理程序，并返回处理结果，也就是 URL 与 Django 的视图建立映射关系。

Django 路由在 urls.py 配置，urls.py 中的每一条配置对应相应的处理方法。

- path：用于普通路径，不需要自己手动添加正则首位限制符号，底层已经添加。
- re_path：用于正则路径，需要自己手动添加正则首位限制符号。

实例

```python
from django.urls import re_path # 用re_path 需要引入
urlpatterns = [
  path('admin/', admin.site.urls),
  path('index/', views.index), # 普通路径
  re_path(r'^articles/([0-9]{4})/$', views.articles), # 正则路径
]
```

## 正则路径中的分组

### 正则路径中的无名分组

无名分组按位置传参，一一对应。

views 中除了 request，其他形参的数量要与 urls 中的分组数量一致。

### 正则路径中的有名分组

语法：

```
(?P<组名>正则表达式)
```

有名分组按关键字传参，与位置顺序无关。

views 中除了 request，其他形参的数量要与 urls 中的分组数量一致， 并且 views 中的形参名称要与 urls 中的组名对应。

### 路由分发(include)

**存在问题**：Django 项目里多个app目录共用一个 urls 容易造成混淆，后期维护也不方便。

**解决**：使用路由分发（include），让每个app目录都单独拥有自己的 urls。

**步骤：**

- 1、在每个 app 目录里都创建一个 urls.py 文件。
- 2、在项目名称目录下的 urls 文件里，统一将路径分发给各个 app 目录。

## 反向解析

随着功能的增加，路由层的 url 发生变化，就需要去更改对应的视图层和模板层的 url，非常麻烦，不便维护。

这时我们可以利用反向解析，当路由层 url 发生改变，在视图层和模板层动态反向解析出更改后的 url，免去修改的操作。

反向解析一般用在模板中的超链接及视图中的重定向。

### 普通路径

在 urls.py 中给路由起别名，**name="路由别名"**。

```python
path("login1/", views.login, name="login")
```

在 views.py 中，从 django.urls 中引入 reverse，利用 **reverse("路由别名")** 反向解析:

```python
return redirect(reverse("login"))
```

在模板 templates 中的 HTML 文件中，利用 **{% url "路由别名" %}** 反向解析。

```python
<form action="{% url 'login' %}" method="post"> 
```

### 正则路径（无名分组）

在 urls.py 中给路由起别名，**name="路由别名"**。

```
re_path(r"^login/([0-9]{2})/$", views.login, name="login")
```

在 views.py 中，从 django.urls 中引入 reverse，利用 **reverse("路由别名"，args=(符合正则匹配的参数,))** 反向解析。

```python
return redirect(reverse("login",args=(10,)))
```

在模板 templates 中的 HTML 文件中利用 **{% url "路由别名" 符合正则匹配的参数 %}** 反向解析。

```python
<form action="{% url 'login' 10 %}" method="post"> 
```

### 正则路径（有名分组）

在 urls.py 中给路由起别名，**name="路由别名"**。

```python
re_path(r"^login/(?P<year>[0-9]{4})/$", views.login, name="login")
```

在 views.py 中，从 django.urls 中引入 reverse，利用 **reverse("路由别名"，kwargs={"分组名":符合正则匹配的参数})** 反向解析。

```python
return redirect(reverse("login",kwargs={"year":3333}))
```

在模板 templates 中的 HTML 文件中，利用 **{% url "路由别名" 分组名=符合正则匹配的参数 %}** 反向解析。

```html
<form action="{% url 'login' year=3333 %}" method="post">
```

## 命名空间

命名空间（英语：Namespace）是表示标识符的可见范围。

一个标识符可在多个命名空间中定义，它在不同命名空间中的含义是互不相干的。

一个新的命名空间中可定义任何标识符，它们不会与任何重复的标识符发生冲突，因为重复的定义都处于其它命名空间中。

**存在问题：**路由别名 name 没有作用域，Django 在反向解析 URL 时，会在项目全局顺序搜索，当查找到第一个路由别名 name 指定 URL 时，立即返回。当在不同的 app 目录下的urls 中定义相同的路由别名 name 时，可能会导致 URL 反向解析错误。

**解决：**使用命名空间。

### 普通路径

```
include(("app名称：urls"，"app名称"))
```

实例：

```
path("app01/", include(("app01.urls","app01"))) 
path("app02/", include(("app02.urls","app02")))
```

在 app01/urls.py 中起相同的路由别名。

```
path("login/", views.login, name="login")
```

在 views.py 中使用名称空间，语法格式如下：

```
reverse("app名称：路由别名")
```

实例：

```
return redirect(reverse("app01:login")
```

在 templates 模板的 HTML 文件中使用名称空间，语法格式如下：

```
{% url "app名称：路由别名" %}
```

实例：

```
<form action="{% url 'app01:login' %}" method="post">
```

# Django Admin 管理工具

```python
python manage.py createsuperuser
```

使用管理工具

model里面定义

admin里面注册

## 自定义表单

定义后台显示样式与添加方式

## 内联(Inline)显示

可以让有关系的数据在一页显示

## 列表页的显示

在指定列表下可以设置list_display属性来显示内容

```python
list_display = ('name', 'age', 'email')
```

当有大量数据时候也可以search_fields来显示搜索栏

```python
search_fields = ("name",)
```

andmin官网文档里面还有很多实用功能，可以参照官方文档来学习



