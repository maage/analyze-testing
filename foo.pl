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
  push @bulk,
    { index => { _id => $id } },
    { message => sprintf('Prefix something %f suffix other', rand(1000)), },
  ;
  $id ++;
  if (@bulk == 100) {
    index_bulk(\@bulk);
    print "\r$_     ";
  }
}
index_bulk(\@bulk) if (@bulk);
print "\n";

for (1..10000) {
  push @bulk,
    { index => { _id => $id } },
    { message => sprintf('ERROR: Why we get this, now %d %f', int($_/5), rand(1000)), },
  ;
  $id ++;
  if (@bulk == 100) {
    index_bulk(\@bulk);
    print "\r$_     ";
  }
}
index_bulk(\@bulk) if (@bulk);
print "\n";

for (1..10000) {
  push @bulk,
    { index => { _id => $id } },
    { message => sprintf('DEBUG: This message is entirely not for any use in any way.'), },
  ;
  $id ++;
  if (@bulk == 100) {
    index_bulk(\@bulk);
    print "\r$_     ";
  }
}
index_bulk(\@bulk) if (@bulk);
print "\n";
