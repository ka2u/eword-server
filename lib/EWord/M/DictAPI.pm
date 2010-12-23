package EWord::M::DictAPI;

use strict;
use warnings;

use LWP::UserAgent;
use XML::LibXML;

sub get_def {
    my ($class, $dic, $word) = @_;

    my $ua = LWP::UserAgent->new('Mozilla/5.0');
    my $uri = URI->new();
    $uri->scheme("http");
    $uri->authority("services.aonaware.com");
    $uri->path("/DictService/DictService.asmx/DefineInDict");
    $uri->query("dictId=${dic}&word=${word}");

    my $res = $ua->get($uri);
    if ($res->is_success) {
        warn $res->content;
        my $dom = XML::LibXML->load_xml(string => $res->content);
        my ($top, $node) = $dom->getElementsByTagName("WordDefinition");
        return $node->textContent;
    }
    else {
        return undef;
    }
}

1;
