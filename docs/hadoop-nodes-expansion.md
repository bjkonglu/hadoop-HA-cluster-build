# hadoop cluster expansion
> 随着业务需求的增加，集群的资源出现不足，因此需要对*hadoop*集群进行扩容。

## *hadoop*集群扩容的步骤

- 新节点的基础服务配置：
  - ssh:免密登入
  - jdk:1.8.x
  - scala:2.11.8
  - hadoop:2.7.1
  - spark:2.1.1
  - 环境变量设置

- 新节点（*DN*）的基础目录创建：
  - 组件安装目录：/software/softs
  - /data0/hadoop_tmp
  - /data0/hadoop-logs
  - /data0/hadoop-pids
  - /data0/yarn-logs
  - /data0/spark-logs
  - /data0/dfs

- 修改配置文件
  - 修改*slaves*文件，增加新增的节点
  - 同时同步整个集群的*slaves*文件
  - 修改队列策略配置文件：fair-scheduler.xml
    - 配置新集群的内存资源
    - 配置新集群的计算核资源
  - 修改每个新节点的/etc/hosts文件,增加[ip hostname]
  
- 启动基础进程
  - 启动datanode进程
  - 启动nodemanager进程

- 刷新整个集群资源
  - HDFS
    - 刷新节点信息：hdfs dfsadmin -refreshNodes
    - 平衡磁盘数据: start-balancer.sh
  - YARN
    - 刷新节点信息：yarn rmadmin -refreshNodes
    - 刷新队列资源：yarn rmadmin -refreshQueues

## 服务器基本属性
  - processor:32
  - cpu cores:8
  - MemTotal:128g
