#!/bin/bash

#�жϲ����Ƿ�Ϊ��
pcount=$#
if(($pcount<1)) ; then
  echo no args
  exit
fi
#ִ�б�������
echo ---------- localhost ----------
  $@
#Զ�̵�¼�ڵ�ִ������
for((host=100;host<105;host=host+1)); do
  echo ---------- s$host ----------
  ssh s$host $@
done
