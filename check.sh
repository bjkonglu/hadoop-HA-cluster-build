cd $(dirname "$0")
./slaves.sh jps
read
./slaves.sh ls /data0
read
./slaves.sh ls /data1


su - hadp -c "hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar teragen 100 /tmp/teragen"
