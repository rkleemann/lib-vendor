lib--vendor
===========

lib::vendor


Dist::Zilla
==========

This make a cpan package out of this you need to have (Dist::Zilla)[http://dzil.org]
install. Once you have chacked this out you can can build it using:

```shell

dzil build

```

To release it to cpan use:

```shell

dzil release

```

It is generally recommended to take the contents of the build and check it into 
the master branch. So, that other don't have to deal with Dist::Zilla and leave
the dzil branch as the true head, and have the all the configuration managed 
from there. This allow tools like cpanm which can talk to git to install and 
deploy perl module hosted in github and not just cpan.


