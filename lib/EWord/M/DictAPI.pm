package EWord::M::DictAPI;

use strict;
use warnings;

use LWP::UserAgent;

sub get_def {
    my ($class, $dic, $word) = @_;

    my $ua = LWP::UserAgent->new('Mozilla/5.0');
    my $uri = URI->new();
    $uri->scheme("http");
    $uri->authority("services.aonaware.com");
    $uri->path("/DictService/DictService.asmx/DefineInDict");
    $uri->query("dictId=${dic}&word=${word}");

    warn $uri->as_string;
    my $res = $ua->get($uri);
    if ($res->is_success) {
        warn $res->content;
    }
    else {
        warn "can't get";
    }
}

1;
