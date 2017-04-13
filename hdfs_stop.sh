echo -e "\033[42;37m stop namenode \033[0m"
hadoop-daemons.sh --hosts nns stop namenode
echo -e "\033[42;37m stop zkfc \033[0m"
hadoop-daemons.sh --hosts nns stop zkfc
echo -e "\033[42;37m stop datanode \033[0m"
hadoop-daemons.sh stop datanode
echo -e "\033[42;37m stop journalnode \033[0m"
hadoop-daemons.sh --hosts jn_slaves stop journalnode
