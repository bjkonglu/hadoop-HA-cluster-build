# question-list
> 在维护Hadoop HA集群中出现的问题及对应措施。

|序号|错误类型|描述|措施|
|:---|:-------|:---|:---|
|1   |[YARN]: Failed while trying to construct the redirect url to the log server. Log Server url may not be configured       |已完成的任务无法查看日志|yarn-site.xml文件缺少配置*yarn.log.server.url*,修改完配置后一定得**重启RM**,不然配置不会生效 |增加配置，重启yarn集群|
|2   |[ZKFC]: java.lang.RuntimeException: Unable to fence NameNode at LF-JRDW-RT-10-194-16-2.hadoop.jd.local/10.194.16.2:8021 |HA的自动故障转移失败，由于系统缺少*fuser*命令（ssh: bash: fuser: 未找到命令）|安装命令:yum -y install psmisc|
|3   |[NN]: java.net.NoRouteToHostException: No Route to Host from  LF-JRC-WUDANGSHAN-15420.hadoop.jd.local/172.18.154.20 to LF-JRC-WUDANGSHAN-15421.hadoop.jd.local:8021 failed on socket timeout exception: java.net. |处于*active*状态的NN，由于物理原理宕机，hadoop的失效备援机制没能将处于*standalone*状态的NN切换到*active*状态            |通过修复宕机的物理机，重启namenode和jobhistory进程|
