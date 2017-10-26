cd $(dirname "$0")
echo -e "\033[42;37m zkfc format \033[0m"
hdfs zkfc -formatZK
echo -e "\033[42;37m start journalnode \033[0m"
hadoop-daemons.sh --hosts jn_slaves start journalnode
hdfs namenode -format
slaves.sh --hosts namenode  --index 1 hadoop-daemon.sh start namenode
slaves.sh --hosts namenode  --index 2 hdfs namenode -bootstrapStandby
slaves.sh --hosts namenode  --index 2 hadoop-daemon.sh start namenode
hdfs haadmin -getServiceState nn1
hdfs haadmin -getServiceState nn2
hadoop-daemons.sh start datanode
hadoop-daemons.sh --hosts nns start zkfc
hdfs haadmin -getServiceState nn1
hdfs haadmin -getServiceState nn2

