#! /usr/bin/env perl

use Test::More tests => 12;

ok require lib::vendor, 'Required lib::vendor';

lib::vendor::shrink_INC(@INC);

foreach my $import (
    [],
    [ 't/vendor/alpha/lib', 'alpha' ],
    [ 't/bravo/lib', -vendor => '', 'bravo' ]
) {
    my $path = shift @$import;

    my @old_INC = @INC;
    ok( lib::vendor->import(@$import), 'Import succeeds' );
    my @new_INC = @INC;

    like $INC[0], qr!t/lib$!, "First entry in \@INC has t/lib";

    if ( $path ) {
        like $INC[1], qr!$path$!, "Next entry in \@INC has $path";
    }

    unless (
        is scalar @new_INC, 1 + scalar @old_INC,
            "\@INC has one more entry for @$import"
    ) {
        diag 'Old:';
        diag $_ for @old_INC;
        diag 'New:';
        diag $_ for @new_INC;
    }
}

