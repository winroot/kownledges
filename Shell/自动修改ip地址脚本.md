**自动修改IP地址脚本**  
---
对于不熟悉linux操作的人来说，手动的去更改机器的IP地址是一件麻烦的事情，即使对于很多熟悉linux环境使用的人来说，如果需要频繁的更改机器的IP地址也是一件麻烦事。以下脚本的目的就是实现自动更改IP地址，而不需要太复杂的命令或者通过更改网络适配器的信息的来更改。
changeIP.sh脚本如下：

    #!/bin/bash
    netmask=255.255.255.0
    IP_PATH=/etc/sysconfig/network-scripts/ifcfg-eth1
    GM_PATH=/etc/sysconfig/network  
    //input IP address  
    echo -e "Please input IP(FORMAT:192.168.1.8):\c"
    read ip  
    //input the GateWay  
    echo -e "Please input GateWay(FORMAT:192.168.1.1):\c"
    read gateway  
    //change ipaddress  
    echo "DEVICE=eth1">$IP_PATH
    echo "BOOTPROTO=static">>$IP_PATH
    echo "IPADDR=$ip">>$IP_PATH
    echo "NETMASK=255.255.255.0">>$IP_PATH
    echo "GATEWAY=$gateway">>$IP_PATH
    echo "ONBOOT=yes">>$IP_PATH
    /etc/init.d/network restart

上面的脚本一般来说你只需要修改eth1，将其改为你机子上对应的网卡名称。将上述脚本拷贝到虚拟机任意目录下，并在该目录下执行 chmod u+x ChangIP.sh。如果是从window下拷贝到Linux环境下，由于Windows默认换行符是\r\n，而Linux下是\n，所以还需要执行dos2unix ChangIP.sh命令对文件格式进行转化，首先要下载安装dos2unix，centos环境执行yum install dos2unix -y下载安装。
