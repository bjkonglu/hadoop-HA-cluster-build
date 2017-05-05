# use hadp user execute this script
hdfs dfs -mkdir -p /apps /system /test/in /tmp /userlogs/yarn /userlogs/history/done_intermediate /userlogs/history/done /user
hdfs dfs -chmod 755 /apps
hdfs dfs -chmod 755 /system
hdfs dfs -chmod 755 /test
hdfs dfs -chmod 777 /tmp
hdfs dfs -chmod 775 /user
hdfs dfs -chown mapred:hadoop /userlogs
hdfs dfs -chmod 777 /userlogs
hdfs dfs -chown yarn:hadoop /userlogs/yarn
hdfs dfs -chmod 700 /userlogs/yarn
hdfs dfs -chown -R mapred:hadoop /userlogs/history
hdfs dfs -chmod 755 /userlogs/history
hdfs dfs -chmod 775 /userlogs/history/done
hdfs dfs -chmod 1777 /userlogs/history/done_intermediate


