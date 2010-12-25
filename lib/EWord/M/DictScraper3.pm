package EWord::M::DictScraper3;

use strict;
use warnings;

use HTML::Entities;
use LWP::UserAgent;
use URI;
use YAML;
use Web::Scraper;

sub get_def {
    my ($class, $word) = @_;
    my $s = scraper {
        process ".left_panel > .page > .inner > .wordclick > .entry > .def", def => "TEXT";
        result "def";
    };
    $s->user_agent(LWP::UserAgent->new(agent => "Mozilla/5.0"));

    my $uri = "http://www.learnersdictionary.com/search/$word";
    my $definition = $s->scrape(URI->new($uri));

    return $definition;
}

1;
