#加快git push\pull\clone等操作速度
git clone 特别慢是因为github.global.ssl.fastly.Net域名被限制了。只要找到这个域名对应的ip地址，然后在hosts文件中加上ip–>域名的映射，刷新DNS缓存就可以了：

1.查找ip：nslookup github.global.ssl.fastly.Net。   
2.修改host文件：host文件在Windows的路径为C:\Windows\System32\drivers\etc，直接用记事本打开修改即可  
`151.101.72.249 github.global.ssl.fastly.net  `   
3.修改完之后刷新DNS缓存：ipconfig /flushdns 
