# 前言

## 推荐书籍

《MySQL官方手册》

《MySQL运维内参》

《MySQL8 Cookbook(中文版)》

《MySQL技术内幕InnoDB存储引擎》

《高性能MySQL》

《数据库索引设计与优化》

《深入理解MySQL核心技术》

《Effective MySQL:Replication Techniques in Depth》





# 基础

## MySQL体系结构

MySQL体系结构由 Client Connectors层，MySQL Server层及存储引擎层组成。

Client Connectors层

负责处理客户端的连接请求，与客户端创建连接。目前MySQL几乎支持所有连接类型，JDBC，Python，GO等

MySQL Server层

主要包括Conection Pool，Service & utilities,SQL interface,Parser解析器，Optimizer查询优化器，Caches缓存等模块。



Connection Pool 负责处理和存储数据库与客户端创建的连接，一个线程负责管理一个连接。Connection Pool 包括了用户认证模块，就是用户登录身份的认证和鉴权及安全管理，用户执行操作权限校验。

Service & utilities 是管理服务&工具集，包括备份恢复，安全管理，集群管理服务和工具。

SQL interface 负责接受客户端发送的各种SQL语句，比如DML，DDL和存储过程等。

Optimizer查询优化器会根据解析树生成执行计划，并选择合适的索引，然后按照执行计划执行SQL语言并与各个存储引擎交互。

Cache缓存包括各个存储引擎的缓存部分 比如：InnoDB存储的Buffer Pool，MyISAM存储引擎的key buffer等，Caches中也会缓存一些权限，包括一些Session级别的缓存。

存储引擎层

存储引擎包括MyISAM，InnoDB，已经支持归档的Archive和内存Memory等，MySQL是插件式的存储引擎，只要正确定义与MySQL Server交互的接口，任何引擎都可以访问MySQL

存储引擎底部是物理存储层，是文件的物理存储层，包括二进制日志、数据文件、错误日志、慢查询日志、全日志、redo/undo 日志等。







