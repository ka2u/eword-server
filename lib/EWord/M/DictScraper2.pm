package EWord::M::DictScraper2;

use strict;
use warnings;

use Web::Scraper;
use LWP::UserAgent;
use URI;
use YAML;

sub scrape {
    my ($class, $word) = @_;
    my $s = scraper {
        process "tr>td>span.ResultBodyBlack", "bodyblack[]" => "TEXT";
        process "tr>td>span.ResultBody", "body[]" => "TEXT";
        process "tr>td>span.ResultBodySmallItalic", "italic[]" => "TEXT";
        result "bodyblack", "body", "italic";
    };
    $s->user_agent(LWP::UserAgent->new(agent => "Mozilla/5.0"));

    my $uri = "http://encarta.msn.com/encnet/features/dictionary/DictionaryResults.aspx?lextype=3&search=${word}";
    my $defines = $s->scrape(URI->new($uri));
    shift @{$defines->{body}}; #shift ' [ '
    shift @{$defines->{body}}; #shift ' ] '

    my $definition;
    foreach my $key (keys %{$defines}) {
        while (my $line = shift @{$defines->{$key}}) {
            next unless defined $line;
            $definition .= $line . "\n";
        }
    }

    return $definition;
}

1;
