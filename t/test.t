#!/usr/bin/perl
use File::Copy qw(cp);
use FindBin qw($Bin $Script);
use Test::More;
use Test::File::Contents;


cp("$Bin/$Script.pl.ref", "$Bin/$Script.pl");
my $path = File::Spec->catfile($Bin, "..", "lib");
system $^X, "-Mlib=$path", "$Bin/$Script.pl";

file_contents_like "$Bin/$Script.pl", qr/(?ms)help\s+print/, "pod added SYNOPSIS";
file_contents_like "$Bin/$Script.pl", qr/(?ms)I<help> =>/, "pod added OPTIONS";

done_testing();
