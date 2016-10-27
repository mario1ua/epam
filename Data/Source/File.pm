package Data::Source::File;

use strict;

use Data::Dumper;

sub new {
    my $class = shift;
    my %x = @_;
    my $x = \%x;

    open my $fh, '<', $x->{filename} or die "Error opening $x->{filename}: $!";
    $x->{str} = do { local $/; <$fh> };

    bless $x, $class;

    return $x;
}

sub str {
    my $x = shift;

    return chomp($x->{str}) && $x->{str};
}

sub array {
    my $x = shift;

    return split("\n", $x->str);
}


1;
