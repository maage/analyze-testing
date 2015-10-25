#!/usr/bin/perl -Tw

use Search::Elasticsearch;
use Data::Dumper;
 
# Connect to localhost:9200:
 
my $e = Search::Elasticsearch->new();

sub index_bulk {
  my $bulk = shift;
  my $r = $e->bulk(
    index => 'my_index',
    type => 'my_type',
    body => $bulk,
  );
  #print Dumper($r);
  @{$bulk} = ();
}

$| = 1;

my @bulk;
my $id = 1;
print "0";
for (1..10000) {
  print "\r$_     ";
  push @bulk,
    { index => { _id => $id } },
    { message => sprintf('Prefix something %f suffix other', rand(1000)), },
  ;
  $id ++;
  index_bulk(\@bulk) if (@bulk == 100);
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
index_bulk(\@bulk) if (@bulk);
for (1..10000) {
  print "\r$_     ";
  push @bulk,
    { index => { _id => $id } },
    { message => sprintf('ERROR: Why we get this, now %d %f', int($_/5), rand(1000)), },
  ;
  $id ++;
  index_bulk(\@bulk) if (@bulk == 100);
}
index_bulk(\@bulk) if (@bulk);
print "\n";
