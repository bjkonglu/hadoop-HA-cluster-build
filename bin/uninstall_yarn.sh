cd $(dirname "$0")
stop_yarn.sh
sleep 3
slaves.sh \rm -rf /data*/yarn-logs /data*/yarn1
