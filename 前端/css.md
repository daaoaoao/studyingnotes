



# css选择器

分类

- 简单选择器（根据名称、id、类来选取元素）
- [组合器选择器](https://www.w3school.com.cn/css/css_combinators.asp)（根据它们之间的特定关系来选取元素）
- [伪类选择器](https://www.w3school.com.cn/css/css_pseudo_classes.asp)（根据特定状态选取元素）
- [伪元素选择器](https://www.w3school.com.cn/css/css_pseudo_elements.asp)（选取元素的一部分并设置其样式）
- [属性选择器](https://www.w3school.com.cn/css/css_attribute_selectors.asp)（根据属性或属性值来选取元素）

## 简单选择器

### 元素选择器

例如

在这里，页面上的所有 <p\> 元素都将居中对齐，并带有红色文本颜色：

```css
p {
  text-align: center;
  color: red;
}
```

### CSS id 选择器

id 选择器使用 HTML 元素的 id 属性来选择特定元素。

元素的 id 在页面中是唯一的，因此 id 选择器用于选择一个唯一的元素！

要选择具有特定 id 的元素，请写一个井号（＃），后跟该元素的 id。

实例

这条 CSS 规则将应用于 id="para1" 的 HTML 元素：

```
#para1 {
  text-align: center;
  color: red;
}
```

**注意：**id 名称不能以数字开头。

### CSS 类选择器

类选择器选择有特定 class 属性的 HTML 元素。

如需选择拥有特定 class 的元素，请写一个句点（.）字符，后面跟类名。

实例

在此例中，所有带有 class="center" 的 HTML 元素将为红色且居中对齐：

```
.center {
  text-align: center;
  color: red;
}
```

您还可以指定只有特定的 HTML 元素会受类的影响。

实例

在这个例子中，只有具有 class="center" 的 <p> 元素会居中对齐：

```
p.center {
  text-align: center;
  color: red;
}
```

HTML 元素也可以引用多个类。

实例

在这个例子中，<p> 元素将根据 class="center" 和 class="large" 进行样式设置：

```
<p class="center large">这个段落引用两个类。</p>
```

**注意：**类名不能以数字开头！

### CSS 通用选择器

通用选择器（*）选择页面上的所有的 HTML 元素。

实例

下面的 CSS 规则会影响页面上的每个 HTML 元素：

```
* {
  text-align: center;
  color: blue;
}
```

### CSS 分组选择器

分组选择器选取所有具有相同样式定义的 HTML 元素。

请看下面的 CSS 代码（h1、h2 和 p 元素具有相同的样式定义）：

```
h1 {
  text-align: center;
  color: red;
}

h2 {
  text-align: center;
  color: red;
}

p {
  text-align: center;
  color: red;
}
```

最好对选择器进行分组，以最大程度地缩减代码。

如需对选择器进行分组，请用逗号来分隔每个选择器。

实例

在这个例子中，我们对上述代码中的选择器进行分组：

```
h1, h2, p {
  text-align: center;
  color: red;
}
```



## 后续关于选择器选择器

[CSS 元素选择器](https://www.w3school.com.cn/css/css_selector_type.asp)

课外书：[CSS 选择器分组](https://www.w3school.com.cn/css/css_selector_grouping.asp)

课外书：[CSS 类选择器详解](https://www.w3school.com.cn/css/css_selector_class.asp)

课外书：[CSS ID 选择器详解](https://www.w3school.com.cn/css/css_selector_id.asp)

课外书：[CSS 属性选择器详解](https://www.w3school.com.cn/css/css_selector_attribute.asp)

课外书：[CSS 后代选择器](https://www.w3school.com.cn/css/css_selector_descendant.asp)

课外书：[CSS 子元素选择器](https://www.w3school.com.cn/css/css_selector_child.asp)

课外书：[CSS 相邻兄弟选择器](https://www.w3school.com.cn/css/css_selector_adjacent_sibling.asp)



# css引用方式

行内



外部

通过使用外部样式表，您只需修改一个文件即可改变整个网站的外观！

每张 HTML 页面必须在 head 部分的 <link> 元素内包含对外部样式表文件的引用。

外部样式表可以在任何文本编辑器中编写，并且必须以 .css 扩展名保存。

外部 .css 文件不应包含任何 HTML 标签。

```
<link rel="stylesheet" type="text/css" href="mystyle.css">
```



内部

如果一张 HTML 页面拥有唯一的样式，那么可以使用内部样式表。

内部样式是在 head 部分的 <style> 元素中进行定义。



关于引用顺序

当为某个 HTML 元素指定了多个样式时，会使用哪种样式呢？

页面中的所有样式将按照以下规则“层叠”为新的“虚拟”样式表，其中第一优先级最高：

1. 行内样式（在 HTML 元素中）
2. 外部和内部样式表（在 head 部分）
3. 浏览器默认样式

因此，行内样式具有最高优先级，并且将覆盖外部和内部样式以及浏览器默认样式。



# css背景

| 属性                                                         | 描述                                               |
| :----------------------------------------------------------- | :------------------------------------------------- |
| [background](https://www.w3school.com.cn/cssref/pr_background.asp) | 在一条声明中设置所有背景属性的简写属性。           |
| [background-attachment](https://www.w3school.com.cn/cssref/pr_background-attachment.asp) | 设置背景图像是固定的还是与页面的其余部分一起滚动。 |
| [background-clip](https://www.w3school.com.cn/cssref/pr_background-clip.asp) | 规定背景的绘制区域。                               |
| [background-color](https://www.w3school.com.cn/cssref/pr_background-color.asp) | 设置元素的背景色。                                 |
| [background-image](https://www.w3school.com.cn/cssref/pr_background-image.asp) | 设置元素的背景图像。                               |
| [background-origin](https://www.w3school.com.cn/cssref/pr_background-origin.asp) | 规定在何处放置背景图像。                           |
| [background-position](https://www.w3school.com.cn/cssref/pr_background-position.asp) | 设置背景图像的开始位置。                           |
| [background-repeat](https://www.w3school.com.cn/cssref/pr_background-repeat.asp) | 设置背景图像是否及如何重复。                       |
| [background-size](https://www.w3school.com.cn/cssref/pr_background-size.asp) | 规定背景图像的尺寸。                               |



# 参考手册

[CSS 参考手册 (w3school.com.cn)](https://www.w3school.com.cn/cssref/index.asp)



