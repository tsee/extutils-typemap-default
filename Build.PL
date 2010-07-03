#!/usr/bin/perl -w

use strict;
use Module::Build;

my $build = Module::Build->new(
  module_name    => 'ExtUtils::Typemap::Default',
  license        => 'perl',
  requires       => {
    'ExtUtils::Typemap' => '0.05',
  },
  build_requires => {
    'Module::Build' => '0',
  },
  test_requires  => {
    'Test::More' => '0',
  },
);

$build->create_build_script;
