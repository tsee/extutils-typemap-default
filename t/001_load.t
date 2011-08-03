#!/usr/bin/perl -w

use strict;
use Test::More tests => 23;

use_ok( 'ExtUtils::Typemaps::Default' );
use_ok( 'ExtUtils::Typemaps::STL' );
use_ok( 'ExtUtils::Typemaps::STL::String' );
use_ok( 'ExtUtils::Typemaps::STL::Vector' );
use_ok( 'ExtUtils::Typemaps::ObjectMap' );
use_ok( 'ExtUtils::Typemaps::Basic' );

my $omap = ExtUtils::Typemaps::ObjectMap->new();
isa_ok($omap, 'ExtUtils::Typemaps::ObjectMap');
isa_ok($omap, 'ExtUtils::Typemaps');

my $bmap = ExtUtils::Typemaps::Basic->new();
isa_ok($bmap, 'ExtUtils::Typemaps::Basic');
isa_ok($bmap, 'ExtUtils::Typemaps');

my $smap = ExtUtils::Typemaps::STL::String->new();
isa_ok($smap, 'ExtUtils::Typemaps::STL::String');
isa_ok($smap, 'ExtUtils::Typemaps');

my $vmap = ExtUtils::Typemaps::STL::Vector->new();
isa_ok($vmap, 'ExtUtils::Typemaps::STL::Vector');
isa_ok($vmap, 'ExtUtils::Typemaps');

my $stl = ExtUtils::Typemaps::STL->new;
isa_ok($stl, 'ExtUtils::Typemaps');

my $stlm = ExtUtils::Typemaps->new;
isa_ok($stlm, 'ExtUtils::Typemaps');
$stlm->merge(typemap => $smap);
$stlm->merge(typemap => $vmap);

ok($stl->as_string =~ /\S/);
is($stl->as_string, $stlm->as_string, "manually merged STL and STL are the same");

my $merged = ExtUtils::Typemaps->new;
isa_ok($merged, 'ExtUtils::Typemaps');
$merged->merge(typemap => $bmap);
$merged->merge(typemap => $omap);
$merged->merge(typemap => $stl);

my $def = ExtUtils::Typemaps::Default->new();
isa_ok($def, 'ExtUtils::Typemaps::Default');
isa_ok($def, 'ExtUtils::Typemaps');

ok($def->as_string =~ /\S/);
is($def->as_string, $merged->as_string, "manually merged and default are the same");

