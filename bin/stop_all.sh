cd $(dirname "$0")
stop_yarn.sh
su - hadp -c "$(cd `dirname $0`; pwd)/stop_hdfs.sh"
slaves.sh --hosts zknode /software/servers/zookeeper-3.4.5/bin/zkServer.sh stop
