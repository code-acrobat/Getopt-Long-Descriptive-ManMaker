use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Getopt::Long::Descriptive::ManMaker',
    AUTHOR              => q{Jörg Meltzer <joerg.meltzer@tngtech.com>},
    VERSION_FROM        => 'lib/Getopt/Long/Descriptive/ManMaker.pm',
    ABSTRACT_FROM       => 'lib/Getopt/Long/Descriptive/ManMaker.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Getopt-Long-Descriptive-ManMaker-*' },
);
