
usage(){
  echo "Usage: slaves.sh [--hosts hostfile] [--user user] [--script script] user COMMAND "
}

while [ $# -gt 0 ];do
    case $1 in
        --hosts)
            shift
            SLAVE_FILE=$1
            shift
            ;;
        --user)
            shift
            SLAVE_USER=$1
            shift
            ;;
        --script)
            shift
            SCRIPT_NAME=$1
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
if [ $# = 0 ]; then
  if [ "$SCRIPT_NAME" == "" ]; then
    usage
    exit 1
  fi
fi
pwd
SLAVE_FILE=${SLAVE_FILE:-./allnode}
echo $SLAVE_FILE
if [ "$INDEX" != "" ]; then
  SLAVE_NAMES=$(cat "$SLAVE_FILE" | sed  -n "${INDEX}p")
else
  SLAVE_NAMES=$(cat "$SLAVE_FILE" | sed  's/#.*$//;/^$/d')
fi
for slave in $SLAVE_NAMES ; do
  if [ "$SLAVE_USER" != "" ]; then
    SSH_HOST="$SLAVE_USER@$slave"
  else
    SSH_HOST="$slave"
  fi
  if [ "$SCRIPT_NAME" != "" ]; then
    echo -e "\033[42;37m ssh $SSH_HOST -C \"/bin/bash\" < $SCRIPT_NAME \033[0m"
    ssh $SSH_HOST -C "/bin/bash" < $SCRIPT_NAME
  else
    echo -e "\033[42;37m ssh $SSH_HOST $@ \033[0m"
    ssh $SSH_HOST "$@"
  fi
done
