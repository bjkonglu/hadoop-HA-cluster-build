# hadoop-HA-cluster-build
目前HBASE和spark还没有搭建
## 集群介绍

### Cluster Name

pinball

### 描述

搭建5个结点的测试集群，为了测试jdk1.8下hadoop的一些新特性

## 环境配置

### 服务器

A|192.168.1.156
B|192.168.1.157
C|192.168.1.158
D|192.168.1.159
E|192.168.1.160



### 软件环境

| 名称           |版本|            备注|
|---------------|------------------------|--------------------------------|
| 操作系统 |centos|7.1.1503|
| JDK     |1.8u65以上||
| HADOOP|2.7.1||
| ZK      |3.4.5||
| SPARK   |2.5.1||


### 角色分配
代号|hostname|角色
---|--------|-----
A  |192.168.1.156| NN1/RM1
B  |192.168.1.157| NN2/RM2/sparkhistory/MRJH/Metastore
C  |192.168.1.158| DN/NM/ZK/JN/HBASE
D  |192.168.1.159| DN/NM/ZK/JN/HBASE
E  |192.168.1.160| DN/NM/ZK/JN/HBASE

### 角色信息
角色| 用户|相关位置|备注
----|-----|----|----
zk | hadp|/data0/logs/zookeeper-logs,/data0/zookeeper-3.4.5|
NN | hadp|/data0/hadoop-logs|同时启动DFSZKFailoverController进程
DN | hadp|/data0/hadoop-logs|
NM | yarn|/data1/yarn-logs|
JN | hadp|/data0/hadoop-logs|
RM | yarn|/data1/yarn-logs|
MRJH | mapred |/data0/hadoop-logs/|
ApplicationHistoryServer | yarn |/data1/yarn-logs|
sparkHistory|mapred| |

### 挂载硬盘
- 创建ext4分区并挂载到/data0和/data1
```bash
# 查看已有分区和挂载点
df -Th 
# 查看硬盘设备
ls /dev/sd*
# (*)查看未分区使用的硬盘
blkid
# (*)格式化分区
mkfs.ext4 -L data0 /dev/sdb
mkfs.ext4 -L data1 /dev/sdc
# (*)查看分区和uuid
blkid
# (*)编辑fstab文件
vim /etc/fstab
# (*)加入两行
UUID=bc5261d1-27be-4569-90fe-1f67124d3bf6 /data0 ext4 defaults 1 2 
UUID=8f274d7d-09db-4df5-b286-c7a2742aa128 /data1 ext4 defaults 1 2
# (*)创建/data0 /data1文件夹
mkdir /data0 /data1
# (*)挂载 fstab中的分区
mount -a
# (*)查看已有分区和挂载点
df -Th 
```
### 修改/etc/hosts
```
192.168.1.156  HADOOP-1-156
192.168.1.157  HADOOP-1-157
192.168.1.158  HADOOP-1-158
192.168.1.159  HADOOP-1-159
192.168.1.160  HADOOP-1-160
```
### 脚本介绍

- 为了方便,先将root用户A到BCDE免密，然后使用工具脚本执行命令
  - slaves.sh 多结点执行命令
  - allcli.sh 交互多结点执行命令
  - createuser.sh

### 用户和免密
- root用户A到BCDE免密
- 创建hadp,yarn,mapred用户
```bash
$ slaves.sh --hosts allnode createuser.sh
```
- hadp@A 和 hadp@B 到C\D\E免密

```bash
$ ssh hadp@HADOOP-1-156
$ ssh-copy-id HADOOP-1-156
$ ssh-copy-id HADOOP-1-158
$ ssh-copy-id HADOOP-1-159
$ ssh-copy-id HADOOP-1-160
$ ssh hadp@HADOOP-1-157
$ ssh-copy-id HADOOP-1-157
$ ssh-copy-id HADOOP-1-158
$ ssh-copy-id HADOOP-1-159
$ ssh-copy-id HADOOP-1-160
```

- yarn@A 和 yarn@B 到C\D\E免密
```bash
$ ssh yarn@HADOOP-1-156
$ ssh-copy-id HADOOP-1-156
$ ssh-copy-id HADOOP-1-158
$ ssh-copy-id HADOOP-1-159
$ ssh-copy-id HADOOP-1-160
$ ssh yarn@HADOOP-1-157
$ ssh-copy-id HADOOP-1-157
$ ssh-copy-id HADOOP-1-158
$ ssh-copy-id HADOOP-1-159
$ ssh-copy-id HADOOP-1-160
```
### 配置JDK1.8.65

### 搭建zookeeper

在C D E上搭建zookeeper

- 分别配置conf/zoo.cfg
- 分别生成文件/data0/zookeeper-3.4.5/data/myid，内容在C D E 上分别为1、2、3
- 启动(在setup_all.sh脚本中启动)单独启动脚本如下
```bash
$ ./slaves.sh --hosts zknode 'su - hadp -c "/software/servers/zookeeper-3.4.5/bin/zkServer.sh start"'
```

### 搭建HDFS

在A上以hdfs用户执行`hdfs zkfc -formatZK`，会在zk中创建结点`/pinball-hadoop-ha/ns1`


- 启动jn
编辑/etc/hadoop/slaves 换行分割
`sbin/hadoop-daemons.sh --hosts jn_slaves start journalnode`


### 复制需要的jar到对应的目录
./hadoop/common/lib/hadoop-lzo-0.4.20.jar
./hadoop/yarn/spark-1.4.0-SNAPSHOT-yarn-shuffle.jar


### 启动所有（zk、hdfs、yarn、目录权限）
```bash
$ ./setup_all.sh
```

### 卸载所有 (zk、hdfs、yarn、log、data)
```bash
$ ./uninstall_all.sh
```
### 检查是否成功
```bash
./check.sh
```
