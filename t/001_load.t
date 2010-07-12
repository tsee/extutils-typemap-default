#!/usr/bin/perl -w

use strict;
use Test::More tests => 20;

use_ok( 'ExtUtils::Typemap::Default' );
use_ok( 'ExtUtils::Typemap::STL' );
use_ok( 'ExtUtils::Typemap::STL::String' );
use_ok( 'ExtUtils::Typemap::STL::Vector' );
use_ok( 'ExtUtils::Typemap::ObjectMap' );

my $omap = ExtUtils::Typemap::ObjectMap->new();
isa_ok($omap, 'ExtUtils::Typemap::ObjectMap');
isa_ok($omap, 'ExtUtils::Typemap');

my $smap = ExtUtils::Typemap::STL::String->new();
isa_ok($smap, 'ExtUtils::Typemap::STL::String');
isa_ok($smap, 'ExtUtils::Typemap');

my $vmap = ExtUtils::Typemap::STL::Vector->new();
isa_ok($vmap, 'ExtUtils::Typemap::STL::Vector');
isa_ok($vmap, 'ExtUtils::Typemap');

my $stl = ExtUtils::Typemap::STL->new;
isa_ok($stl, 'ExtUtils::Typemap');

my $stlm = ExtUtils::Typemap->new;
isa_ok($stlm, 'ExtUtils::Typemap');
$stlm->merge(typemap => $smap);
$stlm->merge(typemap => $vmap);

ok($stl->as_string =~ /\S/);
is($stl->as_string, $stlm->as_string, "manually merged STL and STL are the same");

my $merged = ExtUtils::Typemap->new;
isa_ok($merged, 'ExtUtils::Typemap');
$merged->merge(typemap => $omap);
$merged->merge(typemap => $stl);

my $def = ExtUtils::Typemap::Default->new();
isa_ok($def, 'ExtUtils::Typemap::Default');
isa_ok($def, 'ExtUtils::Typemap');

ok($def->as_string =~ /\S/);
is($def->as_string, $merged->as_string, "manually merged and default are the same");

