package EWord::M::DicScraper;

use strict;
use warnings;

use Web::Scraper;
use LWP::UserAgent;
use URI;
use YAML;

sub scrape {
    my $s = scraper {
        process "div.headword", h2 => "TEXT";
        process "div.d", div => "TEXT";
        result "h2", "div";
    };
    $s->user_agent(LWP::UserAgent->new(agent => "Mozilla/5.0"));

    my $uri = "http://www.merriam-webster.com/dictionary/elaborate";
    my $defines = $s->scrape(URI->new($uri));
    warn Dump $defines;

}

1;
