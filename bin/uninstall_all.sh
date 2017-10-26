cd $(dirname "$0")
uninstall_yarn.sh
uninstall_hdfs.sh
slaves.sh --hosts zknode /software/servers/zookeeper-3.4.5/bin/zkServer.sh stop
sleep 3
$(dirname "$0")/slaves.sh jps -ml
sleep 3
$(dirname "$0")/slaves.sh ls /data*
