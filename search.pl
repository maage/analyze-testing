#!/usr/bin/perl -Tw

use Search::Elasticsearch;
 
# Connect to localhost:9200:
 
my $e = Search::Elasticsearch->new();

my $results = $e->search(
  index => 'my_index',
  body  => {
    query => {
      match => { },
    }
  }
);
