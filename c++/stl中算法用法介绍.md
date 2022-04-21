STL函数目录

# 查找算法：判断容器中是否包含某个值

adjacent_find:在iterator对标识元素范围内，查找一对相邻重复元素，找到则返回指向这对元素的第一个元素的                        

 ForwardIterator。否则返回last。重载版本使用输入的二元操作符代替相等的判断。

**binary_search:** 在有序序列中查找value，找到返回true。重载的版本实用指定的比较函数对象或函数指针来判断相等。
**count:**        利用等于操作符，把标志范围内的元素与输入值比较，返回相等元素个数。
**count_if:**      利用输入的操作符，对标志范围内的元素进行操作，返回结果为true的个数。
**equal_range:**   功能类似equal，返回一对iterator，第一个表示lower_bound，第二个表示upper_bound。
**find:**          利用底层元素的等于操作符，对指定范围内的元素与输入值进行比较。当匹配时，结束搜索，返回该元素的 一个InputIterator。

**find_end:**     在指定范围内查找"由输入的另外一对iterator标志的第二个序列"的最后一次出现。找到则返回最后一对的第一              个ForwardIterator，否则返回输入的"另外一对"的第一个ForwardIterator。重载版本使用用户输入的操作符代                替等于操作。
**find_first_of:**   在指定范围内查找"由输入的另外一对iterator标志的第二个序列"中任意一个元素的第一次出现。重载版本中使               用了用户自定义操作符。
**find_if:**        使用输入的函数代替等于操作符执行find。
**lower_bound:**  返回一个ForwardIterator，指向在有序序列范围内的可以插入指定值而不破坏容器顺序的第一个位置。重载函               数使用自定义比较操作。
**upper_bound:** 返回一个ForwardIterator，指向在有序序列范围内插入value而不破坏容器顺序的最后一个位置，该位置标志                一个大于value的值。重载函数使用自定义比较操作。
**search:**       给出两个范围，返回一个ForwardIterator，查找成功指向第一个范围内第一次出现子序列(第二个范围)的位                 置，查找失败指向last1。重载版本使用自定义的比较操作。
**search_n:**     在指定范围内查找val出现n次的子序列。重载版本使用自定义的比较操作。

# 排序和通用算法(14个)：提供元素排序策略

**inplace_merge:**   合并两个有序序列，结果序列覆盖两端范围。重载版本使用输入的操作进行排序。
**merge:**          合并两个有序序列，存放到另一个序列。重载版本使用自定义的比较。
**nth_element:**     将范围内的序列重新排序，使所有小于第n个元素的元素都出现在它前面，而大于它的都出现在后面。重                  载版本使用自定义的比较操作。
**partial_sort:**      对序列做部分排序，被排序元素个数正好可以被放到范围内。重载版本使用自定义的比较操作。
**partial_sort_copy:** 与partial_sort类似，不过将经过排序的序列复制到另一个容器。
**partition:**         对指定范围内元素重新排序，使用输入的函数，把结果为true的元素放在结果为false的元素之前。
**random_shuffle:**  对指定范围内的元素随机调整次序。重载版本输入一个随机数产生操作。
**reverse:**         将指定范围内元素重新反序排序。
**reverse_copy:**    与reverse类似，不过将结果写入另一个容器。
**rotate:**           将指定范围内元素移到容器末尾，由middle指向的元素成为容器第一个元素。
**rotate_copy:**      与rotate类似，不过将结果写入另一个容器。
**sort:**             以升序重新排列指定范围内的元素。重载版本使用自定义的比较操作。
**stable_sort:**      与sort类似，不过保留相等元素之间的顺序关系。
**stable_partition:**  与partition类似，不过不保证保留容器中的相对顺序。

# 删除和替换算法

copy:**          复制序列
**copy_backward:** 与copy相同，不过元素是以相反顺序被拷贝。
**iter_swap:**      交换两个ForwardIterator的值。
**remove:**        删除指定范围内所有等于指定元素的元素。注意，该函数不是真正删除函数。内置函数不适合使用remove和                remove_if函数。
**remove_copy:**   将所有不匹配元素复制到一个制定容器，返回OutputIterator指向被拷贝的末元素的下一个位置。
**remove_if:**      删除指定范围内输入操作结果为true的所有元素。
**remove_copy_if:** 将所有不匹配元素拷贝到一个指定容器。
**replace:**        将指定范围内所有等于vold的元素都用vnew代替。
**replace_copy:**   与replace类似，不过将结果写入另一个容器。
**replace_if:**      将指定范围内所有操作结果为true的元素用新值代替。
**replace_copy_if:** 与replace_if，不过将结果写入另一个容器。
**swap:**          交换存储在两个对象中的值。
**swap_range:**    将指定范围内的元素与另一个序列元素值进行交换。
**unique:**        清除序列中重复元素，和remove类似，它也不能真正删除元素。重载版本使用自定义比较操作。
**unique_copy:**   与unique类似，不过把结果输出到另一个容器。

# 排列组合算法：提供计算给定集合按一定顺序的所有可能排列组合

**next_permutation:** 取出当前范围内的排列，并重新排序为下一个排列。重载版本使用自定义的比较操作。
**prev_permutation:** 取出指定范围内的序列并将它重新排序为上一个序列。如果不存在上一个序列则返回false。重载版本使用                  自定义的比较操作。

## 算术算法

**accumulate:**        iterator对标识的序列段元素之和，加到一个由val指定的初始值上。重载版本不再做加法，而是传进来的                   二元操作符被应用到元素上。
**partial_sum:**        创建一个新序列，其中每个元素值代表指定范围内该位置前所有元素之和。重载版本使用自定义操作代                   替加法。
**inner_product:**      对两个序列做内积(对应元素相乘，再求和)并将内积加到一个输入的初始值上。重载版本使用用户定义                    的操作。
**adjacent_difference:** 创建一个新序列，新序列中每个新值代表当前元素与上一个元素的差。重载版本用指定二元操作计算相                   邻元素的差。

## 生成和异变算法

**fill:**         将输入值赋给标志范围内的所有元素。
**fill_n:**      将输入值赋给first到first+n范围内的所有元素。
**for_each:**   用指定函数依次对指定范围内所有元素进行迭代访问，返回所指定的函数类型。该函数不得修改序列中的元素。
**generate:**   连续调用输入的函数来填充指定的范围。
**generate_n:** 与generate函数类似，填充从指定iterator开始的n个元素。
**transform:**  将输入的操作作用与指定范围内的每个元素，并产生一个新的序列。重载版本将操作作用在一对元素上，另外一            个元素来自输入的另外一个序列。结果输出到指定容器。

## 关系算法

**equal:**                 如果两个序列在标志范围内元素都相等，返回true。重载版本使用输入的操作符代替默认的等于操                        作符。
**includes:**               判断第一个指定范围内的所有元素是否都被第二个范围包含，使用底层元素的<操作符，成功返回                        true。重载版本使用用户输入的函数。
**lexicographical_compare:** 比较两个序列。重载版本使用用户自定义比较操作。
**max:**                   返回两个元素中较大一个。重载版本使用自定义比较操作。
**max_element:**           返回一个ForwardIterator，指出序列中最大的元素。重载版本使用自定义比较操作。
**min:**                   返回两个元素中较小一个。重载版本使用自定义比较操作。
**min_element:**            返回一个ForwardIterator，指出序列中最小的元素。重载版本使用自定义比较操作。
**mismatch:**              并行比较两个序列，指出第一个不匹配的位置，返回一对iterator，标志第一个不匹配元素位置。                         如果都匹配，返回每个容器的last。重载版本使用自定义的比较操作。

