package Acme::Lisp;

use warnings;
use strict;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(eval_lisp);

our %eval;

BEGIN {

  $eval{'+'} = sub { my $ans = 0; $ans += $_ for @_; return $ans };

  $eval{'-'} = sub { my $ans = shift @_; $ans -= $_ for @_; return $ans };

  $eval{'*'} = sub { my $ans = 1; $ans *= $_ for @_; return $ans };

  $eval{'/'} = sub { my $ans = shift @_; for (@_) {
    if ($_) { $ans /= $_ } else { die "division by zero\n" }}; return $ans };

  $eval{'exit'} = sub { exit };

  $eval{'quit'} = sub { exit };
}

=head1 NAME

Acme::Lisp - Evals lisp code on array references

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';

=head1 SYNOPSIS

    use Acme::Lisp;

    my $lisp_code = [ qw(- 1 2 3 4) ];

    eval_lisp($lisp_code) # return -8

=head1 EXPORT

=head2 eval_lisp

This method receives a reference to a Perl list with lisp code, and
evaluates it, returning the value obtained with the evaluation.

Currently supported clisp:

=over 4

=item +

Sums values

=item -

Subtracts values

=item *

Multiply values

=item /

Divide values (at the moment, real division)

=item exit

Exits que program execution (same as quit)

=item quit

Quits the program execution (same as exit)

=back

=cut

sub eval_lisp {
  my $code = shift;

  #print Dumper($code);

  return $code unless ref $code eq "ARRAY";

  my $func = shift @$code;
  if (exists($eval{$func})) {
    return &{$eval{$func}}(map {eval_lisp($_)} @$code);
  } else {
    die "Unknown function '$func'\n";
  }
}



=head1 NOTE

This is a concept module. If I have time, maybe I'll add some
functions. If not, well, you can send me patches.

=head1 AUTHOR

Alberto Simões, C<< <ambs@cpan.org> >>

=head1 BUGS

At the moment division is done as real values, and not fractions as
usual on common lisp.

Please report any bugs or feature requests to
C<bug-acme-lisp@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2004 Alberto Simões, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Acme::Lisp
