echo -e "\033[42;37m start resourcemanager \033[0m"
yarn-daemons.sh --hosts nns start resourcemanager
yarn rmadmin -getServiceState rm1
yarn rmadmin -getServiceState rm2

yarn-daemons.sh --hosts hosts/mapred_hosts start nodemanager

