#!/usr/bin/perl -w

use strict;
use Module::Build;

my $build = Module::Build->new(
  module_name    => 'ExtUtils::Typemaps::Default',
  license        => 'perl',
  requires       => {
    'ExtUtils::Typemaps' => '3.21',
  },
  build_requires => {
    'Module::Build' => '0',
  },
  test_requires  => {
    'Test::More' => '0',
  },
  meta_merge => {
    'resources' => {
      'repository' => {
        type => 'git',
        web  => 'https://github.com/tsee/extutils-typemap-default',
        url  => 'https://github.com/tsee/extutils-typemap-default.git',
      },
    },
  },
);

$build->create_build_script;
