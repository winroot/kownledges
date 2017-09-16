#elasticsearch、solr对比

**Elasticsearch的优缺点**:  
**优点**  


- Elasticsearch是分布式的。不需要其他组件，分发是实时的，被叫做”Push replication”。
- Elasticsearch 完全支持 Apache Lucene 的接近实时的搜索。
- 处理多租户（multitenancy）不需要特殊配置，而Solr则需要更多的高级设置。
- Elasticsearch 采用 Gateway 的概念，使得完备份更加简单。
- 各节点组成对等的网络结构，某些节点出现故障时会自动分配其他节点代替其进行工作。
- ---
**缺点** 
   
- 只有一名开发者（当前Elasticsearch GitHub组织已经不只如此，已经有了相当活跃的维护者）
- 还不够自动（不适合当前新的Index Warmup API）

---
**Solr的优缺点**  
**优点**  


- Solr有一个更大、更成熟的用户、开发和贡献者社区。
- 支持添加多种格式的索引，如：HTML、PDF、微软 Office 系列软件格式以及 JSON、XML、CSV 等纯文本格式。
- Solr比较成熟、稳定。
- 不考虑建索引的同时进行搜索，速度更快。  
  
**缺点**

- 建立索引时，搜索效率下降，实时索引搜索效率不高。

**Elasticsearch与Solr的比较**  
当单纯的对已有数据进行搜索时，Solr更快。
![](https://i.imgur.com/hvU6yud.png)
当实时建立索引时, Solr会产生io阻塞，查询性能较差, Elasticsearch具有明显的优势。
![](https://i.imgur.com/PNOrg3e.png)
随着数据量的增加，Solr的搜索效率会变得更低，而Elasticsearch却没有明显的变化。
![](https://i.imgur.com/KEirAfw.png)

参考：[http://www.cnblogs.com/chowmin/articles/4629220.html](http://www.cnblogs.com/chowmin/articles/4629220.html)