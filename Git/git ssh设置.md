#创建和使用git ssh key

**首先设置git的user name和email：**

    git config --global user.name "xxx"
    git config --global user.email "xxx@gmail.com"

**查看git配置：**

    git config --list

**然后生成SHH密匙：**

查看是否已经有了ssh密钥：cd ~/.ssh
如果没有密钥则不会有此文件夹，有则备份删除  

**生存密钥：**

    ssh-keygen -t rsa -C "xxx@gmail.com"
**按3个回车，密码为空这里一般不使用密钥。**

最后得到了两个文件：id_rsa和id_rsa.pub
注意：密匙生成就不要改了，如果已经生成到~/.ssh文件夹下去找。

**登陆Github, 添加 ssh**  

    复制id_rsa.pub文件里的内容复制到 github-》setting-》ssh keys

**修改.git文件夹下config中的url**
*使用https协议，每次都要填写用户名密码，使用git协议则不用*

修改前

    [remote "origin"]
    url = https://github.com/humingx/humingx.github.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
修改后

    [remote "origin"]
    url = git@github.com:humingx/humingx.github.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*