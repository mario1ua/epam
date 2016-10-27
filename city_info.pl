#!/usr/bin/env perl

use strict;
use feature qw(say);

use Data::Dumper;
use FindBin qw($Bin);
use lib "$Bin/dist";

use Task;

my $task = Task->new;
$task->Two;
$task->One; 
$task->Three;

