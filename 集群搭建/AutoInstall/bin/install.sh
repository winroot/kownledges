#!/bin/bash

if (($#<1))
then
  echo ++++++++++ Please set client path!!! ++++++++++
  exit
fi

#configuration
client_dir="$1"
base_dir=`dirname .`
base_dir=`cd $base_dir;pwd`
pack_dir=`cd $base_dir/../package;pwd`
conf_dir=`cd $base_dir/../conf;pwd`
hadoop_dir=$client_dir/Hadoop
spark_dir=$client_dir/Spark
scala_dir=$client_dir/Scala
jdk_dir=$client_dir/JDK
user=hzgc

#function
Rsync()
{
rsync -rvl $1 $user@$2:$3
}

Xcall()
{
ssh $user@$1 $2
}

#install jdk and scala
#=================================================================================
#jdk
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Start install JDK
echo
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Decompress $pack_dir/jdk-8u131-linux-x64.tar.gz
echo 
mkdir -p $jdk_dir
if [ 0 -eq $?  ]
then
tar zxvf $pack_dir/jdk-*.tar.gz -C $jdk_dir > log.file
fi
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Create symbol link $jd_dir/jdk from $jdk_dir
echo 
ln -s $jdk_dir/jdk* $jdk_dir/jdk
jdk_client=$jdk_dir/jdk
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Decompress JDK successfull
echo 
#scala
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Star install Scala
echo
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Decompress $pack_dir/scala-2.12.2.tgz
echo 
mkdir -p $scala_dir
if [ 0 -eq $? ]
then
tar zxvf $pack_dir/scala-*.tgz -C $scala_dir >> log.file
fi
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Create symbol link $scala_dir/scala from $scala_dir
echo
ln -s $scala_dir/scala*/ $scala_dir/scala
scala_client=$scala_dir/scala
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Decompress Scala successfull
echo
#env
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Write enviroment into $client_dir/big_env
echo
echo JAVA_HOME=$jdk_client > $client_dir/big_env
echo SCALA_HOME=$scala_client >> $client_dir/big_env
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Write enviroment successfull
echo
#=================================================================================

#install hadoop
#=================================================================================
#tar hadoop
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Start install Hadoop
echo
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Decompress $pack_dir/hadoop-2.7.3.tar.gz
echo
mkdir -p $hadoop_dir
if [ 0 -eq $? ]
then
tar zxvf $pack_dir/hadoop-*.tar.gz -C $hadoop_dir >> log.file
fi
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Create symbol link $hadoop_dir/hadoop from $hadoop_dir
echo
ln -s $hadoop_dir/hadoop* $hadoop_dir/hadoop
hadoop_client=$hadoop_dir/hadoop
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Decompress Hadoop successfull
echo
#env
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Write enviroment into $client_dir/big_env
echo
echo HADOOP_HOME=$hadoop_client >> $client_dir/big_env
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Write enviroment successfull
echo
#config
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Replace core-site.xml,hdfs-site.xml,yarn-site.xml,mapred-site.xm,hadoop-env.sh,slaves from $hadoop_client/etc/hadoop
echo
conf_hadoop=$hadoop_client/etc/hadoop/
cp $conf_dir/* $conf_hadoop
localhost=`hostname`
tmpdir=$hadoop_dir/tmp
core_site=$conf_hadoop/core-site.xml
hdfs_site=$conf_hadoop/hdfs-site.xml
yarn_site=$conf_hadoop/yarn-site.xml
mapred_site=$conf_hadoop/mapred-site.xml
hadoop_env=$conf_hadoop/hadoop-env.sh
hadoop_slaves=$conf_hadoop/slaves
ip_list=`cat ip_list`
tmp_ip=""
tmp_hostname=""

echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Start configure core-site.xml,hdfs-site.xml,yarn-site.xml,mapred-site.xm,hadoop-env.sh,slaves in $hadoop_client/etc/hadoop
echo
echo $null > $hadoop_slaves
for ip in $ip_list
do
tmp_ip=$ip
tmp_hostname=`ssh $ip "hostname"`
echo $tmp_hostname >> $hadoop_slaves
done

sed -i "s#{localhost}#$localhost#g" $core_site
sed -i "s#{tmpdir}#$tmpdir#g" $core_site
sed -i "s#{tmp_ip}#$tmp_hostname:50090#g" $hdfs_site
sed -i "s#{localhost}#$localhost#g" $yarn_site
sed -i "s#\${JAVA_HOME}#$jdk_client#g" $hadoop_env
mkdir -p $tmpdir
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Create $tmpdir successfull
echo
#=================================================================================

#=================================================================================
#path
echo PATH=\$PATH:$jdk_client/bin:$scala_client/bin:$hadoop_client/bin:$hadoop_client/sbin >> $client_dir/big_env
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Send file to cluster
echo
tmpdir=`cd $client_dir/..;pwd`
for ip in $ip_list
do
#ssh $user@$ip "mkdir -p $client_dir"
tmp_ip=`ssh $user@$ip hostname`
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Start send file to $tmp_ip:$ip
echo
Rsync $client_dir $ip $tmpdir
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Send successfull
echo
done
#=================================================================================

#=================================================================================
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Format namenode
echo
source $client_dir/big_env;hdfs namenode -format
echo [INFO] `date +%y/%m/%d/%H:%M:%S`:Start cluster
echo
sbin_hadoop=$hadoop_client/sbin
source $client_dir/big_env;$sbin_hadoop/start-all.sh
#=================================================================================








