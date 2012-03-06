#!/usr/bin/perl
use Getopt::Long::Descriptive::ManMaker;

my ($opt, $usage) = describe_options(
  'my-program %o <some-arg>',
  [ 'server|s=s', "the server to connect to"                  ],
  [ 'port|p=i',   "the port to connect to", { default => 79 } ],
  [],
  [ 'verbose|v',  "print extra stuff"            ],
  [ 'help',       "print usage message and exit" ],
);

__END__
=head1 NAME

test.t.pl - 

=head1 SYNOPSIS

 my-program [-psv] [long options...] <some-arg>
	-s --server     the server to connect to
	-p --port       the port to connect to
	              
	-v --verbose    print extra stuff
	--help          print usage message and exit

=head1 OPTIONS

I<server|s=s> => the server to connect to 

I<port|p=i> => the port to connect to { default => 79 }



I<verbose|v> => print extra stuff 

I<help> => print usage message and exit 
