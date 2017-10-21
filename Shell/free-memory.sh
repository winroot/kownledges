#! /bin/sh
#set -x
#$0当前Shell程序的文件名
#dirname $0，获取当前Shell程序的路径
#cd `dirname $0`，进入当前Shell程序的目录

cd `dirname $0`
BIN_DIR=`pwd`    ### bin目录
cd ..
DEPLOY_DIR=`pwd`
LOG_DIR=${DEPLOY_DIR}/logs
LOG_FILE=${LOG_DIR}/free-memory.log
#判断路径是否存在
if [ ! -d $LOG_DIR ];then
   mkdir $LOG_DIR
fi

if [ ! -x $LOG_FILE ]; then
 touch "$LOG_FILE"
fi
#awk 'NR==2' 表示取free -m 后取第二行
used=`free -m | awk 'NR==2' | awk '{print $3}'`
free=`free -m | awk 'NR==2' | awk '{print $4}'`
echo "===========================" >> $LOG_FILE
date >> $LOG_FILE
echo "Memory usage before | [Use：${used}MB][Free：${free}MB]" >> $LOG_FILE
if [ $free -le 20000 ] ; then
#As this is a non-destructive operation, and dirty objects are #notfreeable, the user should run "sync" first in order to make sure #allcached objects are freed.
                #sync命令 linux同步数据命令
                #To free pagecache:
                sync && echo 1 > /proc/sys/vm/drop_caches
				#To free dentries and inodes:
                sync && echo 2 > /proc/sys/vm/drop_caches
				#To free pagecache, dentries and inodes:
                sync && echo 3 > /proc/sys/vm/drop_caches
				used_ok=`free -m | awk 'NR==2' | awk '{print $3}'`
				free_ok=`free -m | awk 'NR==2' | awk '{print $4}'`
				echo "Memory usage after | [Use：${used_ok}MB][Free：${free_ok}MB]" >> $LOG_FILE
                echo "OK" >> $LOG_FILE
else
                echo "Not required" >> $LOG_FILE
fi
exit 1
