# 问题描述：
在集群上同时提交多个任务，但是发现集群的资源还有很多，但是任务却无法起来,一直处于Accepted状态

# 解决方法：
这种情况一般是由于yarn可调度的资源不够而并非集群的资源不够，修改Hadoop/etc/hadoop/capacity-scheduler.xml，将value从0.1改为0.5，增加yarn可调度的资源数
```
<property>
    <name>yarn.scheduler.capacity.maximum-am-resource-percent</name>
    <value>0.5</value>
    <description>
      Maximum percent of resources in the cluster which can be used to run
      application masters i.e. controls number of concurrent running
      applications.
    </description>
  </property>
  ```
