use strict;
package Template::Plugin::Class;
use base 'Template::Plugin';
use vars qw( $VERSION );
$VERSION = '0.11';

sub new {
    my $class = shift;
    my $context = shift;
    my $arg = shift;

    eval "require $arg" or die "couldn't require '$arg' $@";
    return bless \$arg, 'Template::Plugin::Class::Proxy';
}

package Template::Plugin::Class::Proxy;
use vars qw( $AUTOLOAD );

sub AUTOLOAD {
    my $self = shift;
    my $class = ref $self;
    my ($method) = ($AUTOLOAD =~ /^$class\::(.*)/);
    $$self->$method(@_);
}

sub DESTROY {}

1;
__END__

=head1 NAME

Template::Plugin::Class - allow calling of class methods on arbitrary classes

=head1 SYNOPSIS

  [% USE foo = Class('Foo') %]
  [% foo.bar %]

=head1 DESCRIPTION

Template::Plugin::Class allows you to call class methods on
arbitrary classes.  One use for this is in Class::DBI style
applications, where you may do somthing like this:

  [% USE cd = Class('Music::CD') %]
  [% FOREACH disc = cd.retrieve_all %]
  [% disc.artist %] - [% disc.title %]
  [% END %]

=head1 CAVEATS

You won't be able to directly call C<AUTOLOAD> or C<DESTROY> methods
on the remote class.  This shouldn't be a huge hardship.

=head1 BUGS

Apart from the mentioned caveat, none currently known.  If you find
any please make use of L<http://rt.cpan.org> by mailing your report to
bug-Template-Plugin-Class@rt.cpan.org, or contact me directly.

=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 COPYRIGHT

Copyright (C) 2003 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<Template>

=cut

