#groupadd -g 888 hadoop
#usermod -a -G hadoop hadp
#usermod -a -G hadoop yarn
#usermod -a -G hadoop mapred
mkdir -p /sys/fs/cgroup/cpu,cpuacct/hadoop-yarn/
chown -R yarn:yarn  /sys/fs/cgroup/cpu,cpuacct/hadoop-yarn
chmod 750 /sys/fs/cgroup/cpu,cpuacct/hadoop-yarn
mkdir -p /sys/fs/cgroup/net_cls/hadoop-yarn/
chown -R yarn:yarn  /sys/fs/cgroup/net_cls/hadoop-yarn
chmod 750 /sys/fs/cgroup/net_cls/hadoop-yarn
mkdir -p /etc/yarn-executor
chown root:yarn /etc/yarn-executor/

cp $HADOOP_HOME/bin/container-executor /etc/yarn-executor/
cp $HADOOP_HOME/etc/hadoop/container-executor.cfg /etc/yarn-executor/

chown root:yarn /etc/yarn-executor/container-executor
chown root:yarn /etc/yarn-executor/container-executor.cfg
chmod 6050 /etc/yarn-executor/container-executor
chmod 750 /etc/yarn-executor/container-executor.cfg

chmod 777  /data0 /data1
chown hadp:hadoop /data0 /data1
mkdir -p /data0/hadoop_tmp/nm-tc-rules
chown hadp:hadoop /data0/hadoop_tmp/
chmod 777 /data0/hadoop_tmp/
chown yarn:yarn /data0/hadoop_tmp/nm-tc-rules -R
chmod 755 /data0/hadoop_tmp/nm-tc-rules -R
mkdir -p /data0/hadoop_tmp/nm-docker-cmds
chown yarn:yarn /data0/hadoop_tmp/nm-docker-cmds -R
chmod 775 /data0/hadoop_tmp/nm-docker-cmds -R

mkdir /data0/hadoop-pids /data0/hadoop-logs
chown hadp:hadoop /data0/hadoop-pids
chown hadp:hadoop /data0/hadoop-logs
