package lib::vendor;

use strict;

use Cwd         ();
use FindBin     ();
use File::Spec  ();

sub import {
    my ( $package, @vendors ) = @_;

    for my $vendor (@vendors) {
        $vendor = Cwd::abs_path(
            File::Spec->catdir( $FindBin::RealBin, "../vendor/$vendor/lib" )
        );
    }
    unshift @vendors,
        Cwd::abs_path( File::Spec->catdir( $FindBin::RealBin, "../lib" ) );

    require lib;
    lib->import(@vendors);
}

1;

__END__

=head1 NAME

lib::vendor - add vendor libraries to the module search path

=head1 SYNOPSIS

  # Include only $FindBin::RealBin/../lib in module search path.
  use lib::vendor;

or

  # Include in module search path:
  # $FindBin::RealBin/../lib,
  # $FindBin::RealBin/../vendor/core/lib 
  use lib::vendor qw(core);

or

  # Include in module search path:
  # $FindBin::RealBin/../lib,
  # $FindBin::RealBin/../vendor/core/lib,
  # $FindBin::RealBin/../vendor/common/lib,
  # $FindBin::RealBin/../vendor/mongodb/lib,
  # $FindBin::RealBin/../vendor/rabbitmq/lib
  use lib::vendor qw(core common mongodb rabbitmq);

or

  # Do nothing
  use lib::vendor ();

=head1 DESCRIPTION

Locates the full path to the script home and adds its lib directory to the
library search path, plus any vendor library directories specified.

=head1 AUTHOR

Bob Kleemann

=head1 SEE ALSO

L<lib>, L<mylib>, L<FindBin>

=cut

