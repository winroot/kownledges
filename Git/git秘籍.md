`[TOC]`

# **git 操作命令大全**


## git 常用命令：

    【查看分支】：git branch (-v包含注释)   
    
    【查看远程分支】：git branch -r(v)   
    
    【查看所有远程和本地分支】：git branch -a(v)      
     
    【创建分支】：git branch <name>   
    
    【切换分支】：git checkout <name>   
    
    【创建+切换分支】：git checkout -b <name>   
    
    【合并某分支到当前分支】：git merge <name>   
    
    【删除分支】：git branch -d <name> 或者 git branch -D <name>     
    
    【删除远程分支】git branch -r -d <name> 或者 git push origin :<name>(origin后面有空格)  
    

## 分支创建与管理     
**创建dev分支，然后切换到dev分支：**

    $ git checkout -b dev
    Switched to a new branch 'dev'

**git checkout命令加上-b参数表示创建并切换，相当于以下两条命令：**
    
    $ git branch dev
    $ git checkout dev
    Switched to branch 'dev'

**合并dev分支，请注意--no-ff参数，表示禁用Fast forward()：**
    
    $ git merge --no-ff -m "merge with no-ff" dev
    Merge made by the 'recursive' strategy.
     readme.txt |1 +
     1 file changed, 1 insertion(+)

 **删除分支**
    
    $ git branch -d feature-vulcan
    error: The branch 'feature-vulcan' is not fully merged.
    If you are sure you want to delete it, run 'git branch -D feature-vulcan'.
    
销毁失败。Git友情提醒，feature-vulcan分支还没有被合并，如果删除，将丢失掉修改，如果要强行删除，需要使用命令git branch -D feature-vulcan。

强行删除：
    
        $ git branch -D feature-vulcan
        Deleted branch feature-vulcan (was 756d4af).
       
【git 删除本地分支】

       git branch -d(D) br

【git 删除远程分支】

    git push origin :br  (origin 后面有空格)
    或者：  
    git branch -r -d origin/branch-name  

## github 更新fork分支
在github上开发代码的时候我们习惯的是fork一个分支，然后修改再往主分支push request，这样就可以保证多人开发，

但是随着时间的推移，自己fork的版本和主分支的版本差异越来越大; 这时我们就需要从远程分支更新代码并且更新到本地分支

下面简单以etcd为例说明下如何更新：

    git remote add upstream git@github.com:coreos/etcd.git（此为github远程主仓库地址）
    git fetch upstream
    git merge upstream/master
    git push

**git拉取远程分支并创建本地分支**

**查看远程分支

使用如下git命令查看所有远程分支：

    git branch -r


**拉取远程分支并创建本地分支**

**方法一**

使用如下命令：

    git checkout -b 本地分支名x origin/远程分支名x

使用该方式会在本地新建分支x，并自动切换到该本地分支x。

采用此种方法建立的本地分支会和远程分支建立映射关系。  

**方式二**

使用如下命令：

    git fetch origin 远程分支名x:本地分支名x

使用该方式会在本地新建分支x，但是不会自动切换到该本地分支x，需要手动checkout。

采用此种方法建立的本地分支不会和远程分支建立映射关系。


## git 本地代码回滚和远程代码库回滚

git代码库回滚: 指的是将代码库某分支退回到以前的某个commit id

【本地代码库回滚】：

    git reset--hard commit-id :回滚到commit-id，讲commit-id之后提交的commit都去除
    
    git reset --hard HEAD~3：将最近3次的提交回滚

【远程代码库回滚】：

这个是重点要说的内容，过程比本地回滚要复杂

应用场景：自动部署系统发布后发现问题，需要回滚到某一个commit，再重新发布

原理：先将本地分支退回到某个commit，删除远程分支，再重新push本地分支

操作步骤：

    1、git checkout the_branch
    
    2、git pull
    
    3、git branch the_branch_backup //备份一下这个分支当前的情况
    
    4、git reset --hard the_commit_id //把the_branch本地回滚到the_commit_id
    
    5、git push origin :the_branch //删除远程 the_branch
    
    6、git push origin the_branch //用回滚后的本地分支重新建立远程分支
    
    7、git push origin :the_branch_backup //如果前面都成功了，删除这个备份分支

