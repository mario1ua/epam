package Data::Parser;

use strict;
use feature qw/say/;

use Data::Dumper;

sub new {
    my $class = shift;
    my $x = {@_};

    bless $x, $class;

    return $x;
}

sub pattern {
}

sub parse {
    my $x = shift;
    my %p = @_;

    my @lines = grep /\S/, split("\n", $p{str});
    my @header = $x->_split(str => shift @lines, sep => $p{sep});

    $x->{hashes} =  [ map { my %hash; @hash{@header} = @{$_}; \%hash } 
                    map { [$x->_split(str => $_, sep => $p{sep})] } @lines ];

    return $x;
}

sub hashes {
    my $x = shift;

    return $x->{hashes};
}

sub _split {
    my $x = shift;
    my %p = @_;

    return (ref $p{sep} eq 'ARRAY') ? $x->_split_multiple_sep(%p) : $x->_split_single_sep(%p);
}

sub _split_single_sep {
    my $x = shift;
    my %p = @_;

    return split(/\s*[$p{sep}]\s*/, $p{str});
}

sub _split_multiple_sep {
    my $x = shift;
    my %p = @_;

    my $str = $p{str};
    my $a_separators = $p{sep};
    
    my @splitted = ();
    my ($left, $right);
    for my $sep (@$a_separators){
        ($left, $right) = split(/\s*[$sep]\s*/, $str, 2);
        push @splitted, $left;
        $str = $right;
    }
    push @splitted, $right;

    return @splitted;
}

1;
