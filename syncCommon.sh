curPWD=`pwd`
cd $(dirname "$0")
usage(){
  echo "Usage: syncCommon.sh [--hosts hostfile] [--index INDEX] file or folder "
}

while [ $# -gt 0 ];do
    case $1 in
        --hosts)
            shift
            SLAVE_FILE=$1
            shift
            ;;
        --index)
            shift
            INDEX=$1
            shift
            ;;
        -h)
            usage
            exit 0
            ;;
        \?)
            usage
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

SLAVE_FILE=${SLAVE_FILE:-./allnode}
echo $SLAVE_FILE
if [ "$INDEX" != "" ]; then
  SLAVE_NAMES=$(cat "$SLAVE_FILE" | sed  -n "${INDEX}p")
else
  SLAVE_NAMES=$(cat "$SLAVE_FILE" | sed  's/#.*$//;/^$/d')
fi

for slave in $SLAVE_NAMES ; do
  if [ $slave == `hostname` ];  then
     continue
  fi
  if [ -d $1 ];then
    cmd="scp -r $1  $slave:$(dirname `realpath $1`)"
  else
    cmd="scp  $1  $slave:`realpath $1`"
  fi
  echo $cmd
  eval $cmd
done