## 删除已经commit的文件
    git checkout filename
    
## 删除所有数据
当我们需要删除暂存区或分支上的文件, 同时工作区也不需要这个文件了, 可以使用：
  
    git rm file_path

## 删除暂存区和分支文件，在本地保留

    git rm --cached file_path

## 谁动了我的代码？
当事情出了乱子时立马责怪别人这是人类的天性。如果你的服务器程序不能正常工作了，要找出罪魁祸首是非常简单的--只需要执行git blame。这个命令告诉你文件里的每一行的作者是谁，最后改动那一行的提交，以及提交的时间戳。  
    `git blame [file_name]`
    

## github pull request 冲突解决办法

![](https://i.imgur.com/gZWF0Hq.png)

## 远程分支不存在时，如何将本地分支push到远程

    git push --set-upstream origin br
    
## bug 分支创建与管理 
每个bug都可以通过一个新的临时分支来修复，修复后，合并分支，然后将临时分支删除。  
**stash**
当你接到一个修复一个代号101的bug的任务时，很自然地，你想创建一个分支issue-101来修复它，但是，等等，当前正在dev上进行的工作还没有提交：

    $ git status
    # On branch dev
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #   new file:   hello.py
    #
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #   modified:   readme.txt
    #
并不是你不想提交，而是工作只进行到一半，还没法提交，预计完成还需1天时间。但是，必须在两个小时内修复该bug，怎么办？

幸好，Git还提供了一个stash功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
    
    $ git stash
    Saved working directory and index state WIP on dev: 6224937 add merge
    HEAD is now at 6224937 add merge
现在，用git status查看工作区，就是干净的（除非有没有被Git管理的文件），因此可以放心地创建分支来修复bug。

首先确定要在哪个分支上修复bug，假定需要在master分支上修复，就从master创建临时分支：

    $ git checkout master
    Switched to branch 'master'
    Your branch is ahead of 'origin/master' by 6 commits.
    
    $ git checkout -b issue-101
    Switched to a new branch 'issue-101'
现在修复bug，需要把“Git is free software ...”改为“Git is a free software ...”，然后提交：
    
    $ git add readme.txt 
    
    $ git commit -m "fix bug 101"
    [issue-101 cc17032] fix bug 101
     1 file changed, 1 insertion(+), 1 deletion(-)
     
修复完成后，切换到master分支，并完成合并，最后删除issue-101分支：

    $ git checkout master
    Switched to branch 'master'
    Your branch is ahead of 'origin/master' by 2 commits.
    
    $ git merge --no-ff -m "merged bug fix 101" issue-101
    Merge made by the 'recursive' strategy.
     readme.txt |2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
     
    $ git branch -d issue-101
    Deleted branch issue-101 (was cc17032).
    
切换回dev分支继续原来的工作：
   
    $ git checkout dev
    Switched to branch 'dev'
    
    $ git status
    # On branch dev
    nothing to commit (working directory clean)
    
工作区是干净的，刚才的工作现场存到哪去了？用git stash list命令看看：

    $ git stash list
    stash@{0}: WIP on dev: 6224937 add merge
    
工作现场还在，Git把stash内容存在某个地方了，但是需要恢复一下，有两个办法：

(1)一是用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除；

(2)另一种方式是用git stash pop，恢复的同时把stash内容也删了：

$ git stash pop

    # On branch dev
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #   new file:   hello.py
    #
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #   modified:   readme.txt
    #

    Dropped refs/stash@{0} (f624f8e5f082f2df2bed8a4e09c12fd2943bdd40)
    
再用git stash list查看，就看不到任何stash内容了：
    
    $ git stash list
    
你可以多次stash，恢复的时候，先用git stash list查看，然后恢复指定的stash，用命令：

    $ git stash apply stash@{0}

