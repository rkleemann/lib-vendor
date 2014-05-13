#! /usr/bin/env perl

use Test::More tests => 5;

ok require lib::vendor, 'Required lib::vendor';

my @old_INC = @INC;
ok(lib::vendor->import(), 'Import succeeds');
my @new_INC = @INC;
is scalar @new_INC, 1 + scalar @old_INC, '@INC has one more entry';

@old_INC = @new_INC;
lib::vendor->import('alpha');
@new_INC = @INC;
is scalar @new_INC, 1 + scalar @old_INC, '@INC has one more entry';

@old_INC = @new_INC;
lib::vendor->import( -vendor => '', 'bravo' );
@new_INC = @INC;
is scalar @new_INC, 1 + scalar @old_INC, '@INC has one more entry';