## 集合算法

**set_union:**              构造一个有序序列，包含两个序列中所有的不重复元素。重载版本使用自定义的比较操作。
**set_intersection:**         构造一个有序序列，其中元素在两个序列中都存在。重载版本使用自定义的比较操作。
**set_difference:**          构造一个有序序列，该序列仅保留第一个序列中存在的而第二个中不存在的元素。重载版本使用                         自定义的比较操作。
**set_symmetric_difference:** 构造一个有序序列，该序列取两个序列的对称差集(并集-交集)。

## 堆算法

**make_heap:** 把指定范围内的元素生成一个堆。重载版本使用自定义比较操作。
**pop_heap:**  并不真正把最大元素从堆中弹出，而是重新排序堆。它把first和last-1交换，然后重新生成一个堆。可使用容器的            back来访问被"弹出"的元素或者使用pop_back进行真正的删除。重载版本使用自定义的比较操作。
**push_heap:** 假设first到last-1是一个有效堆，要被加入到堆的元素存放在位置last-1，重新生成堆。在指向该函数前，必须先把            元素插入容器后。重载版本使用指定的比较操作。
**sort_heap:** 对指定范围内的序列重新排序，它假设该序列是个有序堆。重载版本使用自定义比较操作。

# 特定算法函数详解

## sort

1. 容器支持的迭代器类型必须为随机访问迭代器。这意味着，sort() 只对 array、vector、deque 这 3 个容器提供支持。
2. 对于指定区域内值相等的元素，sort() 函数无法保证它们的相对位置不发生改变，实际场景中，如果需要保证值相等元素的相对位置不发生改变，可以选用 stable_sort() 排序函数。有关该函数的具体用法，后续章节会做详细讲解。

```c++
//对 [first, last) 区域内的元素做默认的升序排序
//less 升序  greater降序排序  
void sort (RandomAccessIterator first, RandomAccessIterator last);
//按照指定的 comp 排序规则，对 [first, last) 区域内的元素进行排序
void sort (RandomAccessIterator first, RandomAccessIterator last, Compare comp);
```

