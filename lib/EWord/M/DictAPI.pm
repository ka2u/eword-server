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
        my $dom = XML::LibXML->load_xml(string => $res->content);
        my ($top, $node) = $dom->getElementsByTagName("WordDefinition");
        my $node_txt = $node->textContent;
        $node_txt =~ s/\r|\n//g;
        $node_txt =~ s/\s{2,}//g;
        $node_txt =~ s/;/;\n/g;
        return $node_txt;
    }
    else {
        return undef;
    }
}

1;
