# 集群上运行jar程序，状态一直Accepted且不停止不报错

如果spark任务在提交之后集群的状态一直为Accepted且不停止不报错，一般是由于多个用户同时向集群提交任务或一个用户向集群同时提交了多个任务导致yarn资源分配错误。解决这个问题，只需要修改Hadoop配置文件：
> /etc/hadoop/conf/capacity-scheduler.xml  

把这项：

> yarn.scheduler.capacity.maximum-am-resource-percent从0.1调到更大（如0.5）就可以了。

顾名思义，这个选项是增加yarn可调度资源量。

查看spark进程：

> ps aux |grep spark

查看spark上正在运行的任务：

> yarn application -list


