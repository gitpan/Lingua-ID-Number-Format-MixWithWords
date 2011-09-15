package Lingua::ID::Number::Format::MixWithWords;

use 5.010;
use strict;
use warnings;

use Lingua::EN::Number::Format::MixWithWords;
use parent qw(Lingua::EN::Number::Format::MixWithWords);

use Exporter::Lite;
use Math::Round qw(nearest);
use Number::Format;
use POSIX qw(floor log10);

our @EXPORT_OK = qw(format_number_mix);

our $VERSION = '0.01'; # VERSION

our %SPEC = %Lingua::EN::Number::Format::MixWithWords::SPEC;

sub format_number_mix {
    my %args = @_;

    my $f = Lingua::ID::Number::Format::MixWithWords->new(
        num_decimal   => $args{num_decimal},
        min_format    => $args{min_format},
        min_fraction  => $args{min_fraction},
    );
    $f->_format($args{num});
}

sub new {
    my ($class, %args) = @_;
    $args{decimal_point} //= ",";
    $args{thousands_sep} //= ".";
    $args{names} //= {
        #2   => 'ratus',
        3   => 'ribu',
        6   => 'juta',
        9   => 'miliar',
       12   => 'triliun',
       15   => 'kuadriliun',
       18   => 'kuintiliun',
       21   => 'sekstiliun',
       24   => 'septiliun',
       27   => 'oktiliun',
       30   => 'noniliun',
       33   => 'desiliun',
       36   => 'undesiliun',
       39   => 'duodesiliun',
       42   => 'tredesiliun',
       45   => 'kuatuordesiliun',
       48   => 'kuindesiliun',
       51   => 'seksdesiliun',
       54   => 'septendesiliun',
       57   => 'oktodesiliun',
       60   => 'novemdesiliun',
       63   => 'vigintiliun',
       100  => 'googol',
       303  => 'sentiliun',
    };
    # XXX should use "SUPER"
    my $self = Lingua::EN::Number::Format::MixWithWords->new(%args);
    bless $self, $class;
}

1;
# ABSTRACT: Format number to a mixture of numbers and words (e.g. "12,3 juta")


=pod

=head1 NAME

Lingua::ID::Number::Format::MixWithWords - Format number to a mixture of numbers and words (e.g. "12,3 juta")

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 use Lingua::ID::Number::Format::MixWithWords qw(format_number_mix);

 print format_number_mix(num => 1.23e7); # prints "12,3 juta"

=head1 DESCRIPTION

This module formats number with Indonesian names of large numbers (ribu, juta,
miliar, triliun, and so on), e.g. 1.23e7 becomes "12,3 juta". If number is too
small or too large so it does not have any appropriate names, it will be
formatted like a normal number.

=head1 FUNCTIONS

None of the functions are exported by default, but they are exportable.

=head2 format_number_mix(%args) -> RESULT


Arguments (C<*> denotes required arguments):

=over 4

=item * B<min_format>* => I<float> (default C<1000000>)

Number must be larger than this to be formatted as mixture of number and word.

=item * B<min_fraction>* => I<float> (default C<1>)

Whether smaller number can be formatted with 0,x.

If min_fraction is 1 (the default) or 0.9, 800000 won't be formatted as 0.9
omillion but will be if min_fraction is 0.8.

=item * B<num>* => I<float>

The input number to format.

=item * B<num_decimal> => I<int>

Number of decimal points to round.

Can be negative, e.g. -1 to round to nearest 10, -2 to nearest 100, and so on.

=back

=head1 SEE ALSO

L<Lingua::ID::Nums2Words>

L<Lingua::EN::Number::Format::MixWithWords>

L<Number::Format>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

