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
```

实现分页的思想，页面默认位于第一也 点击以后返回当前page页 判读左右两边还剩下的页数  和预留判读第一页和最后一页，有关分页的一些关键数据以字典“键—值”对形式存于变量pageData传入前端来判断



富文本编辑器的添加

添加现成的富文本编辑器来源于git

```
https://github.com/twz915/DjangoUeditor3/

富文本字段的注册形式，通过定义style_fields属性来绑定富文本字段
```
