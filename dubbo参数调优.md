# dubbo参数调优

一、dubbo 配置的优先级：  

（1）dubbo分为consumer和provider端，在配置各个参数时，其优先级如下：  
1、consumer的method配置   
2、provider的method配置  
3、consumer的reference配置  
4、provider的service配置  
5、consumer的consumer节点配置  
6、provider的provider节点配置  
方法级的配置优先级高于接口级，consumer的优先级高于provider。  

（2）在本地参数配置还存在一层优先级：  
1、系统参数(-D)，如-Ddubbo.protocol.port=20881  
2、xml配置  
3、property文件  
也就是数程序启动时首先读取系统参数、然后才是xml文件，最后才是properties文件中的配置项 


