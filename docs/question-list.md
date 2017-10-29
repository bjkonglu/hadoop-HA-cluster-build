# question-list
> 在维护Hadoop HA集群中出现的问题及对应措施。

|序号|错误类型|描述|措施|
|:---|:-------|:---|:---|
|1   |[YARN]: Failed while trying to construct the redirect url to the log server. Log Server url may not be configured       |已完成的任务无法查看日志！？                                                 |--|
|2   |[ZKFC]: java.lang.RuntimeException: Unable to fence NameNode at LF-JRDW-RT-10-194-16-2.hadoop.jd.local/10.194.16.2:8021 |HA的自动故障转移失败，由于系统缺少*fuser*命令（ssh: bash: fuser: 未找到命令）|安装命令:yum -y install psmisc|
