开始

# 上传时取消输入用户名和密码

在本地克隆下来的[git](https://so.csdn.net/so/search?q=git&spm=1001.2101.3001.7020)仓库中找到 .git 目录，进入 .git 目录 找到 config 文件打开，添加

```
[user]
    name = 你的用户名
    email = 你的邮箱
[credential]
    helper = store
```

保存后 push 一次，下次就不需要输入[密码](https://so.csdn.net/so/search?q=密码&spm=1001.2101.3001.7020)了

# 上传错误

```
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

表示要设置ssh
```

具体操作可以参考

[git上传错误 ](https://blog.csdn.net/weixin_44364444/article/details/118277368)

# 上传步骤

```
git add *    （注：别忘记后面的.，此操作是把Test文件夹下面的文件都添加进来）

git commit  -m  "提交信息"  （注：“提交信息”里面换成你需要，如“first commit”）

git remote add origin git@github.com:smartdoublej/studyingnotes.git

git push -u origin master   （注：此操作目的是把本地仓库push到github上面，此步骤需要你输入帐号和密码）
```

 [完整参考教程](https://cloud.tencent.com/developer/article/1504684)

```git
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	ignorecase = true
[remote "origin"]
	url = https://github.91chi.fun/https://github.com/smartdoublej/smartdoublej.github.io.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[user]
    name = smartdoublej
    email = 1535086745@QQ.COM
[credential]
    helper = store
[branch "master"]
	remote = origin
	merge = refs/heads/master

```

