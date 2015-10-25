#!/usr/bin/perl -Tw

use Search::Elasticsearch;
use Data::Dumper;
 
# Connect to localhost:9200:
 
my $e = Search::Elasticsearch->new();

$| = 1;
my @bulk;
print "0";
for (1..10000) {
  print "\r$_";
  push @bulk,
    { index => { _id => $_ } },
    { message => sprintf('Prefix something %f suffix other', rand(1000)), },
  ;
  if (@bulk == 100) {
    my $r = $e->bulk(
      index => 'my_index',
      type => 'my_type',
      body => \@bulk,
    );
    print Dumper($r);
    @bulk = ();
  }
  if (0) {
    $e->index(
      index => 'my_index',
      type => 'my_type',
      id => $_,
      body => {
        message => sprintf('Prefix something %f suffix other', rand(1000)),
      },
    );
  }
}
if (@bulk) {
  my $r = $e->bulk(
    index => 'my_index',
    type => 'my_type',
    body => \@bulk,
  );
  print Dumper($r);
  @bulk = ();
}
print "\n";
