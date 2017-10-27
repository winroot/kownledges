#! /bin/sh  

cd `dirname $0`
BIN_DIR=`pwd`
cd ..

DEPLOY_DIR=`pwd`
BIN_DIR=$DEPLOY_DIR/bin
LOG_DIR=${DEPLOY_DIR}/logs  
LOG_FILE=$LOG_DIR/cron.log                              # 日志文件  
host_dir=`echo ~`                                       # 当前用户根目录  
proc_name="KafkaOverFtpServer"                          # 进程名  
                             
pid=0  
  
proc_num()                                              # 计算进程数  
{  
    num=`ps -ef | grep $proc_name | grep -v grep | wc -l`  
    return $num  
}  
  
proc_id()                                               # 进程号  
{  
    pid=`ps -ef | grep $proc_name | grep -v grep | awk '{print $2}'`  
}  
  
proc_num  
number=$?  
if [ $number -eq 0 ]                                # 判断进程是否存在  
then   
    cd $BIN_DIR/; ./ftpcorn.sh -DZone               # 重启进程的命令，请相应修改  
    proc_id                                         # 获取新进程号  
    echo ${pid}, `date` >> $LOG_FILE                # 将新进程号和重启时间记录  
fi  