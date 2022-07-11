# STL

## vector

### 基本函数的实现

#### 1.构造函数

- vector():创建一个空vector
- vector(int nSize):创建一个vector,元素个数为nSize
- vector(int nSize,const t& t):创建一个vector，元素个数为nSize,且值均为t
- vector(const vector&):复制构造函数
- vector(begin,end):复制[begin,end)区间内另一个数组的元素到vector中

#### **2.增加函数**

- void push_back(const T& x):向量尾部增加一个元素X
- iterator insert(iterator it,const T& x):向量中迭代器指向元素前增加一个元素x
- iterator insert(iterator it,int n,const T& x):向量中迭代器指向元素前增加n个相同的元素x
- iterator insert(iterator it,const_iterator first,const_iterator last):向量中迭代器指向元素前插入另一个相同类型向量的[first,last)间的数据

#### **3.删除函数**

- iterator erase(iterator it):删除向量中迭代器指向元素
- iterator erase(iterator first,iterator last):删除向量中[first,last)中元素
- void pop_back():删除向量中最后一个元素
- void clear():清空向量中所有元素

#### **4.遍历函数**

- reference at(int pos):返回pos位置元素的引用
- reference front():返回首元素的引用
- reference back():返回尾元素的引用
- iterator begin():返回向量头指针，指向第一个元素
- iterator end():返回向量尾指针，指向向量最后一个元素的下一个位置
- reverse_iterator rbegin():反向迭代器，指向最后一个元素
- reverse_iterator rend():反向迭代器，指向第一个元素之前的位置

#### **5.判断函数**

- bool empty() const:判断向量是否为空，若为空，则向量中无元素

#### 6.大小函数

- int size() const:返回向量中元素的个数
- int capacity() const:返回当前向量张红所能容纳的最大元素值
- int max_size() const:返回最大可允许的vector元素数量值

#### **7.其他函数**

- void swap(vector&):交换两个同类型向量的数据
- void assign(int n,const T& x):设置向量中第n个元素的值为x
- void assign(const_iterator first,const_iterator last):向量中[first,last)中元素设置成当前向量元
- max_element（）及min_element（）函数，二者返回的都是迭代器或指针

#### 8.速查

1.push_back 在数组的最后添加一个数据

2.pop_back 去掉数组的最后一个数据

3.at 得到编号位置的数据

4.begin 得到数组头的指针

5.end 得到数组的最后一个单元+1的指针

6．front 得到数组头的引用

7.back 得到数组的最后一个单元的引用

8.max_size 得到vector最大可以是多大

9.capacity 当前vector分配的大小

10.size 当前使用数据的大小

11.resize 改变当前使用数据的大小，如果它比当前使用的大，者填充默认值

12.reserve 改变当前vecotr所分配空间的大小

13.erase 删除指针指向的数据项

14.clear 清空当前的vector

15.rbegin 将vector反转后的开始指针返回(其实就是原来的end-1)

16.rend 将vector反转构的结束指针返回(其实就是原来的begin-1)

17.empty 判断vector是否为空

18.swap 与另一个vector交换数据

### 实例

两种访问方式迭代器和数组

## deque

所谓的deque是”double ended queue”的缩写，双端队列不论在尾部或头部插入元素，都十分迅速。而在中间插入元素则会比较费时，因为必须移动中间其他的元素。双端队列是一种随机访问的数据类型，提供了在序列两端快速插入和删除操作的功能，它可以在需要的时候改变自身大小，完成了标准的C++数据结构中队列的所有功能。 

Vector是单向开口的连续线性空间，deque则是一种双向开口的连续线性空间。deque对象在队列的两端放置元素和删除元素是高效的，而向量vector只是在插入序列的末尾时操作才是高效的。deque和vector的最大差异，一在于deque允许于常数时间内对头端进行元素的插入或移除操作，二在于deque没有所谓的capacity观念，因为它是动态地以分段连续空间组合而成，随时可以增加一段新的空间并链接起来。换句话说，像vector那样“因旧空间不足而重新配置一块更大空间，然后复制元素，再释放旧空间”这样的事情在deque中是不会发生的。也因此，deque没有必要提供所谓的空间预留（reserved）功能。 

