# 搭建HADOOP-HA集群

## 集群角色分配
|角色|描述|角色IP|兼职|兼职描述|
|:---|:----|:---|:--|:------|
|NN1  |NameNode节点   |ip-nn1|rm         |ResourceManager |
|NN2  |NameNode节点   |ip-nn2|his-server |JobHistoryServer|
|JN1  |JournalNode节点|ip-jn1|DN/NM      |DataNode/NodeManager|
|JN2  |JournalNode节点|ip-jn2|DN/NM      |DataNode/NodeManager|
|JN3  |JournalNode节点|ip-jn3|DN/NM      |DataNode/NodeManager|
|ZK1  |ZooKeeper     |ip-zk1|DN/NM      |DataNode/NodeManager|
|ZK2  |Zookeeper     |ip-zk2|DN/NM      |DataNode/NodeManager|
|ZK3  |Zookeeper     |ip-zk3|DN/NM      |DataNode/NodeManager|
|DN   |DataNode      |ip-其他|NM         |NodeManager    |

## 基础组件部署

* SSH:免密登入
    * NN1->其他节点
    * NN2->其他节点
* jdk 1.8.x
* scala 2.1.x
* hadoop 2.7.1
* spark 2.1.1 -> 针对spark
* zookeeper -> 针对zk集群节点（ip-zk1,ip-zk2,ip-zk3）

## 基础目录创建

### 节点公共目录
* /data0/hadoop_tmp
* /data0/hadoop-logs
* /data0/hadoop-pids
* /data0/yarn-logs
* /data0/spark-logs -> 针对spark

### 角色特有目录
|角色|私有目录|
|:---|:------|
|NN  |/data0/nn|
|DN  |/data0/dfs|
|NM  |/data0/yarn/local, /data0/yarn/logs|
|JN  |/data0/journal/data|
|ZK  |/data0/zookeeper/data, /data0/zookeeper/log|

## 配置文件修改
* core-site.xml
* hdfs-site.xml
* yarn-site.xml
* mapred-site.xml

## 第一次启动集群步骤
- zk集群启动
> zkServer start

- 格式化zookeeper上hadoop-ha目录
> hdfs zkfc -formatZK

- 启动journalnode(namenode日志同步服务)
> hadoop-daemon.sh start journalnode

- 格式化namenode
> hdfs namenode -format

- 启动namenode, 同步备用namenode, 启动备用namenode
>hadoop-daemon.sh start namenode, hdfs namenode -bootstrapStandby, hadoop-daemon.sh start namenode

- 启动zkfc(DFSZKFailoverController)
>hadoop-daemon.sh start zkfc

- 启动datanode
>hadoop-deamons.sh start datanode

- 启动yarn
>start-yarn.sh

- 启动yarn日志服务JobHistoryServer和spark的历史日志服务
>mr-jobhistory-deamon.sh start historyserver

>start-history-server.sh

## 测试集群步骤

1. 测试hdfs
    - 本地文件上传到hdfs
    - 读取hdfs文件
2. ha特性
    - nn1:active, nn2:standby -> 遇到nn1->down -> nn2:active 
3. 在yarn上提交任务
