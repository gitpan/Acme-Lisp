use Test::More tests => 2;

BEGIN {
  use_ok( 'Acme::Lisp' );
}

diag( "Testing Acme::Lisp $Acme::Lisp::VERSION" );

my $lc = [ qw(- 1 2 3 4) ];
is(eval_lisp($lc), -8);
