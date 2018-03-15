# Spark的stage & job & task 到底是什么 ,以及划分原理

Stage 是spark 中一个非常重要的概念 ，
在一个job 中划分stage 的一个重要依据是否有shuflle 发生(更严格的说是宽依赖) ，也就是是否会发生数据的重组 （重新组织数据）。

在一个stage 内部会有很多的task 被执行，在同一个stage 中 所有的task 结束后才能根据DAG 依赖执行下一个stage 中的task.

job 有很多任务组成，每组任务可以是一个stage   
Task 是spark 中另一个很重要的概念 ，
task 跟 partition  block 等概念紧密相连 ，task 是执行job 的逻辑单元 ，在task 会在每个executor 中的cpu core 中执行  

Job 是一个比task 和 stage 更大的逻辑概念，
job 可以认为是我们在driver 或是通过spark-submit 提交的程序中一个action ，在我们的程序中有很多action  所有也就对应很多的jobs
