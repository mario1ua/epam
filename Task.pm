package Task;

use strict;
use feature qw/say/;

use Data::Dumper;

use Data::Source::Args;
use Data::Source::File;
use Data::Source::RestCountries;

use Data::Parser;

$|++;


sub new {
    my $class = shift;
    my %x = @_;
    my $x = \%x;

    my %args = Data::Source::Args->new->hash;
    my $file = Data::Source::File->new(filename => $args{filename})->str;

    my $ah_cities = Data::Parser->new->parse( str=>$file, sep=>[qw( . , - )] )->hashes;

    my $city = (grep { $_->{City} eq $args{city} } @{$ah_cities})[0];


    $x->{args} = \%args;
    $x->{file} = $file;
    $x->{ah_cities} = $ah_cities;
    $x->{city} = $city;

    $x->{err} = "No city found '$x->{args}->{city}'" unless $city;

    bless $x, $class;

    return $x;
}

sub One {
    my $x = shift;

    say "\n\n=== Task 1:";
    $x->_error && return;

    say "Information for $x->{args}->{city}:";
    say $_.": ".$x->{city}->{$_} for (keys %{ $x->{city} });
}

sub Two {
    my $x = shift;

    say "\n\n=== Task 2:";
    $x->_error && return;

    say "\nInformation for all cities:";
    for my $city (@{ $x->{ah_cities} }) {
        say;
        say $_.": ".$city->{$_} for (sort keys %{$city});
    }
}

sub Three {
    my $x = shift;
    
    say "\n\n=== Task 3:";
    $x->_error && return;

    my $o_country = Data::Source::RestCountries->new->country($x->{city}->{Country});

    say "Information for $x->{args}->{city}:";
    say $_.": ".$x->{city}->{$_} for (keys %{ $x->{city} });

    if ($x->{city}->{City} eq $o_country->{capital}) {
        say "$x->{city}->{City}  is a capital of $x->{city}->{Country}";
        say "Country population: ". $o_country->{population};
    }
}

sub _error {
    my $x = shift;

    if($x->{err}) {
        say $x->{err};
        return 1;
    }
}
    
1;
