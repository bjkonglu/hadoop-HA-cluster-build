cd $(dirname "$0")
echo ./stop_hdfs.sh
./stop_hdfs.sh
sleep 3
echo -e "\033[42;37m rm /data*/nn /data*/dfs\033[0m"
./slaves.sh \rm -rf /data*/nn /data*/dfs

echo -e "\033[42;37m rm journal hadoop-pids \033[0m"
./slaves.sh \rm -rf /data0/journal /data0/hadoop-pids /data0/hadoop_tmp /data0/hadoop-logs /data*/hadoop-audit-logs

