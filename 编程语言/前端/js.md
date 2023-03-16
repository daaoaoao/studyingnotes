交互脚本语言

html使用JavaScript \<script>元素

\<scriptasyncsrc>改变脚本的处理方式，异步脚本保证会在页面的load事件前执行



把js放到外部文件中，包含外部js文件，必须将src属性设置为要包含文件的URL，文件可以位于网页同一服务器上，也可以位于不同的域

所有的\<script>元素会依照他们在网页中出现的次序被解释，在不实用defer和async属性的情况下，包含在\<script>元素中的代码必须严格按次序解释

注释与c++类似



外部javascript文件不使用<script> 直接写代码

HTML 输出流中使用 document.write，相当于添加在原有html代码中添加一串html代码。而如果在文档加载后使用（如使用函数），会覆盖整个文档。





增加了严格模式

"use strict"

可以整个文件严格模式，也可以在函数体的开头放



关键字与保留字





# JavaScript输出

显示数据

window.alert()弹出警告框

document.write()方法将内容写到HTML文档中。

innerHTML写入到HTML元素中

console.log()写入到浏览器的控制台





