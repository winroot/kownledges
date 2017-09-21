# ElasticSearch的安装
**操作系统环境：**  centos 6.7  
**elasticsearch:** elasticsearch 2.1.1  
**集群搭建方式：** 三个虚拟机节点（ip和hostname见安装步骤2）  
**安装路径：** /opt  
**必备环境：** java运行环境  
# 安装步骤：
1.在三台机器上分别安装jdk(略)

2.修改/etc/hosts文件如下：  
![](https://i.imgur.com/n4VTt5t.png)

3.在s100机器上将es压缩文件移到/opt中  
移动命令：mv elasticsearch-2.1.1.tar.gz /opt 
  
4.解压并重命名  
命令：tar–xvf elasticsearch-2.1.1.tar.gz   mv elasticsearch-2.1.1.tar.gz elasticsearch

5.修改配置文件
将config底下的elasticsearch.yml文件中：  
    node.name  
    network.host  
    discovery.zen.ping.unicast.hosts
  
改成如下配置：  
    node.name: s100  
    network.host: 172.18.18.100  
    discovery.zen.ping.unicast.hosts: ["s100", "s101","s102"](在三个节点配置hosts文件，172.18.18.100、172.18.18.101、172.18.18.102是节点的ip地址，对应hostname分别为s100\s101\s102) 

6.将elasticsearch文件分别复制到s101和s102节点上，修改上述配置文件中node.name\network.host为对应节点IP和hostname  
 
7.es不允许在root用户下启动，所以需要单独创建一个用户elasticsearch  
命令：  
groupadd elsearch  
useradd elsearch -g elsearch -p elasticsearch

8.更改elasticsearch文件夹及内部文件的所属用户及组为  elsearch:elsearch  
命令：chown -R elsearch:elsearch elasticsearch

9.切换到elsearch用户再启动  
命令：
su elsearch   
cd elasticsearch/bin./elasticsearch  

10.因为elasticsearch启动后会一直存在在界面上，所以可以让它在后台运行  
命令：./elasticsearch -d
