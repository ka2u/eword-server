package EWord::M::DicScraper2;

use strict;
use warnings;

use Web::Scraper;
use LWP::UserAgent;
use URI;
use YAML;

sub scrape {
    my $s = scraper {
        process "tr>td>span.ResultBodyBlack", "bodyblack[]" => "TEXT";
        process "tr>td>span.ResultBody", "body[]" => "TEXT";
        process "tr>td>span.ResultBodySmallItalic", "italic[]" => "TEXT";
        result "bodyblack", "body", "italic";
    };
    $s->user_agent(LWP::UserAgent->new(agent => "Mozilla/5.0"));

    my $uri = "http://encarta.msn.com/encnet/features/dictionary/DictionaryResults.aspx?lextype=3&search=commence";
    my $defines = $s->scrape(URI->new($uri));
    warn Dump $defines;

}

1;
