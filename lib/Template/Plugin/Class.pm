use strict;
package Template::Plugin::Class;
use base 'Template::Plugin';
use vars qw( $VERSION );
$VERSION = '0.10';

sub new {
    my $class = shift;
    my $context = shift;
    my $arg = shift;
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

