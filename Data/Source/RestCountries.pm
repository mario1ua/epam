package Data::Source::RestCountries;

use strict;
use feature qw/say/;

use Data::Dumper;
use LWP::UserAgent;
use JSON;

sub new {
    my $class = shift;
    my %x= @_;
    my $x = \%x;

    $x->{ua} = LWP::UserAgent->new;

    bless $x, $class;

    return $x;
}

sub country {
    my $x = shift;
    my $country = shift;

    return shift JSON->new->decode($x->{ua}->get("https://restcountries.eu/rest/v1/name/".$country)->content);
}


1;
