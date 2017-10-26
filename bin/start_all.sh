cd $(dirname "$0")
# zookeeper
slaves.sh --hosts zknode 'su - hadp -c "/software/servers/zookeeper-3.4.5/bin/zkServer.sh start"'

su - hadp -c "hadoop-daemons.sh --hosts jn_slaves start journalnode"
#su - hadp -c "cd `pwd`;./slaves.sh --hosts namenode  --index 1 hadoop-daemon.sh start namenode"
#su - hadp -c "cd `pwd`;./slaves.sh --hosts namenode  --index 2 hdfs namenode -bootstrapStandby"
#su - hadp -c "cd `pwd`;./slaves.sh --hosts namenode  --index 2 hadoop-daemon.sh start namenode"
su - hadp -c "hadoop-daemons.sh --hosts nns start namenode"
su - hadp -c "hdfs haadmin -getServiceState nn1"
su - hadp -c "hdfs haadmin -getServiceState nn2"
su - hadp -c "hadoop-daemons.sh start datanode"
su - hadp -c "hadoop-daemons.sh --hosts nns start zkfc"
su - hadp -c "hdfs haadmin -getServiceState nn1"
su - hadp -c "hdfs haadmin -getServiceState nn2"
# 用mapred用户启动mr jobhistory

su - yarn -c "$(cd `dirname $0`; pwd)/setup_yarn.sh"
slaves.sh --hosts jobhistory 'su - mapred -c "mr-jobhistory-daemon.sh start historyserver"'
