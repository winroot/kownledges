#RDD的依赖关系

RDD和它的依赖关系有两种不同的类型，即在依赖和宽依赖。

1） 窄依赖指的是每一个parent RDD的partition最多被子RDD的一个Partition使用。

2）宽依赖指的是多个子RDD的Partition会依赖同一个parent RDD的Partition