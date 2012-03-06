#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Getopt::Long::Descriptive::ManMaker' ) || print "Bail out!\n";
}

diag( "Testing Getopt::Long::Descriptive::ManMaker $Getopt::Long::Descriptive::ManMaker::VERSION, Perl $], $^X" );
