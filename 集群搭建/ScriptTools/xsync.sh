#!/bin/bash
#�жϲ����Ƿ�Ϊ��
pcount=$#
if(($pcount<1)) ; then
  echo no args
  exit
fi
#��ȡ�ļ���
p1=$1
fname=`basename $p1`
#��ȡ����·��
pdir=`dirname $p1`
pdir=`cd $pdir;pwd`
cuser=`whoami`
#�ַ��ļ�
for((host=100;host<105;host=host+1)); do
echo ---------- s$host ----------
rsync -rvl $pdir/$fname $cuser@s$host:$pdir
done
