package IO::Socket::Patch::ByteCounter;

# DATE
# VERSION

use 5.010001;
use strict;
no warnings;
use Log::ger;

use Module::Patch ();
use base qw(Module::Patch);

my $wrap_send = sub {
    my $ctx  = shift;
    my $orig = $ctx->{orig};

    use DD; dd \@_;
    $ctx->{orig}->(@_);
};

my $wrap_recv = sub {
    my $ctx  = shift;
    my $orig = $ctx->{orig};

    use DD; dd \@_;
    $ctx->{orig}->(@_);
};

sub patch_data {
    return {
        v => 3,
        config => {
        },
        patches => [
            {
                action => 'wrap',
                sub_name => 'send',
                code => $wrap_send,
            },
            {
                action => 'wrap',
                sub_name => 'recv',
                code => $wrap_recv,
            },
        ],
    };
}

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
