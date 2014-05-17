#! /usr/bin/env perl

use Test::More tests => 13;

ok require lib::vendor, 'Required lib::vendor';

my $INC_size = @INC;
@INC = (@INC, @INC);
cmp_ok lib::vendor::shrink_INC(), '<=', $INC_size, 'shrink_INC worked';

foreach my $import (
    [],
    [ File::Spec->catdir( qw(t vendor alpha lib) ), 'alpha' ],
    [ File::Spec->catdir( qw(t bravo lib) ), -vendor => '', 'bravo' ]
) {
    my $path = shift @$import;

    my @old_INC = @INC;
    ok( lib::vendor->import(@$import), 'Import succeeds' );
    my @new_INC = @INC;

    my $tlib = File::Spec->catdir( qw(t lib) );
    like $INC[0], qr!\Q$tlib\E$!, "First entry in \@INC has t/lib";

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

