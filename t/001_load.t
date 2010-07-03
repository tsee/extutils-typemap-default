#!/usr/bin/perl -w

use strict;
use Test::More tests => 12;

use_ok( 'ExtUtils::Typemap::STL::String' );
use_ok( 'ExtUtils::Typemap::ObjectMap' );
use_ok( 'ExtUtils::Typemap::Default' );

my $omap = ExtUtils::Typemap::ObjectMap->new();
isa_ok($omap, 'ExtUtils::Typemap::ObjectMap');
isa_ok($omap, 'ExtUtils::Typemap');

my $smap = ExtUtils::Typemap::STL::String->new();
isa_ok($smap, 'ExtUtils::Typemap::STL::String');
isa_ok($smap, 'ExtUtils::Typemap');

my $merged = ExtUtils::Typemap->new;
isa_ok($merged, 'ExtUtils::Typemap');
$merged->merge(typemap => $omap);
$merged->merge(typemap => $smap);

my $def = ExtUtils::Typemap::Default->new();
isa_ok($def, 'ExtUtils::Typemap::Default');
isa_ok($def, 'ExtUtils::Typemap');

ok($def->as_string =~ /\S/);
is($def->as_string, $merged->as_string, "manually merged and default are the same");

