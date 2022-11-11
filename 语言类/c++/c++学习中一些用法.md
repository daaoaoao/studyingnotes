# 获取二维数组的行列值

```c++
int ve1[4][3]={{0,0,0},{0,1,0},{0,0,0},{0,0,0}};
    vector<vector<int>> ve = {{0,0,0},{0,1,0},{0,0,0}};
//对于[][]这种获取行列值
    cout<<sizeof(ve1[0])/sizeof(ve1[0][0])<<endl;
    cout<<sizeof(ve1)/sizeof(ve1[0])<<endl;
//对于vector
    cout<<ve.size()<<endl;
    cout<<ve[0].size();
//输出结果3 4 33
```

