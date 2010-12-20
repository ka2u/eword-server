package EWord;
use strict;
use warnings;
use parent qw/Amon2/;
our $VERSION='0.01';

use Amon2::Config::Simple;
sub load_config { Amon2::Config::Simple->load(shift) }

use EWord::DB;
sub db {
    my $self = shift;
    $self->{db} //= do {
        my $conf = $self->config->{db_connection} or die "missing db connection";
        EWord::DB->new($conf);
    };
}

use Log::Dispatch;
sub log {
    my $self = shift;
    $self->{log} //= do {
        Log::Dispatch->new(
            outputs => [
                ['File', min_level => 'debug', filename => "log/eword.log"],
            ],
        );
    };
}


1;
