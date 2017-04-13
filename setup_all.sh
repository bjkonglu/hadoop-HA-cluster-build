cd $(dirname "$0")
# zookeeper
./slaves.sh --hosts zknode 'su - hadp -c "/software/servers/zookeeper-3.4.5/bin/zkServer.sh start"'
# 同步配置文件夹etc/hadoop_template到每个结点
./sync.sh
# 用hadp用户执行安装脚本，包括启动zkfc jn nn dn
su - hadp -c "$(cd `dirname $0`; pwd)/setup_hdfs.sh"
# 初始化hdfs中的目录。如/tmp /userlogs
su - hadp -c "./init_hdfsdir.sh"
# 每个结点都进行目录初始化
./slaves.sh --script init.sh
# 用yarn用户执行安装脚本，包括rm、nm
su - yarn -c "$(cd `dirname $0`; pwd)/setup_yarn.sh"
# 用mapred用户启动mr jobhistory
./slaves.sh --hosts jobhistory 'su - mapred -c "mr-jobhistory-daemon.sh start historyserver"'