[C++ STL关联式容器自定义排序规则（2种方法） (xinbaoku.com)](https://xinbaoku.com/archive/6xuzFEcB.html)

## partial_sort()

部分排序 

```
//按照默认的升序排序规则，对 [first, last) 范围的数据进行筛选并排序
void partial_sort (RandomAccessIterator first,
                   RandomAccessIterator middle,
                   RandomAccessIterator last);
//按照 comp 排序规则，对 [first, last) 范围的数据进行筛选并排序
void partial_sort (RandomAccessIterator first,
                   RandomAccessIterator middle,
                   RandomAccessIterator last,
                   Compare comp);
```

其中，first、middle 和 last 都是随机访问迭代器，comp 参数用于自定义排序规则。

partial_sort() 函数会以交换元素存储位置的方式实现部分排序的。具体来说，partial_sort() 会将 [first, last) 范围内最小（或最大）的 middle-first 个元素移动到 [first, middle) 区域中，并对这部分元素做升序（或降序）排序。

需要注意的是，partial_sort() 函数受到底层实现方式的限制，它仅适用于普通数组和部分类型的容器。换句话说，只有普通数组和具备以下条件的容器，才能使用 partial_sort() 函数：

- 容器支持的迭代器类型必须为随机访问迭代器。这意味着，partial_sort() 函数只适用于 array、vector、deque 这 3 个容器。
- 当选用默认的升序排序规则时，容器中存储的元素类型必须支持 <小于运算符；同样，如果选用标准库提供的其它排序规则，元素类型也必须支持该规则底层实现所用的比较运算符；
- partial_sort() 函数在实现过程中，需要交换某些元素的存储位置。因此，如果容器中存储的是自定义的类对象，则该类的内部必须提供移动构造函数和移动赋值运算符。

```c++
int main(){
   vector<int> ve={1,2,5,7,0,2,45,643,34,745,854,83,67};
    vector<int>::iterator it=ve.begin();
    partial_sort(it,it+3,it+ve.size());
    
    for(auto &s:ve)
    {
        cout<<s<<" ";
    }
}
//输出0 1 2 7 5 2 45 643 34 745 854 83 67 
```

### partial_sort_copy()排序函数

partial_sort_copy() 函数的功能和 partial_sort() 类似，唯一的区别在于，前者不会对原有数据做任何变动，而是先将选定的部分元素拷贝到另外指定的数组或容器中，然后再对这部分元素进行排序。

partial_sort_copy() 函数也有 2 种语法格式，分别为：

```
//默认以升序规则进行部分排序
RandomAccessIterator partial_sort_copy (
                       InputIterator first,
                       InputIterator last,
                       RandomAccessIterator result_first,
                       RandomAccessIterator result_last);
//以 comp 规则进行部分排序
RandomAccessIterator partial_sort_copy (
                       InputIterator first,
                       InputIterator last,
                       RandomAccessIterator result_first,
                       RandomAccessIterator result_last,
                       Compare comp);
```

其中，first 和 last 为输入迭代器；result_first 和 result_last 为随机访问迭代器；comp 用于自定义排序规则。

partial_sort_copy() 函数会将 [first, last) 范围内最小（或最大）的 result_last-result_first 个元素复制到 [result_first, result_last) 区域中，并对该区域的元素做升序（或降序）排序。

值得一提的是，[first, last] 中的这 2 个迭代器类型仅限定为输入迭代器，这意味着相比 partial_sort() 函数，partial_sort_copy() 函数放宽了对存储原有数据的容器类型的限制。换句话说，partial_sort_copy() 函数还支持对 list 容器或者 forward_list 容器中存储的元素进行“部分排序”，而 partial_sort() 函数不行。

但是，介于 result_first 和 result_last 仍为随机访问迭代器，因此 [result_first, result_last) 指定的区域仍仅限于普通数组和部分类型的容器，这和 partial_sort() 函数对容器的要求是一样的。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::partial_sort_copy
#include <list>       // std::list
using namespace std;
bool mycomp1(int i, int j) {
    return (i > j);
}
class mycomp2 {
public:
    bool operator() (int i, int j) {
        return (i > j);
    }
};
int main() {
    int myints[5] = { 0 };
    std::list<int> mylist{ 3,2,5,4,1,6,9,7 };
    //按照默认的排序规则进行部分排序
    std::partial_sort_copy(mylist.begin(), mylist.end(), myints, myints + 5);
    cout << "第一次排序：\n";
    for (int i = 0; i < 5; i++) {
        cout << myints[i] << " ";
    }
    //以自定义的 mycomp2 作为排序规则，进行部分排序
    std::partial_sort_copy(mylist.begin(), mylist.end(), myints, myints + 5, mycomp2());
    cout << "\n第二次排序：\n";
    for (int i = 0; i < 5; i++) {
        cout << myints[i] << " ";
    }
    return 0;
}
/* 第一次排序：
1 2 3 4 5
第二次排序：
9 7 6 5 4 */
```

### nth_element()

nth_element() 函数的功能，当采用默认的升序排序规则（std::less<T\>）时，该函数可以从某个序列中找到第 n 小的元素 K，并将 K 移动到序列中第 n 的位置处。不仅如此，整个序列经过 nth_element() 函数处理后，所有位于 K 之前的元素都比 K 小，所有位于 K 之后的元素都比 K 大。

当然，我们也可以将 nth_element() 函数的排序规则自定义为降序排序，此时该函数会找到第 n 大的元素 K 并将其移动到第 n 的位置处，同时所有位于 K 之前的元素都比 K 大，所有位于 K 之后的元素都比 K 小。

```
//排序规则采用默认的升序排序
void nth_element (RandomAccessIterator first,
                  RandomAccessIterator nth,
                  RandomAccessIterator last);
//排序规则为自定义的 comp 排序规则
void nth_element (RandomAccessIterator first,
                  RandomAccessIterator nth,
                  RandomAccessIterator last,
                  Compare comp);
```

其中，各个参数的含义如下：

- first 和 last：都是随机访问迭代器，[first, last) 用于指定该函数的作用范围（即要处理哪些数据）；
- nth：也是随机访问迭代器，其功能是令函数查找“第 nth 大”的元素，并将其移动到 nth 指向的位置；
- comp：用于自定义排序规则。

例如

以下面这个序列为例：

3 4 1 2 5

假设按照升序排序，并通过 nth_element() 函数查找此序列中第 3 小的元素，则最终得到的序列可能为：

2 1 3 4 5

显然，nth_element() 函数找到了第 3 小的元素 3 并将其位于第 3 的位置，同时元素 3 之前的所有元素都比该元素小，元素 3 之后的所有元素都比该元素大。

注意，鉴于 nth_element() 函数中各个参数的类型，其只能对普通数组或者部分容器进行排序。换句话说，只有普通数组和符合以下全部条件的容器，才能使用使用 nth_element() 函数：

1. 容器支持的迭代器类型必须为随机访问迭代器。这意味着，nth_element() 函数只适用于 array、vector、deque 这 3 个容器。
2. 当选用默认的升序排序规则时，容器中存储的元素类型必须支持 <小于运算符；同样，如果选用标准库提供的其它排序规则，元素类型也必须支持该规则底层实现所用的比较运算符；
3. nth_element() 函数在实现过程中，需要交换某些元素的存储位置。因此，如果容器中存储的是自定义的类对象，则该类的内部必须提供移动构造函数和移动赋值运算符。

### is_sorted() 

函数有 2 种语法格式，分别是：

```c++
//判断 [first, last) 区域内的数据是否符合 std::less<T> 排序规则，即是否为升序序列
bool is_sorted (ForwardIterator first, ForwardIterator last);
//判断 [first, last) 区域内的数据是否符合 comp 排序规则  
bool is_sorted (ForwardIterator first, ForwardIterator last, Compare comp);
```

其中，first 和 last 都为正向迭代器（这意味着该函数适用于大部分容器），[first, last) 用于指定要检测的序列；comp 用于指定自定义的排序规则。

> 注意，如果使用默认的升序排序规则，则 [first, last) 指定区域内的元素必须支持使用 < 小于运算符做比较；同样，如果指定排序规则为 comp，也要保证 [first, last) 区域内的元素支持该规则内部使用的比较运算符。

另外，该函数会返回一个 bool 类型值，即如果 [first, last) 范围内的序列符合我们指定的排序规则，则返回 true；反之，函数返回 false。值得一提得是，如果 [first, last) 指定范围内只有 1 个元素，则该函数始终返回 true。

## merge()

merge() 函数用于将 2 个有序序列合并为 1 个有序序列，前提是这 2 个有序序列的排序规则相同（要么都是升序，要么都是降序）。并且最终借助该函数获得的新有序序列，其排序规则也和这 2 个有序序列相同。

```c++
//以默认的升序排序作为排序规则
OutputIterator merge (InputIterator1 first1, InputIterator1 last1,
                      InputIterator2 first2, InputIterator2 last2,
                      OutputIterator result);
//以自定义的 comp 规则作为排序规则
OutputIterator merge (InputIterator1 first1, InputIterator1 last1,
                      InputIterator2 first2, InputIterator2 last2,
                      OutputIterator result, Compare comp);
```

可以看到，first1、last1、first2 以及 last2 都为输入迭代器，[first1, last1) 和 [first2, last2) 各用来指定一个有序序列；result 为输出迭代器，用于为最终生成的新有序序列指定存储位置；comp 用于自定义排序规则。同时，该函数会返回一个输出迭代器，其指向的是新有序序列中最后一个元素之后的位置。

> 注意，当采用第一种语法格式时，[first1, last1) 和 [first2, last2) 指定区域内的元素必须支持 < 小于运算符；同样当采用第二种语法格式时，[first1, last1) 和 [first2, last2) 指定区域内的元素必须支持 comp 排序规则内的比较运算符。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::merge
#include <vector>       // std::vector
using namespace std;
int main() {
    //first 和 second 数组中各存有 1 个有序序列
    int first[] = { 5,10,15,20,25 };
    int second[] = { 7,17,27,37,47,57 };
    //用于存储新的有序序列
    vector<int> myvector(11);
    //将 [first,first+5) 和 [second,second+6) 合并为 1 个有序序列，并存储到 myvector 容器中。
    merge(first, first + 5, second, second + 6, myvector.begin());
    //输出 myvector 容器中存储的元素
    for (vector<int>::iterator it = myvector.begin(); it != myvector.end(); ++it) {
        cout << *it << ' ';
    }   
    return 0;
}
```

### inplace_merge()

当 2 个有序序列存储在同一个数组或容器中时，如果想将它们合并为 1 个有序序列，除了使用 merge() 函数，更推荐使用 inplace_merge() 函数。

和 merge() 函数相比，inplace_merge() 函数的语法格式要简单很多：

```
//默认采用升序的排序规则
void inplace_merge (BidirectionalIterator first, BidirectionalIterator middle,
                    BidirectionalIterator last);
//采用自定义的 comp 排序规则
void inplace_merge (BidirectionalIterator first, BidirectionalIterator middle,
                    BidirectionalIterator last, Compare comp);
```

其中，first、middle 和 last 都为双向迭代器，[first, middle) 和 [middle, last) 各表示一个有序序列。

和 merge() 函数一样，inplace_merge() 函数也要求 [first, middle) 和 [middle, last) 指定的这 2 个序列必须遵循相同的排序规则，且当采用第一种语法格式时，这 2 个序列中的元素必须支持 < 小于运算符；同样，当采用第二种语法格式时，这 2 个序列中的元素必须支持 comp 排序规则内部的比较运算符。不同之处在于，merge() 函数会将最终合并的有序序列存储在其它数组或容器中，而 inplace_merge() 函数则将最终合并的有序序列存储在 [first, last) 区域中。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::merge
using namespace std;
int main() {
    //该数组中存储有 2 个有序序列
    int first[] = { 5,10,15,20,25,7,17,27,37,47,57 };
    //将 [first,first+5) 和 [first+5,first+11) 合并为 1 个有序序列。
    inplace_merge(first, first + 5,first +11);

    for (int i = 0; i < 11; i++) {
        cout << first[i] << " ";
    }
    return 0;
}
//程序执行结果为：5 7 10 15 17 20 25 27 37 47 57
```

## find()

find() 函数本质上是一个模板函数，用于在指定范围内查找和目标元素值相等的第一个元素。

如下为 find() 函数的语法格式：

InputIterator find (InputIterator first, InputIterator last, const T& val);

其中，first 和 last 为输入迭代器，[first, last) 用于指定该函数的查找范围；val 为要查找的目标元素。

> 正因为 first 和 last 的类型为输入迭代器，因此该函数适用于所有的序列式容器。

另外，该函数会返回一个输入迭代器，当 find() 函数查找成功时，其指向的是在 [first, last) 区域内查找到的第一个目标元素；如果查找失败，则该迭代器的指向和 last 相同。

值得一提的是，find() 函数的底层实现，其实就是用`==`运算符将 val 和 [first, last) 区域内的元素逐个进行比对。这也就意味着，[first, last) 区域内的元素必须支持`==`运算符。

### find_if()

和 find() 函数相同，find_if() 函数也用于在指定区域内执行查找操作。不同的是，前者需要明确指定要查找的元素的值，而后者则允许自定义查找规则。

find_if() 函数会根据指定的查找规则，在指定区域内查找第一个符合该函数要求（使函数返回 true）的元素。

find_if() 函数的语法格式如下：

InputIterator find_if (InputIterator first, InputIterator last, UnaryPredicate pred);

其中，first 和 last 都为输入迭代器，其组合 [first, last) 用于指定要查找的区域；pred 用于自定义查找规则。

> 值得一提的是，由于 first 和 last 都为输入迭代器，意味着该函数适用于所有的序列式容器。甚至当采用适当的谓词函数时，该函数还适用于所有的关联式容器（包括哈希容器）。

同时，该函数会返回一个输入迭代器，当查找成功时，该迭代器指向的是第一个符合查找规则的元素；反之，如果 find_if() 函数查找失败，则该迭代器的指向和 last 迭代器相同。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::find_if
#include <vector>       // std::vector
using namespace std;
//自定义一元谓词函数
bool mycomp(int i) {
    return ((i % 2) == 1);
}
//以函数对象的形式定义一个 find_if() 函数的查找规则
class mycomp2 {
public:
    bool operator()(const int& i) {
        return ((i % 2) == 1);
    }
};
int main() {
    vector<int> myvector{ 4,2,3,1,5 };
    //调用 find_if() 函数，并以 IsOdd() 一元谓词函数作为查找规则
    vector<int>::iterator it = find_if(myvector.begin(), myvector.end(), mycomp2());
    cout << "*it = " << *it;
    return 0;
}
```

[C++ STL find_if()官网](http://www.cplusplus.com/reference/algorithm/find_if/)给出了 find_if() 函数底层实现的参考代码（如下所示），感兴趣的读者可自行分析，这里不做过多描述：

```c++
template<class InputIterator, class UnaryPredicate>
InputIterator find_if (InputIterator first, InputIterator last, UnaryPredicate pred)
{
    while (first!=last) {
        if (pred(*first)) return first;
        ++first;
    }
    return last;
}
```

###  find_if_not()函数

find_if_not() 函数和 find_if() 函数的功能恰好相反，通过上面的学习我们知道，find_if() 函数用于查找符合谓词函数规则的第一个元素，而 find_if_not() 函数则用于查找第一个不符合谓词函数规则的元素。

find_if_not() 函数的语法规则如下所示：

InputIterator find_if_not (InputIterator first, InputIterator last, UnaryPredicate pred);

其中，first 和 last 都为输入迭代器，[first, last) 用于指定查找范围；pred 用于自定义查找规则。

> 和 find_if() 函数一样，find_if_not() 函数也适用于所有的容器，包括所有序列式容器和关联式容器。

同样，该函数也会返回一个输入迭代器，当 find_if_not() 函数查找成功时，该迭代器指向的是查找到的那个元素；反之，如果查找失败，该迭代器的指向和 last 迭代器相同。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::find_if_not
#include <vector>       // std::vector
using namespace std;
//自定义一元谓词函数
bool mycomp(int i) {
    return ((i % 2) == 1);
}

int main() {
    vector<int> myvector{4,2,3,1,5};
    //调用 find_if() 函数，并以 mycomp() 一元谓词函数作为查找规则
    vector<int>::iterator it = find_if_not(myvector.begin(), myvector.end(), mycomp);
    cout << "*it = " << *it;
    return 0;
}
//*it =4
```

可以看到，由于第一个元素 4 就不符合 (i%2)==1，因此 find_if_not() 成功找到符合条件的元素，并返回一个指向该元素的迭代器。

find_if_not() 函数的底层实现和 find_if() 函数非常类似，[C++ STL find_if_not()官网](http://www.cplusplus.com/reference/algorithm/find_if_not/)给出了该函数底层实现的参考代码，感兴趣的读者可自行分析，这里不做过多描述：

```c++
template<class InputIterator, class UnaryPredicate>
InputIterator find_if_not (InputIterator first, InputIterator last, UnaryPredicate pred)
{
    while (first!=last) {
        if (!pred(*first)) return first;
        ++first;
    }
    return last;
}
```

### find_end()

find_end() 函数定义在`<algorithm>`头文件中，常用于在序列 A 中查找序列 B 最后一次出现的位置。例如，有如下 2 个序列：

序列 A：1,2,3,4,5,1,2,3,4,5
序列 B：1,2,3

通过观察不难发现，序列 B 在序列 A 中出现了 2 次，而借助 find_end() 函数，可以轻松的得到序列 A 中最后一个（也就是第 2 个） {1,2,3}。

find_end() 函数的语法格式有 2 种：

```
//查找序列 [first1, last1) 中最后一个子序列 [first2, last2)
ForwardIterator find_end (ForwardIterator first1, ForwardIterator last1,
                          ForwardIterator first2, ForwardIterator last2);
//查找序列 [first2, last2) 中，和 [first2, last2) 序列满足 pred 规则的最后一个子序列
ForwardIterator find_end (ForwardIterator first1, ForwardIterator last1,
                          ForwardIterator first2, ForwardIterator last2,
                          BinaryPredicate pred);
```

其中，各个参数的含义如下：

- first1、last1：都为正向迭代器，其组合 [first1, last1) 用于指定查找范围（也就是上面例子中的序列 A）；
- first2、last2：都为正向迭代器，其组合 [first2, last2) 用于指定要查找的序列（也就是上面例子中的序列 B）；
- pred：用于自定义查找规则。该规则实际上是一个包含 2 个参数且返回值类型为 bool 的函数（第一个参数接收 [first1, last1) 范围内的元素，第二个参数接收 [first2, last2) 范围内的元素）。函数定义的形式可以是普通函数，也可以是函数对象。

> 实际上，第一种语法格式也可以看做是包含一个默认的 pred 参数，该参数指定的是一种相等规则，即在 [first1, last1) 范围内查找和 [first2, last2) 中各个元素对应相等的子序列；而借助第二种语法格式，我们可以自定义一个当前场景需要的匹配规则。

同时，find_end() 函数会返回一个正向迭代器，当函数查找成功时，该迭代器指向查找到的子序列中的第一个元素；反之，如果查找失败，则该迭代器的指向和 last1 迭代器相同。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::find_end
#include <vector>       // std::vector
using namespace std;
//以普通函数的形式定义一个匹配规则
bool mycomp1(int i, int j) {
    return (i%j == 0);
}
//以函数对象的形式定义一个匹配规则
class mycomp2 {
public:
    bool operator()(const int& i, const int& j) {
        return (i%j == 0);
    }
};
int main() {
    vector<int> myvector{ 1,2,3,4,8,12,18,1,2,3 };
    int myarr[] = { 1,2,3 };
    //调用第一种语法格式
    vector<int>::iterator it = find_end(myvector.begin(), myvector.end(), myarr, myarr + 3);
    if (it != myvector.end()) {
        cout << "最后一个{1,2,3}的起始位置为：" << it - myvector.begin() << ",*it = " << *it << endl;
    }
    int myarr2[] = { 2,4,6 };
    //调用第二种语法格式
    it = find_end(myvector.begin(), myvector.end(), myarr2, myarr2 + 3, mycomp2());
    if (it != myvector.end()) {
        cout << "最后一个{2,3,4}的起始位置为：" << it - myvector.begin() << ",*it = " << *it;
    }
    return 0;
}
/*
程序执行结果为：
匹配{1,2,3}的起始位置为：7,*it = 1
匹配{2,3,4}的起始位置为：4,*it = 8
*/
```

上面程序中共调用了 2 次 find_end() 函数：

1. 第 22 行代码：调用了第一种语法格式的 find_end() 函数，其功能是在 myvector 容器中查找和 {1,2,3} 相等的最后一个子序列，显然最后一个 {1,2,3} 中元素 1 的位置下标为 7（myvector 容器下标从 0 开始）；
2. 第 29 行代码：调用了第二种格式的 find_end() 函数，其匹配规则为 mycomp2，即在 myvector 容器中找到最后一个子序列，该序列中的元素能分别被 {2、4、6} 中的元素整除。显然，myvector 容器中 {4,8,12} 和 {8,12,18} 都符合，该函数会找到后者并返回一个指向元素 8 的迭代器。

> 注意，find_end() 函数的第一种语法格式，其底层是借助 == 运算符实现的。这意味着，如果 [first1, last1] 和 [first2, last2] 区域内的元素为自定义的类对象或结构体变量时，使用该函数之前需要对 == 运算符进行重载。

C++ STL标准库官方给出了 find_end() 函数底层实现的参考代码，感兴趣的读者可自行分析，这里不再做过多描述：

```c++
template<class ForwardIterator1, class ForwardIterator2>
ForwardIterator1 find_end(ForwardIterator1 first1, ForwardIterator1 last1,
  ForwardIterator2 first2, ForwardIterator2 last2)
{
    if (first2 == last2) return last1;  // specified in C++11

    ForwardIterator1 ret = last1;

    while (first1 != last1)
    {
        ForwardIterator1 it1 = first1;
        ForwardIterator2 it2 = first2;
        while (*it1 == *it2) {    // or: while (pred(*it1,*it2)) for version (2)
            ++it1; ++it2;
            if (it2 == last2) { ret = first1; break; }
            if (it1 == last1) return ret;
        }
        ++first1;
    }
    return ret;
}
```

### find_first_of()

在某些情境中，我们可能需要在 A 序列中查找和 B 序列中任意元素相匹配的第一个元素，这时就可以使用 find_first_of() 函数。

仅仅用一句话概述 find_first_of() 函数的功能，读者可能并不理解。别急，下面我们将从语法格式的角度继续阐述该函数的功能。

find_first_of() 函数有 2 种语法格式，分别是：

```c++
//以判断两者相等作为匹配规则
InputIterator find_first_of (InputIterator first1, InputIterator last1,
                             ForwardIterator first2, ForwardIterator last2);
//以 pred 作为匹配规则
InputIterator find_first_of (InputIterator first1, InputIterator last1,
                             ForwardIterator first2, ForwardIterator last2,
                             BinaryPredicate pred);
```

其中，各个参数的含义如下：

- first1、last1：都为输入迭代器，它们的组合 [first1, last1) 用于指定该函数要查找的范围；
- first2、last2：都为正向迭代器，它们的组合 [first2, last2) 用于指定要进行匹配的元素所在的范围；
- pred：可接收一个包含 2 个形参且返回值类型为 bool 的函数，该函数可以是普通函数（又称为二元谓词函数），也可以是函数对象。

> 有关谓词函数，读者可阅读《[C++谓词函数](https://xinbaoku.com/archive/L6cvHBcx.html)》一节详细了解。

find_first_of() 函数用于在 [first1, last1) 范围内查找和 [first2, last2) 中任何元素相匹配的第一个元素。如果匹配成功，该函数会返回一个指向该元素的输入迭代器；反之，则返回一个和 last1 迭代器指向相同的输入迭代器。

值得一提的是，不同语法格式的匹配规则也是不同的：

- 第 1 种语法格式：逐个取 [first1, last1) 范围内的元素（假设为 A），和 [first2, last2) 中的每个元素（假设为 B）做 A==B 运算，如果成立则匹配成功；
- 第 2 种语法格式：逐个取 [first1, last1) 范围内的元素（假设为 A），和 [first2, last2) 中的每个元素（假设为 B）一起带入 pred(A, B) 谓词函数，如果函数返回 true 则匹配成功。

> 注意，当采用第一种语法格式时，如果 [first1, last1) 或者 [first2, last2) 范围内的元素类型为自定义的类对象或者结构体变量，此时应对 == 运算符进行重载，使其适用于当前场景。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::find_first_of
#include <vector>       // std::vector
using namespace std;
//自定义二元谓词函数，作为 find_first_of() 函数的匹配规则
bool mycomp(int c1, int c2) {
    return (c2 % c1 == 0);
}
//以函数对象的形式定义一个 find_first_of() 函数的匹配规则
class mycomp2 {
public:
    bool operator()(const int& c1, const int& c2) {
        return (c2 % c1 == 0);
    }
};
int main() {
    char url[] = "http://c.xinbaoku.com/stl/";
    char ch[] = "stl";
    //调用第一种语法格式，找到 url 中和 "stl" 任一字符相同的第一个字符
    char *it = find_first_of(url, url + 27, ch, ch + 4);

    if (it != url + 27) {
        cout << "*it = " << *it << '\n';
    }
    vector<int> myvector{ 5,7,3,9 };
    int inter[] = { 4,6,8 };
    //调用第二种语法格式，找到 myvector 容器中和 3、5、7 任一元素有 c2%c1=0 关系的第一个元素
    vector<int>::iterator iter = find_first_of(myvector.begin(), myvector.end(), inter, inter + 3, mycomp2());
    if (iter != myvector.end()) {
        cout << "*iter = " << *iter;
    }
    return 0;
}
/*
结果
*it = t
*iter = 3
*/
```

演示了 find_first_of() 函数 2 种语法格式的用法。其中第 20 行代码中 find_first_of() 函数发挥的功能是，在 url 字符数组中逐个查找和 's'、't'、'l' 这 3 个字符相等的字符，显然 url 数组第 2 个字符 't' 就符合此规则。

在第 29 行代码中，find_first_of() 会逐个提取 myvector 容器中的每个元素（假设为 A），并尝试和 inter 数组中的每个元素（假设为 B）一起带入 mycomp2(A, B) 函数对象中。显然，当将 myvector 容器中的元素 3 和 inter 数组中的元素 6 带入该函数时，c2 % c1=0 表达式第一次成立。

### adjacent_find() 

函数用于在指定范围内查找 2 个连续相等的元素。该函数的语法格式为：

```c++
//查找 2 个连续相等的元素
ForwardIterator adjacent_find (ForwardIterator first, ForwardIterator last);
//查找 2 个连续满足 pred 规则的元素
ForwardIterator adjacent_find (ForwardIterator first, ForwardIterator last,
                               BinaryPredicate pred);
```

其中，first 和 last 都为正向迭代器，其组合 [first, last) 用于指定该函数的查找范围；pred 用于接收一个包含 2 个参数且返回值类型为 bool 的函数，以实现自定义查找规则。

> 值得一提的是，pred 参数接收的函数既可以定义为普通函数，也可以用函数对象的形式定义。有关谓词函数，读者可阅读《[C++谓词函数](https://xinbaoku.com/archive/L6cvHBcx.html)》一节详细了解。

另外，该函数会返回一个正向迭代器，当函数查找成功时，该迭代器指向的是连续相等元素的第 1 个元素；而如果查找失败，该迭代器的指向和 last 迭代器相同。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::adjacent_find
#include <vector>       // std::vector
using namespace std;
//以创建普通函数的形式定义一个查找规则
bool mycomp1(int i, int j) {
    return (i == j);
}
//以函数对象的形式定义一个查找规则
class mycomp2{
public:
    bool operator()(const int& _Left, const int& _Right){
        return (_Left == _Right);
    }
};
int main() {
    std::vector<int> myvector{ 5,20,5,30,30,20,10,10,20 };
    //调用第一种语法格式
    std::vector<int>::iterator it = adjacent_find(myvector.begin(), myvector.end());

    if (it != myvector.end()) {
        cout << "one : " << *it << '\n';
    }
    //调用第二种格式，也可以使用 mycomp1
    it = adjacent_find(++it, myvector.end(), mycomp2());
    if (it != myvector.end()) {
        cout << "two : " << *it;
    }
    return 0;
}
/*
one : 30
two : 10
*/
```

可以看到，程序中调用了 2 次 adjacent_find() 函数：

- 第 19 行：使用该函数的第一种语法格式，查找整个 myvector 容器中首个连续 2 个相等的元素，显然最先找到的是 30；
- 第 25 行：使用该函数的第二种语法格式，查找 {30,20,10,10,20} 部分中是否有连续 2 个符合 mycomp2 规则的元素。不过，程序中自定义的 mycomp1 或 mycomp2 查找规则也是查找 2 个连续相等的元素，因此最先找到的是元素 10。

> 注意，对于第一种语法格式的 adjacent_find() 函数，其底层使用的是 == 运算符来判断连续 2 个元素是否相等。这意味着，如果指定区域内的元素类型为自定义的类对象或者结构体变量时，需要先对 == 运算符进行重载，然后才能使用此函数。

adjacent_find() 函数底层实现的参考代码

```c++
template <class ForwardIterator>
ForwardIterator adjacent_find (ForwardIterator first, ForwardIterator last)
{
    if (first != last)
    {
        ForwardIterator next=first; ++next;
        while (next != last) {
            if (*first == *next)     // 或者 if (pred(*first,*next)), 对应第二种语法格式
                return first;
        ++first; ++next;
        }
    }
    return last;
}
```

## search()

在序列A中查找序列B第一次出现位置

仍以如下两个序列为例：

序列 A：1,2,3,4,5,1,2,3,4,5
序列 B：1,2,3

可以看到，序列 B 在序列 A 中出现了 2 次。借助 find_end() 函数，我们可以找到序列 A 中最后一个（也就是第 2 个）{1,2,3}；而借助 search() 函数，我们可以找到序列 A 中第 1 个 {1,2,3}。

和 find_end() 相同，search() 函数也提供有以下 2 种语法格式：

```
//查找 [first1, last1) 范围内第一个 [first2, last2) 子序列
ForwardIterator search (ForwardIterator first1, ForwardIterator last1,
                        ForwardIterator first2, ForwardIterator last2);
//查找 [first1, last1) 范围内，和 [first2, last2) 序列满足 pred 规则的第一个子序列
ForwardIterator search (ForwardIterator first1, ForwardIterator last1,
                        ForwardIterator first2, ForwardIterator last2,
                        BinaryPredicate pred);
```

其中，各个参数的含义分别为：

- first1、last1：都为正向迭代器，其组合 [first1, last1) 用于指定查找范围（也就是上面例子中的序列 A）；
- first2、last2：都为正向迭代器，其组合 [first2, last2) 用于指定要查找的序列（也就是上面例子中的序列 B）；
- pred：用于自定义查找规则。该规则实际上是一个包含 2 个参数且返回值类型为 bool 的函数（第一个参数接收 [first1, last1) 范围内的元素，第二个参数接收 [first2, last2) 范围内的元素）。函数定义的形式可以是普通函数，也可以是函数对象。

> 实际上，第一种语法格式也可以看做是包含一个默认的 pred 参数，该参数指定的是一种相等规则，即在 [first1, last1) 范围内查找和 [first2, last2) 中各个元素对应相等的子序列；而借助第二种语法格式，我们可以自定义一个当前场景需要的匹配规则。

同时，search() 函数会返回一个正向迭代器，当函数查找成功时，该迭代器指向查找到的子序列中的第一个元素；反之，如果查找失败，则该迭代器的指向和 last1 迭代器相同。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::search
#include <vector>       // std::vector
using namespace std;
//以普通函数的形式定义一个匹配规则
bool mycomp1(int i, int j) {
    return (i%j == 0);
}
//以函数对象的形式定义一个匹配规则
class mycomp2 {
public:
    bool operator()(const int& i, const int& j) {
        return (i%j == 0);
    }
};
int main() {
    vector<int> myvector{ 1,2,3,4,8,12,18,1,2,3 };
    int myarr[] = { 1,2,3 };
    //调用第一种语法格式
    vector<int>::iterator it = search(myvector.begin(), myvector.end(), myarr, myarr + 3);
    if (it != myvector.end()) {
        cout << "第一个{1,2,3}的起始位置为：" << it - myvector.begin() << ",*it = " << *it << endl;
    }
    int myarr2[] = { 2,4,6 };
    //调用第二种语法格式
    it = search(myvector.begin(), myvector.end(), myarr2, myarr2 + 3, mycomp2());
    if (it != myvector.end()) {
        cout << "第一个{2,3,4}的起始位置为：" << it - myvector.begin() << ",*it = " << *it;
    }
    return 0;
}
/*
第一个{1,2,3}的起始位置为：0,*it = 1
第一个{2,3,4}的起始位置为：3,*it = 4
*/
```

通过程序的执行结果可以看到，第 22 行代码借助 search() 函数找到了 myvector 容器中第一个 {1,2,3}，并返回了一个指向元素 1 的迭代器（其下标位置为 0）。

而在第 29 行中，search() 函数使用的是第 2 种格式，其自定义了 mycomp2 匹配规则，即在 myvector 容器中找到第一个连续的 3 个元素，它们能分别被 2、4、6 整除。显然，myvector 容器中符合要求的子序列有 2 个，分别为 {4,8,12} 和 {8,12,18}，但 search() 函数只会查找到第一个，并返回指向元素 4 的迭代器（其下标为 3）。

> 注意，search() 函数的第一种语法格式，其底层是借助 == 运算符实现的。这意味着，如果 [first1, last1] 和 [first2, last2] 区域内的元素为自定义的类对象或结构体变量时，使用该函数之前需要对 == 运算符进行重载。

## search_n()

[C++ search_n()函数用法（超级详细） (xinbaoku.com)](https://xinbaoku.com/archive/r1u2HLCN.html)

## partiton()

partition 可直译为“分组”，partition() 函数可根据用户自定义的筛选规则，重新排列指定区域内存储的数据，使其分为 2 组，第一组为符合筛选条件的数据，另一组为不符合筛选条件的数据。



partition() 函数的语法格式：

```
ForwardIterator partition (ForwardIterator first,
                           ForwardIterator last,
                           UnaryPredicate pred);
```

其中，first 和 last 都为正向迭代器，其组合 [first, last) 用于指定该函数的作用范围；pred 用于指定筛选规则。

> 所谓筛选规则，其本质就是一个可接收 1 个参数且返回值类型为 bool 的函数，可以是普通函数，也可以是一个函数对象。

同时，partition() 函数还会返回一个正向迭代器，其指向的是两部分数据的分界位置，更确切地说，指向的是第二组数据中的第 1 个元素。

```c++
#include <iostream>     // std::cout
#include <algorithm>    // std::partition
#include <vector>       // std::vector
using namespace std;
//以普通函数的方式定义partition()函数的筛选规则
bool mycomp(int i) { return (i % 2) == 0; }
//以函数对象的形式定义筛选规则
class mycomp2 {
public:
    bool operator()(const int& i) {
        return (i%2 == 0);
    }
};
int main() {
    std::vector<int> myvector{1,2,3,4,5,6,7,8,9};
    std::vector<int>::iterator bound;
    //以 mycomp2 规则，对 myvector 容器中的数据进行分组
    bound = std::partition(myvector.begin(), myvector.end(), mycomp2());
    for (std::vector<int>::iterator it = myvector.begin(); it != myvector.end(); ++it) {
        cout << *it << " ";
    }
    cout << "\nbound = " << *bound;
    return 0;
}
/*
8 2 6 4 5 3 7 1 9
bound = 5
*/
```

可以看到，程序中借助 partition() 对 myvector 容器中的数据进行了再加工，基于 mycomp2() 筛选规则，能够被 2 整除的元素位于第 1 组，不能被 2 整除的元素位于第 2 组。

同时，parition() 函数会返回一个迭代器，通过观察程序的执行结果可以看到，该迭代器指向的是元素 5，同时也是第 2 组数据中的第 1 个元素。

> [C++ STL partition()函数官方](http://www.cplusplus.com/reference/algorithm/partition/)给出了该函数底层实现的参考代码，感兴趣的读者可自行前往分析，这里不再做过多描述。

### stable_partition()函数

前面提到，partition() 函数只负责对指定区域内的数据进行分组，并不保证各组中元素的相对位置不发生改变。而如果想在分组的同时保证不改变各组中元素的相对位置，可以使用 stable_partition() 函数。

也就是说，stable_partition() 函数可以保证对指定区域内数据完成分组的同时，不改变各组内元素的相对位置。

仍以数组 a[9] 举例，其存储的数据如下：

1 2 3 4 5 6 7 8 9

假定筛选规则为 i%2=0（其中 i 即代指数组 a 中的各个元素），则借助 stable_partition() 函数，a[9] 数组中存储数据的顺序为：

2 4 6 8 1 3 5 7 9

其中 {2,4,6,8} 为一组，{1,3,5,7,9} 为另一组。通过和先前的 a[9] 对比不难看出，各个组中元素的相对位置没有发生改变。

> 所谓元素的相对位置不发生改变，以 {2,4,6,8} 中的元素 4 为例，在原 a[9] 数组中，该元素位于 2 的右侧，6 和 8 的左侧；在经过 stable_partition() 函数处理后的 a[9] 数组中，元素 4 仍位于 2 的右侧，6 和 8 的左侧。因此，该元素的相对位置确实没有发生改变。

### partition_copy()函数

[C++ partition_copy()函数详解 (xinbaoku.com)](https://xinbaoku.com/archive/26u3HKcw.html)

```c++
vector<int> myvector{ 1,2,3,4,5,6,7,8,9 };
    int b[10] = { 0 }, c[10] = { 0 };
    //以 mycomp 规则，对 myvector 容器中的数据进行分组，这里的 mycomp 还可以改为 mycomp2()，即以 mycomp2 为筛选规则
    pair<int*, int*> result= partition_copy(myvector.begin(), myvector.end(), b, c, mycomp);
/*
b[10]：2 4 6 8
c[10]：1 3 5 7 9
*/
```

### partition_point()

[C++ partition_point()函数（详解版） (xinbaoku.com)](https://xinbaoku.com/archive/E0uqHqc7.html)

```c++
vector<int> myvector{ 2,4,6,8,1,3,5,7,9 };
    //根据 mycomp 规则，为 myvector 容器中的数据找出分界
    vector<int>::iterator iter = partition_point(myvector.begin(), myvector.end(),mycomp);
    //输出第一组的数据
    for (auto it = myvector.begin(); it != iter; ++it) {
        cout << *it << " ";
    }
    cout << "\n";
    //输出第二组的数据
    for (auto it = iter; it != myvector.end(); ++it) {
        cout << *it << " ";
    }
    cout << "\n*iter = " << *iter;
/*
2 4 6 8
1 3 5 7 9
*iter = 1
*/
```

## lower_bound()函数

lower_bound() 函数用于在指定区域内查找不小于目标值的第一个元素。也就是说，使用该函数在指定范围内查找某个目标值时，最终查找到的不一定是和目标值相等的元素，还可能是比目标值大的元素。

[C++ lower_bound()函数用法详解 (xinbaoku.com)](https://xinbaoku.com/archive/KKuwH9Fz.html)

```c++
int a[5] = { 1,2,3,4,5 };
    //从 a 数组中找到第一个不小于 3 的元素
    int *p = lower_bound(a, a + 5, 3);
    cout << "*p = " << *p << endl;
    vector<int> myvector{ 4,5,3,1,2 };
    //根据 mycomp2 规则，从 myvector 容器中找到第一个违背 mycomp2 规则的元素
    vector<int>::iterator iter = lower_bound(myvector.begin(), myvector.end(),3,mycomp2());
    cout << "*iter = " << *iter;
/*
*p = 3
*iter = 3
*/
```

## upper_bound()函数

[C++ upper_bound()函数（精讲版） (xinbaoku.com)](https://xinbaoku.com/archive/r1u2H5Fd.html)

```c++
 int a[5] = { 1,2,3,4,5 };
    //从 a 数组中找到第一个大于 3 的元素
    int *p = upper_bound(a, a + 5, 3);
    cout << "*p = " << *p << endl;
    vector<int> myvector{ 4,5,3,1,2 };
    //根据 mycomp2 规则，从 myvector 容器中找到第一个违背 mycomp2 规则的元素
    vector<int>::iterator iter = upper_bound(myvector.begin(), myvector.end(), 3, mycomp2());
    cout << "*iter = " << *iter;
/*
*p = 4
*iter = 1
*/
```

借助输出结果可以看出，upper_bound() 函数的功能和 lower_bound() 函数不同，前者查找的是大于目标值的元素，而后者查找的不小于（大于或者等于）目标值的元素。

此程序中演示了 upper_bound() 函数的 2 种适用场景，其中 a[5] 数组中存储的为升序序列；而 myvector 容器中存储的序列虽然整体是乱序的，但对于目标元素 3 来说，所有符合 mycomp2(3, element) 规则的元素都位于其左侧，不符合的元素都位于其右侧，因此 upper_bound() 函数仍可正常执行。

## equel_range()函数

用于在指定范围内查找等于目标值的所有元素

[C++ equel_range()函数详解 (xinbaoku.com)](https://xinbaoku.com/archive/w1uqH9aD.html)

```c++
int a[9] = { 1,2,3,4,4,4,5,6,7};
    //从 a 数组中找到所有的元素 4
    pair<int*, int*> range = equal_range(a, a + 9, 4);
    cout << "a[9]：";
    for (int *p = range.first; p < range.second; ++p) {
        cout << *p << " ";
    }
    vector<int>myvector{ 7,8,5,4,3,3,3,3,2,1 };
    pair<vector<int>::iterator, vector<int>::iterator> range2;
    //在 myvector 容器中找到所有的元素 3
    range2 = equal_range(myvector.begin(), myvector.end(), 3,mycomp2());
    cout << "\nmyvector：";
    for (auto it = range2.first; it != range2.second; ++it) {
        cout << *it << " ";
    }
/*
a[9]：4 4 4
myvector：3 3 3 3
*/
```

此程序中演示了 equal_range() 函数的 2 种适用场景，其中 a[9] 数组中存储的为升序序列；而 myvector 容器中存储的序列虽然整体是乱序的，但对于目标元素 3 来说，所有符合 mycomp2(element, 3) 规则的元素都位于其左侧，不符合的元素都位于其右侧，因此 equal_range() 函数仍可正常执行。

##  binary_search()

用于查找指定区域内是否包含某个目标元素

[C++ binary_search()函数详解 (xinbaoku.com)](https://xinbaoku.com/archive/NEuNHvaK.html)

```c++
int a[7] = { 1,2,3,4,5,6,7 };
    //从 a 数组中查找元素 4
    bool haselem = binary_search(a, a + 9, 4);
    cout << "haselem：" << haselem << endl;
    vector<int>myvector{ 4,5,3,1,2 };
    //从 myvector 容器查找元素 3
    bool haselem2 = binary_search(myvector.begin(), myvector.end(), 3, mycomp2());
    cout << "haselem2：" << haselem2;
/*
haselem：1
haselem2：1
*/
```

## all_of、any_of及none_of算法

[C++(STL) all_of、any_of及none_of算法详解 (xinbaoku.com)](https://xinbaoku.com/archive/G90HwfwG.html)

## equal(STL equal)比较算法详解

[C++ equal(STL equal)比较算法详解 (xinbaoku.com)](https://xinbaoku.com/archive/JMNHdfKO.html)

## mismatch(STL mismatch)算法详解

equal() 算法可以告诉我们两个序列是否匹配。mismatch() 算法也可以告诉我们两个序列是否匹配，而且如果不匹配，它还能告诉我们不匹配的位置。

[C++ mismatch(STL mismatch)算法详解 (xinbaoku.com)](https://xinbaoku.com/archive/GDvH1frO.html)

## lexicographical_compare字符串排序算法详解

[C++（STL） lexicographical_compare字符串排序算法详解 (xinbaoku.com)](https://xinbaoku.com/archive/GyLHPfDG.html)

# 迭代适配器算法

## distance()

[C++ STL distance()函数用法详解（一看就懂） (xinbaoku.com)](https://xinbaoku.com/archive/26u9a9u8.html)

```c++
list<int> mylist;
    //向空 list 容器中添加元素 0~9
    for (int i = 0; i < 10; i++) {
        mylist.push_back(i);
    }
    //指定 2 个双向迭代器，用于执行某个区间
    list<int>::iterator first = mylist.begin();//指向元素 0
    list<int>::iterator last = mylist.end();//指向元素 9 之后的位置
    //获取 [first,last) 范围内包含元素的个数
    cout << "distance() = " << distance(first, last);
/*
distance() = 10
*/
```

## prev()和next()函数用法详解

《[C++ STL advance()函数](https://xinbaoku.com/archive/d1uea4u8.html)》一节中，详细讲解了 advance() 函数的功能，其可以将指定迭代器前移或后移 n 个位置的距离。

```c++
//创建并初始化一个 list 容器
    std::list<int> mylist{ 1,2,3,4,5 };
    std::list<int>::iterator it = mylist.end();
    //获取一个距离 it 迭代器 2 个元素的迭代器，由于 2 为正数，newit 位于 it 左侧
    auto newit = prev(it, 2);
    cout << "prev(it, 2) = " << *newit << endl;
    //n为负数，newit 位于 it 右侧
    it = mylist.begin();
    newit = prev(it, -2);
    cout << "prev(it, -2) = " << *newit;
/*
prev(it, 2) = 4
prev(it, -2) = 3
*/
```

可以看到，当 it 指向 mylist 容器最后一个元素之后的位置时，通过 prev(it, 2) 可以获得一个新迭代器 newit，其指向的是距离 it 左侧 2 个元素的位置（其存储的是元素 4）；当 it 指向 mylist 容器中首个元素时，通过 prev(it, -2) 可以获得一个指向距离 it 右侧 2 个位置处的新迭代器。

> 注意，prev() 函数自身不会检验新迭代器的指向是否合理，需要我们自己来保证其合理性。

next()用来获取一个距离指定迭代器 n 个元素的迭代器

```c++
/创建并初始化一个 list 容器
    std::list<int> mylist{ 1,2,3,4,5 };
    std::list<int>::iterator it = mylist.begin();
    //获取一个距离 it 迭代器 2 个元素的迭代器，由于 2 为正数，newit 位于 it 右侧
    auto newit = next(it, 2);
    cout << "next(it, 2) = " << *newit << endl;
    //n为负数，newit 位于 it 左侧
    it = mylist.end();
    newit = next(it, -2);
    cout << "next(it, -2) = " << *newit;
/*
next(it, 2) = 3
next(it, -2) = 4
*/
```

可以看到，和 prev() 函数恰好相反，当 n 值为 2 时，next(it, 2) 函数获得的新迭代器位于 it 迭代器的右侧，距离 2 个元素；反之，当 n 值为 -2 时，新迭代器位于 it 迭代器的左侧，距离 2 个元素。

> 注意，和 prev() 函数一样，next() 函数自身也不会检查新迭代器指向的有效性，需要我们自己来保证。

