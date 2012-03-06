package Getopt::Long::Descriptive::ManMaker;
use Data::Dump qw(pp);
use Carp;
use FindBin qw($Script);
our $VERSION='0.0.1';

BEGIN {
  use Sub::Install;
  use Getopt::Long::Descriptive;
  *Getopt::Long::Descriptive::ManMaker::describe_options_orig
     = \&Getopt::Long::Descriptive::describe_options;
  sub make_man {
   my $self = $_[0];
   my ($opt, $usage) = describe_options_orig(@_);

   open my $fh, "<", $0;
   my $content = do{local $/=undef; <$fh>};
   close $fh;

   # pod goes at the end
   unless ($content =~ m{^__END__$}ms){
       $content .= "\n__END__\n";
   }
   
   # TODO handle sections individually
   unless($content =~ m{=head1 NAME.*?^=head1 SYNOPSIS.*?^=head1 OPTIONS}ms){
   $content =~s{^__END__\n}{__END__
=head1 NAME

$Script - 

=head1 SYNOPSIS

=head1 OPTIONS

}ms;
  }
  # todo call Getopt::Long::Descriptive::describe_options for $usage
  $content =~ s{^=head1 SYNOPSIS.*?(\n^=|\z)}
               {"=head1 SYNOPSIS\n\n " . $usage->text . $1}ems;
  shift @_;
  $content =~ s{^=head1 OPTIONS.*?(\n^=|\z)}
   {"=head1 OPTIONS\n\n" .
    join("\n" => 
     map {(@$_? "I<" . shift(@$_). "> => ". shift(@$_). " " . (@$_? pp(@$_):""):"") . "\n" } @_
    )
    .$1
   }ems;

   if (-w $0){
      open my $w_fh, "+<", $0;
      print $w_fh $content;
      close $w_fh;
   }
  }
  Sub::Install::reinstall_sub({ 
    into => 'main',
    as  => 'describe_options',
    code => \&make_man ,
  });
}
1;
__END__
=head1 NAME

Getopt::Long::Descriptive::ManMaker - generate pod sections from G::L::D::describe_options

=head1 SYNOPSIS

 perl -MGetopt::Long::Descriptive::ManMaker getoptlongdescriptive_script.pl

=head1 DESCRIPTION

Getopt::Long::Descriptive::ManMaker generates pod sections NAME SYNOPSIS and OPTIONS from Getopt::Long::Descriptive::describe_options arguments.

This serves as autodocumentation for your script or at least a stub to begin with.

=head1 SEE ALSO

Getopt::Euclid - goes the other way round, write pod to generate the Getopt call, but forces you to write in an ugly looking DSL.

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to
C<bug-getopt-long-descriptive-manmaker@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

Joerg Meltzer C<< <joerg.meltzer@tngtech.com> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2011, Joerg Meltzer C<< <joerg.meltzer@tngtech.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
