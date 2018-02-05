# Linux常用命令

1.设置某个文件中某个参数的值

cat /etc/sysctl.conf | grep vm.max_map_countvm.max_map_count=262144

2.查看最新的日志文件 

tailf xxx.log

3.杀掉进程

kill -9 pid(进程号)

4.查看进程pid

lsof -i:port

5.查看进程所占内存三种方式：  
1） top -p 进程号  
2） ps -aux | grep 进程名   
3） cat /proc/进程号/status  
VmSize(KB) 任务虚拟地址空间的大小 (total_vm-reserved_vm)，其中total_vm为进程的地址空间的大小，reserved_vm：进程在预留或特殊的内存间的物理页   
VmLck(KB) 任务已经锁住的物理内存的大小。锁住的物理内存不能交换到硬盘 (locked_vm)   
VmRSS(KB) 应用程序正在使用的物理内存的大小，就是用ps命令的参数rss的值 (rss)   
VmData(KB) 程序数据段的大小（所占虚拟内存的大小），存放初始化了的数据； (total_vm-shared_vm-stack_vm)   
VmStk(KB) 任务在用户态的栈的大小 (stack_vm)   
VmExe(KB) 程序所拥有的可执行虚拟内存的大小，代码段，不包括任务使用的库 (end_code-start_code)   
VmLib(KB) 被映像到任务的虚拟内存空间的库的大小 (exec_lib)   
VmPTE 该进程的所有页表的大小，单位：kb   
Threads 共享使用该信号描述符的任务的个数，在POSIX多线程序应用程序中，线程组中的所有线程使用同一个信号描述符  

1、VmRSS是真实正在占用的内存，而VmData是虚拟内存，大小差异大并没有什么问题。   
2、VmData是指数据段的内存大小，存放初始化了的数据； (total_vm-shared_vm-stack_vm)   
3、不调动态库的时候是不计算的(dlopen方式)   
4、静态库会编译为程序本身的一部分，不在VmLib的统计之内。   
5、参考上面的说明   
6、除非有非常明显的内存泄露，如内存一直大幅度增长并长时间不释放，否则单纯以来这些值是很判断真正的内在泄露。  

6.查看某个进程是否存在  
1)ps -ef | grep 进程号 | grep -v grep   
2)ps aux | grep 进程号 | grep -v grep 

7.查看某个程序是否已经安装  
rpm -qa XXX* 

8.关闭虚拟机防火墙

---
关闭/启动/重启命令：service iptables stop/stop/restart
永久关闭/启动防火墙：chkconfig iptables off/on
查看防火墙状态：service iptables stop

9.查看IO情况
diskio

10.查看CPU信息
cat /proc/cpuinfo

11.查看内存使用率
free -m/g

12.查看包含特殊字段的日志信息
tailf xxx.log | grep 关键字



