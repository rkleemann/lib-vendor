#! /usr/bin/env perl

use Test::More tests => 5;

ok require lib::vendor, 'Required lib::vendor';
lib::vendor::shrink_INC(@INC);
my @old_INC = @INC;
ok( lib::vendor->import(), 'Import succeeds' );
my @new_INC = @INC;
unless (
is scalar @new_INC, 1 + scalar @old_INC,
    '@INC has one more entry: lib'
) {
    diag 'Old:';
    diag $_ for @old_INC;
    diag 'New:';
    diag $_ for @new_INC;
}

@old_INC = @new_INC;
lib::vendor->import('alpha');
@new_INC = @INC;
is scalar @new_INC, 1 + scalar @old_INC,
    '@INC has one more entry: vendor/alpha';

@old_INC = @new_INC;
lib::vendor->import( -vendor => '', 'bravo' );
@new_INC = @INC;
is scalar @new_INC, 1 + scalar @old_INC,
    '@INC has one more entry: bravo';

