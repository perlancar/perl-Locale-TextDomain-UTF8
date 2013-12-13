package Locale::TextDomain::UTF8;

use 5.010001;

# VERSION

use Encode             ();
use Locale::Messages   ();
use Locale::TextDomain ();

$ENV{OUTPUT_CHARSET} = 'UTF-8';
sub import {
    my ($class, $text_domain) = @_;
    Locale::TextDomain->import;
    Locale::Messages::bind_textdomain_filter(
        $text_domain, \&Encode::decode_utf8);
}

1;
# ABSTRACT: Shortcut to use Locale::TextDomain and decoding to UTF8

=head1 SYNOPSIS

Instead of:

 use Locale::TextDomain 'Some-TextDomain';

you now say:

 use Locale::TextDomain::UTF8 'Some-TextDomain';


=head1 DESCRIPTION

 use Locale::TextDomain::UTF8 'Some-TextDomain'

is equivalent to:

 use Locale::TextDomain 'Some-TextDomain';
 use Locale::Messages qw(bind_textdomain_filter);
 use Encode;
 BEGIN {
     $ENV{OUTPUT_CHARSET} = 'UTF-8';
     bind_textdomain_filter 'Some-TextDomain' => \&Encode::decode_utf8;
 }

it's just more convenient, especially if you have to do it for each textdomain.

Why would you want this? To ensure that strings returned by the C<__()>, et al
functions are UTF8-encoded Perl strings. For example, if you want to pass the
strings to L<Unicode::GCString>. For more details, see the Perl Advent article
mentioned in the SEE ALSO section.


=head1 SEE ALSO

L<Locale::TextDomain>

L<Locale::Messages>

L<http://www.perladvent.org/2013/2013-12-09.html>

=cut
