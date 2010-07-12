package ExtUtils::Typemap::STL::Vector;

use strict;
use warnings;
use ExtUtils::Typemap;

our $VERSION = '0.02';

our @ISA = qw(ExtUtils::Typemap);

=head1 NAME

ExtUtils::Typemap::STL::Vector - A set of typemaps for STL std::vectors

=head1 SYNOPSIS

  use ExtUtils::Typemap::STL::Vector;
  # First, read my own type maps:
  my $private_map = ExtUtils::Typemap->new(file => 'my.map');
  
  # Then, get the object map set and merge it into my maps
  $private_map->merge(typemap => ExtUtils::Typemap::STL::Vector->new);
  
  # Now, write the combined map to an output file
  $private_map->write(file => 'typemap');

=head1 DESCRIPTION

C<ExtUtils::Typemap::STL::Vector> is an C<ExtUtils::Typemap>
subclass that provides a set of mappings for C++ STL vectors.
These are:

  TYPEMAP
  std::vector<double> T_STD_VECTOR_DOUBLE
  std::vector<double>* T_STD_VECTOR_DOUBLE_PTR
  std::vector<int> T_STD_VECTOR_INT
  std::vector<int>* T_STD_VECTOR_INT_PTR
  std::vector<unsigned int> T_STD_VECTOR_UINT
  std::vector<unsigned int>* T_STD_VECTOR_UINT_PTR

All of these mean that the vectors are converted to references
to Perl arrays and vice versa.

=head1 METHODS

These are the overridden methods:

=head2 new

Creates a new C<ExtUtils::Typemap::STL::Vector> object.
It acts as any other C<ExtUtils::Typemap> object, except that
it has the string type maps initialized.

=cut

sub new {
  my $class = shift;

  my $self = $class->SUPER::new(@_);
  my $input_tmpl = <<'HERE';
!TYPENAME!
	if (SvROK($arg) && SvTYPE(SvRV($arg))==SVt_PVAV) {
	  AV* av = (AV*)SvRV($arg);
	  const unsigned int len = av_len(av)+1;
	  $var = std::vector<!TYPE!>(len);
	  for (unsigned int i = 0; i < len; i++) {
	    SV** elem;
	    elem = av_fetch(av, i, 0);
	    if (elem != NULL)
	      $var[i] = Sv!SHORTTYPE!V(*elem);
	    else
	      $var[i] = !DEFAULT!;
	  }
	}
	else
	  Perl_croak(aTHX_ \"%s: %s is not an array reference\",
	             ${$ALIAS?\q[GvNAME(CvGV(cv))]:\qq[\"$pname\"]},
	             \"$var\");

!TYPENAME!_PTR
	if (SvROK($arg) && SvTYPE(SvRV($arg))==SVt_PVAV) {
	  AV* av = (AV*)SvRV($arg);
	  const unsigned int len = av_len(av)+1;
	  $var = new std::vector<!TYPE!>(len);
	  for (unsigned int i = 0; i < len; i++) {
	    SV** elem;
	    elem = av_fetch(av, i, 0);
	    if (elem != NULL)
	      (*$var)[i] = Sv!SHORTTYPE!V(*elem);
	    else
	      (*$var)[i] = 0.;
	  }
	}
	else
	  Perl_croak(aTHX_ \"%s: %s is not an array reference\",
	             ${$ALIAS?\q[GvNAME(CvGV(cv))]:\qq[\"$pname\"]},
	             \"$var\");

HERE

  my $output_tmpl = <<'HERE';
!TYPENAME!
	AV* av = newAV();
	$arg = newRV_noinc((SV*)av);
	const unsigned int len = $var.size();
	av_extend(av, len-1);
	for (unsigned int i = 0; i < len; i++) {
	  av_store(av, i, newSV!SHORTTYPELC!v($var[i]));
	}

!TYPENAME!_PTR
	AV* av = newAV();
	$arg = newRV_noinc((SV*)av);
	const unsigned int len = $var->size();
	av_extend(av, len-1);
	for (unsigned int i = 0; i < len; i++) {
	  av_store(av, i, newSV!SHORTTYPELC!v((*$var)[i]));
	}

HERE

  my ($output_code, $input_code);
  # TYPENAME, TYPE, SHORTTYPE, SHORTTYPELC, DEFAULT
  foreach my $type ([qw(T_STD_VECTOR_DOUBLE double N n 0.)],
                    [qw(T_STD_VECTOR_INT int I i 0)],
                    [qw(T_STD_VECTOR_UINT), "unsigned int", qw(U u 0)])
  {
    my @type = @$type;
    my $otmpl = $output_tmpl;
    my $itmpl = $input_tmpl;

    for ($otmpl, $itmpl) {
      s/!TYPENAME!/$type[0]/g;
      s/!TYPE!/$type[1]/g;
      s/!SHORTTYPE!/$type[2]/g;
      s/!SHORTYPELC!/$type[3]/g;
      s/!DEFAULT!/$type[4]/g;
    }

    $output_code .= $otmpl;
    $input_code  .= $itmpl;
  }


  my $typemap_code = <<'END_TYPEMAP';
TYPEMAP
std::vector< double >*	T_STD_VECTOR_DOUBLE_PTR
std::vector<double>*	T_STD_VECTOR_DOUBLE_PTR
std::vector< double >	T_STD_VECTOR_DOUBLE
std::vector<double>	T_STD_VECTOR_DOUBLE
std::vector< int >*	T_STD_VECTOR_INT_PTR
std::vector<int>*	T_STD_VECTOR_INT_PTR
std::vector< int >	T_STD_VECTOR_INT
std::vector<int>	T_STD_VECTOR_INT
std::vector< unsigned int >*	T_STD_VECTOR_UINT_PTR
std::vector<unsigned int>*	T_STD_VECTOR_UINT_PTR
std::vector< unsigned int >	T_STD_VECTOR_UINT
std::vector<unsigned int>	T_STD_VECTOR_UINT

INPUT
END_TYPEMAP
  $typemap_code .= $input_code;
  $typemap_code .= "\nOUTPUT\n";
  $typemap_code .= $output_code;
  $typemap_code .= "\n";

  $self->add_string(string => $typemap_code);

  return $self;
}

1;

__END__

=head1 SEE ALSO

L<ExtUtils::Typemap>, L<ExtUtils::Typemap::Default>, L<ExtUtils::Typemap::ObjectMap>,
L<ExtUtils::Typemap::STL>, L<ExtUtils::Typemap::STL::String>

=head1 AUTHOR

Steffen Mueller <smueller@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 by Steffen Mueller

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
