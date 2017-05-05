cd $(dirname "$0")
num=1

SLAVE_FILE=${SLAVE_FILE:-./zknode}
SLAVE_NAMES=$(cat "$SLAVE_FILE" | sed  's/#.*$//;/^$/d')
for slave in $SLAVE_NAMES ; do
  SSH_HOST="$slave"
  cmd="ssh $SSH_HOST \"mkdir -p /data0/zookeeper-3.4.5/data/;echo \\\"$num\\\">/data0/zookeeper-3.4.5/data/myid\""
  echo $cmd
  eval $cmd
  ssh $SSH_HOST "cat /data0/zookeeper-3.4.5/data/myid"
#  ssh $SSH_HOST "mkdir -p /data0/zookeeper-3.4.5/data/;echo $num>/data0/zookeeper-3.4.5/data/myid"
  let  num=$num+1
done
