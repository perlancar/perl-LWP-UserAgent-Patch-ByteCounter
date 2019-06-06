package LWP::Protocol::http::Socket::Patch::ByteCounter;

# DATE
# VERSION

use 5.010001;
use strict;
no warnings;
use Log::ger;

use Module::Patch;

my $add_send = sub {
    my $ctx  = shift;
    my $orig = $ctx->{orig};

    use DD; dd \@_;
    $ctx->{orig}->(@_);
};

my $add_recv = sub {
    my $ctx  = shift;
    my $orig = $ctx->{orig};

    use DD; dd \@_;
    $ctx->{orig}->(@_);
};

my $handle = Module::Patch::patch_package(
    'LWP::Protocol::http::Socket',
    [
        {
            action => 'add',
            #mod_version => qr/^6\./,
            sub_name => 'syswritex',
            code => $add_send,
        },
        {
            action => 'add',
            #mod_version => qr/^6\./,
            sub_name => 'sysread',
            code => $add_recv,
        },
    ],
);

1;
# ABSTRACT: Add sleep() between requests to slow down

=head1 SYNOPSIS

 use LWP::UserAgent::Patch::Delay;


=head1 DESCRIPTION

This patch adds sleep() between L<LWP::UserAgent>'s requests.


=head1 CONFIGURATION

=head2 -between_request

Float. Default is 1. Number of seconds to sleep() after each request. Uses
L<Time::HiRes> so you can include fractions of a second, e.g. 0.1 or 1.5.


=head1 FAQ

=head2 Why not subclass?

By patching, you do not need to replace all the client code which uses
L<LWP::UserAgent> (or WWW::Mechanize, and so on).


=head1 SEE ALSO

L<LWP::UserAgent>

L<HTTP::Tiny::Patch::Delay>

=cut
