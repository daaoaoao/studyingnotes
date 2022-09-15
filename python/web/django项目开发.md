# 企业网站

```python
python manage.py startapp aboutApp
python manage.py startapp newsApp
python manage.py startapp productsApp
python manage.py startapp serviceApp
python manage.py startapp scienceApp
python manage.py startapp contactApp
来创建公司简介”(aboutApp)、“新闻动态”(newsApp)、“产品中心”(productsApp)、“服务支持”(serviceApp)、“科研基地”(scienceApp)、“人才招聘”(contactApp)

```

模型的设计

```python
#来获取当前时间
from django.utils import timezone
```



setting添加配置

配置路由和访问

导入静态文件

```
{% load static %}
```

寻找方式 应用名:函数名 无应用名也可不写，如果定义了应用名函数名可以反向解析

```html
<a href="{% url 'home' %}">首页</a>
```



基于Django模板的复用

- 可以显著减少前端代码编写量；
- 当需要对各个页面共享的部分进行修改时，例如需要更换企业logo图标，此时只需要修改共享页面即可，不需要单独对每个页面进行改动；

为了使用templates到各个应用里面需要

```python
'DIRS': [os.path.join(BASE_DIR, 'templates')],
```

显示在当前页面

```html
<script type="text/JavaScript">
    $('#{{active_menu}}').addClass("active");
</script>
```

Django上传图片

配置文件

```python
# 添加媒体资源
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media/')

#pip install pillow 
#安装图像处理库
#查询图片
from .models import Award
 
def honor(request):
    awards = Award.objects.all()
    return render(request, 'honor.html', {
        'active_menu': 'about',
        'sub_menu': 'honor',
        'awards': awards,
    })
```

前端显示图片

```html
<div class="col-md-9">
    <div class="model-details-title">
        荣誉资质
    </div>
    <div class="row">
        {% for award in awards %}
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <img src="{{award.photo.url}}">
                <div class="caption">
                    <p>{{award.description}}</p>
                </div>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
```

图片显示异常时,添加一下代码到主app的urls里面

```python
from django.conf import settings
from django.conf.urls.static import static
 
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)
```

对于url捕获值

```python
要从url中捕获值，需要使用尖括号<>来定义路由附带的参数。参数类型可以自行定义，在上述实例中使用了<str:productName>，表示该路由带的参数名为productName，参数类型为str字符串类型。
    
app_name = 'productsApp'
 
urlpatterns = [
    path('products/<str:productName>/', views.products, name='products'),
]
```

后端传递数据到前端模板进行数据处理

对于文本处理方式：产品文字部分采用{{ product.title}}模板变量来实现，其后紧跟的truncatechars为Django提供的模板过滤器，可以对文字进行截断显示。此处对应的product.title截断字数为20，产品文字描述{{ product.description }}截断字数为150。Django提供了多达30多种的过滤器可供使用，各个过滤器可以级联使用。例如在本例的产品文字描述部分，不仅使用了truncatechars过滤器，同时也使用了linebreaks过滤器，使得文字的换行能够有效的在HTML中实现。



分页

```python
Django提供了一个分页类Paginator来帮助管理分页数据
#获取页数
page = int(request.GET.get('page',1))
#具体分页实现要结合前后端代码
```

实现分页的思想，页面默认位于第一也 点击以后返回当前page页 判读左右两边还剩下的页数  和预留判读第一页和最后一页，有关分页的一些关键数据以字典“键—值”对形式存于变量pageData传入前端来判断



富文本编辑器的添加

添加现成的富文本编辑器来源于git

```
https://github.com/twz915/DjangoUeditor3/

富文本字段的注册形式，通过定义style_fields属性来绑定富文本字段
```

表单传递数据到后台

Django提供了两种表单的基本类：

- Form：标准表单。可以对输入数据作验证，但没有与数据库模型关联；
- ModelForm：模型表单。可以对输入数据作验证，同时与数据库模型进行了关联，可以直接通过模型表单存储和修改数据库数据； 

