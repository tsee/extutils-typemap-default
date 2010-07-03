package ExtUtils::Typemap::Default;

use strict;
use warnings;
use ExtUtils::Typemap;

our $VERSION = '0.01';

our @ISA = qw(ExtUtils::Typemap);

=head1 NAME

ExtUtils::Typemap::Default - A set of useful typemaps

=head1 SYNOPSIS

  use ExtUtils::Typemap::Default;
  # First, read my own type maps:
  my $private_map = ExtUtils::Typemap->new(file => 'my.map');
  
  # Then, get the default set and merge it into my maps
  my $map = ExtUtils::Typemap::Default->new;
  $private_map->merge(typemap => $map);
  
  # Now, write the combined map to an output file
  $private_map->write(file => 'typemap');

=head1 DESCRIPTION

C<ExtUtils::Typemap::Default> is an C<ExtUtils::Typemap>
subclass that provides a set of default mappings (in addition to what
perl itself provides). These default mappings are currently defined
as the combination of the mappings provided by the
following typemap classes which are provided in this distribution:

L<ExtUtils::Typemap::ObjectMap>, L<ExtUtils::Typemap::STL::String>

=head1 METHODS

These are the overridden methods:

=head2 new

Creates a new C<ExtUtils::Typemap::Default> object.

=cut

sub new {
  my $class = shift;

  my $self = $class->SUPER::new(@_);
  $self->merge(typemap => ExtUtils::Typemap::ObjectMap->new);
  $self->merge(typemap => ExtUtils::Typemap::STL::String->new);

  return $self;
}

1;

__END__

=head1 SEE ALSO

L<ExtUtils::Typemap>, L<ExtUtils::Typemap::ObjectMap>, L<ExtUtils::Typemap::STL::String>

=head1 AUTHOR

Steffen Mueller <smueller@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 by Steffen Mueller

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
