package Data::Source::Args;

use strict;
use feature qw(say);

use Getopt::Long;

sub new {
    my $class=shift;
    my $x = {
        arg_hash => {}
    };

    my $name;
    my @value = ();
    my %args;

    for my $arg (@ARGV) {
        if ($arg =~ /^--(.*)/) {
            $args{$name} = join(' ', @value) if $name;
            $name = $1;
            @value = ();
        } 
        else {
            push @value, $arg;
        }
    } 
    $args{$name} = join(' ', @value);

    $x->{arg_hash} = \%args;

    bless $x, $class;
    
    return $x;
}

sub hashref {
    my $x = shift;

    return $x->{arg_hash};
}

sub hash {
    my $x = shift;

    return %{$x->{arg_hash}};
}

1;