为了方便开发，本节重点阐述模型表单的使用方法。具体分为3个步骤：
（1）定义模型；
（2）根据模型创建模型表单；
（3）视图处理函数中通过模型表单接收并解析数据，最后渲染页面；

- 首先从Django中导入forms类来使用表单组件。新建的模型表单类ResumeForm继承自forms.ModelForm，表明该表单是一个模型表单；

- 模型表单通过元信息类Meta来进行模型的定制化。model属性指向具体需要定制化的模型。fields属性用来指明需要定制化的具体字段；

- 由于模型中有两个字段是单选菜单形式展示，因此需要为这两个字段设置可选项sex_list和edu_list；

- 最后一个属性widgets用来控制各个表单字段在前端的具体展现形式，默认情况下模型中的CharField字段对应HTML中的输入文本框，其它字段的前端形式在widgets中进行设置；

- 两个单选下拉菜单sex和edu采用forms.Select来进行定制，对choices参数进行绑定即可完成可选项的设置；

- 图像字段采用文件输入形式forms.FileInput；

  

  为了能够使用Bootstrap表单组件，同时能够利用模型表单的自动渲染功能，需要使用一个额外的第三方应用django-widget-tweaks，该应用允许在前端中使用特定的模板标签语言为模型表单组件添加样式类和属性

```python
```

-  转义：首先引入make_safe转义函数用来对HTML语言关键字进行转义，将HTML代码转换为HTML实体；
- 模型管理器：为了能够定制化模型的输出，可以采用Django提供的模型管理器进行模型定制输出。模型管理器通过继承类admin.ModelAdmin来创建，其中list_display属性列出了需要在后台管理系统中展示的模型字段，此处并没有列出photo字段，而是采用了另一个变量image_data。通过函数image_data将photo的url赋值到HTML中，并通过转义字符进行转化，从而使得最终渲染的image_data能以缩略图形式显示；
- 绑定模型和模型管理器：通过admin.site.register函数将模型与模型管理器绑定并且注册；

Django信号机制来实现触发效果

```python
# 引入Django自带的模型信号post_init表示在管理员单击保存按钮前触发信号，post_save表示在单击保存按钮后触发信号；
from django.db.models.signals import post_init, post_save
from django.dispatch import receiver

# 信号的接收采用装饰器@receiver来实现，其中第一个参数是信号类型，第二个参数是需要监控的模型类；
# 对应两个不同的信号，分别采用两个不同的函数进行响应，其中instance参数即为传入的模型变量。
# 在保存前，将当前状态记录在__original_status变量中，保存后输出前后变量的值来查看变化；
@receiver(post_init, sender=Resume)
def before_save_resume(sender, instance, **kwargs):
    instance.__original_status = instance.status


@receiver(post_save, sender=Resume)
def post_save_resume(sender, instance, **kwargs):
    print(instance.__original_status)
    print(instance.status)
```

Django实现邮箱互动

```python
# 邮箱配置
EMAIL_HOST = 'smtp.qq.com'
EMAIL_PORT = 587
EMAIL_HOST_USER = '1535086745@qq.com'
EMAIL_HOST_PASSWORD = '马赛克'  #授权码
EMAIL_USE_TLS = True
EMAIL_USE_SSL = False


from django.core.mail import send_mail

@receiver(post_save, sender=Resume)
def post_save_resume(sender, instance, **kwargs):
    email = instance.email  # 应聘者邮箱
    EMAIL_FROM = '1535086745@qq.com'  # 企业QQ邮箱
    if instance.__original_status == 1 and instance.status == 2:
        email_title = '通知：my科技招聘初试结果'
        email_body = '恭喜您通过本企业初试'
        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
    elif instance.__original_status == 1 and instance.status == 3:
        email_title = '通知：my科技招聘初试结果'
        email_body = '很遗憾，您未能通过本企业初试，感谢您的关注'
        send_status = send_mail(email_title, email_body, EMAIL_FROM, [email])
```



