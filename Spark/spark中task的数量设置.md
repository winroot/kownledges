# spark中task的数量设置

spark中有partition的概念，每个partition都会对应一个task，task越多，在处理大规模数据的时候，就会越有效率。不过task并不是越多越好，如果平时测试，或者数据量没有那么大，则没有必要task数量太多。 
我的第一个query程序，有200个task，我改成了50个，节约了1s左右。 
参数可以通过spark_home/conf/spark-default.conf配置文件设置:

>spark.sql.shuffle.partitions 50

>spark.default.parallelism 10

上边两个参数，第一个是针对spark sql的task数量，我的程序逻辑是将rdd首先转换成dataframe，然后进行query，所以对应第一个参数。而如果程序是非sql则第二个参数生效。 
