# -*- cperl -*-

use Test::More tests => 5;

BEGIN {
  use_ok( 'Acme::Lisp' );
}

#diag( "Testing Acme::Lisp $Acme::Lisp::VERSION" );

my $lc = [ qw(+ 1 2 3 4) ];
is(eval_lisp($lc), 10);

$lc = [ qw(- 1 2 3 4) ];
is(eval_lisp($lc), -8);

$lc = [ qw(* 1 2 3 4) ];
is(eval_lisp($lc), 24);

$lc = [ '+', [qw(* 1 2 3 4)], [qw(* 5 6 7 8)]];
is(eval_lisp($lc), 1704);
