#!perl -w
use strict;
use Test::More tests => 3;
use Template;
my $tt = Template->new;

my $template = "[% USE foo=Class('Foo') %][% foo.bar %]";
my $out;
ok( $tt->process(\$template, {}, \$out), "processed ok" );
is( $tt->error, undef, "no error" );

is( $out, Foo->bar, "method was called" );

BEGIN { $INC{'Foo.pm'} = 1 }
package Foo;
sub bar {
    "I am returning bar";
}
