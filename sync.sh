cd $(dirname "$0")
./slaves.sh \rm -rf $HADOOP_HOME/etc/hadoop 
timestamp=`date '+%Y%m%d%H%M%S'`
echo $timestamp>$HADOOP_HOME/etc/hadoop_template/timestamp
chmod 777 $HADOOP_HOME/etc/hadoop_template/timestamp
SLAVE_FILE=allnode
SLAVE_NAMES=$(cat "$SLAVE_FILE" | sed  's/#.*$//;/^$/d')
for slave in $SLAVE_NAMES ; do
  scp -r $HADOOP_HOME/etc/hadoop_template $slave:$HADOOP_HOME/etc/hadoop
done

./slaves.sh chown hadp:hadp -R  $HADOOP_HOME/etc/hadoop
./slaves.sh cat $HADOOP_HOME/etc/hadoop/timestamp
