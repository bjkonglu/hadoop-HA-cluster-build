cd $(dirname "$0")
echo -e "\033[42;37m stop rm \033[0m"
su - yarn -c "yarn-daemons.sh --hosts nns stop resourcemanager"
echo -e "\033[42;37m stop nm \033[0m"
su - yarn -c "yarn-daemons.sh --hosts hosts/mapred_hosts stop nodemanager"
echo -e "\033[42;37m stop mr-jobhistory \033[0m"
./slaves.sh --hosts jobhistory  'su - mapred -c "mr-jobhistory-daemon.sh stop historyserver"'
sleep 3
./slaves.sh \rm -rf /data*/yarn-logs /data*/yarn1