Django针对文件下载专门提供了StreamingHttpResponse对象用来代替HttpResponse对象，以流的形式提供下载功能。StreamingHttpResponse对象用于将文件流发送给浏览器，与HttpResponse对象非常相似。对于文件下载功能，使用StreamingHttpResponse对象更稳定和有效。





Q函数，该函数可以用于对象的复杂查询，可以对关键字参数进行封装，从而更好地应用于多条件查询，同时可以组合使用 &（and）,|（or），~（not）等操作符；



# 实现注册和登入

要实现用户跟踪，服务器端可以为每个用户会话创建一个session对象并将session对象的ID写入到浏览器的cookie中；用户下次请求服务器时，浏览器会在HTTP请求头中携带该网站保存的cookie信息，这样服务器就可以从cookie中找到session对象的ID并根据此ID获取到之前创建的session对象；由于session对象可以用键值对的方式保存用户数据，这样之前保存在session对象中的信息可以悉数取出，服务器也可以根据这些信息判定用户身份和了解用户偏好，为用户提供更好的个性化服务。

cookie的工作原理是：由服务器产生内容，浏览器收到请求后保存在本地；当浏览器再次访问时，浏览器会自动带上cookie，这样服务器就能通过cookie的内容来判断这个是“谁”了。

cookie虽然在一定程度上解决了“保持状态”的需求，但是由于cookie本身最大支持4096字节，以及cookie本身保存在客户端，可能被拦截或窃取，因此就需要有一种新的东西，它能支持更多的字节，并且他保存在服务器，有较高的安全性。这就是session。

问题来了，基于http协议的无状态特征，服务器根本就不知道访问者是“谁”。那么上述的cookie就起到桥接的作用。

我们可以给每个客户端的cookie分配一个唯一的id，这样用户在访问时，通过cookie，服务器就知道来的人是“谁”。然后我们再根据不同的cookie的id，在服务器上保存一段时间的私密资料，如“账号密码”等等。

总结而言：cookie弥补了http无状态的不足，让服务器知道来的人是“谁”；但是cookie以文本的形式保存在本地，自身安全性较差；所以我们就通过cookie识别不同的用户，对应的在session里保存私密的信息以及超过4096字节的文本。

另外，上述所说的cookie和session其实是共通性的东西，不限于语言和框架

Django的实现

## cookies

```python
设置：response.set_cookie(key,value,max_age=None,exprise=None)
获取：request.GET.get(key)
删除：request.delete_cookie(key)

```

注意：cookie不能跨浏览器

参数定义：

max_age和exprise时间：

```
max_age :  整数，指定cookie过期时间，以秒为单位

exprise： 整数，指定过期时间，还支持是一个datetime或者timedelta，可以指定一个具体日期时间
```

设置10天后过期：

```
exprise=datetime.datetime.now() + timedelta(days=10) 10天后过期
```

永不过期：

```
exprise设置为None表示为永不过期
```

## 2. session

### 描述

```
服务端会话技术，依赖于cookie
```

### 开启session设置

1）django中启用SESSION

在settings中修改如下地方

```
INSTALLED_APPS:
    ‘django.contrib.sessions’

MIDDLEWARE:
    ‘django.contrib.sessions.middleware.SessionMiddleware’
```

每个HttpResponse对象都有一个session属性，也是一个类字典对象

### 常用操作

```
request.session[‘user’] = username 设置数据

request.session.get(key, default=None) 根据键获取会话的值

request.session.flush() 删除当前的会话数据并删除会话的cookie，django.contrib.auth.logout() 函数中就会调用它。

request.session.session_key  获取sessionid值

request.session.delete(request.session.session_key) 删除当前用户的所有Session数据

del request.session['key'] 删除session中的key值

request.session.set_expiry(value)
	如果value是个整数，session会在些秒数后失效
	如果value是个datatime或timedelta，session就会在这个时间后失效。 
	如果value是0,用户关闭浏览器session就会失效。


数据存储到数据库中会进行编码使用的是base64
```
