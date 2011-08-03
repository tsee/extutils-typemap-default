package ExtUtils::Typemap::STL;

use strict;
use warnings;
use ExtUtils::Typemap;
use ExtUtils::Typemap::STL::Vector;
use ExtUtils::Typemap::STL::String;

our $VERSION = '0.06';

our @ISA = qw(ExtUtils::Typemap);

=head1 NAME

ExtUtils::Typemap::STL - A set of useful typemaps for STL

=head1 SYNOPSIS

  use ExtUtils::Typemap::STL;
  # First, read my own type maps:
  my $private_map = ExtUtils::Typemap->new(file => 'my.map');
  
  # Then, get the STL set and merge it into my maps
  my $map = ExtUtils::Typemap::STL->new;
  $private_map->merge(typemap => $map);
  
  # Now, write the combined map to an output file
  $private_map->write(file => 'typemap');

=head1 DESCRIPTION

C<ExtUtils::Typemap::STL> is an C<ExtUtils::Typemap>
subclass that provides a few of default mappings for Standard Template Library
types. These default mappings are currently defined
as the combination of the mappings provided by the
following typemap classes which are provided in this distribution:

L<ExtUtils::Typemap::STL::Vector>, L<ExtUtils::Typemap::STL::String>

More are to come, patches are welcome.

=head1 METHODS

These are the overridden methods:

=head2 new

Creates a new C<ExtUtils::Typemap::STL> object.

=cut

sub new {
  my $class = shift;

  my $self = $class->SUPER::new(@_);
  $self->merge(typemap => ExtUtils::Typemap::STL::String->new);
  $self->merge(typemap => ExtUtils::Typemap::STL::Vector->new);

  return $self;
}

1;

__END__

=head1 SEE ALSO

L<ExtUtils::Typemap>, L<ExtUtils::Typemap::Default>

L<ExtUtils::Typemap::STL::String>,
L<ExtUtils::Typemap::STL::Vector

=head1 AUTHOR

Steffen Mueller <smueller@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 by Steffen Mueller

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
