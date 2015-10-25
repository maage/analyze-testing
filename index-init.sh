#!/bin/bash -ex
curl -XDELETE localhost:9200/my_index?pretty
curl -XPUT localhost:9200/my_index?pretty -d @my_index.json 
curl localhost:9200/my_index?pretty
curl -XPUT localhost:9200/my_index/_mapping/my_type?pretty -d @./my_type-mapping.json 
curl localhost:9200/my_index/_mapping/my_type?pretty

