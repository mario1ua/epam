  1 package Data::Source::RestCountries;                                            
    2                                                                                 
      3 use strict;                                                                     
        4                                                                                 
          5 use Data::Dumper;                                                               
            6 use LWP::UserAgent;                                                             
              7                                                                                 
                8 sub new {                                                                       
                  9     my $class = shift;                                                          
                   10     my $x = {@_};                                                               
                    11                                                                                 
                     12     $x->{ua} = LWP::UserAgent->new;                                             
                      13                                                                                 
                       14     bless $x, $class;                                                           
                        15                                                                                 
                         16     return $x;                                                                  
                          17 }                                                                               
                           18                                                                                 
                            19 sub country {                                                                   
                             20     my $x = shift;                                                              
                              21     my %p = @_;                                                                 
                               22                                                                                 
                                23     my $country_json = $ua->get("https://restcountries.eu/rest/v1/name/" + $p->{country})->content;
                                 24                                                                                 
                                  25     print $country_json;                                                        
                                   26 }                                                                               
                                    27                                                                                 
                                     28                                                                                 
                                      29 1;   
