package ExtUtils::Typemap::Basic;

use strict;
use warnings;
use ExtUtils::Typemap;

our $VERSION = '0.03';

our @ISA = qw(ExtUtils::Typemap);

=head1 NAME

ExtUtils::Typemap::Basic - A set of typemaps for simple types

=head1 SYNOPSIS

  use ExtUtils::Typemap::Basic;
  # First, read my own type maps:
  my $private_map = ExtUtils::Typemap->new(file => 'my.map');
  
  # Then, get additional typemaps and merge them into mine
  $private_map->merge(typemap => ExtUtils::Typemap::Basic->new);
  
  # Now, write the combined map to an output file
  $private_map->write(file => 'typemap');

=head1 DESCRIPTION

C<ExtUtils::Typemap::Basic> is an C<ExtUtils::Typemap>
subclass that provides a set of mappings for some basic
integer, unsigned, and floating point types that aren't
in perl's builtin typemap.

=head1 METHODS

These are the overridden methods:

=head2 new

Creates a new C<ExtUtils::Typemap::Basic> object.
It acts as any other C<ExtUtils::Typemap> object, except that
it has the object maps initialized.

=cut

sub new {
  my $class = shift;

  my @iv_types = (qw(int short long char), "short int", "long int", "long long");
  my @uv_types = ((map {"unsigned $_"} @iv_types), qw(unsigned Uint16 Uint32 Uint64));
  @iv_types = map {($_, "signed $_")} @iv_types;
  push @iv_types, qw(time_t size_t Sint16 Sint32 Sint64);
  my @nv_types = (qw(float double), "long double");

  my $map = "TYPEMAP\n";
  $map .= "$_\tT_IV\n" for @iv_types;
  $map .= "$_\tT_UV\n" for @uv_types;
  $map .= "$_\tT_NV\n" for @nv_types;

  $map .= "const $_\tT_IV\n" for @iv_types;
  $map .= "const $_\tT_UV\n" for @uv_types;
  $map .= "const $_\tT_NV\n" for @nv_types;

  my $self = $class->SUPER::new(@_);
  $self->add_string(string => $map);

  return $self;
}

1;

__END__

=head1 SEE ALSO

L<ExtUtils::Typemap>, L<ExtUtils::Typemap::Default>

=head1 AUTHOR

Steffen Mueller <smueller@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 by Steffen Mueller

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
