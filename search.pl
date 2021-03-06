#!/usr/bin/perl -Tw

use Search::Elasticsearch;
use Data::Dumper;
use JSON::XS;
use MIME::Base64;
 
# Connect to localhost:9200:
 
my $e = Search::Elasticsearch->new();
my $json = JSON::XS->new->pretty(1)->canonical(1)->ascii(1)->space_before(0);

if (0) {
my $results = $e->search(
  index => 'my_index',
  body  => {
    query => {
      term => { _type => 'my_type', },
    },
    fields => [qw'message minhash_value'],
  },
);
}

my $scroll = $e->scroll_helper(
  index       => 'my_index',
  search_type => 'scan',          # important!
  size        => 500,
  body        => {
    query => {
      term => { _type => 'my_type', },
    },
    fields => [qw'message minhash_value'],
  },
);

my %h;
my $maxlen = 128;
my $maxid = 0;
my @bfreq;

sub handle_doc {
  local $_ = shift;

  for my $v (@{$_->{fields}->{minhash_value}}) {
    my $bits = decode_base64($v);
    #print '>'.$bits."<\n";
    #$h{ $_->{_id} } = $bits;
    if (0) {
      my $bs = unpack('b*', $bits);
      my $len = length($bs);
      $maxlen = $len if (not defined $maxlen or $len > $maxlen);
    }
    for (my $i = 0; $i < $maxlen; $i++) {
      my $b = vec($bits, $i, 1);
      push @{$bfreq[$i][$b]}, $_->{_id};
      $bfreq{$i.' '.$b} ++;
    }
  }

  $maxid = $_->{_id} if ($_->{_id} > $maxid);
}

while (my $doc = $scroll->next) {
  #print $json->encode($doc);
  handle_doc($doc);
}

#print Dumper($results);
#print $json->encode($results);
#my %h;
#my $maxlen = 128;
#die unless (defined $results->{hits}->{hits});
#for (@{$results->{hits}->{hits}}) {
#  #print $json->encode($_);
#}
#print "maxlen: $maxlen\n";

my @c = (0 .. (int(($maxid-1)/10000)) );
for my $k (sort { $bfreq{$a} <=> $bfreq{$b} } keys %bfreq) {
  my ($i, $c) = split(/ /, $k, 2);
  my %cnt;
  for (@c) { $cnt{$_} = 0 };
  for my $id (@{$bfreq[$i][$c]}) {
    $cnt{ int(($id-1)/10000) } ++;
  }
  my @cnt = map { $cnt{$_} } @c;
  my @part = map { $cnt{$_} / $bfreq{$k} } @c;
  printf("%s %d %s %s\n", $k, $bfreq{$k}, join(' ', @cnt), join(' ', @part));
}

#print $json->encode(\@bfreq);