虽然deque也提供Random Access Iterator，但它的迭代器并不是普通指针，其复杂度和vector不可同日而语，这当然涉及到各个运算层面。因此，除非必要，我们应尽可能选择使用vector而非deque。对deque进行的排序操作，为了最高效率，可将deque先完整复制到一个vector身上，将vector排序后（利用STL的sort算法），再复制回deque。 

deque是一种优化了的对序列两端元素进行添加和删除操作的基本序列容器。通常由一些独立的区块组成，第一区块朝某方向扩展，最后一个区块朝另一方向扩展。它允许较为快速地随机访问但它不像vector一样把所有对象保存在一个连续的内存块，而是多个连续的内存块。并且在一个映射结构中保存对这些块以及顺序的跟踪。

### 声明

```c++
#include<deque>  // 头文件
deque<type> deq;  // 声明一个元素类型为type的双端队列que
deque<type> deq(size);  // 声明一个类型为type、含有size个默认值初始化元素的的双端队列que
deque<type> deq(size, value);  // 声明一个元素类型为type、含有size个value元素的双端队列que
deque<type> deq(mydeque);  // deq是mydeque的一个副本
deque<type> deq(first, last);  // 使用迭代器first、last范围内的元素初始化deq
```

### 常用成员函数

1. deq[ ]：用来访问双向队列中单个的元素。
2. deq.front()：返回第一个元素的引用。
3. deq.back()：返回最后一个元素的引用。
4. deq.push_front(x)：把元素x插入到双向队列的头部。
5. deq.pop_front()：弹出双向队列的第一个元素。
6. deq.push_back(x)：把元素x插入到双向队列的尾部。
7. deq.pop_back()：弹出双向队列的最后一个元素。

### 特点

1. 支持随机访问，即支持[ ]以及at()，但是性能没有vector好。
2. 可以在内部进行插入和删除操作，但性能不及list。
3. deque两端都能够快速插入和删除元素，而vector只能在尾端进行。
4. deque的元素存取和迭代器操作会稍微慢一些，因为deque的内部结构会多一个间接过程。
5. deque迭代器是特殊的智能指针，而不是一般指针，它需要在不同的区块之间跳转。
6. deque可以包含更多的元素，其max_size可能更大，因为不止使用一块内存。
7. deque不支持对容量和内存分配时机的控制。
8. 在除了首尾两端的其他地方插入和删除元素，都将会导致指向deque元素的任何pointers、references、iterators失效。不过，deque的内存重分配优于vector，因为其内部结构显示不需要复制所有元素。
9. deque的内存区块不再被使用时，会被释放，deque的内存大小是可缩减的。不过，是不是这么做以及怎么做由实际操作版本定义。
10. deque不提供容量操作：capacity()和reverse()，但是vector可以。

## list的定义

List是stl实现的双向链表，与向量(vectors)相比, 它允许快速的插入和删除，但是随机访问却比较慢。使用时需要添加头文件

### 初始化

list\<int>lst1;     //创建空list

  list\<int> lst2(5);    //创建含有5个元素的list

  list\<int>lst3(3,2); //创建含有3个元素的list

  list\<int>lst4(lst2);  //使用lst2初始化lst4

  list\<int>lst5(lst2.begin(),lst2.end()); //同lst4

### 常用操作函数

Lst1.assign() 给list赋值 
Lst1.back() 返回最后一个元素 
Lst1.begin() 返回指向第一个元素的迭代器 
Lst1.clear() 删除所有元素 
Lst1.empty() 如果list是空的则返回true 
Lst1.end() 返回末尾的迭代器 
Lst1.erase() 删除一个元素 
Lst1.front() 返回第一个元素 
Lst1.get_allocator() 返回list的配置器 
Lst1.insert() 插入一个元素到list中 
Lst1.max_size() 返回list能容纳的最大元素数量 
Lst1.merge() 合并两个list 
Lst1.pop_back() 删除最后一个元素 
Lst1.pop_front() 删除第一个元素 
Lst1.push_back() 在list的末尾添加一个元素 
Lst1.push_front() 在list的头部添加一个元素 
Lst1.rbegin() 返回指向第一个元素的逆向迭代器 
Lst1.remove() 从list删除元素 
Lst1.remove_if() 按指定条件删除元素 
Lst1.rend() 指向list末尾的逆向迭代器 
Lst1.resize() 改变list的大小 
Lst1.reverse() 把list的元素倒转 
Lst1.size() 返回list中的元素个数 
Lst1.sort() 给list排序 
Lst1.splice() 合并两个list 
Lst1.swap() 交换两个list 
Lst1.unique() 删除list中相邻重复的元素

