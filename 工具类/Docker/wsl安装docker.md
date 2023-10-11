# WSL命令

`wsl -l -v`

更新到wsl2

`wsl --set-version Ubuntu 2`



启动和关闭

```
wsl --shutdown
wsl -d Ubuntu
```

卸载wsl系统

`wsl --unregister Ubuntu`

查看在线可以安装

`wsl --list --online`



设置代理

```
export ALL_PROXY="http://172.18.96.1:7890"
172.18.96.1
```

> [WSL2配置代理 - Leaos - 博客园 (cnblogs.com)](https://www.cnblogs.com/tuilk/p/16287472.html)





# WSL迁移

wsl --list 查看wsl列表

```
wsl --export Ubuntu d://wslubuntu//ubuntu.tar
wsl --unregister Ubuntu
wsl --import Ubuntu d://wslubuntu d://wslubuntu//ubuntu.tar
```



WSL 安装docker 不安装docker desktop

```
/opt/distrod/bin/distrod enable
```





# 安装docker

wsl 换源

推荐清华源或者国科大源

一般是编辑Ubuntu 的软件源配置文件是 `/etc/apt/sources.list`。将系统自带的该文件做个备份，将该文件替换为下面内容，即可使用选择的软件源镜像。

>[ubuntu | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)

使用官方脚本安装

`curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`

```
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
$ sudo service docker start

```

```
# 检查dockerd进程启动
service docker status
ps aux|grep docker
# 检查拉取镜像等正常
sudo docker pull busybox
sudo docker images

```







# 卸载docker

```
sudo apt-get purge docker-engine
sudo apt-get autoremove --purge docker-engine
rm -rf /var/lib/docker
```



windows 安装docker下载桌面版 使用docker管理容易出现问题。
