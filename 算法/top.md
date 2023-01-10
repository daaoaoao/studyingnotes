# KMP算法

> [字符串匹配的KMP算法 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2013/05/Knuth–Morris–Pratt_algorithm.html)

理解部分匹配表里面的值

一般步骤先计算匹配表，再进行匹配





# 633 两数平方和

```c++
class Solution {
public:
    bool judgeSquareSum(int c) {
        int left=0,right=sqrt(c);
        while(left<=right){
            
            if(c-left*left-right*right==0) return true;
            else if(c-left*left-right*right>0) left++;
            else right--;
        }
        return false;
    }
};
```



345 反转元音字母

```c++
class Solution {
public:
    
    bool isVowel(char c){
        vector<char> vowels {'a','e','i','o','u','A','E','I','O','U'};
        for(auto v:vowels){
            if(v==c) return true;
        }
        return false;
    }
    string reverseVowels(string s) {
        int left=0,right=s.size()-1;
        while(left<right){
            while(left<right && !isVowel(s[left])) left++;
            while(left<right && !isVowel(s[right])) right--;
            swap(s[left],s[right]);
            left++;
            right--;
        }
        return s;
    }
};
```



680回文字符串2

```c++
class Solution {
public:
    bool isPalindrome(string s,int l,int r)
    {
        while(l<r){
            if(s[l]!=s[r]) return false;
            l++;
            r--;
        }
        return true;
    }
    bool validPalindrome(string s) {
        int left=0,right=s.size()-1;
        while(left<right){
            if(s[left]!=s[right]) return isPalindrome(s,left+1,right) || isPalindrome(s,left,right-1);
            left++;
            right--;
        }
        return true;
    }
};
```



归并两个有序数组

```c++
class Solution {
public:
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        int i=m-1,j=n-1,k=m+n-1;
        while(j>=0){
            if(i<0)
                nums1[k--]=nums2[j--];
            else if(nums1[i]<nums2[j])
                nums1[k--]=nums2[j--];
            else
                nums1[k--]=nums1[i--];
    }
    }
};
```





倒数第k大的元素





451

按照字符出现次数对字符串排序

```c++
class Solution {
public:
    string frequencySort(string s) {
        vector<pair<char,int>> v;
        for(int i = 0; i < s.size(); i++)
        {
            int j = 0;
            for(; j < v.size(); j++)
            {
                if(v[j].first == s[i])
                {
                    v[j].second++;
                    break;
                }
            }
            if(j == v.size())
            {
                v.push_back(make_pair(s[i],1));
            }
        }
        sort(v.begin(),v.end(),[](pair<char,int> a,pair<char,int> b){return a.second > b.second;});
        string t;
        for(int i = 0; i < v.size(); i++)
        {
            for(int j = 0; j < v[i].second; j++)
            {
                t.push_back(v[i].first);
            }
        }
        return t;
    }
};
```