map/multimap

map和multimap都需要#include<map>，唯一的不同是，map的键值key不可重复，而multimap可以，也正是由于这种区别，map支持[ ]运算符，multimap不支持[ ]运算符。在用法上没什么区别。

C++中map提供的是一种键值对容器，里面的数据都是成对出现的,如下图：每一对中的第一个值称之为关键字(key)，每个关键字只能在map中出现一次；第二个称之为该关键字的对应值。

![http://www.studytonight.com/cpp/images/map-example.png](D:/workstudy/studyingnotes/img/map-example-16482002244522.png)

Map是STL的一个关联容器，它提供一对一（其中第一个可以称为关键字，每个关键字只能在map中出现一次，第二个可能称为该关键字的值）的数据 处理能力，由于这个特性，它完成有可能在我们处理一对一数据的时候，在编程上提供快速通道。这里说下map内部数据的组织，map内部自建一颗红黑树(一 种非严格意义上的平衡二叉树)，这颗树具有对数据自动排序的功能，所以在map内部所有的数据都是有序的。

## 基本操作函数

 **begin**()     返回指向map头部的迭代器

   **clear**(）    删除所有元素

   **count**()     返回指定元素出现的次数

   **empty**()     如果map为空则返回true

   **end**()      返回指向map末尾的迭代器

   **equal_range**()  返回特殊条目的迭代器对

   **erase**()     删除一个元素

   **find**()     查找一个元素

   **get_allocator**() 返回map的配置器

   **insert**()    插入元素

   **key_comp**()   返回比较元素key的函数

   **lower_bound**()  返回键值>=给定元素的第一个位置

   **max_size**()   返回可以容纳的最大元素个数

   **rbegin**()    返回一个指向map尾部的逆向迭代器

   **rend**()     返回一个指向map头部的逆向迭代器

   **size**()     返回map中元素的个数

   **swap**()      交换两个map

   **upper_bound**()  返回键值>给定元素的第一个位置

   **value_comp**()   返回比较元素value的函数

### 迭代器

共有八个获取迭代器的函数：**begin, end, rbegin,rend** 以及对应的 **cbegin, cend, crbegin,crend**。

二者的区别在于，后者一定返回 const_iterator，而前者则根据map的类型返回iterator 或者 const_iterator。const情况下，不允许对值进行修改。如下面代码所示

### 插入操作

```c++
mapStudent.insert(map<int, string>::value_type (1, "student_one"));
 mapStudent.insert(pair<int, string>(1, "student_one")); 
//多个插入
// 插入单个键值对，并返回插入位置和成功标志，插入位置已经存在值时，插入失败
pair<iterator,bool> insert (const value_type& val);
//在指定位置插入，在不同位置插入效率是不一样的，因为涉及到重排
iterator insert (const_iterator position, const value_type& val);
// 插入多个
void insert (InputIterator first, InputIterator last);
//c++11开始支持，使用列表插入多个   
void insert (initializer_list<value_type> il);


ret = mymap.insert(std::pair<char, int>('z', 500));
//指定位置插入
    std::map<char, int>::iterator it = mymap.begin();
    mymap.insert(it, std::pair<char, int>('b', 300));  //效率更高
    mymap.insert(it, std::pair<char, int>('c', 400));  //效率非最高
 
    //范围多值插入
    std::map<char, int> anothermap;
    anothermap.insert(mymap.begin(), mymap.find('c'));
 
    // 列表形式插入
    anothermap.insert({ { 'd', 100 }, {'e', 200} });


```

插入方式的区别，虽然都可以实现数据的插入，但是它们是有区别的，当然了第一种和第二种在效果上是完成一样的，用insert函数插入数据，在数据的 插入上涉及到集合的唯一性这个概念，即当map中有这个关键字时，insert操作是插入数据不了的，但是用数组方式就不同了，它可以覆盖以前该关键字对 应的值

### 查找，删除和交换

```c++
// 关键字查询，找到则返回指向该关键字的迭代器，否则返回指向end的迭代器
// 根据map的类型，返回的迭代器为 iterator 或者 const_iterator
iterator find (const key_type& k);
const_iterator find (const key_type& k) const;

// 删除迭代器指向位置的键值对，并返回一个指向下一元素的迭代器
iterator erase( iterator pos )
 
// 删除一定范围内的元素，并返回一个指向下一元素的迭代器
iterator erase( const_iterator first, const_iterator last );
 
// 根据Key来进行删除， 返回删除的元素数量，在map里结果非0即1
size_t erase( const key_type& key );
 
// 清空map，清空后的size为0
void clear();

// 就是两个map的内容互换
void swap( map& other );

// 查询map是否为空
bool empty();
 
// 查询map中键值对的数量
size_t size();
 
// 查询map所能包含的最大键值对数量，和系统和应用库有关。
// 此外，这并不意味着用户一定可以存这么多，很可能还没达到就已经开辟内存失败了
size_t max_size();
 
// 查询关键字为key的元素的个数，在map里结果非0即1
size_t count( const Key& key ) const; //
```

### 排序

map中的元素是自动按Key升序排序，所以不能对map用sort函数；

### 小于号 < 重载

```c++
#include <iostream>  
#include <string>  
#include <map>  
using namespace std;
 
typedef struct tagStudentinfo
{
	int      niD;
	string   strName;
	bool operator < (tagStudentinfo const& _A) const
	{     //这个函数指定排序策略，按niD排序，如果niD相等的话，按strName排序  
		if (niD < _A.niD) return true;
		if (niD == _A.niD)
			return strName.compare(_A.strName) < 0;
		return false;
	}
}Studentinfo, *PStudentinfo; //学生信息  
 
int main()
{
	int nSize;   //用学生信息映射分数  
	map<Studentinfo, int>mapStudent;
	map<Studentinfo, int>::iterator iter;
	Studentinfo studentinfo;
	studentinfo.niD = 1;
	studentinfo.strName = "student_one";
	mapStudent.insert(pair<Studentinfo, int>(studentinfo, 90));
	studentinfo.niD = 2;
	studentinfo.strName = "student_two";
	mapStudent.insert(pair<Studentinfo, int>(studentinfo, 80));
	for (iter = mapStudent.begin(); iter != mapStudent.end(); iter++)
		cout << iter->first.niD << ' ' << iter->first.strName << ' ' << iter->second << endl;
	return 0;
}
```



###  **仿函数的应用，这个时候结构体中没有直接的小于号重载** 

```c++
//第二种：仿函数的应用，这个时候结构体中没有直接的小于号重载，程序说明  
 
#include <iostream>  
#include <map>  
#include <string>  
using namespace std;
 
typedef struct tagStudentinfo
{
	int      niD;
	string   strName;
}Studentinfo, *PStudentinfo; //学生信息  
 
class sort
{
public:
	bool operator() (Studentinfo const &_A, Studentinfo const &_B) const
	{
		if (_A.niD < _B.niD)
			return true;
		if (_A.niD == _B.niD)
			return _A.strName.compare(_B.strName) < 0;
		return false;
	}
};
 
int main()
{   
	//用学生信息映射分数  
	map<Studentinfo, int, sort>mapStudent;
	map<Studentinfo, int>::iterator iter;
	Studentinfo studentinfo;
	studentinfo.niD = 1;
	studentinfo.strName = "student_one";
	mapStudent.insert(pair<Studentinfo, int>(studentinfo, 90));
	studentinfo.niD = 2;
	studentinfo.strName = "student_two";
	mapStudent.insert(pair<Studentinfo, int>(studentinfo, 80));
	for (iter = mapStudent.begin(); iter != mapStudent.end(); iter++)
		cout << iter->first.niD << ' ' << iter->first.strName << ' ' << iter->second << endl;
	system("pause");
}
```

按照value来排序就要重新定义自定义函数通过vector<pair\>来调用sort

```c++
//功能：输入单词，统计单词出现次数并按照单词出现次数从多到少排序  
#include <iostream>
#include <cstdlib>  
#include <map>  
#include <vector>  
#include <string>  
#include <algorithm>  
using namespace std;
int cmp(const pair<string, int>& x, const pair<string, int>& y)  
{  
    return x.second > y.second;  
}  
void sortMapByValue(map<string, int>& tMap,vector<pair<string, int> >& tVector)  
{  
    for (map<string, int>::iterator curr = tMap.begin(); curr != tMap.end(); curr++)   
        tVector.push_back(make_pair(curr->first, curr->second));    
   
    sort(tVector.begin(), tVector.end(), cmp);  
}  
int main()  
{  
    map<string, int> tMap;  
    string word;  
    while (cin >> word)  
    {  
        pair<map<string,int>::iterator,bool> ret = tMap.insert(make_pair(word, 1));  
        if (!ret.second)  
            ++ret.first->second;  
    }   
   
    vector<pair<string,int>> tVector;  
    sortMapByValue(tMap,tVector);  
    for(int i=0;i<tVector.size();i++)  
        cout<<tVector[i].first<<": "<<tVector[i].second<<endl;  
   
    system("pause");  
    return 0;  
}  
```





unordered_multimap

如果你需要对map中的数据排序，就首选map，他会把你的数据按照key的自然排序排序（由于它的底层实现红黑树机制所以会排序），如果不需要排序，就看你对内存和cpu的选择了，不过一般都会选择unordered_map，它的查找效率会更高

## set/multimap

`std::set` 是关联容器，含有 `Key` 类型对象的已排序集。用比较函数compare进行排序。搜索、移除和插入拥有对数复杂度。 set 通常以红黑树实现。

set容器内的元素会被自动排序，set与map不同，set中的元素即是键值又是实值，set不允许两个元素有相同的键值。不能通过set的迭代器去修改set元素，原因是修改元素会破坏set组织。当对容器中的元素进行插入或者删除时，操作之前的所有迭代器在操作之后依然有效。

由于set元素是排好序的，且默认为升序，因此当set集合中的元素为结构体或自定义类时，该结构体或自定义类必须实现运算符‘<’的重载。

　　multiset特性及用法和set完全相同，唯一的差别在于它允许键值重复。

　　set和multiset的底层实现是一种高效的平衡二叉树，即红黑树（Red-Black Tree）。

### 常用函数

1\. begin()--返回指向第一个元素的迭代器

2\. clear()--清除所有元素

3\. count()--返回某个值元素的个数

4\. empty()--如果集合为空，返回true

5\. end()--返回指向最后一个元素的迭代器

6\. equal_range()--返回集合中与给定值相等的上下限的两个迭代器

7\. erase()--删除集合中的元素

8\. find()--返回一个指向被查找到元素的迭代器

9\. get_allocator()--返回集合的分配器

10\. insert()--在集合中插入元素

11\. lower_bound()--返回指向大于（或等于）某值的第一个元素的迭代器

12\. key_comp()--返回一个用于元素间值比较的函数

13\. max_size()--返回集合能容纳的元素的最大限值

14\. rbegin()--返回指向集合中最后一个元素的反向迭代器

15\. rend()--返回指向集合中第一个元素的反向迭代器

16\. size()--集合中元素的数目

17\. swap()--交换两个集合变量

18\. upper_bound()--返回大于某个值元素的迭代器

19\. value_comp()--返回一个用于比较元素间的值的函数

```c++
#include <iostream>
#include <string>
#include <set>
using namespace std;
/* 仿函数CompareSet，在test02使用 */
class CompareSet
{
public:
    //从大到小排序
    bool operator()(int v1, int v2)
    {
        return v1 > v2;
    }
    //从小到大排序
    //bool operator()(int v1, int v2)
    //{
    //    return v1 < v2;
    //}
};
/* Person类，用于test03 */
class Person
{
    friend ostream &operator<<(ostream &out, const Person &person);
public:
    Person(string name, int age)
    {
        mName = name;
        mAge = age;
    }
public:
    string mName;
    int mAge;
};
ostream &operator<<(ostream &out, const Person &person)
{
    out << "name:" << person.mName << " age:" << person.mAge << endl;
    return out;
}
 
/* 仿函数ComparePerson,用于test03 */
class ComparePerson
{
public:
    //名字大的在前面，如果名字相同，年龄大的排前面
    bool operator()(const Person &p1, const Person &p2)
    {
        if (p1.mName == p2.mName)
        {
            return p1.mAge > p2.mAge;
        }
        return p1.mName > p2.mName;
    }
};
/* 打印set类型的函数模板 */
template<typename T>
void PrintSet(T &s)
{
    for (T::iterator iter = s.begin(); iter != s.end(); ++iter)
        cout << *iter << " ";
    cout << endl;
}
void test01()
{
    //set容器默认从小到大排序
    set<int> s;
    s.insert(10);
    s.insert(20);
    s.insert(30);
    //输出set
    PrintSet(s);
    //结果为:10 20 30
    /* set的insert函数返回值为一个对组(pair)。
       对组的第一个值first为set类型的迭代器：
       1、若插入成功，迭代器指向该元素。
       2、若插入失败，迭代器指向之前已经存在的元素
       对组的第二个值seconde为bool类型：
       1、若插入成功，bool值为true
       2、若插入失败，bool值为false
    */
    pair<set<int>::iterator, bool> ret = s.insert(40);
    if (true == ret.second)
        cout << *ret.first << " 插入成功" << endl;
    else
        cout << *ret.first << " 插入失败" << endl;
}
void test02()
{
    /* 如果想让set容器从大到小排序，需要给set容
       器提供一个仿函数,本例的仿函数为CompareSet
    */
    set<int, CompareSet> s;
    s.insert(10);
    s.insert(20);
    s.insert(30);
    
    //打印set
    PrintSet(s);
    //结果为:30,20,10
}
void test03()
{
    /* set元素类型为Person，当set元素类型为自定义类型的时候
       必须给set提供一个仿函数，用于比较自定义类型的大小，
       否则无法通过编译 
    */
    set<Person,ComparePerson> s;
    s.insert(Person("John", 22));
    s.insert(Person("Peter", 25));
    s.insert(Person("Marry", 18));
    s.insert(Person("Peter", 36));
 
    //打印set
    PrintSet(s);
}
int main(void)
{
    //test01();
    //test02();
    //test03();
    return 0;
}
```

```c++
#include <iostream>
#include <set>

using namespace std;
 
/* 打印set类型的函数模板 */

template<typename T>
void PrintSet(T &s)
{
    typename T::iterator iter;
    for (iter = s.begin();iter != s.end();++iter)
        cout << *iter << " ";
    cout << endl;
}

void test(void)
{
    multiset<int> s;
    s.insert(10);
    s.insert(20);
    s.insert(30);
    
    //打印multiset
    PrintSet(s);
 
    /* multiset的insert函数返回值为multiset类型的迭代器，
       指向新插入的元素。multiset允许插入相同的值，因此
       插入一定成功，因此不需要返回bool类型。
    */
    //返回值是元素本身
    multiset<int>::iterator iter = s.insert(10);
    
    cout << *iter << endl;    
    PrintSet(s);
}
 
int main(void)
{
    test();
    return 0;
}
```

## unordered_set

C++ 11中出现了两种新的关联容器:unordered_set和unordered_map，其内部实现与set和map大有不同，set和map内部实现是基于RB-Tree，而unordered_set和unordered_map内部实现是基于哈希表(hashtable)，由于unordered_set和unordered_map内部实现的公共接口大致相同，所以本文以unordered_set为例。

​    unordered_set是基于哈希表，因此要了解unordered_set，就必须了解哈希表的机制。哈希表是根据关键码值而进行直接访问的数据结构，通过相应的哈希函数(也称散列函数)处理关键字得到相应的关键码值，关键码值对应着一个特定位置，用该位置来存取相应的信息，这样就能以较快的速度获取关键字的信息。比如：现有公司员工的个人信息（包括年龄），需要查询某个年龄的员工个数。由于人的年龄范围大约在[0，200]，所以可以开一个200大小的数组，然后通过哈希函数[![img](D:/workstudy/studyingnotes/img/fn_jvn&space;f(key)=key.gif)](http://private.codecogs.com/eqnedit.php?latex=\dpi{100}&space;\fn_jvn&space;f(key)=key)得到key对应的key-value，这样就能完成统计某个年龄的员工个数。而在这个例子中，也存在这样一个问题，两个员工的年龄相同，但其他信息（如：名字、身份证）不同，通过前面说的哈希函数，会发现其都位于数组的相同位置，这里，就涉及到“冲突”。准确来说，冲突是不可避免的，而解决冲突的方法常见的有：开发地址法、再散列法、链地址法(也称拉链法)。而unordered_set内部解决冲突采用的是----链地址法，当用冲突发生时把具有同一关键码的数据组成一个链表。下图展示了链地址法的使用:

![img](D:/workstudy/studyingnotes/img/20150707111017370-16482030650225.png)

## STACK

![img](D:/workstudy/studyingnotes/img/1738131-20190920194156752-1724424437-16482032682847.png)

### stack容器的声明

stackstack容器存放在模板库：`#include<stack>`里，使用前需要先开这个库。
stackstack容器的声明遵循C++STLC++STL的一般声明原则：
容器类型<变量类型> 名称
例：

```cpp
#include<stack>
stack<int> st;
stack<char> st;
stack<pair<int,int> > st;
stack<node> st;
struct node{...};
```

### stack容器的使用方法

stackstack容器的使用方法大致如下表所示：

| 用法         | 作用                              |
| ------------ | --------------------------------- |
| `st.top()`   | 返回stack的栈顶**元素**           |
| `st.push()`  | 从stack栈顶加入一个元素           |
| `st.size()`  | 返回stack当前的长度（大小）       |
| `st.pop()`   | 从stack栈顶弹出一个元素           |
| `st.empty()` | 返回stack是否为空，1为空、0不为空 |

## priority_queue

优先队列

![img](D:/workstudy/studyingnotes/img/1738131-20190920194202009-539251419-16482033713179.png)

而C++STLC++STL中的优先队列就是在这个队列的基础上，把其中的元素加以排序。其内部实现是一个二叉堆。所以优先队列其实就是把堆模板化，将所有入队的元素排成具有单调性的一队，方便我们调用。

### priority_queue容器的声明

priorityqueuepriorityqueue容器存放在模板库：`#include<queue>`里，使用前需要先开这个库。

这里需要注意的是，优先队列的声明与一般STLSTL模板的声明方式并不一样。事实上，我认为其是C++STLC++STL中最难声明的一个容器。

#### 大根堆声明方式：

大根堆就是把大的元素放在堆顶的堆。优先队列默认实现的就是大根堆，所以大根堆的声明不需要任何花花肠子，直接按C++STLC++STL的声明规则声明即可。

```cpp
#include<queue>
priority_queue<int> q;
priority_queue<string> q;
priority_queue<pair<int,int> > q;
```

C++C++中的int,stringint,string等类型可以直接比较大小，所以不用我们多操心，优先队列自然会帮我们实现。但是如果是我们自己定义的结构体，就需要进行重载运算符了。

重载运算符

```c++
struct node
{
    int id;
    double x,y;
}//定义结构体
bool operator <(const node &a,const node &b)
{
    return a.x<b.x && a.y<b.y;
}//重载运算符“<”

```

#### 小根堆声明方式

大根堆是把大的元素放堆顶，小根堆就是把小的元素放到堆顶。

实现小根堆有两种方式：

第一种是比较巧妙的，因为优先队列默认实现的是大根堆，所以我们可以把元素取反放进去，因为负数的绝对值越小越大，那么绝对值较小的元素就会被放在前面，我们在取出的时候再取个反，就瞒天过海地用大根堆实现了小根堆。

第二种：

小根堆有自己的声明方式，我们记住即可（我也说不明白道理）：

```cpp
priority_queue<int,vector<int>,greater<int> >q;
```

注意，当我们声明的时候碰到两个"<"或者">"放在一起的时候，一定要记得在中间加一个空格。这样编译器才不会把两个连在一起的符号判断成位运算的左移/右移。

### priority_queue容器的使用方法

priorityqueuepriorityqueue容器的使用方法大致如下表所示：

| 用法        | 作用                                       |
| ----------- | ------------------------------------------ |
| `q.top()`   | 返回priority_queue的首**元素**             |
| `q.push()`  | 向priority_queue中加入一个元素             |
| `q.size()`  | 返回priority_queue当前的长度（大小）       |
| `q.pop()`   | 从priority_queue末尾删除一个元素           |
| `q.empty()` | 返回priority_queue是否为空，1为空、0不为空 |

注意：priority_queue取出队首元素是使用toptop，而不是frontfront，这点一定要注意！

## C++ STL bitset 容器详解

本篇随笔讲解C++STLC++STL中bitsetbitset容器的用法及常见使用技巧。

### bitsetbitset容器概论

bitsetbitset容器其实就是个0101串。可以被看作是一个boolbool数组。它比boolbool数组更优秀的优点是：**节约空间，节约时间，支持基本的位运算。**在bitsetbitset容器中，88位占一个字节，相比于boolbool数组44位一个字节的空间利用率要高很多。同时，nn位的bitsetbitset在执行一次位运算的复杂度可以被看作是n/32n/32，这都是boolbool数组所没有的优秀性质。

bitsetbitset容器包含在C++C++自带的bitsetbitset库中。

```cpp
#include<bitset>
```

### bitsetbitset容器的声明

因为bitsetbitset容器就是装0101串的，所以不用在< >中装数据类型，这和一般的STLSTL容器不太一样。< >中装0101串的**位数**。

如：（声明一个105105位的bitsetbitset）

```cpp
bitset<100000> s;
```

### 对bitsetbitset容器的一些操作

#### 1、常用的操作函数

和其他的STLSTL容器一样，对bitsetbitset的很多操作也是由自带函数来实现的。下面，我们来介绍一下bitsetbitset的一些常用函数及其使用方法。

- count()count()函数

countcount，数数的意思。它的作用是数出11的个数。即s.count()s.count()返回ss中有多少个11.

```cpp
s.count();
```

- any()/none()any()/none()函数

anyany，任何的意思。nonenone，啥也没有的意思。这两个函数是在检查bitsetbitset容器中全00的情况。

如果，bitsetbitset中全都为00，那么s.any()s.any()返回falsefalse，s.none()s.none()返回truetrue。

反之，假如bitsetbitset中至少有一个11，即哪怕有一个11，那么s.any()s.any()返回truetrue，s.none()s.none()返回falsefalse.

```cpp
s.any();
s.none();
```

- set()set()函数

set()set()函数的作用是把bitsetbitset全部置为11.

特别地，set()set()函数里面可以传参数。set(u,v)set(u,v)的意思是把bitsetbitset中的第uu位变成v,v∈0/1v,v∈0/1。

```cpp
s.set();
s.set(u,v);
```

- reset()reset()函数

与set()set()函数相对地，reset()reset()函数将bitsetbitset的所有位置为00。而reset()reset()函数只传一个参数，表示把这一位改成00。

```cpp
s.reset();
s.reset(k);
```

- flip()flip()函数

flip()flip()函数与前两个函数不同，它的作用是将整个bitsetbitset容器按位取反。同上，其传进的参数表示把其中一位取反。

```cpp
s.flip();
s.flip(k);
```

#### 2、位运算操作在bitsetbitset中的实现

bitsetbitset的作用就是帮助我们方便地实现位运算的相关操作。它当然支持位运算的一些操作内容。我们在编写程序的时候对数进行的二进制运算均可以用在bitsetbitset函数上。

比如：

~：按位取反

&：按位与

|：按位或

^：按位异或

<< >>：左/右移

==/！=：比较两个bitsetbitset是否相等。

关于位运算的相关知识，不懂的小伙伴请戳这里：

[常用的位运算技巧](https://www.cnblogs.com/fusiwei/p/11384756.html)

另外，bitsetbitset容器还支持直接取值和直接赋值的操作：具体操作方式如下：

```cpp
s[3]=1;
s[5]=0;
```

这里要注意：在bitsetbitset容器中，最低位为00。这与我们的数组实现仍然有区别。

### bitset容器的实际应用

bitsetbitset可以高效率地对0101串，0101矩阵等等只含0/10/1的题目进行处理。其中支持的许多操作对我们处理数据非常有帮助。如果碰到一道0/10/1题，使用bitsetbitset或许是不错的选择。



# 多线程

