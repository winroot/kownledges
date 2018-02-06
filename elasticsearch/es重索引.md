将原来某个索引的数据全部迁移到另外一个索引上面
```
POST _reindex
{
"source": {
"index": "twitter"
},
"dest": {
"index": "new_twitter"
}
}
```
