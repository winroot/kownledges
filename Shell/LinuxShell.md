# Linux常用命令
***
1.设置某个文件中某个参数的值

cat /etc/sysctl.conf | grep vm.max_map_countvm.max_map_count=262144

2.查看最新的日志文件 

tailf xxx.log

3.杀掉进程

kill -9 pid(进程号)

4.查看进程pid

lsof -i:port
