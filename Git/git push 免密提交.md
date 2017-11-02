##解决git push到github时每次都要输入用户名和密码问题

**使用命令**

.gitconfig 文件中添加

    [credential]
    helper = store

或者在git bash 中执行设置记住密码（默认15分钟）：

    git config –global credential.helper cache

如果想自己设置时间，可以这样做：
    
    git config credential.helper ‘cache –timeout=3600’ 

这样就设置一个小时之后失效

长期存储密码：

    git config –global credential.helper store

**使用ssh方式**  
1、在每次push 的时候，都要输入用户名和密码，是不是很麻烦？原因是使用了https方式 push，在git bash里边输入:

    git remote -v

会出现https打头的github连接地址

2、接下来，我们把它换成ssh方式的。

    $ git remote rm origin
    $ git remote add origin git@github.com:sosout/myblog.git
    $ git push origin
    
3、上述的前提是已经添加ssh key,如果没有的话需要在github中配置ssh key