#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Fatal;

use mop;

class Foo {

    has $foo;
    has $bar;

    method bar { 'Foo::bar' }

    method baz ($x) {
        join "::" => $self, 'baz', $x
    }

    method test ($x) {
        $foo = $x if $x;
        $foo;
    }
}

is(Foo->bar, 'Foo::bar', '... simple test works');
is(Foo->baz('hi'), 'Foo::baz::hi', '... another test works');

my $foo = Foo->new;
isa_ok($foo, 'Foo');

is($foo->bar, 'Foo::bar', '... simple test works');
is($foo->baz('hi'), $foo . '::baz::hi', '... another test works');

is($foo->test(10), 10, '... got the right value');
is($foo->test, 10, '... got the right value');
is($foo->test(20), 20, '... got the right value');
is($foo->test, 20, '... got the right value');
is_deeply($foo->test([ 1, 2, 3 ]), [ 1, 2, 3 ], '... got the right value');
is_deeply($foo->test, [ 1, 2, 3 ], '... got the right value');

done_testing;