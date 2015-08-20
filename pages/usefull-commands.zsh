#Check mysqld server in running
netstat -tap | grep mysql
#get your ip
ifconfig eth0 | grep inet | awk '{ print $2 }'
