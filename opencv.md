# NumPy

同构多维数组

NumPy的数组类被调用ndarray 

ndarray.ndim-数组的轴（维度）的个数。在Pythoni世界中，维度的数量被称为rank。

ndarray..shape-数组的维度。这是一个整数的元组，表示每个维度中数组的大小。对于有n行和m列的矩阵，shape将是(n,m)。因此，shape元组的长度就是rank或维度的个数ndim。
ndarray.size-数组元素的总数。这等于shape的元素的乘积。
ndarray.dtype-一个描述数组中元素类型的对象。可以使用标准的Python类型创建或指定dtype。另外NumPy提供它自己的类型。例如numpy.int32、numpy..int16和numpy..float64。
ndarray..itemsize-数组中每个元素的字节大小。例如，元素为float64类型的数组的itemsize为8(=64/8)，而comp1ex32类型的数组的temsize为4(=32/8)。它等于ndarray.dtype.itemsize
ndarray.data-该缓冲区包含数组的实际元素。通常，我们不需要使用此属性，因为我们将使
用索引访问数组中的元素。



另见这些API

[`array`](https://numpy.org/devdocs/reference/generated/numpy.array.html#numpy.array)， [`zeros`](https://numpy.org/devdocs/reference/generated/numpy.zeros.html#numpy.zeros)， [`zeros_like`](https://numpy.org/devdocs/reference/generated/numpy.zeros_like.html#numpy.zeros_like)， [`ones`](https://numpy.org/devdocs/reference/generated/numpy.ones.html#numpy.ones)， [`ones_like`](https://numpy.org/devdocs/reference/generated/numpy.ones_like.html#numpy.ones_like)， [`empty`](https://numpy.org/devdocs/reference/generated/numpy.empty.html#numpy.empty)， [`empty_like`](https://numpy.org/devdocs/reference/generated/numpy.empty_like.html#numpy.empty_like)， [`arange`](https://numpy.org/devdocs/reference/generated/numpy.arange.html#numpy.arange)， [`linspace`](https://numpy.org/devdocs/reference/generated/numpy.linspace.html#numpy.linspace)， [`numpy.random.mtrand.RandomState.rand`](https://numpy.org/devdocs/reference/random/generated/numpy.random.mtrand.RandomState.rand.html#numpy.random.mtrand.RandomState.rand)， [`numpy.random.mtrand.RandomState.randn`](https://numpy.org/devdocs/reference/random/generated/numpy.random.mtrand.RandomState.randn.html#numpy.random.mtrand.RandomState.randn)， [`fromfunction`](https://numpy.org/devdocs/reference/generated/numpy.fromfunction.html#numpy.fromfunction)， [`fromfile`](https://numpy.org/devdocs/reference/generated/numpy.fromfile.html#numpy.fromfile)



## **基本操作**

乘积运算符* 在Numpy按元素进行运算  矩阵乘积可以使用@运算符或dot函数

+=     *= 会直接修改被操作的矩阵数组而不会创建新的矩阵数组

会发生向上转型



许多一元操作（sum，等）都是作为ndarray类的方法实现

默认情况下，操作适应于数组，可以通过axis参数来指定轴



## 通函数

NumPy提供熟悉的数学函数，例如sin，cos和exp。在NumPy中，这些被称为“通函数”（`ufunc`）。在NumPy中，这些函数在数组上按元素进行运算，产生一个数组作为输出。



>另见这些通函数
>
>[`all`](https://numpy.org/devdocs/reference/generated/numpy.all.html#numpy.all)， [`any`](https://numpy.org/devdocs/reference/generated/numpy.any.html#numpy.any)， [`apply_along_axis`](https://numpy.org/devdocs/reference/generated/numpy.apply_along_axis.html#numpy.apply_along_axis)， [`argmax`](https://numpy.org/devdocs/reference/generated/numpy.argmax.html#numpy.argmax)， [`argmin`](https://numpy.org/devdocs/reference/generated/numpy.argmin.html#numpy.argmin)， [`argsort`](https://numpy.org/devdocs/reference/generated/numpy.argsort.html#numpy.argsort)， [`average`](https://numpy.org/devdocs/reference/generated/numpy.average.html#numpy.average)， [`bincount`](https://numpy.org/devdocs/reference/generated/numpy.bincount.html#numpy.bincount)， [`ceil`](https://numpy.org/devdocs/reference/generated/numpy.ceil.html#numpy.ceil)， [`clip`](https://numpy.org/devdocs/reference/generated/numpy.clip.html#numpy.clip)， [`conj`](https://numpy.org/devdocs/reference/generated/numpy.conj.html#numpy.conj)， [`corrcoef`](https://numpy.org/devdocs/reference/generated/numpy.corrcoef.html#numpy.corrcoef)， [`cov`](https://numpy.org/devdocs/reference/generated/numpy.cov.html#numpy.cov)， [`cross`](https://numpy.org/devdocs/reference/generated/numpy.cross.html#numpy.cross)， [`cumprod`](https://numpy.org/devdocs/reference/generated/numpy.cumprod.html#numpy.cumprod)， [`cumsum`](https://numpy.org/devdocs/reference/generated/numpy.cumsum.html#numpy.cumsum)， [`diff`](https://numpy.org/devdocs/reference/generated/numpy.diff.html#numpy.diff)， [`dot`](https://numpy.org/devdocs/reference/generated/numpy.dot.html#numpy.dot)， [`floor`](https://numpy.org/devdocs/reference/generated/numpy.floor.html#numpy.floor)， [`inner`](https://numpy.org/devdocs/reference/generated/numpy.inner.html#numpy.inner)， *INV* ， [`lexsort`](https://numpy.org/devdocs/reference/generated/numpy.lexsort.html#numpy.lexsort)， [`max`](https://docs.python.org/dev/library/functions.html#max)， [`maximum`](https://numpy.org/devdocs/reference/generated/numpy.maximum.html#numpy.maximum)， [`mean`](https://numpy.org/devdocs/reference/generated/numpy.mean.html#numpy.mean)， [`median`](https://numpy.org/devdocs/reference/generated/numpy.median.html#numpy.median)， [`min`](https://docs.python.org/dev/library/functions.html#min)， [`minimum`](https://numpy.org/devdocs/reference/generated/numpy.minimum.html#numpy.minimum)， [`nonzero`](https://numpy.org/devdocs/reference/generated/numpy.nonzero.html#numpy.nonzero)， [`outer`](https://numpy.org/devdocs/reference/generated/numpy.outer.html#numpy.outer)， [`prod`](https://numpy.org/devdocs/reference/generated/numpy.prod.html#numpy.prod)， [`re`](https://docs.python.org/dev/library/re.html#module-re)， [`round`](https://docs.python.org/dev/library/functions.html#round)， [`sort`](https://numpy.org/devdocs/reference/generated/numpy.sort.html#numpy.sort)， [`std`](https://numpy.org/devdocs/reference/generated/numpy.std.html#numpy.std)， [`sum`](https://numpy.org/devdocs/reference/generated/numpy.sum.html#numpy.sum)， [`trace`](https://numpy.org/devdocs/reference/generated/numpy.trace.html#numpy.trace)， [`transpose`](https://numpy.org/devdocs/reference/generated/numpy.transpose.html#numpy.transpose)， [`var`](https://numpy.org/devdocs/reference/generated/numpy.var.html#numpy.var)， [`vdot`](https://numpy.org/devdocs/reference/generated/numpy.vdot.html#numpy.vdot)， [`vectorize`](https://numpy.org/devdocs/reference/generated/numpy.vectorize.html#numpy.vectorize)， [`where`](https://numpy.org/devdocs/reference/generated/numpy.where.html#numpy.where)



## 索引，切片和迭代

一维数组可以进行索引，切片和迭代操作，和列表或者其它序列类似



多维的数组每个轴都可以有一个索引

eg

```
>>> def f(x,y):
...     return 10*x+y
...
>>> b = np.fromfunction(f,(5,4),dtype=int)
>>> b
array([[ 0,  1,  2,  3],
       [10, 11, 12, 13],
       [20, 21, 22, 23],
       [30, 31, 32, 33],
       [40, 41, 42, 43]])
>>> b[2,3]
23
>>> b[0:5, 1]                       # each row in the second column of b
array([ 1, 11, 21, 31, 41])
>>> b[ : ,1]                        # equivalent to the previous example
array([ 1, 11, 21, 31, 41])
>>> b[1:3, : ]                      # each column in the second and third row of b
array([[10, 11, 12, 13],
       [20, 21, 22, 23]])
```

当提供的索引少于轴的数量时，缺啥的索引认为是完整的切片

b[i] 方括号中的表达式 i 被视为后面紧跟着 : 的多个实例，用于表示剩余轴。NumPy也允许你使用三个点写为 b[i,...]。

三个点（ ... ）表示产生完整索引元组所需的冒号。例如，如果 x 是rank为5的数组（即，它具有5个轴），则：

x[1,2,...] 相当于 x[1,2,:,:,:]，
x[...,3] 等效于 x[:,:,:,:,3]
x[4,...,5,:] 等效于 x[4,:,:,5,:]。



对多维数组进行 **迭代（Iterating）** 是相对于第一个轴完成的

如果想要对数组中的每个元素执行操作，可以使用flat属性，该属性是数组的所有元素的迭代器

>另见
>
>[Indexing](https://www.numpy.org.cn/user/basics.indexing.html#basics-indexing), [Indexing](https://numpy.org/devdocs/reference/arrays.indexing.html#arrays-indexing) (reference), [`newaxis`](https://numpy.org/devdocs/reference/constants.html#numpy.newaxis), [`ndenumerate`](https://numpy.org/devdocs/reference/generated/numpy.ndenumerate.html#numpy.ndenumerate), [`indices`](https://numpy.org/devdocs/reference/generated/numpy.indices.html#numpy.indices)

## 形状操纵

改变数组形状

a.shape  输出形状

a.ravel 输出一维

a.reshap(x,y) 改变大小为x轴y数

a.T 返回

a.resize 会修改数组本身



将不同数组堆叠在一起

np.vstack((a,b)) 

np.hstack((a,b))

```
>>> from numpy import newaxis
>>> np.column_stack((a,b))     # with 2D arrays
array([[ 8.,  8.,  1.,  8.],
       [ 0.,  0.,  0.,  4.]])
>>> a = np.array([4.,2.])
>>> b = np.array([3.,8.])
>>> np.column_stack((a,b))     # returns a 2D array
array([[ 4., 3.],
       [ 2., 8.]])
>>> np.hstack((a,b))           # the result is different
array([ 4., 2., 3., 8.])
>>> a[:,newaxis]               # this allows to have a 2D columns vector
array([[ 4.],
       [ 2.]])
>>> np.column_stack((a[:,newaxis],b[:,newaxis]))
array([[ 4.,  3.],
       [ 2.,  8.]])
>>> np.hstack((a[:,newaxis],b[:,newaxis]))   # the result is the same
array([[ 4.,  3.],
       [ 2.,  8.]])
```

另一方面，该函数ma.row_stack等效vstack 于任何输入数组。通常，对于具有两个以上维度的数组， hstack沿其第二轴vstack堆叠，沿其第一轴堆叠，并concatenate 允许可选参数给出连接应发生的轴的编号。

注意

在复杂的情况下，r_和c c_于通过沿一个轴堆叠数字来创建数组很有用。它们允许使用范围操作符(“：”)。

与数组一起用作参数时， r_ 和 c_ 在默认行为上类似于 vstack 和 hstack ，但允许使用可选参数给出要连接的轴的编号。

>另见
>
>[`hstack`](https://numpy.org/devdocs/reference/generated/numpy.hstack.html#numpy.hstack)， [`vstack`](https://numpy.org/devdocs/reference/generated/numpy.vstack.html#numpy.vstack)， [`column_stack`](https://numpy.org/devdocs/reference/generated/numpy.column_stack.html#numpy.column_stack)， [`concatenate`](https://numpy.org/devdocs/reference/generated/numpy.concatenate.html#numpy.concatenate)， [`c_`](https://numpy.org/devdocs/reference/generated/numpy.c_.html#numpy.c_)， [`r_`](https://numpy.org/devdocs/reference/generated/numpy.r_.html#numpy.r_)



将一个数组拆分成几个较小的数组

使用hsplit  可沿数组水平轴拆分数组，方法是指定要返回的形状相等的数组的数量，或者指定应该在其之后进行分割的列

[`vsplit`](https://numpy.org/devdocs/reference/generated/numpy.vsplit.html#numpy.vsplit)沿垂直轴分割，并[`array_split`](https://numpy.org/devdocs/reference/generated/numpy.array_split.html#numpy.array_split)允许指定要分割的轴



## 拷贝和视图

完全不复制

简单分配不会复制数组对象或其数据



python将可变对象作为引用传递 因此函数调用不会复制





视图或浅拷贝

c = a.view()   创建一个查看相同数据的新数组对象



切片数组会返回一个视图



## 功能和方法概述

以下是按类别排序的一些有用的NumPy函数和方法名称的列表。有关完整列表，请参阅[参考手册](https://www.numpy.org.cn/reference/)里的[常用API](https://www.numpy.org.cn/reference/routines/)。

- **数组的创建（Array Creation）** - [arange](https://numpy.org/devdocs/reference/generated/numpy.arange.html#numpy.arange), [array](https://numpy.org/devdocs/reference/generated/numpy.array.html#numpy.array), [copy](https://numpy.org/devdocs/reference/generated/numpy.copy.html#numpy.copy), [empty](https://numpy.org/devdocs/reference/generated/numpy.empty.html#numpy.empty), [empty_like](https://numpy.org/devdocs/reference/generated/numpy.empty_like.html#numpy.empty_like), [eye](https://numpy.org/devdocs/reference/generated/numpy.eye.html#numpy.eye), [fromfile](https://numpy.org/devdocs/reference/generated/numpy.fromfile.html#numpy.fromfile), [fromfunction](https://numpy.org/devdocs/reference/generated/numpy.fromfunction.html#numpy.fromfunction), [identity](https://numpy.org/devdocs/reference/generated/numpy.identity.html#numpy.identity), [linspace](https://numpy.org/devdocs/reference/generated/numpy.linspace.html#numpy.linspace), [logspace](https://numpy.org/devdocs/reference/generated/numpy.logspace.html#numpy.logspace), [mgrid](https://numpy.org/devdocs/reference/generated/numpy.mgrid.html#numpy.mgrid), [ogrid](https://numpy.org/devdocs/reference/generated/numpy.ogrid.html#numpy.ogrid), [ones](https://numpy.org/devdocs/reference/generated/numpy.ones.html#numpy.ones), [ones_like](https://numpy.org/devdocs/reference/generated/numpy.ones_like.html#numpy.ones_like), [zeros](https://numpy.org/devdocs/reference/generated/numpy.zeros.html#numpy.zeros), [zeros_like](https://numpy.org/devdocs/reference/generated/numpy.zeros_like.html#numpy.zeros_like)
- **转换和变换（Conversions）** - [ndarray.astype](https://numpy.org/devdocs/reference/generated/numpy.ndarray.astype.html#numpy.ndarray.astype), [atleast_1d](https://numpy.org/devdocs/reference/generated/numpy.atleast_1d.html#numpy.atleast_1d), [atleast_2d](https://numpy.org/devdocs/reference/generated/numpy.atleast_2d.html#numpy.atleast_2d), [atleast_3d](https://numpy.org/devdocs/reference/generated/numpy.atleast_3d.html#numpy.atleast_3d), [mat](https://numpy.org/devdocs/reference/generated/numpy.mat.html#numpy.mat)
- **操纵术（Manipulations）** - [array_split](https://numpy.org/devdocs/reference/generated/numpy.array_split.html#numpy.array_split), [column_stack](https://numpy.org/devdocs/reference/generated/numpy.column_stack.html#numpy.column_stack), [concatenate](https://numpy.org/devdocs/reference/generated/numpy.concatenate.html#numpy.concatenate), [diagonal](https://numpy.org/devdocs/reference/generated/numpy.diagonal.html#numpy.diagonal), [dsplit](https://numpy.org/devdocs/reference/generated/numpy.dsplit.html#numpy.dsplit), [dstack](https://numpy.org/devdocs/reference/generated/numpy.dstack.html#numpy.dstack), [hsplit](https://numpy.org/devdocs/reference/generated/numpy.hsplit.html#numpy.hsplit), [hstack](https://numpy.org/devdocs/reference/generated/numpy.hstack.html#numpy.hstack), [ndarray.item](https://numpy.org/devdocs/reference/generated/numpy.ndarray.item.html#numpy.ndarray.item), [newaxis](https://www.numpy.org.cn/reference/constants.html#numpy.newaxis), [ravel](https://numpy.org/devdocs/reference/generated/numpy.ravel.html#numpy.ravel), [repeat](https://numpy.org/devdocs/reference/generated/numpy.repeat.html#numpy.repeat), [reshape](https://numpy.org/devdocs/reference/generated/numpy.reshape.html#numpy.reshape), [resize](https://numpy.org/devdocs/reference/generated/numpy.resize.html#numpy.resize), [squeeze](https://numpy.org/devdocs/reference/generated/numpy.squeeze.html#numpy.squeeze), [swapaxes](https://numpy.org/devdocs/reference/generated/numpy.swapaxes.html#numpy.swapaxes), [take](https://numpy.org/devdocs/reference/generated/numpy.take.html#numpy.take), [transpose](https://numpy.org/devdocs/reference/generated/numpy.transpose.html#numpy.transpose), [vsplit](https://numpy.org/devdocs/reference/generated/numpy.vsplit.html#numpy.vsplit), [vstack](https://numpy.org/devdocs/reference/generated/numpy.vstack.html#numpy.vstack)
- **询问（Questions）** - [all](https://numpy.org/devdocs/reference/generated/numpy.all.html#numpy.all), [any](https://numpy.org/devdocs/reference/generated/numpy.any.html#numpy.any), [nonzero](https://numpy.org/devdocs/reference/generated/numpy.nonzero.html#numpy.nonzero), [where](https://numpy.org/devdocs/reference/generated/numpy.where.html#numpy.where),
- **顺序（Ordering）** - [argmax](https://numpy.org/devdocs/reference/generated/numpy.argmax.html#numpy.argmax), [argmin](https://numpy.org/devdocs/reference/generated/numpy.argmin.html#numpy.argmin), [argsort](https://numpy.org/devdocs/reference/generated/numpy.argsort.html#numpy.argsort), [max](https://docs.python.org/dev/library/functions.html#max), [min](https://docs.python.org/dev/library/functions.html#min), [ptp](https://numpy.org/devdocs/reference/generated/numpy.ptp.html#numpy.ptp), [searchsorted](https://numpy.org/devdocs/reference/generated/numpy.searchsorted.html#numpy.searchsorted), [sort](https://numpy.org/devdocs/reference/generated/numpy.sort.html#numpy.sort)
- **操作（Operations）** - [choose](https://numpy.org/devdocs/reference/generated/numpy.choose.html#numpy.choose), [compress](https://numpy.org/devdocs/reference/generated/numpy.compress.html#numpy.compress), [cumprod](https://numpy.org/devdocs/reference/generated/numpy.cumprod.html#numpy.cumprod), [cumsum](https://numpy.org/devdocs/reference/generated/numpy.cumsum.html#numpy.cumsum), [inner](https://numpy.org/devdocs/reference/generated/numpy.inner.html#numpy.inner), [ndarray.fill](https://numpy.org/devdocs/reference/generated/numpy.ndarray.fill.html#numpy.ndarray.fill), [imag](https://numpy.org/devdocs/reference/generated/numpy.imag.html#numpy.imag), [prod](https://numpy.org/devdocs/reference/generated/numpy.prod.html#numpy.prod), [put](https://numpy.org/devdocs/reference/generated/numpy.put.html#numpy.put), [putmask](https://numpy.org/devdocs/reference/generated/numpy.putmask.html#numpy.putmask), [real](https://numpy.org/devdocs/reference/generated/numpy.real.html#numpy.real), [sum](https://numpy.org/devdocs/reference/generated/numpy.sum.html#numpy.sum)
- **基本统计（Basic Statistics）** - [cov](https://numpy.org/devdocs/reference/generated/numpy.cov.html#numpy.cov), [mean](https://numpy.org/devdocs/reference/generated/numpy.mean.html#numpy.mean), [std](https://numpy.org/devdocs/reference/generated/numpy.std.html#numpy.std), [var](https://numpy.org/devdocs/reference/generated/numpy.var.html#numpy.var)
- **基本线性代数（Basic Linear Algebra）** - [cross](https://numpy.org/devdocs/reference/generated/numpy.cross.html#numpy.cross), [dot](https://numpy.org/devdocs/reference/generated/numpy.dot.html#numpy.dot), [outer](https://numpy.org/devdocs/reference/generated/numpy.outer.html#numpy.outer), [linalg.svd](https://numpy.org/devdocs/reference/generated/numpy.linalg.svd.html#numpy.linalg.svd), [vdot](https://numpy.org/devdocs/reference/generated/numpy.vdot.html#numpy.vdot)





## Less基础

### 广播规则



### 花式索引和索引技巧

使用索引数组进行索引

数组索引在图片处理颜色

搜索与时间相关的系列最大值

数组索引作为给目标分配

当索引列表有重复时，分配会多次完成，留下最后一个值

  注意使用+=时的问题



使用布尔数组进行索引时

布尔索引生成Mandelbrot集图像



ix_()函数

可以组合不同的向量，以便获取每个n-uplet的结果





简单数组操作



自动整形



矢量堆叠



直方图







# opencv

读取图像

使用cv.imread（）函数读取图像，图像应该在工作目录或者图像完整路径给出

第一个参数是路径

第二个是一个标志 读取图片的方式

cv.IMGREAD_COLOR:加载彩色图像，任何图像的透明度都会被忽略

cv.IMGREAD_GRAYSCALE:以灰度模式加载图像

cv.IMGREAD_UNCHANGED:加载图像，包括alpha通道

也可以简单传递参数1，0或-1

图片路径出错不会引发任何错误，但是print img 会出现None



## 显示图像

cv.imshow 窗口自动适应图像尺寸

第一个参数是窗口名称 字符串 第二个是对象

cv.waitKey()键盘绑定函数 参数是以毫秒为单位，该函数等待任何键盘事件指定的毫秒



> GUI事件





显示视频



读取视频



捕获摄像头



保存视频



具体参考代码

见git地址



## 绘图功能



cv.line()，cv.circle()，cv.rectangle()，cv.ellipse()，cv.putText()

在上述所有功能中，您将看到一些常见的参数，如下所示：

- img：您要绘制形状的图像
- color：形状的颜色。对于BGR，将其作为元组传递，例如：(255,0,0)对于蓝色。对于灰度，只需传递标量值即可。
- 厚度：线或圆等的粗细。如果对闭合图形（如圆）传递`-1` ，它将填充形状。*默认厚度= 1*
- lineType：线的类型，是否为8连接线，抗锯齿线等。*默认情况下*，为8连接线。**cv.LINE_AA**给出了抗锯齿的线条，看起来非常适合曲线。



## 鼠标事件

```
['EVENT_FLAG_ALTKEY', 'EVENT_FLAG_CTRLKEY', 'EVENT_FLAG_LBUTTON', 'EVENT_FLAG_MBUTTON', 'EVENT_FLAG_RBUTTON', 'EVENT_FLAG_SHIFTKEY', 'EVENT_LBUTTONDBLCLK', 'EVENT_LBUTTONDOWN', 'EVENT_LBUTTONUP', 'EVENT_MBUTTONDBLCLK', 'EVENT_MBUTTONDOWN', 'EVENT_MBUTTONUP', 'EVENT_MOUSEHWHEEL', 'EVENT_MOUSEMOVE', 'EVENT_MOUSEWHEEL', 'EVENT_RBUTTONDBLCLK', 'EVENT_RBUTTONDOWN', 'EVENT_RBUTTONUP']
```





