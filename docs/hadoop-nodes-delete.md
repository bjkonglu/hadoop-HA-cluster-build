# hadoop cluster delete nodes
> 在集群正常运维过程中，需要将坏的节点或者需要拆分的节点移除集群，需要将这类节点从集群中删除。

## hadoop集群动态删除节点
- 新建配置文件*excludes*
  - excludes文件里每行代表一个要删除的节点

- 修改配置文件*hdfs-site.xml*以及*mapred-site.xml*
  - hdfs-site.xml文件增加配置属性如下：
  ```
  <property>
        <name>dfs.hosts.exclude</name>
        <value>/software/softs/hadoop-2.7.1/etc/hadoop/excludes</value>
  </property>
  ```
  - mapred-site.xml文件增加配置属性如下：
  ```
  <property>
        <name>mapred.hosts.exclude</name>
        <value>/software/softs/hadoop-2.7.0/etc/hadoop/excludes</value>
        <final>true</final>
  </property>
  ```
  - *整个集群*同步以上新建或修改的配置文件
  - 集群配置文件同步后，在namenode节点上执行刷新整个集群节点操作：
  ```
  hdfs dfsadmin -refreshNodes
  ```
  - 查看*删除节点*的状态由In Service -> Decommissioning -> Decommissioned
  - 在将*删除节点*上的datanode和nodemanager进程关闭：
  ```
  hadoop-daemon.sh stop datanode
  yarn-daemond.sh stop nodemanager
  ```
  - 再次查看*删除节点*的状态，状态已经为Dead
  - 最后均衡整个集群的数据块(block)
  ```
  start-balancer.sh
  ```
