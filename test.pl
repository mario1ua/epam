#!/usr/bin/perl

use strict;
use Data::Dumper;

my @a = qw(a b c);

p(a=>'aa', b=>'ba');

sub p {
    my $x = {@_};
    print Dumper($x);
}
